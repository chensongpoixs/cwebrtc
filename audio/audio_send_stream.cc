﻿/*
 *  Copyright (c) 2015 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "audio/audio_send_stream.h"

#include <string>
#include <utility>
#include <vector>

#include "absl/memory/memory.h"
#include "api/audio_codecs/audio_encoder.h"
#include "api/audio_codecs/audio_encoder_factory.h"
#include "api/audio_codecs/audio_format.h"
#include "api/call/transport.h"
#include "api/crypto/frame_encryptor_interface.h"
#include "api/function_view.h"
#include "audio/audio_state.h"
#include "audio/channel_send.h"
#include "audio/conversion.h"
#include "call/rtp_config.h"
#include "call/rtp_transport_controller_send_interface.h"
#include "common_audio/vad/include/vad.h"
#include "logging/rtc_event_log/events/rtc_event_audio_send_stream_config.h"
#include "logging/rtc_event_log/rtc_event_log.h"
#include "logging/rtc_event_log/rtc_stream_config.h"
#include "modules/audio_coding/codecs/cng/audio_encoder_cng.h"
#include "modules/audio_processing/include/audio_processing.h"
#include "rtc_base/checks.h"
#include "rtc_base/event.h"
#include "rtc_base/logging.h"
#include "rtc_base/strings/audio_format_to_string.h"
#include "rtc_base/task_queue.h"
#include "system_wrappers/include/field_trial.h"

namespace webrtc {
namespace internal {
namespace {
// TODO(eladalon): Subsequent CL will make these values experiment-dependent.
constexpr size_t kPacketLossTrackerMaxWindowSizeMs = 15000;
constexpr size_t kPacketLossRateMinNumAckedPackets = 50;
constexpr size_t kRecoverablePacketLossRateMinNumAckedPairs = 40;

void UpdateEventLogStreamConfig(RtcEventLog* event_log,
                                const AudioSendStream::Config& config,
                                const AudioSendStream::Config* old_config) {
  using SendCodecSpec = AudioSendStream::Config::SendCodecSpec;
  // Only update if any of the things we log have changed.
  auto payload_types_equal = [](const absl::optional<SendCodecSpec>& a,
                                const absl::optional<SendCodecSpec>& b) {
    if (a.has_value() && b.has_value()) {
      return a->format.name == b->format.name &&
             a->payload_type == b->payload_type;
    }
    return !a.has_value() && !b.has_value();
  };

  if (old_config && config.rtp.ssrc == old_config->rtp.ssrc &&
      config.rtp.extensions == old_config->rtp.extensions &&
      payload_types_equal(config.send_codec_spec,
                          old_config->send_codec_spec)) {
    return;
  }

  auto rtclog_config = absl::make_unique<rtclog::StreamConfig>();
  rtclog_config->local_ssrc = config.rtp.ssrc;
  rtclog_config->rtp_extensions = config.rtp.extensions;
  if (config.send_codec_spec) {
    rtclog_config->codecs.emplace_back(config.send_codec_spec->format.name,
                                       config.send_codec_spec->payload_type, 0);
  }
  event_log->Log(absl::make_unique<RtcEventAudioSendStreamConfig>(
      std::move(rtclog_config)));
}

}  // namespace

AudioSendStream::AudioSendStream(
    Clock* clock,
    const webrtc::AudioSendStream::Config& config,
    const rtc::scoped_refptr<webrtc::AudioState>& audio_state,
    TaskQueueFactory* task_queue_factory,
    ProcessThread* module_process_thread,
    RtpTransportControllerSendInterface* rtp_transport,
    BitrateAllocatorInterface* bitrate_allocator,
    RtcEventLog* event_log,
    RtcpRttStats* rtcp_rtt_stats,
    const absl::optional<RtpState>& suspended_rtp_state)
    : AudioSendStream(clock,
                      config,
                      audio_state,
                      task_queue_factory,
                      rtp_transport,
                      bitrate_allocator,
                      event_log,
                      rtcp_rtt_stats,
                      suspended_rtp_state,
                      voe::CreateChannelSend(clock,
                                             task_queue_factory,
                                             module_process_thread,
                                             config.media_transport,
                                             /*overhead_observer=*/this,
                                             config.send_transport,
                                             rtcp_rtt_stats,
                                             event_log,
                                             config.frame_encryptor,
                                             config.crypto_options,
                                             config.rtp.extmap_allow_mixed,
                                             config.rtcp_report_interval_ms)) {}

