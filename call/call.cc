﻿/*
 *  Copyright (c) 2013 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include <string.h>
#include <algorithm>
#include <map>
#include <memory>
#include <set>
#include <utility>
#include <vector>

#include "absl/memory/memory.h"
#include "absl/types/optional.h"
#include "api/task_queue/global_task_queue_factory.h"
#include "api/transport/network_control.h"
#include "audio/audio_receive_stream.h"
#include "audio/audio_send_stream.h"
#include "audio/audio_state.h"
#include "call/bitrate_allocator.h"
#include "call/call.h"
#include "call/flexfec_receive_stream_impl.h"
#include "call/receive_time_calculator.h"
#include "call/rtp_stream_receiver_controller.h"
#include "call/rtp_transport_controller_send.h"
#include "logging/rtc_event_log/events/rtc_event_audio_receive_stream_config.h"
#include "logging/rtc_event_log/events/rtc_event_rtcp_packet_incoming.h"
#include "logging/rtc_event_log/events/rtc_event_rtp_packet_incoming.h"
#include "logging/rtc_event_log/events/rtc_event_video_receive_stream_config.h"
#include "logging/rtc_event_log/events/rtc_event_video_send_stream_config.h"
#include "logging/rtc_event_log/rtc_event_log.h"
#include "logging/rtc_event_log/rtc_stream_config.h"
#include "modules/bitrate_controller/include/bitrate_controller.h"
#include "modules/congestion_controller/include/receive_side_congestion_controller.h"
#include "modules/rtp_rtcp/include/flexfec_receiver.h"
#include "modules/rtp_rtcp/include/rtp_header_extension_map.h"
#include "modules/rtp_rtcp/include/rtp_header_parser.h"
#include "modules/rtp_rtcp/source/byte_io.h"
#include "modules/rtp_rtcp/source/rtp_packet_received.h"
#include "modules/utility/include/process_thread.h"
#include "modules/video_coding/fec_controller_default.h"
#include "rtc_base/checks.h"
#include "rtc_base/constructor_magic.h"
#include "rtc_base/location.h"
#include "rtc_base/logging.h"
#include "rtc_base/numerics/safe_minmax.h"
#include "rtc_base/strings/string_builder.h"
#include "rtc_base/synchronization/rw_lock_wrapper.h"
#include "rtc_base/synchronization/sequence_checker.h"
#include "rtc_base/thread_annotations.h"
#include "rtc_base/time_utils.h"
#include "rtc_base/trace_event.h"
#include "system_wrappers/include/clock.h"
#include "system_wrappers/include/cpu_info.h"
#include "system_wrappers/include/field_trial.h"
#include "system_wrappers/include/metrics.h"
#include "video/call_stats.h"
#include "video/send_delay_stats.h"
#include "video/stats_counter.h"
#include "video/video_receive_stream.h"
#include "video/video_send_stream.h"

namespace webrtc {



	////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////      TODO@chensong  2022-11-29  call 

//#if 0
//
//static FILE* out_rtc_call_ptr = NULL;
//static void rtc_call_log() {
//  if (!out_rtc_call_ptr) {
//    out_rtc_call_ptr =
//        ::fopen("./debug/call.log", "wb+");
//  }
//
//}
//
//#define RTC_GCC_NETWORK_CONTROL_LOG()
//#define RTC_NORMAL_LOG(format, ...)                         \
//  rtc_call_log();                                        \
//  if ( out_rtc_call_ptr) { 					\
//  fprintf(out_rtc_call_ptr, format, ##__VA_ARGS__); \
//  fprintf(out_rtc_call_ptr, "\n");                  \
//  fflush(out_rtc_call_ptr);}
//
//#define RTC_NORMAL_EX_LOG(format, ...) \
//  RTC_NORMAL_LOG("[%s][%d][info]" format, __FUNCTION__, __LINE__, ##__VA_ARGS__)
//#define ERROR_EX_LOG(format, ...) \
//  RTC_NORMAL_LOG("[%s][%d][error]" format, __FUNCTION__, __LINE__, ##__VA_ARGS__)
//#define WARNING_EX_LOG(format, ...) \
//  RTC_NORMAL_LOG("[%s][%d][warning]" format, __FUNCTION__, __LINE__, ##__VA_ARGS__)
//#endif  // _DEBUG



namespace {
bool SendPeriodicFeedback(const std::vector<RtpExtension>& extensions) {
  for (const auto& extension : extensions) {
    if (extension.uri == RtpExtension::kTransportSequenceNumberV2Uri)
      return false;
  }
  return true;
}

// TODO(nisse): This really begs for a shared context struct.
bool UseSendSideBwe(const std::vector<RtpExtension>& extensions,
                    bool transport_cc) {
  if (!transport_cc)
    return false;
  for (const auto& extension : extensions) {
    if (extension.uri == RtpExtension::kTransportSequenceNumberUri ||
        extension.uri == RtpExtension::kTransportSequenceNumberV2Uri)
      return true;
  }
  return false;
}

bool UseSendSideBwe(const VideoReceiveStream::Config& config) {
  return UseSendSideBwe(config.rtp.extensions, config.rtp.transport_cc);
}

bool UseSendSideBwe(const AudioReceiveStream::Config& config) {
  return UseSendSideBwe(config.rtp.extensions, config.rtp.transport_cc);
}

bool UseSendSideBwe(const FlexfecReceiveStream::Config& config) {
  return UseSendSideBwe(config.rtp_header_extensions, config.transport_cc);
}

const int* FindKeyByValue(const std::map<int, int>& m, int v) {
  for (const auto& kv : m) {
    if (kv.second == v)
      return &kv.first;
  }
  return nullptr;
}

std::unique_ptr<rtclog::StreamConfig> CreateRtcLogStreamConfig(
    const VideoReceiveStream::Config& config) {
  auto rtclog_config = absl::make_unique<rtclog::StreamConfig>();
  rtclog_config->remote_ssrc = config.rtp.remote_ssrc;
  rtclog_config->local_ssrc = config.rtp.local_ssrc;
  rtclog_config->rtx_ssrc = config.rtp.rtx_ssrc;
  rtclog_config->rtcp_mode = config.rtp.rtcp_mode;
  rtclog_config->remb = config.rtp.remb;
  rtclog_config->rtp_extensions = config.rtp.extensions;

  for (const auto& d : config.decoders) {
    const int* search =
        FindKeyByValue(config.rtp.rtx_associated_payload_types, d.payload_type);
    rtclog_config->codecs.emplace_back(d.video_format.name, d.payload_type,
                                       search ? *search : 0);
  }
  return rtclog_config;
}

std::unique_ptr<rtclog::StreamConfig> CreateRtcLogStreamConfig(
    const VideoSendStream::Config& config,
    size_t ssrc_index) {
  auto rtclog_config = absl::make_unique<rtclog::StreamConfig>();
  rtclog_config->local_ssrc = config.rtp.ssrcs[ssrc_index];
  if (ssrc_index < config.rtp.rtx.ssrcs.size()) {
    rtclog_config->rtx_ssrc = config.rtp.rtx.ssrcs[ssrc_index];
  }
  rtclog_config->rtcp_mode = config.rtp.rtcp_mode;
  rtclog_config->rtp_extensions = config.rtp.extensions;

  rtclog_config->codecs.emplace_back(config.rtp.payload_name,
                                     config.rtp.payload_type,
                                     config.rtp.rtx.payload_type);
  return rtclog_config;
}

std::unique_ptr<rtclog::StreamConfig> CreateRtcLogStreamConfig(
    const AudioReceiveStream::Config& config) {
  auto rtclog_config = absl::make_unique<rtclog::StreamConfig>();
  rtclog_config->remote_ssrc = config.rtp.remote_ssrc;
  rtclog_config->local_ssrc = config.rtp.local_ssrc;
  rtclog_config->rtp_extensions = config.rtp.extensions;
  return rtclog_config;
}

}  // namespace

namespace internal {

class Call final : public webrtc::Call,
                   public PacketReceiver,
                   public RecoveredPacketReceiver,
                   public TargetTransferRateObserver,
                   public BitrateAllocator::LimitObserver {
 public:
  Call(Clock* clock, const Call::Config& config,
       std::unique_ptr<RtpTransportControllerSendInterface> transport_send,
       std::unique_ptr<ProcessThread> module_process_thread, TaskQueueFactory* task_queue_factory);
  ~Call() override;

  // Implements webrtc::Call.
  PacketReceiver* Receiver() override;

  webrtc::AudioSendStream* CreateAudioSendStream(const webrtc::AudioSendStream::Config& config) override;
  void DestroyAudioSendStream(webrtc::AudioSendStream* send_stream) override;

  webrtc::AudioReceiveStream* CreateAudioReceiveStream(const webrtc::AudioReceiveStream::Config& config) override;
  void DestroyAudioReceiveStream(webrtc::AudioReceiveStream* receive_stream) override;

  webrtc::VideoSendStream* CreateVideoSendStream(webrtc::VideoSendStream::Config config,VideoEncoderConfig encoder_config) override;
  webrtc::VideoSendStream* CreateVideoSendStream(webrtc::VideoSendStream::Config config,
      VideoEncoderConfig encoder_config, std::unique_ptr<FecController> fec_controller) override;
  void DestroyVideoSendStream(webrtc::VideoSendStream* send_stream) override;

  webrtc::VideoReceiveStream* CreateVideoReceiveStream(webrtc::VideoReceiveStream::Config configuration) override;
  void DestroyVideoReceiveStream(webrtc::VideoReceiveStream* receive_stream) override;

  FlexfecReceiveStream* CreateFlexfecReceiveStream(const FlexfecReceiveStream::Config& config) override;
  void DestroyFlexfecReceiveStream(FlexfecReceiveStream* receive_stream) override;

  RtpTransportControllerSendInterface* GetTransportControllerSend() override;

  Stats GetStats() const override;

  // Implements PacketReceiver.
  DeliveryStatus DeliverPacket(MediaType media_type, rtc::CopyOnWriteBuffer packet, int64_t packet_time_us) override;

  // Implements RecoveredPacketReceiver.
  void OnRecoveredPacket(const uint8_t* packet, size_t length) override;

  void SetBitrateAllocationStrategy(std::unique_ptr<rtc::BitrateAllocationStrategy> bitrate_allocation_strategy) override;

  void SignalChannelNetworkState(MediaType media, NetworkState state) override;

  void OnAudioTransportOverheadChanged(int transport_overhead_per_packet) override;

  void OnSentPacket(const rtc::SentPacket& sent_packet) override;

  // Implements TargetTransferRateObserver,
  void OnTargetTransferRate(TargetTransferRate msg) override;
  void OnStartRateUpdate(DataRate start_rate) override;

  // Implements BitrateAllocator::LimitObserver.
  void OnAllocationLimitsChanged(uint32_t min_send_bitrate_bps, uint32_t max_padding_bitrate_bps, uint32_t total_bitrate_bps) override;

  // This method is invoked when the media transport is created and when the
  // media transport is being destructed.
  // We only allow one media transport per connection.
  //
  // It should be called with non-null argument at most once, and if it was
  // called with non-null argument, it has to be called with a null argument
  // at least once after that.
  void MediaTransportChange(MediaTransportInterface* media_transport) override;

  void SetClientBitratePreferences(const BitrateSettings& preferences) override;

 private:
  DeliveryStatus DeliverRtcp(MediaType media_type, const uint8_t* packet, size_t length);
  DeliveryStatus DeliverRtp(MediaType media_type, rtc::CopyOnWriteBuffer packet, int64_t packet_time_us);
  void ConfigureSync(const std::string& sync_group) RTC_EXCLUSIVE_LOCKS_REQUIRED(receive_crit_);

  void NotifyBweOfReceivedPacket(const RtpPacketReceived& packet,
                                 MediaType media_type)
      RTC_SHARED_LOCKS_REQUIRED(receive_crit_);

  void UpdateSendHistograms(int64_t first_sent_packet_ms)
      RTC_EXCLUSIVE_LOCKS_REQUIRED(&bitrate_crit_);
  void UpdateReceiveHistograms();
  void UpdateHistograms();
  void UpdateAggregateNetworkState();

  //  If |media_transport| is not null, it registers the rate observer for the
  //  media transport.
  void RegisterRateObserver() RTC_LOCKS_EXCLUDED(target_observer_crit_);

  // Intended for DCHECKs, to avoid locking in production builds.
  MediaTransportInterface* media_transport()
      RTC_LOCKS_EXCLUDED(target_observer_crit_);

  Clock* const clock_;
  TaskQueueFactory* const task_queue_factory_;

  // Caching the last SetBitrate for media transport.
  absl::optional<MediaTransportTargetRateConstraints> last_set_bitrate_
      RTC_GUARDED_BY(&target_observer_crit_);
  const int num_cpu_cores_;
  const std::unique_ptr<ProcessThread> module_process_thread_;
  const std::unique_ptr<CallStats> call_stats_;
  const std::unique_ptr<BitrateAllocator> bitrate_allocator_;
  Call::Config config_;
  SequenceChecker configuration_sequence_checker_;

  NetworkState audio_network_state_;
  NetworkState video_network_state_;
  rtc::CriticalSection aggregate_network_up_crit_;
  bool aggregate_network_up_ RTC_GUARDED_BY(aggregate_network_up_crit_);

  std::unique_ptr<RWLockWrapper> receive_crit_;
  // Audio, Video, and FlexFEC receive streams are owned by the client that
  // creates them.
  std::set<AudioReceiveStream*> audio_receive_streams_
      RTC_GUARDED_BY(receive_crit_);
  std::set<VideoReceiveStream*> video_receive_streams_
      RTC_GUARDED_BY(receive_crit_);

  std::map<std::string, AudioReceiveStream*> sync_stream_mapping_
      RTC_GUARDED_BY(receive_crit_);

  // TODO(nisse): Should eventually be injected at creation,
  // with a single object in the bundled case.
  RtpStreamReceiverController audio_receiver_controller_;
  RtpStreamReceiverController video_receiver_controller_;

  // This extra map is used for receive processing which is
  // independent of media type.

  // TODO(nisse): In the RTP transport refactoring, we should have a
  // single mapping from ssrc to a more abstract receive stream, with
  // accessor methods for all configuration we need at this level.
  struct ReceiveRtpConfig {
    explicit ReceiveRtpConfig(const webrtc::AudioReceiveStream::Config& config)
        : extensions(config.rtp.extensions),
          use_send_side_bwe(UseSendSideBwe(config)) {}
    explicit ReceiveRtpConfig(const webrtc::VideoReceiveStream::Config& config)
        : extensions(config.rtp.extensions),
          use_send_side_bwe(UseSendSideBwe(config)) {}
    explicit ReceiveRtpConfig(const FlexfecReceiveStream::Config& config)
        : extensions(config.rtp_header_extensions),
          use_send_side_bwe(UseSendSideBwe(config)) {}

    // Registered RTP header extensions for each stream. Note that RTP header
    // extensions are negotiated per track ("m= line") in the SDP, but we have
    // no notion of tracks at the Call level. We therefore store the RTP header
    // extensions per SSRC instead, which leads to some storage overhead.
    const RtpHeaderExtensionMap extensions;
    // Set if both RTP extension the RTCP feedback message needed for
    // send side BWE are negotiated.
    const bool use_send_side_bwe;
  };
  std::map<uint32_t, ReceiveRtpConfig> receive_rtp_config_
      RTC_GUARDED_BY(receive_crit_);

  std::unique_ptr<RWLockWrapper> send_crit_;
  // Audio and Video send streams are owned by the client that creates them.
  std::map<uint32_t, AudioSendStream*> audio_send_ssrcs_
      RTC_GUARDED_BY(send_crit_);
  std::map<uint32_t, VideoSendStream*> video_send_ssrcs_
      RTC_GUARDED_BY(send_crit_);
  std::set<VideoSendStream*> video_send_streams_ RTC_GUARDED_BY(send_crit_);

  using RtpStateMap = std::map<uint32_t, RtpState>;
  RtpStateMap suspended_audio_send_ssrcs_
      RTC_GUARDED_BY(configuration_sequence_checker_);
  RtpStateMap suspended_video_send_ssrcs_
      RTC_GUARDED_BY(configuration_sequence_checker_);

  using RtpPayloadStateMap = std::map<uint32_t, RtpPayloadState>;
  RtpPayloadStateMap suspended_video_payload_states_
      RTC_GUARDED_BY(configuration_sequence_checker_);

  webrtc::RtcEventLog* event_log_;

  // The following members are only accessed (exclusively) from one thread and
  // from the destructor, and therefore doesn't need any explicit
  // synchronization.
  RateCounter received_bytes_per_second_counter_;
  RateCounter received_audio_bytes_per_second_counter_;
  RateCounter received_video_bytes_per_second_counter_;
  RateCounter received_rtcp_bytes_per_second_counter_;
  absl::optional<int64_t> first_received_rtp_audio_ms_;
  absl::optional<int64_t> last_received_rtp_audio_ms_;
  absl::optional<int64_t> first_received_rtp_video_ms_;
  absl::optional<int64_t> last_received_rtp_video_ms_;

  rtc::CriticalSection last_bandwidth_bps_crit_;
  uint32_t last_bandwidth_bps_ RTC_GUARDED_BY(&last_bandwidth_bps_crit_);
  // TODO(holmer): Remove this lock once BitrateController no longer calls
  // OnNetworkChanged from multiple threads.
  rtc::CriticalSection bitrate_crit_;
  uint32_t min_allocated_send_bitrate_bps_ RTC_GUARDED_BY(&bitrate_crit_);
  uint32_t configured_max_padding_bitrate_bps_ RTC_GUARDED_BY(&bitrate_crit_);
  AvgCounter estimated_send_bitrate_kbps_counter_
      RTC_GUARDED_BY(&bitrate_crit_);
  AvgCounter pacer_bitrate_kbps_counter_ RTC_GUARDED_BY(&bitrate_crit_);

  ReceiveSideCongestionController receive_side_cc_;

  const std::unique_ptr<ReceiveTimeCalculator> receive_time_calculator_;

  const std::unique_ptr<SendDelayStats> video_send_delay_stats_;
  const int64_t start_ms_;

  // Caches transport_send_.get(), to avoid racing with destructor.
  // Note that this is declared before transport_send_ to ensure that it is not
  // invalidated until no more tasks can be running on the transport_send_ task
  // queue.
  RtpTransportControllerSendInterface* transport_send_ptr_;
  // Declared last since it will issue callbacks from a task queue. Declaring it
  // last ensures that it is destroyed first and any running tasks are finished.
  std::unique_ptr<RtpTransportControllerSendInterface> transport_send_;

  // This is a precaution, since |MediaTransportChange| is not guaranteed to be
  // invoked on a particular thread.
  rtc::CriticalSection target_observer_crit_;
  bool is_target_rate_observer_registered_
      RTC_GUARDED_BY(&target_observer_crit_) = false;
  MediaTransportInterface* media_transport_
      RTC_GUARDED_BY(&target_observer_crit_) = nullptr;

  RTC_DISALLOW_COPY_AND_ASSIGN(Call);
};
}  // namespace internal

std::string Call::Stats::ToString(int64_t time_ms) const {
  char buf[1024];
  rtc::SimpleStringBuilder ss(buf);
  ss << "Call stats: " << time_ms << ", {";
  ss << "send_bw_bps: " << send_bandwidth_bps << ", ";
  ss << "recv_bw_bps: " << recv_bandwidth_bps << ", ";
  ss << "max_pad_bps: " << max_padding_bitrate_bps << ", ";
  ss << "pacer_delay_ms: " << pacer_delay_ms << ", ";
  ss << "rtt_ms: " << rtt_ms;
  ss << '}';
  return ss.str();
}
// TODO@chensong 20220803 网络发送信息包线程 PacerThread、ModuleProcessThread
Call* Call::Create(const Call::Config& config) {
  return Create(config, Clock::GetRealTimeClock(),
                ProcessThread::Create("PacerThread"),
                ProcessThread::Create("ModuleProcessThread"));
}

Call* Call::Create(const Call::Config& config,
                   Clock* clock,
                   std::unique_ptr<ProcessThread> call_thread,
                   std::unique_ptr<ProcessThread> pacer_thread) {
  // TODO(bugs.webrtc.org/10284): DCHECK task_queue_factory dependency is
  // always provided in the config.
  TaskQueueFactory* task_queue_factory = config.task_queue_factory
                                             ? config.task_queue_factory
                                             : &GlobalTaskQueueFactory();

  // TODO@chensong 2022-09-29
  //		1.
  //RtpTransportControllerSend中有个线程pacer专门发送网络包反馈网络情况
  //		2. Call :
  return new internal::Call(
      clock, config,
      absl::make_unique<RtpTransportControllerSend>(
          clock, config.event_log, config.network_state_predictor_factory,
          config.network_controller_factory, config.bitrate_config,
          std::move(pacer_thread), task_queue_factory),
      std::move(call_thread), task_queue_factory);
}

// This method here to avoid subclasses has to implement this method.
// Call perf test will use Internal::Call::CreateVideoSendStream() to inject
// FecController.
VideoSendStream* Call::CreateVideoSendStream(
    VideoSendStream::Config config,
    VideoEncoderConfig encoder_config,
    std::unique_ptr<FecController> fec_controller) {
  return nullptr;
}

namespace internal {

Call::Call(Clock* clock,
           const Call::Config& config,
           std::unique_ptr<RtpTransportControllerSendInterface> transport_send,
           std::unique_ptr<ProcessThread> module_process_thread,
           TaskQueueFactory* task_queue_factory)
    : clock_(clock),
      task_queue_factory_(task_queue_factory),
      num_cpu_cores_(CpuInfo::DetectNumberOfCores()),
      module_process_thread_(std::move(module_process_thread)),
      call_stats_(new CallStats(clock_, module_process_thread_.get())),
      bitrate_allocator_(new BitrateAllocator(clock_, this)),
      config_(config),
      audio_network_state_(kNetworkDown),
      video_network_state_(kNetworkDown),
      aggregate_network_up_(false),
      receive_crit_(RWLockWrapper::CreateRWLock()),
      send_crit_(RWLockWrapper::CreateRWLock()),
      event_log_(config.event_log),
      received_bytes_per_second_counter_(clock_, nullptr, true),
      received_audio_bytes_per_second_counter_(clock_, nullptr, true),
      received_video_bytes_per_second_counter_(clock_, nullptr, true),
      received_rtcp_bytes_per_second_counter_(clock_, nullptr, true),
      last_bandwidth_bps_(0),
      min_allocated_send_bitrate_bps_(0),
      configured_max_padding_bitrate_bps_(0),
      estimated_send_bitrate_kbps_counter_(clock_, nullptr, true),
      pacer_bitrate_kbps_counter_(clock_, nullptr, true),
      receive_side_cc_(clock_, transport_send->packet_router()),
      receive_time_calculator_(ReceiveTimeCalculator::CreateFromFieldTrial()),
      video_send_delay_stats_(new SendDelayStats(clock_)),
      start_ms_(clock_->TimeInMilliseconds()) {
  RTC_DCHECK(config.event_log != nullptr);
  transport_send_ = std::move(transport_send);
  transport_send_ptr_ = transport_send_.get();
}

Call::~Call() {
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);

  RTC_CHECK(audio_send_ssrcs_.empty());
  RTC_CHECK(video_send_ssrcs_.empty());
  RTC_CHECK(video_send_streams_.empty());
  RTC_CHECK(audio_receive_streams_.empty());
  RTC_CHECK(video_receive_streams_.empty());

  if (!media_transport_) {
    module_process_thread_->DeRegisterModule(receive_side_cc_.GetRemoteBitrateEstimator(true));
    module_process_thread_->DeRegisterModule(&receive_side_cc_);
    module_process_thread_->DeRegisterModule(call_stats_.get());
    module_process_thread_->Stop();
    call_stats_->DeregisterStatsObserver(&receive_side_cc_);
  }

  int64_t first_sent_packet_ms = transport_send_->GetFirstPacketTimeMs();
  // Only update histograms after process threads have been shut down, so that
  // they won't try to concurrently update stats.
  {
    rtc::CritScope lock(&bitrate_crit_);
    UpdateSendHistograms(first_sent_packet_ms);
  }
  UpdateReceiveHistograms();
  UpdateHistograms();
}

void Call::RegisterRateObserver() {
  rtc::CritScope lock(&target_observer_crit_);

  if (is_target_rate_observer_registered_) {
    return;
  }

  is_target_rate_observer_registered_ = true;

  if (media_transport_) {
    // TODO(bugs.webrtc.org/9719): We should report call_stats_ from
    // media transport (at least Rtt). We should extend media transport
    // interface to include "receive_side bwe" if needed.
    media_transport_->AddTargetTransferRateObserver(this);
  } else {
    transport_send_ptr_->RegisterTargetTransferRateObserver(this);

    call_stats_->RegisterStatsObserver(&receive_side_cc_);

    module_process_thread_->RegisterModule(receive_side_cc_.GetRemoteBitrateEstimator(true), RTC_FROM_HERE);
    module_process_thread_->RegisterModule(call_stats_.get(), RTC_FROM_HERE);
    module_process_thread_->RegisterModule(&receive_side_cc_, RTC_FROM_HERE);
    module_process_thread_->Start();
  }
}

MediaTransportInterface* Call::media_transport() {
  rtc::CritScope lock(&target_observer_crit_);
  return media_transport_;
}

void Call::MediaTransportChange(MediaTransportInterface* media_transport) {
  rtc::CritScope lock(&target_observer_crit_);

  if (is_target_rate_observer_registered_) {
    // Only used to unregister rate observer from media transport. Registration
    // happens when the stream is created.
    if (!media_transport && media_transport_) {
      media_transport_->RemoveTargetTransferRateObserver(this);
      media_transport_ = nullptr;
      is_target_rate_observer_registered_ = false;
    }
  } else if (media_transport) {
    RTC_DCHECK(media_transport_ == nullptr ||
               media_transport_ == media_transport)
        << "media_transport_=" << (media_transport_ != nullptr)
        << ", (media_transport_==media_transport)="
        << (media_transport_ == media_transport);
    media_transport_ = media_transport;
    MediaTransportTargetRateConstraints constraints;
    if (config_.bitrate_config.start_bitrate_bps > 0) {
      constraints.starting_bitrate =
          DataRate::bps(config_.bitrate_config.start_bitrate_bps);
    }
    if (config_.bitrate_config.max_bitrate_bps > 0) {
      constraints.max_bitrate =
          DataRate::bps(config_.bitrate_config.max_bitrate_bps);
    }
    if (config_.bitrate_config.min_bitrate_bps > 0) {
      constraints.min_bitrate =
          DataRate::bps(config_.bitrate_config.min_bitrate_bps);
    }

    // User called ::SetBitrate on peer connection before
    // media transport was created.
    if (last_set_bitrate_) {
      media_transport_->SetTargetBitrateLimits(*last_set_bitrate_);
    } else {
      media_transport_->SetTargetBitrateLimits(constraints);
    }
  }
}

void Call::SetClientBitratePreferences(const BitrateSettings& preferences) {
  GetTransportControllerSend()->SetClientBitratePreferences(preferences);
  // Can the client code invoke 'SetBitrate' before media transport is created?
  // It's probably possible :/
  MediaTransportTargetRateConstraints constraints;
  if (preferences.start_bitrate_bps.has_value()) {
    constraints.starting_bitrate =
        webrtc::DataRate::bps(*preferences.start_bitrate_bps);
  }
  if (preferences.max_bitrate_bps.has_value()) {
    constraints.max_bitrate =
        webrtc::DataRate::bps(*preferences.max_bitrate_bps);
  }
  if (preferences.min_bitrate_bps.has_value()) {
    constraints.min_bitrate =
        webrtc::DataRate::bps(*preferences.min_bitrate_bps);
  }
  rtc::CritScope lock(&target_observer_crit_);
  last_set_bitrate_ = constraints;
  if (media_transport_) {
    media_transport_->SetTargetBitrateLimits(constraints);
  }
}

void Call::UpdateHistograms() {
  RTC_HISTOGRAM_COUNTS_100000(
      "WebRTC.Call.LifetimeInSeconds",
      (clock_->TimeInMilliseconds() - start_ms_) / 1000);
}

void Call::UpdateSendHistograms(int64_t first_sent_packet_ms) {
  if (first_sent_packet_ms == -1)
    return;
  int64_t elapsed_sec =
      (clock_->TimeInMilliseconds() - first_sent_packet_ms) / 1000;
  if (elapsed_sec < metrics::kMinRunTimeInSeconds)
    return;
  const int kMinRequiredPeriodicSamples = 5;
  AggregatedStats send_bitrate_stats =
      estimated_send_bitrate_kbps_counter_.ProcessAndGetStats();
  if (send_bitrate_stats.num_samples > kMinRequiredPeriodicSamples) {
    RTC_HISTOGRAM_COUNTS_100000("WebRTC.Call.EstimatedSendBitrateInKbps",
                                send_bitrate_stats.average);
    RTC_LOG(LS_INFO) << "WebRTC.Call.EstimatedSendBitrateInKbps, "
                     << send_bitrate_stats.ToString();
  }
  AggregatedStats pacer_bitrate_stats =
      pacer_bitrate_kbps_counter_.ProcessAndGetStats();
  if (pacer_bitrate_stats.num_samples > kMinRequiredPeriodicSamples) {
    RTC_HISTOGRAM_COUNTS_100000("WebRTC.Call.PacerBitrateInKbps",
                                pacer_bitrate_stats.average);
    RTC_LOG(LS_INFO) << "WebRTC.Call.PacerBitrateInKbps, "
                     << pacer_bitrate_stats.ToString();
  }
}

void Call::UpdateReceiveHistograms() {
  if (first_received_rtp_audio_ms_) {
    RTC_HISTOGRAM_COUNTS_100000(
        "WebRTC.Call.TimeReceivingAudioRtpPacketsInSeconds",
        (*last_received_rtp_audio_ms_ - *first_received_rtp_audio_ms_) / 1000);
  }
  if (first_received_rtp_video_ms_) {
    RTC_HISTOGRAM_COUNTS_100000(
        "WebRTC.Call.TimeReceivingVideoRtpPacketsInSeconds",
        (*last_received_rtp_video_ms_ - *first_received_rtp_video_ms_) / 1000);
  }
  const int kMinRequiredPeriodicSamples = 5;
  AggregatedStats video_bytes_per_sec =
      received_video_bytes_per_second_counter_.GetStats();
  if (video_bytes_per_sec.num_samples > kMinRequiredPeriodicSamples) {
    RTC_HISTOGRAM_COUNTS_100000("WebRTC.Call.VideoBitrateReceivedInKbps",
                                video_bytes_per_sec.average * 8 / 1000);
    RTC_LOG(LS_INFO) << "WebRTC.Call.VideoBitrateReceivedInBps, "
                     << video_bytes_per_sec.ToStringWithMultiplier(8);
  }
  AggregatedStats audio_bytes_per_sec =
      received_audio_bytes_per_second_counter_.GetStats();
  if (audio_bytes_per_sec.num_samples > kMinRequiredPeriodicSamples) {
    RTC_HISTOGRAM_COUNTS_100000("WebRTC.Call.AudioBitrateReceivedInKbps",
                                audio_bytes_per_sec.average * 8 / 1000);
    RTC_LOG(LS_INFO) << "WebRTC.Call.AudioBitrateReceivedInBps, "
                     << audio_bytes_per_sec.ToStringWithMultiplier(8);
  }
  AggregatedStats rtcp_bytes_per_sec =
      received_rtcp_bytes_per_second_counter_.GetStats();
  if (rtcp_bytes_per_sec.num_samples > kMinRequiredPeriodicSamples) {
    RTC_HISTOGRAM_COUNTS_100000("WebRTC.Call.RtcpBitrateReceivedInBps",
                                rtcp_bytes_per_sec.average * 8);
    RTC_LOG(LS_INFO) << "WebRTC.Call.RtcpBitrateReceivedInBps, "
                     << rtcp_bytes_per_sec.ToStringWithMultiplier(8);
  }
  AggregatedStats recv_bytes_per_sec =
      received_bytes_per_second_counter_.GetStats();
  if (recv_bytes_per_sec.num_samples > kMinRequiredPeriodicSamples) {
    RTC_HISTOGRAM_COUNTS_100000("WebRTC.Call.BitrateReceivedInKbps",
                                recv_bytes_per_sec.average * 8 / 1000);
    RTC_LOG(LS_INFO) << "WebRTC.Call.BitrateReceivedInBps, "
                     << recv_bytes_per_sec.ToStringWithMultiplier(8);
  }
}

PacketReceiver* Call::Receiver() {
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);
  return this;
}

webrtc::AudioSendStream* Call::CreateAudioSendStream(
    const webrtc::AudioSendStream::Config& config) {
  TRACE_EVENT0("webrtc", "Call::CreateAudioSendStream");
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);

  RTC_DCHECK(media_transport() == config.media_transport);

  RegisterRateObserver();

  // Stream config is logged in AudioSendStream::ConfigureStream, as it may
  // change during the stream's lifetime.
  absl::optional<RtpState> suspended_rtp_state;
  {
    const auto& iter = suspended_audio_send_ssrcs_.find(config.rtp.ssrc);
    if (iter != suspended_audio_send_ssrcs_.end()) {
      suspended_rtp_state.emplace(iter->second);
    }
  }

  AudioSendStream* send_stream =
      new AudioSendStream(clock_, config, config_.audio_state,
                          task_queue_factory_, module_process_thread_.get(),
                          transport_send_ptr_, bitrate_allocator_.get(),
                          event_log_, call_stats_.get(), suspended_rtp_state);
  {
    WriteLockScoped write_lock(*send_crit_);
    RTC_DCHECK(audio_send_ssrcs_.find(config.rtp.ssrc) ==
               audio_send_ssrcs_.end());
    audio_send_ssrcs_[config.rtp.ssrc] = send_stream;
  }
  {
    ReadLockScoped read_lock(*receive_crit_);
    for (AudioReceiveStream* stream : audio_receive_streams_) {
      if (stream->config().rtp.local_ssrc == config.rtp.ssrc) {
        stream->AssociateSendStream(send_stream);
      }
    }
  }
  send_stream->SignalNetworkState(audio_network_state_);
  UpdateAggregateNetworkState();
  return send_stream;
}

void Call::DestroyAudioSendStream(webrtc::AudioSendStream* send_stream) {
  TRACE_EVENT0("webrtc", "Call::DestroyAudioSendStream");
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);
  RTC_DCHECK(send_stream != nullptr);

  send_stream->Stop();

  const uint32_t ssrc = send_stream->GetConfig().rtp.ssrc;
  webrtc::internal::AudioSendStream* audio_send_stream =
      static_cast<webrtc::internal::AudioSendStream*>(send_stream);
  suspended_audio_send_ssrcs_[ssrc] = audio_send_stream->GetRtpState();
  {
    WriteLockScoped write_lock(*send_crit_);
    size_t num_deleted = audio_send_ssrcs_.erase(ssrc);
    RTC_DCHECK_EQ(1, num_deleted);
  }
  {
    ReadLockScoped read_lock(*receive_crit_);
    for (AudioReceiveStream* stream : audio_receive_streams_) {
      if (stream->config().rtp.local_ssrc == ssrc) {
        stream->AssociateSendStream(nullptr);
      }
    }
  }
  UpdateAggregateNetworkState();
  delete send_stream;
}

webrtc::AudioReceiveStream* Call::CreateAudioReceiveStream(
    const webrtc::AudioReceiveStream::Config& config) {
  TRACE_EVENT0("webrtc", "Call::CreateAudioReceiveStream");
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);
  RegisterRateObserver();
  event_log_->Log(absl::make_unique<RtcEventAudioReceiveStreamConfig>(
      CreateRtcLogStreamConfig(config)));
  AudioReceiveStream* receive_stream = new AudioReceiveStream(
      clock_, &audio_receiver_controller_, transport_send_ptr_->packet_router(),
      module_process_thread_.get(), config, config_.audio_state, event_log_);
  {
    WriteLockScoped write_lock(*receive_crit_);
    receive_rtp_config_.emplace(config.rtp.remote_ssrc,
                                ReceiveRtpConfig(config));
    audio_receive_streams_.insert(receive_stream);

    ConfigureSync(config.sync_group);
  }
  {
    ReadLockScoped read_lock(*send_crit_);
    auto it = audio_send_ssrcs_.find(config.rtp.local_ssrc);
    if (it != audio_send_ssrcs_.end()) {
      receive_stream->AssociateSendStream(it->second);
    }
  }
  receive_stream->SignalNetworkState(audio_network_state_);
  UpdateAggregateNetworkState();
  return receive_stream;
}

void Call::DestroyAudioReceiveStream(
    webrtc::AudioReceiveStream* receive_stream) {
  TRACE_EVENT0("webrtc", "Call::DestroyAudioReceiveStream");
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);
  RTC_DCHECK(receive_stream != nullptr);
  webrtc::internal::AudioReceiveStream* audio_receive_stream =
      static_cast<webrtc::internal::AudioReceiveStream*>(receive_stream);
  {
    WriteLockScoped write_lock(*receive_crit_);
    const AudioReceiveStream::Config& config = audio_receive_stream->config();
    uint32_t ssrc = config.rtp.remote_ssrc;
    receive_side_cc_.GetRemoteBitrateEstimator(UseSendSideBwe(config))->RemoveStream(ssrc);
    audio_receive_streams_.erase(audio_receive_stream);
    const std::string& sync_group = audio_receive_stream->config().sync_group;
    const auto it = sync_stream_mapping_.find(sync_group);
    if (it != sync_stream_mapping_.end() &&
        it->second == audio_receive_stream) {
      sync_stream_mapping_.erase(it);
      ConfigureSync(sync_group);
    }
    receive_rtp_config_.erase(ssrc);
  }
  UpdateAggregateNetworkState();
  delete audio_receive_stream;
}

// This method can be used for Call tests with external fec controller factory.
webrtc::VideoSendStream* Call::CreateVideoSendStream(
    webrtc::VideoSendStream::Config config,
    VideoEncoderConfig encoder_config,
    std::unique_ptr<FecController> fec_controller) {
  TRACE_EVENT0("webrtc", "Call::CreateVideoSendStream");
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);

  RTC_DCHECK(media_transport() == config.media_transport);

  RegisterRateObserver();

  video_send_delay_stats_->AddSsrcs(config);
  for (size_t ssrc_index = 0; ssrc_index < config.rtp.ssrcs.size();
       ++ssrc_index) {
    event_log_->Log(absl::make_unique<RtcEventVideoSendStreamConfig>(
        CreateRtcLogStreamConfig(config, ssrc_index)));
  }

  // TODO(mflodman): Base the start bitrate on a current bandwidth estimate, if
  // the call has already started.
  // Copy ssrcs from |config| since |config| is moved.
  std::vector<uint32_t> ssrcs = config.rtp.ssrcs;

  VideoSendStream* send_stream = new VideoSendStream(
      clock_, num_cpu_cores_, module_process_thread_.get(), task_queue_factory_,
      call_stats_.get(), transport_send_ptr_, bitrate_allocator_.get(),
      video_send_delay_stats_.get(), event_log_, std::move(config),
      std::move(encoder_config), suspended_video_send_ssrcs_,
      suspended_video_payload_states_, std::move(fec_controller));

  {
    WriteLockScoped write_lock(*send_crit_);
    for (uint32_t ssrc : ssrcs) {
      RTC_DCHECK(video_send_ssrcs_.find(ssrc) == video_send_ssrcs_.end());
      video_send_ssrcs_[ssrc] = send_stream;
    }
    video_send_streams_.insert(send_stream);
  }
  UpdateAggregateNetworkState();

  return send_stream;
}

webrtc::VideoSendStream* Call::CreateVideoSendStream(
    webrtc::VideoSendStream::Config config,
    VideoEncoderConfig encoder_config) {
  if (config_.fec_controller_factory) {
    RTC_LOG(LS_INFO) << "External FEC Controller will be used.";
  }
  std::unique_ptr<FecController> fec_controller =
      config_.fec_controller_factory
          ? config_.fec_controller_factory->CreateFecController()
          : absl::make_unique<FecControllerDefault>(clock_);
  return CreateVideoSendStream(std::move(config), std::move(encoder_config),
                               std::move(fec_controller));
}

void Call::DestroyVideoSendStream(webrtc::VideoSendStream* send_stream) {
  TRACE_EVENT0("webrtc", "Call::DestroyVideoSendStream");
  RTC_DCHECK(send_stream != nullptr);
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);

  send_stream->Stop();

  VideoSendStream* send_stream_impl = nullptr;
  {
    WriteLockScoped write_lock(*send_crit_);
    auto it = video_send_ssrcs_.begin();
    while (it != video_send_ssrcs_.end()) {
      if (it->second == static_cast<VideoSendStream*>(send_stream)) {
        send_stream_impl = it->second;
        video_send_ssrcs_.erase(it++);
      } else {
        ++it;
      }
    }
    video_send_streams_.erase(send_stream_impl);
  }
  RTC_CHECK(send_stream_impl != nullptr);

  VideoSendStream::RtpStateMap rtp_states;
  VideoSendStream::RtpPayloadStateMap rtp_payload_states;
  send_stream_impl->StopPermanentlyAndGetRtpStates(&rtp_states,
                                                   &rtp_payload_states);
  for (const auto& kv : rtp_states) {
    suspended_video_send_ssrcs_[kv.first] = kv.second;
  }
  for (const auto& kv : rtp_payload_states) {
    suspended_video_payload_states_[kv.first] = kv.second;
  }

  UpdateAggregateNetworkState();
  delete send_stream_impl;
}

webrtc::VideoReceiveStream* Call::CreateVideoReceiveStream(webrtc::VideoReceiveStream::Config configuration)
{
  TRACE_EVENT0("webrtc", "Call::CreateVideoReceiveStream");
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);

  receive_side_cc_.SetSendPeriodicFeedback(SendPeriodicFeedback(configuration.rtp.extensions));

  RegisterRateObserver();

  VideoReceiveStream* receive_stream = new VideoReceiveStream(
      task_queue_factory_, &video_receiver_controller_, num_cpu_cores_,
      transport_send_ptr_->packet_router(), std::move(configuration),
      module_process_thread_.get(), call_stats_.get(), clock_);

  const webrtc::VideoReceiveStream::Config& config = receive_stream->config();
  {
    WriteLockScoped write_lock(*receive_crit_);
    if (config.rtp.rtx_ssrc) {
      // We record identical config for the rtx stream as for the main
      // stream. Since the transport_send_cc negotiation is per payload
      // type, we may get an incorrect value for the rtx stream, but
      // that is unlikely to matter in practice.
      receive_rtp_config_.emplace(config.rtp.rtx_ssrc,
                                  ReceiveRtpConfig(config));
    }
    receive_rtp_config_.emplace(config.rtp.remote_ssrc,
                                ReceiveRtpConfig(config));
    video_receive_streams_.insert(receive_stream);
    ConfigureSync(config.sync_group);
  }
  receive_stream->SignalNetworkState(video_network_state_);
  UpdateAggregateNetworkState();
  event_log_->Log(absl::make_unique<RtcEventVideoReceiveStreamConfig>(
      CreateRtcLogStreamConfig(config)));
  return receive_stream;
}

void Call::DestroyVideoReceiveStream(
    webrtc::VideoReceiveStream* receive_stream) {
  TRACE_EVENT0("webrtc", "Call::DestroyVideoReceiveStream");
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);
  RTC_DCHECK(receive_stream != nullptr);
  VideoReceiveStream* receive_stream_impl =
      static_cast<VideoReceiveStream*>(receive_stream);
  const VideoReceiveStream::Config& config = receive_stream_impl->config();
  {
    WriteLockScoped write_lock(*receive_crit_);
    // Remove all ssrcs pointing to a receive stream. As RTX retransmits on a
    // separate SSRC there can be either one or two.
    receive_rtp_config_.erase(config.rtp.remote_ssrc);
    if (config.rtp.rtx_ssrc) {
      receive_rtp_config_.erase(config.rtp.rtx_ssrc);
    }
    video_receive_streams_.erase(receive_stream_impl);
    ConfigureSync(config.sync_group);
  }

  receive_side_cc_.GetRemoteBitrateEstimator(UseSendSideBwe(config))->RemoveStream(config.rtp.remote_ssrc);

  UpdateAggregateNetworkState();
  delete receive_stream_impl;
}

FlexfecReceiveStream* Call::CreateFlexfecReceiveStream(const FlexfecReceiveStream::Config& config) 
{
  TRACE_EVENT0("webrtc", "Call::CreateFlexfecReceiveStream");
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);

  RecoveredPacketReceiver* recovered_packet_receiver = this;

  FlexfecReceiveStreamImpl* receive_stream;
  {
    WriteLockScoped write_lock(*receive_crit_);
    // Unlike the video and audio receive streams,
    // FlexfecReceiveStream implements RtpPacketSinkInterface itself,
    // and hence its constructor passes its |this| pointer to
    // video_receiver_controller_->CreateStream(). Calling the
    // constructor while holding |receive_crit_| ensures that we don't
    // call OnRtpPacket until the constructor is finished and the
    // object is in a valid state.
    // TODO(nisse): Fix constructor so that it can be moved outside of
    // this locked scope.
    receive_stream = new FlexfecReceiveStreamImpl(clock_, &video_receiver_controller_, config, recovered_packet_receiver,
        call_stats_.get(), module_process_thread_.get());

    RTC_DCHECK(receive_rtp_config_.find(config.remote_ssrc) ==
               receive_rtp_config_.end());
    receive_rtp_config_.emplace(config.remote_ssrc, ReceiveRtpConfig(config));
  }

  // TODO(brandtr): Store config in RtcEventLog here.

  return receive_stream;
}

void Call::DestroyFlexfecReceiveStream(FlexfecReceiveStream* receive_stream) 
{
  TRACE_EVENT0("webrtc", "Call::DestroyFlexfecReceiveStream");
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);

  RTC_DCHECK(receive_stream != nullptr);
  {
    WriteLockScoped write_lock(*receive_crit_);

    const FlexfecReceiveStream::Config& config = receive_stream->GetConfig();
    uint32_t ssrc = config.remote_ssrc;
    receive_rtp_config_.erase(ssrc);

    // Remove all SSRCs pointing to the FlexfecReceiveStreamImpl to be
    // destroyed.
    receive_side_cc_.GetRemoteBitrateEstimator(UseSendSideBwe(config))->RemoveStream(ssrc);
  }

  delete receive_stream;
}

RtpTransportControllerSendInterface* Call::GetTransportControllerSend() 
{
  return transport_send_ptr_;
}

Call::Stats Call::GetStats() const {
  // TODO(solenberg): Some test cases in EndToEndTest use this from a different
  // thread. Re-enable once that is fixed.
  // RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);
  Stats stats;
  // Fetch available send/receive bitrates.
  std::vector<unsigned int> ssrcs;
  uint32_t recv_bandwidth = 0;
  receive_side_cc_.GetRemoteBitrateEstimator(false)->LatestEstimate(&ssrcs, &recv_bandwidth);

  {
    rtc::CritScope cs(&last_bandwidth_bps_crit_);
    stats.send_bandwidth_bps = last_bandwidth_bps_;
  }
  stats.recv_bandwidth_bps = recv_bandwidth;
  // TODO(srte): It is unclear if we only want to report queues if network is
  // available.
  {
    rtc::CritScope cs(&aggregate_network_up_crit_);
    stats.pacer_delay_ms = aggregate_network_up_ ? transport_send_ptr_->GetPacerQueuingDelayMs() : 0;
  }

  stats.rtt_ms = call_stats_->LastProcessedRtt();
  {
    rtc::CritScope cs(&bitrate_crit_);
    stats.max_padding_bitrate_bps = configured_max_padding_bitrate_bps_;
  }
  return stats;
}

void Call::SetBitrateAllocationStrategy(
    std::unique_ptr<rtc::BitrateAllocationStrategy>
        bitrate_allocation_strategy) {
  // TODO(srte): This function should be moved to RtpTransportControllerSend
  // when BitrateAllocator is moved there.
  struct Functor {
    void operator()() {
      bitrate_allocator_->SetBitrateAllocationStrategy(
          std::move(bitrate_allocation_strategy_));
    }
    BitrateAllocator* bitrate_allocator_;
    std::unique_ptr<rtc::BitrateAllocationStrategy>
        bitrate_allocation_strategy_;
  };
  transport_send_ptr_->GetWorkerQueue()->PostTask(Functor{
      bitrate_allocator_.get(), std::move(bitrate_allocation_strategy)});
}

void Call::SignalChannelNetworkState(MediaType media, NetworkState state) {
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);
  switch (media) {
    case MediaType::AUDIO:
      audio_network_state_ = state;
      break;
    case MediaType::VIDEO:
      video_network_state_ = state;
      break;
    case MediaType::ANY:
    case MediaType::DATA:
      RTC_NOTREACHED();
      break;
  }

  UpdateAggregateNetworkState();
  {
    ReadLockScoped read_lock(*send_crit_);
    for (auto& kv : audio_send_ssrcs_) {
      kv.second->SignalNetworkState(audio_network_state_);
    }
  }
  {
    ReadLockScoped read_lock(*receive_crit_);
    for (AudioReceiveStream* audio_receive_stream : audio_receive_streams_) {
      audio_receive_stream->SignalNetworkState(audio_network_state_);
    }
    for (VideoReceiveStream* video_receive_stream : video_receive_streams_) {
      video_receive_stream->SignalNetworkState(video_network_state_);
    }
  }
}

void Call::OnAudioTransportOverheadChanged(int transport_overhead_per_packet) {
  ReadLockScoped read_lock(*send_crit_);
  for (auto& kv : audio_send_ssrcs_) {
    kv.second->SetTransportOverhead(transport_overhead_per_packet);
  }
}

void Call::UpdateAggregateNetworkState() {
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);

  bool have_audio = false;
  bool have_video = false;
  {
    ReadLockScoped read_lock(*send_crit_);
    if (!audio_send_ssrcs_.empty())
      have_audio = true;
    if (!video_send_ssrcs_.empty())
      have_video = true;
  }
  {
    ReadLockScoped read_lock(*receive_crit_);
    if (!audio_receive_streams_.empty())
      have_audio = true;
    if (!video_receive_streams_.empty())
      have_video = true;
  }

  bool aggregate_network_up =
      ((have_video && video_network_state_ == kNetworkUp) ||
       (have_audio && audio_network_state_ == kNetworkUp));

  RTC_LOG(LS_INFO) << "UpdateAggregateNetworkState: aggregate_state="
                   << (aggregate_network_up ? "up" : "down");
  {
    rtc::CritScope cs(&aggregate_network_up_crit_);
    aggregate_network_up_ = aggregate_network_up;
  }
  transport_send_ptr_->OnNetworkAvailability(aggregate_network_up);
}

void Call::OnSentPacket(const rtc::SentPacket& sent_packet) {
  video_send_delay_stats_->OnSentPacket(sent_packet.packet_id,
                                        clock_->TimeInMilliseconds());

  #if 0

  RTC_NORMAL_EX_LOG("[transport_send_ptr_->OnSentPacket][sent_packet = %s]", webrtc::ToString(sent_packet).c_str());
#endif  // _DEBUG

  transport_send_ptr_->OnSentPacket(sent_packet);
}

void Call::OnStartRateUpdate(DataRate start_rate) {
  if (!transport_send_ptr_->GetWorkerQueue()->IsCurrent()) {
    transport_send_ptr_->GetWorkerQueue()->PostTask(
        [this, start_rate] { this->OnStartRateUpdate(start_rate); });
    return;
  }
  bitrate_allocator_->UpdateStartRate(start_rate.bps<uint32_t>());
}

void Call::OnTargetTransferRate(TargetTransferRate msg) {
  // TODO(bugs.webrtc.org/9719)
  // Call::OnTargetTransferRate requires that on target transfer rate is invoked
  // from the worker queue (because bitrate_allocator_ requires it). Media
  // transport does not guarantee the callback on the worker queue.
  // When the threading model for MediaTransportInterface is update, reconsider
  // changing this implementation.
  if (!transport_send_ptr_->GetWorkerQueue()->IsCurrent()) {
    transport_send_ptr_->GetWorkerQueue()->PostTask(
        [this, msg] { this->OnTargetTransferRate(msg); });
    return;
  }

  uint32_t target_bitrate_bps = msg.target_rate.bps();
  int loss_ratio_255 = msg.network_estimate.loss_rate_ratio * 255;
  uint8_t fraction_loss =
      rtc::dchecked_cast<uint8_t>(rtc::SafeClamp(loss_ratio_255, 0, 255));
  int64_t rtt_ms = msg.network_estimate.round_trip_time.ms();
  int64_t probing_interval_ms = msg.network_estimate.bwe_period.ms();
  uint32_t bandwidth_bps = msg.network_estimate.bandwidth.bps();
  {
    rtc::CritScope cs(&last_bandwidth_bps_crit_);
    last_bandwidth_bps_ = bandwidth_bps;
  }
  // For controlling the rate of feedback messages.
  receive_side_cc_.OnBitrateChanged(target_bitrate_bps);
  bitrate_allocator_->OnNetworkChanged(target_bitrate_bps, bandwidth_bps,
                                       fraction_loss, rtt_ms,
                                       probing_interval_ms);

  // Ignore updates if bitrate is zero (the aggregate network state is down).
  if (target_bitrate_bps == 0) {
    rtc::CritScope lock(&bitrate_crit_);
    estimated_send_bitrate_kbps_counter_.ProcessAndPause();
    pacer_bitrate_kbps_counter_.ProcessAndPause();
    return;
  }

  bool sending_video;
  {
    ReadLockScoped read_lock(*send_crit_);
    sending_video = !video_send_streams_.empty();
  }

  rtc::CritScope lock(&bitrate_crit_);
  if (!sending_video) {
    // Do not update the stats if we are not sending video.
    estimated_send_bitrate_kbps_counter_.ProcessAndPause();
    pacer_bitrate_kbps_counter_.ProcessAndPause();
    return;
  }
  estimated_send_bitrate_kbps_counter_.Add(target_bitrate_bps / 1000);
  // Pacer bitrate may be higher than bitrate estimate if enforcing min bitrate.
  uint32_t pacer_bitrate_bps =
      std::max(target_bitrate_bps, min_allocated_send_bitrate_bps_);
  pacer_bitrate_kbps_counter_.Add(pacer_bitrate_bps / 1000);
}

void Call::OnAllocationLimitsChanged(uint32_t min_send_bitrate_bps,
                                     uint32_t max_padding_bitrate_bps,
                                     uint32_t total_bitrate_bps) {
  transport_send_ptr_->SetAllocatedSendBitrateLimits(
      min_send_bitrate_bps, max_padding_bitrate_bps, total_bitrate_bps);

  {
    rtc::CritScope lock(&target_observer_crit_);
    if (media_transport_) {
      MediaTransportAllocatedBitrateLimits limits;
      limits.min_pacing_rate = DataRate::bps(min_send_bitrate_bps);
      limits.max_padding_bitrate = DataRate::bps(max_padding_bitrate_bps);
      limits.max_total_allocated_bitrate = DataRate::bps(total_bitrate_bps);
      media_transport_->SetAllocatedBitrateLimits(limits);
    }
  }

  rtc::CritScope lock(&bitrate_crit_);
  min_allocated_send_bitrate_bps_ = min_send_bitrate_bps;
  configured_max_padding_bitrate_bps_ = max_padding_bitrate_bps;
}

void Call::ConfigureSync(const std::string& sync_group) {
  // Set sync only if there was no previous one.
  if (sync_group.empty())
    return;

  AudioReceiveStream* sync_audio_stream = nullptr;
  // Find existing audio stream.
  const auto it = sync_stream_mapping_.find(sync_group);
  if (it != sync_stream_mapping_.end()) {
    sync_audio_stream = it->second;
  } else {
    // No configured audio stream, see if we can find one.
    for (AudioReceiveStream* stream : audio_receive_streams_) {
      if (stream->config().sync_group == sync_group) {
        if (sync_audio_stream != nullptr) {
          RTC_LOG(LS_WARNING)
              << "Attempting to sync more than one audio stream "
                 "within the same sync group. This is not "
                 "supported in the current implementation.";
          break;
        }
        sync_audio_stream = stream;
      }
    }
  }
  if (sync_audio_stream)
    sync_stream_mapping_[sync_group] = sync_audio_stream;
  size_t num_synced_streams = 0;
  for (VideoReceiveStream* video_stream : video_receive_streams_) {
    if (video_stream->config().sync_group != sync_group)
      continue;
    ++num_synced_streams;
    if (num_synced_streams > 1) {
      // TODO(pbos): Support synchronizing more than one A/V pair.
      // https://code.google.com/p/webrtc/issues/detail?id=4762
      RTC_LOG(LS_WARNING)
          << "Attempting to sync more than one audio/video pair "
             "within the same sync group. This is not supported in "
             "the current implementation.";
    }
    // Only sync the first A/V pair within this sync group.
    if (num_synced_streams == 1) {
      // sync_audio_stream may be null and that's ok.
      video_stream->SetSync(sync_audio_stream);
    } else {
      video_stream->SetSync(nullptr);
    }
  }
}

PacketReceiver::DeliveryStatus Call::DeliverRtcp(MediaType media_type,
                                                 const uint8_t* packet,
                                                 size_t length) {
  TRACE_EVENT0("webrtc", "Call::DeliverRtcp");
  // TODO(pbos): Make sure it's a valid packet.
  //             Return DELIVERY_UNKNOWN_SSRC if it can be determined that
  //             there's no receiver of the packet.
  if (received_bytes_per_second_counter_.HasSample()) {
    // First RTP packet has been received.
    received_bytes_per_second_counter_.Add(static_cast<int>(length));
    received_rtcp_bytes_per_second_counter_.Add(static_cast<int>(length));
  }
  bool rtcp_delivered = false;
  if (media_type == MediaType::ANY || media_type == MediaType::VIDEO) {
    ReadLockScoped read_lock(*receive_crit_);
    for (VideoReceiveStream* stream : video_receive_streams_) {
      if (stream->DeliverRtcp(packet, length))
        rtcp_delivered = true;
    }
  }
  if (media_type == MediaType::ANY || media_type == MediaType::AUDIO) {
    ReadLockScoped read_lock(*receive_crit_);
    for (AudioReceiveStream* stream : audio_receive_streams_) {
      stream->DeliverRtcp(packet, length);
      rtcp_delivered = true;
    }
  }
  if (media_type == MediaType::ANY || media_type == MediaType::VIDEO) {
    ReadLockScoped read_lock(*send_crit_);
    for (VideoSendStream* stream : video_send_streams_) {
      stream->DeliverRtcp(packet, length);
      rtcp_delivered = true;
    }
  }
  if (media_type == MediaType::ANY || media_type == MediaType::AUDIO) {
    ReadLockScoped read_lock(*send_crit_);
    for (auto& kv : audio_send_ssrcs_) {
      kv.second->DeliverRtcp(packet, length);
      rtcp_delivered = true;
    }
  }

  if (rtcp_delivered) {
    event_log_->Log(absl::make_unique<RtcEventRtcpPacketIncoming>(
        rtc::MakeArrayView(packet, length)));
  }

  return rtcp_delivered ? DELIVERY_OK : DELIVERY_PACKET_ERROR;
}

PacketReceiver::DeliveryStatus Call::DeliverRtp(MediaType media_type,
                                                rtc::CopyOnWriteBuffer packet,
                                                int64_t packet_time_us) {
  TRACE_EVENT0("webrtc", "Call::DeliverRtp");

  RtpPacketReceived parsed_packet;
  if (!parsed_packet.Parse(std::move(packet)))
  {
	  return DELIVERY_PACKET_ERROR;
  }
  // TODO@chensong 2023-03-31  从底层socket读取数据结束时的时间微妙数据 在async_udp_socket.cc文件中
  //  AsyncUDPSocket::OnReadEvent(AsyncSocket* socket)方法设置微妙数哈 ^_^ 
  if (packet_time_us != -1) 
  {
    if (receive_time_calculator_) 
	{
      // Repair packet_time_us for clock resets by comparing a new read of
      // the same clock (TimeUTCMicros) to a monotonic clock reading.
	  //通过比较新读取的
	  //将相同的时钟（TimeUTCMicrosoft）转换为单调的时钟读数。
      packet_time_us = receive_time_calculator_->ReconcileReceiveTimes(packet_time_us, rtc::TimeUTCMicros(), clock_->TimeInMicroseconds());
    }
    parsed_packet.set_arrival_time_ms((packet_time_us + 500) / 1000);
  }
  else 
  {
    parsed_packet.set_arrival_time_ms(clock_->TimeInMilliseconds());
  }

  // We might get RTP keep-alive packets in accordance with RFC6263 section 4.6.
  // These are empty (zero length payload) RTP packets with an unsignaled
  // payload type.
  const bool is_keep_alive_packet = parsed_packet.payload_size() == 0;

  RTC_DCHECK(media_type == MediaType::AUDIO || media_type == MediaType::VIDEO || is_keep_alive_packet);

  // TODO@chensong 2023-04-24 接收的rtp的数据查询ssrc表中是否有ssrc
  ReadLockScoped read_lock(*receive_crit_);
  auto it = receive_rtp_config_.find(parsed_packet.Ssrc());
  if (it == receive_rtp_config_.end()) 
  {
    RTC_LOG(LS_ERROR) << "receive_rtp_config_ lookup failed for ssrc " << parsed_packet.Ssrc();
    // Destruction of the receive stream, including deregistering from the
    // RtpDemuxer, is not protected by the |receive_crit_| lock. But
    // deregistering in the |receive_rtp_config_| map is protected by that lock.
    // So by not passing the packet on to demuxing in this case, we prevent
    // incoming packets to be passed on via the demuxer to a receive stream
    // which is being torned down.
    return DELIVERY_UNKNOWN_SSRC;
  }

  parsed_packet.IdentifyExtensions(it->second.extensions);

  NotifyBweOfReceivedPacket(parsed_packet, media_type);

  // RateCounters expect input parameter as int, save it as int,
  // instead of converting each time it is passed to RateCounter::Add below.
  int length = static_cast<int>(parsed_packet.size());
  if (media_type == MediaType::AUDIO) 
  {
    if (audio_receiver_controller_.OnRtpPacket(parsed_packet)) 
	{
      received_bytes_per_second_counter_.Add(length);
      received_audio_bytes_per_second_counter_.Add(length);
      event_log_->Log(absl::make_unique<RtcEventRtpPacketIncoming>(parsed_packet));
      const int64_t arrival_time_ms = parsed_packet.arrival_time_ms();
      if (!first_received_rtp_audio_ms_) 
	  {
        first_received_rtp_audio_ms_.emplace(arrival_time_ms);
      }
      last_received_rtp_audio_ms_.emplace(arrival_time_ms);
      return DELIVERY_OK;
    }
  } 
  else if (media_type == MediaType::VIDEO) 
  {
    parsed_packet.set_payload_type_frequency(kVideoPayloadTypeFrequency);
    if (video_receiver_controller_.OnRtpPacket(parsed_packet)) 
	{
      received_bytes_per_second_counter_.Add(length);
      received_video_bytes_per_second_counter_.Add(length);
      event_log_->Log(absl::make_unique<RtcEventRtpPacketIncoming>(parsed_packet));
      const int64_t arrival_time_ms = parsed_packet.arrival_time_ms();
      if (!first_received_rtp_video_ms_) 
	  {
        first_received_rtp_video_ms_.emplace(arrival_time_ms);
      }
      last_received_rtp_video_ms_.emplace(arrival_time_ms);
      return DELIVERY_OK;
    }
  }
  return DELIVERY_UNKNOWN_SSRC;
}

PacketReceiver::DeliveryStatus Call::DeliverPacket(
    MediaType media_type,
    rtc::CopyOnWriteBuffer packet,
    int64_t packet_time_us) {
  RTC_DCHECK_RUN_ON(&configuration_sequence_checker_);
  if (RtpHeaderParser::IsRtcp(packet.cdata(), packet.size())) 
  {
    return DeliverRtcp(media_type, packet.cdata(), packet.size());
  }

  return DeliverRtp(media_type, std::move(packet), packet_time_us);
}

void Call::OnRecoveredPacket(const uint8_t* packet, size_t length) {
  RtpPacketReceived parsed_packet;
  if (!parsed_packet.Parse(packet, length))
    return;

  parsed_packet.set_recovered(true);

  ReadLockScoped read_lock(*receive_crit_);
  auto it = receive_rtp_config_.find(parsed_packet.Ssrc());
  if (it == receive_rtp_config_.end()) {
    RTC_LOG(LS_ERROR) << "receive_rtp_config_ lookup failed for ssrc "
                      << parsed_packet.Ssrc();
    // Destruction of the receive stream, including deregistering from the
    // RtpDemuxer, is not protected by the |receive_crit_| lock. But
    // deregistering in the |receive_rtp_config_| map is protected by that lock.
    // So by not passing the packet on to demuxing in this case, we prevent
    // incoming packets to be passed on via the demuxer to a receive stream
    // which is being torn down.
    return;
  }
  parsed_packet.IdentifyExtensions(it->second.extensions);

  // TODO(brandtr): Update here when we support protecting audio packets too.
  parsed_packet.set_payload_type_frequency(kVideoPayloadTypeFrequency);
  video_receiver_controller_.OnRtpPacket(parsed_packet);
}

void Call::NotifyBweOfReceivedPacket(const RtpPacketReceived& packet, MediaType media_type) 
{
  auto it = receive_rtp_config_.find(packet.Ssrc());
  bool use_send_side_bwe = (it != receive_rtp_config_.end()) && it->second.use_send_side_bwe;

  RTPHeader header;
  packet.GetHeader(&header);

  if (!use_send_side_bwe && header.extension.hasTransportSequenceNumber) 
  {
    // Inconsistent configuration of send side BWE. Do nothing.
    // TODO(nisse): Without this check, we may produce RTCP feedback
    // packets even when not negotiated. But it would be cleaner to
    // move the check down to RTCPSender::SendFeedbackPacket, which
    // would also help the PacketRouter to select an appropriate rtp
    // module in the case that some, but not all, have RTCP feedback
    // enabled.
	//发送方BWE的配置不一致。什么都不做。
	//TODO（nisse）：如果没有此检查，我们可能会产生RTCP反馈
	//即使在未协商的情况下。但这样会更干净
	//将检查下移到RTCPSender:：SendFeedbackPacket
	//也有助于PacketRouter选择合适的rtp
	//在某些（但不是所有）具有RTCP反馈的情况下，模块
	//启用。
    return;
  }
  // For audio, we only support send side BWE. 对于音频，我们只支持发送端BWE。
  if (media_type == MediaType::VIDEO || (use_send_side_bwe && header.extension.hasTransportSequenceNumber)) 
  {
    receive_side_cc_.OnReceivedPacket(packet.arrival_time_ms(), packet.payload_size() + packet.padding_size(), header);
  }
}

}  // namespace internal

}  // namespace webrtc