AudioSendStream::AudioSendStream(
    Clock* clock,
    const webrtc::AudioSendStream::Config& config,
    const rtc::scoped_refptr<webrtc::AudioState>& audio_state,
    TaskQueueFactory* task_queue_factory,
    RtpTransportControllerSendInterface* rtp_transport,
    BitrateAllocatorInterface* bitrate_allocator,
    RtcEventLog* event_log,
    RtcpRttStats* rtcp_rtt_stats,
    const absl::optional<RtpState>& suspended_rtp_state,
    std::unique_ptr<voe::ChannelSendInterface> channel_send)
    : clock_(clock),
      worker_queue_(rtp_transport->GetWorkerQueue()),
      config_(Config(/*send_transport=*/nullptr,
                     /*media_transport=*/nullptr)),
      audio_state_(audio_state),
      channel_send_(std::move(channel_send)),
      event_log_(event_log),
      bitrate_allocator_(bitrate_allocator),
      rtp_transport_(rtp_transport),
      packet_loss_tracker_(kPacketLossTrackerMaxWindowSizeMs,
                           kPacketLossRateMinNumAckedPackets,
                           kRecoverablePacketLossRateMinNumAckedPairs),
      rtp_rtcp_module_(nullptr),
      suspended_rtp_state_(suspended_rtp_state) {
  RTC_LOG(LS_INFO) << "AudioSendStream: " << config.rtp.ssrc;
  RTC_DCHECK(worker_queue_);
  RTC_DCHECK(audio_state_);
  RTC_DCHECK(channel_send_);
  RTC_DCHECK(bitrate_allocator_);
  // Currently we require the rtp transport even when media transport is used.
  RTC_DCHECK(rtp_transport);

  // TODO(nisse): Eventually, we should have only media_transport. But for the
  // time being, we can have either. When media transport is injected, there
  // should be no rtp_transport, and below check should be strengthened to XOR
  // (either rtp_transport or media_transport but not both).
  RTC_DCHECK(rtp_transport || config.media_transport);
  if (config.media_transport) {
    // TODO(sukhanov): Currently media transport audio overhead is considered
    // constant, we will not get overhead_observer calls when using
    // media_transport. In the future when we introduce RTP media transport we
    // should make audio overhead interface consistent and work for both RTP and
    // non-RTP implementations.
    audio_overhead_per_packet_bytes_ =
        config.media_transport->GetAudioPacketOverhead();
  }
  rtp_rtcp_module_ = channel_send_->GetRtpRtcp();
  RTC_DCHECK(rtp_rtcp_module_);

  ConfigureStream(this, config, true);

  pacer_thread_checker_.Detach();
  if (rtp_transport_) {
    // Signal congestion controller this object is ready for OnPacket*
    // callbacks.
    rtp_transport_->RegisterPacketFeedbackObserver(this);
  }
}

AudioSendStream::~AudioSendStream() {
  RTC_DCHECK(worker_thread_checker_.IsCurrent());
  RTC_LOG(LS_INFO) << "~AudioSendStream: " << config_.rtp.ssrc;
  RTC_DCHECK(!sending_);
  if (rtp_transport_) {
    rtp_transport_->DeRegisterPacketFeedbackObserver(this);
    channel_send_->ResetSenderCongestionControlObjects();
  }
  // Blocking call to synchronize state with worker queue to ensure that there
  // are no pending tasks left that keeps references to audio.
  rtc::Event thread_sync_event;
  worker_queue_->PostTask([&] { thread_sync_event.Set(); });
  thread_sync_event.Wait(rtc::Event::kForever);
}

const webrtc::AudioSendStream::Config& AudioSendStream::GetConfig() const {
  RTC_DCHECK(worker_thread_checker_.IsCurrent());
  return config_;
}

void AudioSendStream::Reconfigure(
    const webrtc::AudioSendStream::Config& new_config) {
  RTC_DCHECK(worker_thread_checker_.IsCurrent());
  ConfigureStream(this, new_config, false);
}

AudioSendStream::ExtensionIds AudioSendStream::FindExtensionIds(
    const std::vector<RtpExtension>& extensions) {
  ExtensionIds ids;
  for (const auto& extension : extensions) {
    if (extension.uri == RtpExtension::kAudioLevelUri) {
      ids.audio_level = extension.id;
    } else if (extension.uri == RtpExtension::kTransportSequenceNumberUri) {
      ids.transport_sequence_number = extension.id;
    } else if (extension.uri == RtpExtension::kMidUri) {
      ids.mid = extension.id;
    } else if (extension.uri == RtpExtension::kRidUri) {
      ids.rid = extension.id;
    } else if (extension.uri == RtpExtension::kRepairedRidUri) {
      ids.repaired_rid = extension.id;
    }
  }
  return ids;
}

int AudioSendStream::TransportSeqNumId(const AudioSendStream::Config& config) {
  return FindExtensionIds(config.rtp.extensions).transport_sequence_number;
}

void AudioSendStream::ConfigureStream(
    webrtc::internal::AudioSendStream* stream,
    const webrtc::AudioSendStream::Config& new_config,
    bool first_time) {
  RTC_LOG(LS_INFO) << "AudioSendStream::ConfigureStream: "
                   << new_config.ToString();
  UpdateEventLogStreamConfig(stream->event_log_, new_config,
                             first_time ? nullptr : &stream->config_);

  const auto& channel_send = stream->channel_send_;
  const auto& old_config = stream->config_;

  // Configuration parameters which cannot be changed.
  RTC_DCHECK(first_time ||
             old_config.send_transport == new_config.send_transport);

  if (first_time || old_config.rtp.ssrc != new_config.rtp.ssrc) {
    channel_send->SetLocalSSRC(new_config.rtp.ssrc);
    if (stream->suspended_rtp_state_) {
      stream->rtp_rtcp_module_->SetRtpState(*stream->suspended_rtp_state_);
    }
  }
  if (first_time || old_config.rtp.c_name != new_config.rtp.c_name) {
    channel_send->SetRTCP_CNAME(new_config.rtp.c_name);
  }

  // Enable the frame encryptor if a new frame encryptor has been provided.
  if (first_time || new_config.frame_encryptor != old_config.frame_encryptor) {
    channel_send->SetFrameEncryptor(new_config.frame_encryptor);
  }

  if (first_time ||
      new_config.rtp.extmap_allow_mixed != old_config.rtp.extmap_allow_mixed) {
    channel_send->SetExtmapAllowMixed(new_config.rtp.extmap_allow_mixed);
  }

  const ExtensionIds old_ids = FindExtensionIds(old_config.rtp.extensions);
  const ExtensionIds new_ids = FindExtensionIds(new_config.rtp.extensions);
  // Audio level indication
  if (first_time || new_ids.audio_level != old_ids.audio_level) {
    channel_send->SetSendAudioLevelIndicationStatus(new_ids.audio_level != 0,
                                                    new_ids.audio_level);
  }
  bool transport_seq_num_id_changed =
      new_ids.transport_sequence_number != old_ids.transport_sequence_number;
  if (first_time || (transport_seq_num_id_changed &&
                     !stream->allocation_settings_.ForceNoAudioFeedback())) {
    if (!first_time) {
      channel_send->ResetSenderCongestionControlObjects();
    }

    RtcpBandwidthObserver* bandwidth_observer = nullptr;

    if (stream->allocation_settings_.ShouldSendTransportSequenceNumber(
            new_ids.transport_sequence_number)) {
      channel_send->EnableSendTransportSequenceNumber(
          new_ids.transport_sequence_number);
      // Probing in application limited region is only used in combination with
      // send side congestion control, wich depends on feedback packets which
      // requires transport sequence numbers to be enabled.
      if (stream->rtp_transport_) {
        stream->rtp_transport_->EnablePeriodicAlrProbing(true);
        bandwidth_observer = stream->rtp_transport_->GetBandwidthObserver();
      }
    }
    if (stream->rtp_transport_) {
      channel_send->RegisterSenderCongestionControlObjects(
          stream->rtp_transport_, bandwidth_observer);
    }
  }
  // MID RTP header extension.
  if ((first_time || new_ids.mid != old_ids.mid ||
       new_config.rtp.mid != old_config.rtp.mid) &&
      new_ids.mid != 0 && !new_config.rtp.mid.empty()) {
    channel_send->SetMid(new_config.rtp.mid, new_ids.mid);
  }

  // RID RTP header extension
  if ((first_time || new_ids.rid != old_ids.rid ||
       new_ids.repaired_rid != old_ids.repaired_rid ||
       new_config.rtp.rid != old_config.rtp.rid)) {
    channel_send->SetRid(new_config.rtp.rid, new_ids.rid, new_ids.repaired_rid);
  }
  // TODO@chensong 2022-10-16 
  if (!ReconfigureSendCodec(stream, new_config)) {
    RTC_LOG(LS_ERROR) << "Failed to set up send codec state.";
  }

  if (stream->sending_) {
    ReconfigureBitrateObserver(stream, new_config);
  }
  stream->config_ = new_config;
}

void AudioSendStream::Start() {
  RTC_DCHECK_RUN_ON(&worker_thread_checker_);
  if (sending_) {
    return;
  }
  // TODO@chensong 20220816 音频设备开始录制初始化码流
  if (allocation_settings_.IncludeAudioInAllocationOnStart(
          config_.min_bitrate_bps, config_.max_bitrate_bps, config_.has_dscp,
          TransportSeqNumId(config_))) {
    rtp_transport_->packet_sender()->SetAccountForAudioPackets(true);
    rtp_rtcp_module_->SetAsPartOfAllocation(true);
    rtc::Event thread_sync_event;
    worker_queue_->PostTask([&] {
      RTC_DCHECK_RUN_ON(worker_queue_);
      ConfigureBitrateObserver();
      thread_sync_event.Set();
    });
    thread_sync_event.Wait(rtc::Event::kForever);
  } else {
    rtp_rtcp_module_->SetAsPartOfAllocation(false);
  }
  // 开始发送通道
  channel_send_->StartSend();
  sending_ = true;
  //     调用音频AudioState增加一个音频流
  audio_state()->AddSendingStream(this, encoder_sample_rate_hz_,
                                  encoder_num_channels_);
}

void AudioSendStream::Stop() {
  RTC_DCHECK(worker_thread_checker_.IsCurrent());
  if (!sending_) {
    return;
  }

  RemoveBitrateObserver();
  channel_send_->StopSend();
  sending_ = false;
  audio_state()->RemoveSendingStream(this);
}

void AudioSendStream::SendAudioData(std::unique_ptr<AudioFrame> audio_frame) {
  RTC_CHECK_RUNS_SERIALIZED(&audio_capture_race_checker_);
  channel_send_->ProcessAndEncodeAudio(std::move(audio_frame));
}

bool AudioSendStream::SendTelephoneEvent(int payload_type,
                                         int payload_frequency,
                                         int event,
                                         int duration_ms) {
  RTC_DCHECK(worker_thread_checker_.IsCurrent());
  channel_send_->SetSendTelephoneEventPayloadType(payload_type,
                                                  payload_frequency);
  return channel_send_->SendTelephoneEventOutband(event, duration_ms);
}

void AudioSendStream::SetMuted(bool muted) {
  RTC_DCHECK(worker_thread_checker_.IsCurrent());
  channel_send_->SetInputMute(muted);
}

webrtc::AudioSendStream::Stats AudioSendStream::GetStats() const {
  return GetStats(true);
}

webrtc::AudioSendStream::Stats AudioSendStream::GetStats(
    bool has_remote_tracks) const {
  RTC_DCHECK(worker_thread_checker_.IsCurrent());
  webrtc::AudioSendStream::Stats stats;
  stats.local_ssrc = config_.rtp.ssrc;
  stats.target_bitrate_bps = channel_send_->GetBitrate();

  webrtc::CallSendStatistics call_stats = channel_send_->GetRTCPStatistics();
  stats.bytes_sent = call_stats.bytesSent;
  stats.packets_sent = call_stats.packetsSent;
  // RTT isn't known until a RTCP report is received. Until then, VoiceEngine
  // returns 0 to indicate an error value.
  if (call_stats.rttMs > 0) {
    stats.rtt_ms = call_stats.rttMs;
  }
  if (config_.send_codec_spec) {
    const auto& spec = *config_.send_codec_spec;
    stats.codec_name = spec.format.name;
    stats.codec_payload_type = spec.payload_type;

    // Get data from the last remote RTCP report.
    for (const auto& block : channel_send_->GetRemoteRTCPReportBlocks()) {
      // Lookup report for send ssrc only.
      if (block.source_SSRC == stats.local_ssrc) {
        stats.packets_lost = block.cumulative_num_packets_lost;
        stats.fraction_lost = Q8ToFloat(block.fraction_lost);
        stats.ext_seqnum = block.extended_highest_sequence_number;
        // Convert timestamps to milliseconds.
        if (spec.format.clockrate_hz / 1000 > 0) {
          stats.jitter_ms =
              block.interarrival_jitter / (spec.format.clockrate_hz / 1000);
        }
        break;
      }
    }
  }

  AudioState::Stats input_stats = audio_state()->GetAudioInputStats();
  stats.audio_level = input_stats.audio_level;
  stats.total_input_energy = input_stats.total_energy;
  stats.total_input_duration = input_stats.total_duration;

  stats.typing_noise_detected = audio_state()->typing_noise_detected();
  stats.ana_statistics = channel_send_->GetANAStatistics();
  RTC_DCHECK(audio_state_->audio_processing());
  stats.apm_statistics =
      audio_state_->audio_processing()->GetStatistics(has_remote_tracks);

  return stats;
}

void AudioSendStream::SignalNetworkState(NetworkState state) {
  RTC_DCHECK(worker_thread_checker_.IsCurrent());
}

void AudioSendStream::DeliverRtcp(const uint8_t* packet, size_t length) {
  // TODO(solenberg): Tests call this function on a network thread, libjingle
  // calls on the worker thread. We should move towards always using a network
  // thread. Then this check can be enabled.
  // RTC_DCHECK(!worker_thread_checker_.IsCurrent());
  channel_send_->ReceivedRTCPPacket(packet, length);
}

uint32_t AudioSendStream::OnBitrateUpdated(BitrateAllocationUpdate update) {
  // A send stream may be allocated a bitrate of zero if the allocator decides
  // to disable it. For now we ignore this decision and keep sending on min
  // bitrate.
  if (update.target_bitrate.IsZero()) {
    update.target_bitrate = DataRate::bps(config_.min_bitrate_bps);
  }
  RTC_DCHECK_GE(update.target_bitrate.bps<int>(), config_.min_bitrate_bps);
  // The bitrate allocator might allocate an higher than max configured bitrate
  // if there is room, to allow for, as example, extra FEC. Ignore that for now.
  const DataRate max_bitrate = DataRate::bps(config_.max_bitrate_bps);
  if (update.target_bitrate > max_bitrate)
    update.target_bitrate = max_bitrate;

  channel_send_->OnBitrateAllocation(update);

  // The amount of audio protection is not exposed by the encoder, hence
  // always returning 0.
  return 0;
}

void AudioSendStream::OnPacketAdded(uint32_t ssrc, uint16_t seq_num) {
  RTC_DCHECK(pacer_thread_checker_.IsCurrent());
  // Only packets that belong to this stream are of interest.
  if (ssrc == config_.rtp.ssrc) {
    rtc::CritScope lock(&packet_loss_tracker_cs_);
    // TODO(eladalon): This function call could potentially reset the window,
    // setting both PLR and RPLR to unknown. Consider (during upcoming
    // refactoring) passing an indication of such an event.
    packet_loss_tracker_.OnPacketAdded(seq_num, clock_->TimeInMilliseconds());
  }
}

void AudioSendStream::OnPacketFeedbackVector(
    const std::vector<PacketFeedback>& packet_feedback_vector) {
  RTC_DCHECK(worker_thread_checker_.IsCurrent());
  absl::optional<float> plr;
  absl::optional<float> rplr;
  {
    rtc::CritScope lock(&packet_loss_tracker_cs_);
    packet_loss_tracker_.OnPacketFeedbackVector(packet_feedback_vector);
    plr = packet_loss_tracker_.GetPacketLossRate();
    rplr = packet_loss_tracker_.GetRecoverablePacketLossRate();
  }
  // TODO(eladalon): If R/PLR go back to unknown, no indication is given that
  // the previously sent value is no longer relevant. This will be taken care
  // of with some refactoring which is now being done.
  if (plr) {
    channel_send_->OnTwccBasedUplinkPacketLossRate(*plr);
  }
  if (rplr) {
    channel_send_->OnRecoverableUplinkPacketLossRate(*rplr);
  }
}

void AudioSendStream::SetTransportOverhead(
    int transport_overhead_per_packet_bytes) {
  RTC_DCHECK(worker_thread_checker_.IsCurrent());
  rtc::CritScope cs(&overhead_per_packet_lock_);
  transport_overhead_per_packet_bytes_ = transport_overhead_per_packet_bytes;
  UpdateOverheadForEncoder();
}

void AudioSendStream::OnOverheadChanged(
    size_t overhead_bytes_per_packet_bytes) {
  rtc::CritScope cs(&overhead_per_packet_lock_);
  audio_overhead_per_packet_bytes_ = overhead_bytes_per_packet_bytes;
  UpdateOverheadForEncoder();
}

void AudioSendStream::UpdateOverheadForEncoder() {
  const size_t overhead_per_packet_bytes = GetPerPacketOverheadBytes();
  channel_send_->CallEncoder([&](AudioEncoder* encoder) {
    encoder->OnReceivedOverhead(overhead_per_packet_bytes);
  });
  worker_queue_->PostTask([this, overhead_per_packet_bytes] {
    RTC_DCHECK_RUN_ON(worker_queue_);
    if (total_packet_overhead_bytes_ != overhead_per_packet_bytes) {
      total_packet_overhead_bytes_ = overhead_per_packet_bytes;
      if (registered_with_allocator_) {
        ConfigureBitrateObserver();
      }
    }
  });
}

size_t AudioSendStream::TestOnlyGetPerPacketOverheadBytes() const {
  rtc::CritScope cs(&overhead_per_packet_lock_);
  return GetPerPacketOverheadBytes();
}

size_t AudioSendStream::GetPerPacketOverheadBytes() const {
  return transport_overhead_per_packet_bytes_ +
         audio_overhead_per_packet_bytes_;
}

RtpState AudioSendStream::GetRtpState() const {
  return rtp_rtcp_module_->GetRtpState();
}

const voe::ChannelSendInterface* AudioSendStream::GetChannel() const {
  return channel_send_.get();
}

internal::AudioState* AudioSendStream::audio_state() {
  internal::AudioState* audio_state =
      static_cast<internal::AudioState*>(audio_state_.get());
  RTC_DCHECK(audio_state);
  return audio_state;
}

const internal::AudioState* AudioSendStream::audio_state() const {
  internal::AudioState* audio_state =
      static_cast<internal::AudioState*>(audio_state_.get());
  RTC_DCHECK(audio_state);
  return audio_state;
}

void AudioSendStream::StoreEncoderProperties(int sample_rate_hz,
                                             size_t num_channels) {
  RTC_DCHECK(worker_thread_checker_.IsCurrent());
  encoder_sample_rate_hz_ = sample_rate_hz;
  encoder_num_channels_ = num_channels;
  if (sending_) {
    // Update AudioState's information about the stream.
    audio_state()->AddSendingStream(this, sample_rate_hz, num_channels);
  }
}

// Apply current codec settings to a single voe::Channel used for sending.
bool AudioSendStream::SetupSendCodec(AudioSendStream* stream,
                                     const Config& new_config) {
  RTC_DCHECK(new_config.send_codec_spec);
  const auto& spec = *new_config.send_codec_spec;

  RTC_DCHECK(new_config.encoder_factory);
  std::unique_ptr<AudioEncoder> encoder =
      new_config.encoder_factory->MakeAudioEncoder(
          spec.payload_type, spec.format, new_config.codec_pair_id);

  if (!encoder) {
    RTC_DLOG(LS_ERROR) << "Unable to create encoder for "
                       << rtc::ToString(spec.format);
    return false;
  }

  // If a bitrate has been specified for the codec, use it over the
  // codec's default.
  if (spec.target_bitrate_bps) {
    encoder->OnReceivedTargetAudioBitrate(*spec.target_bitrate_bps);
  }

  // Enable ANA if configured (currently only used by Opus).
  if (new_config.audio_network_adaptor_config) {
    if (encoder->EnableAudioNetworkAdaptor(
            *new_config.audio_network_adaptor_config, stream->event_log_)) {
      RTC_DLOG(LS_INFO) << "Audio network adaptor enabled on SSRC "
                        << new_config.rtp.ssrc;
    } else {
      RTC_NOTREACHED();
    }
  }

  // Wrap the encoder in a an AudioEncoderCNG, if VAD is enabled.
  if (spec.cng_payload_type) {
    AudioEncoderCngConfig cng_config;
    cng_config.num_channels = encoder->NumChannels();
    cng_config.payload_type = *spec.cng_payload_type;
    cng_config.speech_encoder = std::move(encoder);
    cng_config.vad_mode = Vad::kVadNormal;
    encoder = CreateComfortNoiseEncoder(std::move(cng_config));

    stream->RegisterCngPayloadType(
        *spec.cng_payload_type,
        new_config.send_codec_spec->format.clockrate_hz);
  }

  // Set currently known overhead (used in ANA, opus only).
  // If overhead changes later, it will be updated in UpdateOverheadForEncoder.
  {
    rtc::CritScope cs(&stream->overhead_per_packet_lock_);
    encoder->OnReceivedOverhead(stream->GetPerPacketOverheadBytes());
  }

  stream->StoreEncoderProperties(encoder->SampleRateHz(),
                                 encoder->NumChannels());
  stream->channel_send_->SetEncoder(new_config.send_codec_spec->payload_type,
                                    std::move(encoder));

  return true;
}

bool AudioSendStream::ReconfigureSendCodec(AudioSendStream* stream,
                                           const Config& new_config) {
  const auto& old_config = stream->config_;

  if (!new_config.send_codec_spec) {
    // We cannot de-configure a send codec. So we will do nothing.
    // By design, the send codec should have not been configured.
    RTC_DCHECK(!old_config.send_codec_spec);
    return true;
  }

  if (new_config.send_codec_spec == old_config.send_codec_spec &&
      new_config.audio_network_adaptor_config ==
          old_config.audio_network_adaptor_config) {
    return true;
  }

  // If we have no encoder, or the format or payload type's changed, create a
  // new encoder.
  if (!old_config.send_codec_spec ||
      new_config.send_codec_spec->format !=
          old_config.send_codec_spec->format ||
      new_config.send_codec_spec->payload_type !=
          old_config.send_codec_spec->payload_type)
  {
	  // TODO@chensong 2022-10-16 
    return SetupSendCodec(stream, new_config);
  }

  const absl::optional<int>& new_target_bitrate_bps =
      new_config.send_codec_spec->target_bitrate_bps;
  // If a bitrate has been specified for the codec, use it over the
  // codec's default.
  if (new_target_bitrate_bps &&
      new_target_bitrate_bps !=
          old_config.send_codec_spec->target_bitrate_bps) {
    stream->channel_send_->CallEncoder([&](AudioEncoder* encoder) {
      encoder->OnReceivedTargetAudioBitrate(*new_target_bitrate_bps);
    });
  }

  ReconfigureANA(stream, new_config);
  ReconfigureCNG(stream, new_config);

  // Set currently known overhead (used in ANA, opus only).
  {
    rtc::CritScope cs(&stream->overhead_per_packet_lock_);
    stream->UpdateOverheadForEncoder();
  }

  return true;
}

void AudioSendStream::ReconfigureANA(AudioSendStream* stream,
                                     const Config& new_config) {
  if (new_config.audio_network_adaptor_config ==
      stream->config_.audio_network_adaptor_config) {
    return;
  }
  if (new_config.audio_network_adaptor_config) {
    stream->channel_send_->CallEncoder([&](AudioEncoder* encoder) {
      if (encoder->EnableAudioNetworkAdaptor(
              *new_config.audio_network_adaptor_config, stream->event_log_)) {
        RTC_DLOG(LS_INFO) << "Audio network adaptor enabled on SSRC "
                          << new_config.rtp.ssrc;
      } else {
        RTC_NOTREACHED();
      }
    });
  } else {
    stream->channel_send_->CallEncoder(
        [&](AudioEncoder* encoder) { encoder->DisableAudioNetworkAdaptor(); });
    RTC_DLOG(LS_INFO) << "Audio network adaptor disabled on SSRC "
                      << new_config.rtp.ssrc;
  }
}

void AudioSendStream::ReconfigureCNG(AudioSendStream* stream,
                                     const Config& new_config) {
  if (new_config.send_codec_spec->cng_payload_type ==
      stream->config_.send_codec_spec->cng_payload_type) {
    return;
  }

  // Register the CNG payload type if it's been added, don't do anything if CNG
  // is removed. Payload types must not be redefined.
  if (new_config.send_codec_spec->cng_payload_type) {
    stream->RegisterCngPayloadType(
        *new_config.send_codec_spec->cng_payload_type,
        new_config.send_codec_spec->format.clockrate_hz);
  }

  // Wrap or unwrap the encoder in an AudioEncoderCNG.
  stream->channel_send_->ModifyEncoder(
      [&](std::unique_ptr<AudioEncoder>* encoder_ptr) {
        std::unique_ptr<AudioEncoder> old_encoder(std::move(*encoder_ptr));
        auto sub_encoders = old_encoder->ReclaimContainedEncoders();
        if (!sub_encoders.empty()) {
          // Replace enc with its sub encoder. We need to put the sub
          // encoder in a temporary first, since otherwise the old value
          // of enc would be destroyed before the new value got assigned,
          // which would be bad since the new value is a part of the old
          // value.
          auto tmp = std::move(sub_encoders[0]);
          old_encoder = std::move(tmp);
        }
        if (new_config.send_codec_spec->cng_payload_type) {
          AudioEncoderCngConfig config;
          config.speech_encoder = std::move(old_encoder);
          config.num_channels = config.speech_encoder->NumChannels();
          config.payload_type = *new_config.send_codec_spec->cng_payload_type;
          config.vad_mode = Vad::kVadNormal;
          *encoder_ptr = CreateComfortNoiseEncoder(std::move(config));
        } else {
          *encoder_ptr = std::move(old_encoder);
        }
      });
}

void AudioSendStream::ReconfigureBitrateObserver(
    AudioSendStream* stream,
    const webrtc::AudioSendStream::Config& new_config) {
  RTC_DCHECK_RUN_ON(&stream->worker_thread_checker_);
  // Since the Config's default is for both of these to be -1, this test will
  // allow us to configure the bitrate observer if the new config has bitrate
  // limits set, but would only have us call RemoveBitrateObserver if we were
  // previously configured with bitrate limits.
  if (stream->config_.min_bitrate_bps == new_config.min_bitrate_bps &&
      stream->config_.max_bitrate_bps == new_config.max_bitrate_bps &&
      stream->config_.bitrate_priority == new_config.bitrate_priority &&
      (TransportSeqNumId(stream->config_) == TransportSeqNumId(new_config) ||
       stream->allocation_settings_.IgnoreSeqNumIdChange())) {
    return;
  }

  if (stream->allocation_settings_.IncludeAudioInAllocationOnReconfigure(
          new_config.min_bitrate_bps, new_config.max_bitrate_bps,
          new_config.has_dscp, TransportSeqNumId(new_config))) {
    stream->rtp_transport_->packet_sender()->SetAccountForAudioPackets(true);
    rtc::Event thread_sync_event;
    stream->worker_queue_->PostTask([&] {
      RTC_DCHECK_RUN_ON(stream->worker_queue_);
      stream->registered_with_allocator_ = true;
      // We may get a callback immediately as the observer is registered, so
      // make
      // sure the bitrate limits in config_ are up-to-date.
      stream->config_.min_bitrate_bps = new_config.min_bitrate_bps;
      stream->config_.max_bitrate_bps = new_config.max_bitrate_bps;
      stream->config_.bitrate_priority = new_config.bitrate_priority;
      stream->ConfigureBitrateObserver();
      thread_sync_event.Set();
    });
    thread_sync_event.Wait(rtc::Event::kForever);
    stream->rtp_rtcp_module_->SetAsPartOfAllocation(true);
  } else {
    stream->rtp_transport_->packet_sender()->SetAccountForAudioPackets(false);
    stream->RemoveBitrateObserver();
    stream->rtp_rtcp_module_->SetAsPartOfAllocation(false);
  }
}

void AudioSendStream::ConfigureBitrateObserver() {
  // This either updates the current observer or adds a new observer.
  // TODO(srte): Add overhead compensation here.
  bitrate_allocator_->AddObserver(
      this, MediaStreamAllocationConfig{
                static_cast<uint32_t>(config_.min_bitrate_bps),
                static_cast<uint32_t>(config_.max_bitrate_bps), 0,
                allocation_settings_.DefaultPriorityBitrate().bps(), true,
                config_.track_id, config_.bitrate_priority});
}

void AudioSendStream::RemoveBitrateObserver() {
  RTC_DCHECK(worker_thread_checker_.IsCurrent());
  rtc::Event thread_sync_event;
  worker_queue_->PostTask([this, &thread_sync_event] {
    RTC_DCHECK_RUN_ON(worker_queue_);
    registered_with_allocator_ = false;
    bitrate_allocator_->RemoveObserver(this);
    thread_sync_event.Set();
  });
  thread_sync_event.Wait(rtc::Event::kForever);
}

void AudioSendStream::RegisterCngPayloadType(int payload_type,
                                             int clockrate_hz) {
  channel_send_->RegisterCngPayloadType(payload_type, clockrate_hz);
}
}  // namespace internal
}  // namespace webrtc
