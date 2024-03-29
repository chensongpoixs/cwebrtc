﻿/*
 *  Copyright (c) 2017 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */
#include <utility>
#include <vector>

#include "absl/memory/memory.h"
#include "absl/types/optional.h"
#include "api/transport/goog_cc_factory.h"
#include "api/transport/network_types.h"
#include "api/units/data_rate.h"
#include "api/units/time_delta.h"
#include "api/units/data_size.h"
#include "api/units/timestamp.h"
#include "call/rtp_transport_controller_send.h"
#include "call/rtp_video_sender.h"
#include "rtc_base/checks.h"
#include "rtc_base/location.h"
#include "rtc_base/logging.h"
#include "rtc_base/rate_limiter.h"
#include "system_wrappers/include/field_trial.h"

namespace webrtc {


	////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////      TODO@chensong  2022-11-29  googcc  算法

//#if 0
//
//static FILE* out_rtc_rtp_transport_send_file_ptr = NULL;
//static void rtc_rtp_transport_send_log() {
//  if (!out_rtc_rtp_transport_send_file_ptr) {
//    out_rtc_rtp_transport_send_file_ptr =
//        ::fopen("./debug/rtp_transport_controller_send.log", "wb+");
//  }
//
//  // va_list argptr;
//  // va_start(argptr, format);
//  // ::fprintf(out_rtc_gcc_file_ptr, format, ##__VA_ARGS__);
//  // ::fprintf(out_rtc_gcc_file_ptr, "\n");
//  // ::fflush(out_rtc_gcc_file_ptr);
//
//  // va_end(argptr);
//}
//
// 
//#define RTC_NORMAL_LOG(format, ...)                         \
//  rtc_rtp_transport_send_log();                                        \
//    if ( out_rtc_rtp_transport_send_file_ptr) { 								\
//  fprintf(out_rtc_rtp_transport_send_file_ptr, format, ##__VA_ARGS__); \
//  fprintf(out_rtc_rtp_transport_send_file_ptr, "\n");                  \
//  fflush(out_rtc_rtp_transport_send_file_ptr);}
//
//#define RTC_NORMAL_EX_LOG(format, ...) \
//  RTC_NORMAL_LOG("[%s][%d][info]" format, __FUNCTION__, __LINE__, ##__VA_ARGS__)
//#define ERROR_EX_LOG(format, ...) \
//  RTC_NORMAL_LOG("[%s][%d][error]" format, __FUNCTION__, __LINE__, ##__VA_ARGS__)
//#define WARNING_EX_LOG(format, ...) \
//  RTC_NORMAL_LOG("[%s][%d][warning]" format, __FUNCTION__, __LINE__, ##__VA_ARGS__)
//#endif  // _DEBUG

namespace {
static const int64_t kRetransmitWindowSizeMs = 500;
static const size_t kMaxOverheadBytes = 500;

constexpr TimeDelta kPacerQueueUpdateInterval = TimeDelta::Millis<25>();

TargetRateConstraints ConvertConstraints(int min_bitrate_bps,
                                         int max_bitrate_bps,
                                         int start_bitrate_bps,
                                         Clock* clock) {
  TargetRateConstraints msg;
  msg.at_time = Timestamp::ms(clock->TimeInMilliseconds());
  msg.min_data_rate =
      min_bitrate_bps >= 0 ? DataRate::bps(min_bitrate_bps) : DataRate::Zero();
  msg.max_data_rate = max_bitrate_bps > 0 ? DataRate::bps(max_bitrate_bps)
                                          : DataRate::Infinity();
  if (start_bitrate_bps > 0)
    msg.starting_rate = DataRate::bps(start_bitrate_bps);
  return msg;
}

TargetRateConstraints ConvertConstraints(const BitrateConstraints& contraints,
                                         Clock* clock) {
  return ConvertConstraints(contraints.min_bitrate_bps,
                            contraints.max_bitrate_bps,
                            contraints.start_bitrate_bps, clock);
}
}  // namespace

RtpTransportControllerSend::RtpTransportControllerSend(
    Clock* clock,
    webrtc::RtcEventLog* event_log,
    NetworkStatePredictorFactoryInterface* predictor_factory,
    NetworkControllerFactoryInterface* controller_factory,
    const BitrateConstraints& bitrate_config,
    std::unique_ptr<ProcessThread> process_thread,
    TaskQueueFactory* task_queue_factory)
    : clock_(clock),
      pacer_(clock, &packet_router_, event_log),
      bitrate_configurator_(bitrate_config),
      process_thread_(std::move(process_thread)),
      observer_(nullptr),
      controller_factory_override_(controller_factory),
      controller_factory_fallback_(
          absl::make_unique<GoogCcNetworkControllerFactory>(event_log,
                                                            predictor_factory)),
      process_interval_(controller_factory_fallback_->GetProcessInterval()),
      last_report_block_time_(Timestamp::ms(clock_->TimeInMilliseconds())),
      reset_feedback_on_route_change_(
          !field_trial::IsEnabled("WebRTC-Bwe-NoFeedbackReset")),
	// TODO@chensong 2023-04-29 
	// 参数WebRTC-SendSideBwe-WithOverhead是用于启用或禁用WebRTC发送端带宽估计（BWE）时考虑IP和UDP头部开销的选项。默认值为true，表示启用此选项，即将IP和UDP头部开销作为考虑因素纳入BWE计算中。如果将其设置为false，则不考虑这些overhead。
	//在WebRTC中，BWE是一种自适应机制，通过分析网络状况并根据可用带宽调整音视频质量来实现最佳用户体验。采用BWE可以确保在网络中发生拥塞时，WebRTC应用程序可以适当地降低传输带宽，从而避免数据包丢失和延迟增加。但是，为了准确估计可用带宽，必须考虑IP和UDP头部开销，这些头部会占用网络总带宽的一部分。因此，使用参数WebRTC-SendSideBwe-WithOverhead可以更好地调整BWE算法，以便在考虑网络开销的情况下更准确地估计可用带宽。
      send_side_bwe_with_overhead_(webrtc::field_trial::IsEnabled("WebRTC-SendSideBwe-WithOverhead")),
	  // TODO@chensong 2023-04-29 
	  // 是一个布尔类型的参数，用于启用或禁用WebRTC的pacing功能。当此参数设置为true时，WebRTC将使用拥塞控制窗口回退（congestion window pushback）来控制数据包的发送速率，
	// 并且通过添加延迟以避免网络拥塞。这可以有效地减少数据包的丢失和延迟，并提高视频通话的质量。然而，如果网络条件较好，
	// 则可能会导致额外的延迟，因此在不同的网络环境中需要进行调整和测试来确定是否需要启用此功能。
      add_pacing_to_cwin_(field_trial::IsEnabled("WebRTC-AddPacingToCongestionWindowPushback")),
      transport_overhead_bytes_per_packet_(0),
      network_available_(false),
      retransmission_rate_limiter_(clock, kRetransmitWindowSizeMs),
      task_queue_(task_queue_factory->CreateTaskQueue(
          "rtp_send_controller",
          TaskQueueFactory::Priority::NORMAL)) {
  initial_config_.constraints = ConvertConstraints(bitrate_config, clock_);
  RTC_DCHECK(bitrate_config.start_bitrate_bps > 0);

  pacer_.SetPacingRates(bitrate_config.start_bitrate_bps, 0);
  // TODO@chensong 2022-09-29 注册网络发送包  会不停调用 pacer_中方法Process
  process_thread_->RegisterModule(&pacer_, RTC_FROM_HERE);
  process_thread_->Start();
}

RtpTransportControllerSend::~RtpTransportControllerSend() {
  process_thread_->Stop();
  process_thread_->DeRegisterModule(&pacer_);
}

RtpVideoSenderInterface* RtpTransportControllerSend::CreateRtpVideoSender(
    std::map<uint32_t, RtpState> suspended_ssrcs,
    const std::map<uint32_t, RtpPayloadState>& states,
    const RtpConfig& rtp_config,
    int rtcp_report_interval_ms,
    Transport* send_transport,
    const RtpSenderObservers& observers,
    RtcEventLog* event_log,
    std::unique_ptr<FecController> fec_controller,
    const RtpSenderFrameEncryptionConfig& frame_encryption_config) {
  video_rtp_senders_.push_back(absl::make_unique<RtpVideoSender>(
      clock_, suspended_ssrcs, states, rtp_config, rtcp_report_interval_ms,
      send_transport, observers,
      // TODO(holmer): Remove this circular dependency by injecting
      // the parts of RtpTransportControllerSendInterface that are really used.
      this, event_log, &retransmission_rate_limiter_, std::move(fec_controller),
      frame_encryption_config.frame_encryptor,
      frame_encryption_config.crypto_options));
  return video_rtp_senders_.back().get();
}

void RtpTransportControllerSend::DestroyRtpVideoSender(
    RtpVideoSenderInterface* rtp_video_sender) {
  std::vector<std::unique_ptr<RtpVideoSenderInterface>>::iterator it =
      video_rtp_senders_.end();
  for (it = video_rtp_senders_.begin(); it != video_rtp_senders_.end(); ++it) {
    if (it->get() == rtp_video_sender) {
      break;
    }
  }
  RTC_DCHECK(it != video_rtp_senders_.end());
  video_rtp_senders_.erase(it);
}

void RtpTransportControllerSend::UpdateControlState() {
  absl::optional<TargetTransferRate> update = control_handler_->GetUpdate();
  if (!update)
    return;
  retransmission_rate_limiter_.SetMaxRate(
      update->network_estimate.bandwidth.bps());
  // We won't create control_handler_ until we have an observers.
  RTC_DCHECK(observer_ != nullptr);
  observer_->OnTargetTransferRate(*update);
}

rtc::TaskQueue* RtpTransportControllerSend::GetWorkerQueue() {
  return &task_queue_;
}

PacketRouter* RtpTransportControllerSend::packet_router() {
  return &packet_router_;
}

TransportFeedbackObserver*
RtpTransportControllerSend::transport_feedback_observer() {
  return this;
}

RtpPacketSender* RtpTransportControllerSend::packet_sender() {
  return &pacer_;
}

void RtpTransportControllerSend::SetAllocatedSendBitrateLimits(
    int min_send_bitrate_bps,
    int max_padding_bitrate_bps,
    int max_total_bitrate_bps) 
{
  RTC_DCHECK_RUN_ON(&task_queue_);
	// TODO@chensong 20230628  max bitrate bps 
  streams_config_.min_total_allocated_bitrate =
      DataRate::bps(min_send_bitrate_bps);
  streams_config_.max_padding_rate = DataRate::bps(max_padding_bitrate_bps);
  streams_config_.max_total_allocated_bitrate =
      DataRate::bps(max_total_bitrate_bps);
  UpdateStreamsConfig();
}
void RtpTransportControllerSend::SetPacingFactor(float pacing_factor) {
  RTC_DCHECK_RUN_ON(&task_queue_);
  streams_config_.pacing_factor = pacing_factor;
  UpdateStreamsConfig();
}
void RtpTransportControllerSend::SetQueueTimeLimit(int limit_ms) {
  pacer_.SetQueueTimeLimit(limit_ms);
}
void RtpTransportControllerSend::RegisterPacketFeedbackObserver(PacketFeedbackObserver* observer) 
{
  transport_feedback_adapter_.RegisterPacketFeedbackObserver(observer);
}
void RtpTransportControllerSend::DeRegisterPacketFeedbackObserver(PacketFeedbackObserver* observer)
{
  transport_feedback_adapter_.DeRegisterPacketFeedbackObserver(observer);
}

void RtpTransportControllerSend::RegisterTargetTransferRateObserver(
    TargetTransferRateObserver* observer) {
  task_queue_.PostTask([this, observer] {
    RTC_DCHECK_RUN_ON(&task_queue_);
    RTC_DCHECK(observer_ == nullptr);
    observer_ = observer;
    observer_->OnStartRateUpdate(*initial_config_.constraints.starting_rate);
    MaybeCreateControllers();
  });
}
void RtpTransportControllerSend::OnNetworkRouteChanged(const std::string& transport_name, const rtc::NetworkRoute& network_route)
{
  // Check if the network route is connected.
  if (!network_route.connected) {
    RTC_LOG(LS_INFO) << "Transport " << transport_name << " is disconnected";
    // TODO(honghaiz): Perhaps handle this in SignalChannelNetworkState and
    // consider merging these two methods.
    return;
  }

  // Check whether the network route has changed on each transport.
  auto result =
      network_routes_.insert(std::make_pair(transport_name, network_route));
  auto kv = result.first;
  bool inserted = result.second;
  if (inserted) {
    // No need to reset BWE if this is the first time the network connects.
    return;
  }
  if (kv->second.connected != network_route.connected ||
      kv->second.local_network_id != network_route.local_network_id ||
      kv->second.remote_network_id != network_route.remote_network_id) 
  {
    kv->second = network_route;
    BitrateConstraints bitrate_config = bitrate_configurator_.GetConfig();
    RTC_LOG(LS_INFO) << "Network route changed on transport " << transport_name
                     << ": new local network id "
                     << network_route.local_network_id
                     << " new remote network id "
                     << network_route.remote_network_id
                     << " Reset bitrates to min: "
                     << bitrate_config.min_bitrate_bps
                     << " bps, start: " << bitrate_config.start_bitrate_bps
                     << " bps,  max: " << bitrate_config.max_bitrate_bps
                     << " bps.";
    RTC_DCHECK_GT(bitrate_config.start_bitrate_bps, 0);

	if (reset_feedback_on_route_change_)
	{
		 // TODO@chensong 2023-05-01 设置networkid   feebeek type = 15 
		transport_feedback_adapter_.SetNetworkIds(network_route.local_network_id, network_route.remote_network_id);
	}
    transport_overhead_bytes_per_packet_ = network_route.packet_overhead;

    NetworkRouteChange msg;
    msg.at_time = Timestamp::ms(clock_->TimeInMilliseconds());
    msg.constraints = ConvertConstraints(bitrate_config, clock_);
    task_queue_.PostTask([this, msg] {
      RTC_DCHECK_RUN_ON(&task_queue_);
      if (controller_) {
        PostUpdates(controller_->OnNetworkRouteChange(msg));
      } else {
        UpdateInitialConstraints(msg.constraints);
      }
      pacer_.UpdateOutstandingData(0);
    });
  }
}
void RtpTransportControllerSend::OnNetworkAvailability(bool network_available) 
{
  RTC_LOG(LS_INFO) << "SignalNetworkState " << (network_available ? "Up" : "Down");
  NetworkAvailability msg;
  msg.at_time = Timestamp::ms(clock_->TimeInMilliseconds());
  msg.network_available = network_available;
  task_queue_.PostTask([this, msg]() {
    RTC_DCHECK_RUN_ON(&task_queue_);
	if (network_available_ == msg.network_available)
	{
      return;
	}
    network_available_ = msg.network_available;
    if (network_available_) 
	{
      pacer_.Resume();
    }
	else
	{
      pacer_.Pause();
    }
    pacer_.UpdateOutstandingData(0);

    if (controller_) 
	{
      control_handler_->SetNetworkAvailability(network_available_);
      PostUpdates(controller_->OnNetworkAvailability(msg));
      UpdateControlState();
    }
	else 
	{
		// TODO@chensong 2023-05-04 网络ice协商结束 后会创建GCC模块初始化
      MaybeCreateControllers();
    }
  });

  for (auto& rtp_sender : video_rtp_senders_) 
  {
    rtp_sender->OnNetworkAvailability(network_available);
  }
}
RtcpBandwidthObserver* RtpTransportControllerSend::GetBandwidthObserver() {
  return this;
}
int64_t RtpTransportControllerSend::GetPacerQueuingDelayMs() const {
  return pacer_.QueueInMs();
}
int64_t RtpTransportControllerSend::GetFirstPacketTimeMs() const {
  return pacer_.FirstSentPacketTimeMs();
}
void RtpTransportControllerSend::EnablePeriodicAlrProbing(bool enable) {
  task_queue_.PostTask([this, enable]() {
    RTC_DCHECK_RUN_ON(&task_queue_);
    streams_config_.requests_alr_probing = enable;
    UpdateStreamsConfig();
  });
}
void RtpTransportControllerSend::OnSentPacket(
    const rtc::SentPacket& sent_packet) {
  absl::optional<SentPacket> packet_msg = transport_feedback_adapter_.ProcessSentPacket(sent_packet);
#if 0

  if (packet_msg)
  {
    RTC_NORMAL_EX_LOG(
        "[transport_feedback_adapter_.ProcessSentPacket][sent_packet = %s]  [packet_msg = %s]",
        webrtc::ToString(sent_packet) .c_str(),
        webrtc::ToString(packet_msg.value()).c_str());
  }
#endif // _DEBUG
  if (packet_msg) 
  {
    task_queue_.PostTask([this, packet_msg]() 
	{
      RTC_DCHECK_RUN_ON(&task_queue_);
      if (controller_)
      {
        PostUpdates(controller_->OnSentPacket(*packet_msg));
	  }
    });
  }
  pacer_.UpdateOutstandingData( transport_feedback_adapter_.GetOutstandingData().bytes());
}

void RtpTransportControllerSend::SetSdpBitrateParameters(
    const BitrateConstraints& constraints) {
  absl::optional<BitrateConstraints> updated =
      bitrate_configurator_.UpdateWithSdpParameters(constraints);
  if (updated.has_value()) {
    TargetRateConstraints msg = ConvertConstraints(*updated, clock_);
    task_queue_.PostTask([this, msg]() {
      RTC_DCHECK_RUN_ON(&task_queue_);
      if (controller_) {
        PostUpdates(controller_->OnTargetRateConstraints(msg));
      } else {
        UpdateInitialConstraints(msg);
      }
    });
  } else {
    RTC_LOG(LS_VERBOSE)
        << "WebRTC.RtpTransportControllerSend.SetSdpBitrateParameters: "
        << "nothing to update";
  }
}

void RtpTransportControllerSend::SetClientBitratePreferences(
    const BitrateSettings& preferences) {
  absl::optional<BitrateConstraints> updated =
      bitrate_configurator_.UpdateWithClientPreferences(preferences);
  if (updated.has_value()) {
    TargetRateConstraints msg = ConvertConstraints(*updated, clock_);
    task_queue_.PostTask([this, msg]() {
      RTC_DCHECK_RUN_ON(&task_queue_);
      if (controller_) {
        PostUpdates(controller_->OnTargetRateConstraints(msg));
      } else {
        UpdateInitialConstraints(msg);
      }
    });
  } else {
    RTC_LOG(LS_VERBOSE)
        << "WebRTC.RtpTransportControllerSend.SetClientBitratePreferences: "
        << "nothing to update";
  }
}

void RtpTransportControllerSend::OnTransportOverheadChanged(
    size_t transport_overhead_bytes_per_packet) {
  if (transport_overhead_bytes_per_packet >= kMaxOverheadBytes) {
    RTC_LOG(LS_ERROR) << "Transport overhead exceeds " << kMaxOverheadBytes;
    return;
  }

  // TODO(holmer): Call AudioRtpSenders when they have been moved to
  // RtpTransportControllerSend.
  for (auto& rtp_video_sender : video_rtp_senders_) {
    rtp_video_sender->OnTransportOverheadChanged(
        transport_overhead_bytes_per_packet);
  }
}

void RtpTransportControllerSend::OnReceivedEstimatedBitrate(uint32_t bitrate) {
  RemoteBitrateReport msg;
  msg.receive_time = Timestamp::ms(clock_->TimeInMilliseconds());
  msg.bandwidth = DataRate::bps(bitrate);
  task_queue_.PostTask([this, msg]() {
    RTC_DCHECK_RUN_ON(&task_queue_);
    if (controller_)
      PostUpdates(controller_->OnRemoteBitrateReport(msg));
  });
}

void RtpTransportControllerSend::OnReceivedRtcpReceiverReport(const ReportBlockList& report_blocks, int64_t rtt_ms, int64_t now_ms) 
{
  task_queue_.PostTask([this, report_blocks, now_ms]() 
  {
    RTC_DCHECK_RUN_ON(&task_queue_);
    OnReceivedRtcpReceiverReportBlocks(report_blocks, now_ms);
  });

  task_queue_.PostTask([this, now_ms, rtt_ms]() 
  {
    RTC_DCHECK_RUN_ON(&task_queue_);
    RoundTripTimeUpdate report;
    report.receive_time = Timestamp::ms(now_ms);
    report.round_trip_time = TimeDelta::ms(rtt_ms);
    report.smoothed = false;
	if (controller_ && !report.round_trip_time.IsZero())
	{
		// TODO@chensong 2023-05-04 这边更新rtt值哈 ^_^ OnRoundTripTimeUpdate中
      PostUpdates(controller_->OnRoundTripTimeUpdate(report));
	}
  });
}

void RtpTransportControllerSend::AddPacket(uint32_t ssrc,
                                           uint16_t sequence_number,
                                           size_t length,
                                           const PacedPacketInfo& pacing_info) {
  if (send_side_bwe_with_overhead_) {
    length += transport_overhead_bytes_per_packet_;
  }
  transport_feedback_adapter_.AddPacket(
      ssrc, sequence_number, length, pacing_info,
      Timestamp::ms(clock_->TimeInMilliseconds()));
}

void RtpTransportControllerSend::OnTransportFeedback(const rtcp::TransportFeedback& feedback) 
{
  RTC_DCHECK_RUNS_SERIALIZED(&worker_race_);

  absl::optional<TransportPacketsFeedback> feedback_msg = transport_feedback_adapter_.ProcessTransportFeedback(feedback, Timestamp::ms(clock_->TimeInMilliseconds()));
  if (feedback_msg) 
  {
    task_queue_.PostTask([this, feedback_msg]() 
	{
      RTC_DCHECK_RUN_ON(&task_queue_);
      if (controller_)
      {
		  // TODO@chensong 2022-12-05 gcc算法输入数据
        PostUpdates(controller_->OnTransportPacketsFeedback(*feedback_msg));
	  }
    });
  }
  pacer_.UpdateOutstandingData(transport_feedback_adapter_.GetOutstandingData().bytes());
}

void RtpTransportControllerSend::MaybeCreateControllers() {
  RTC_DCHECK(!controller_);
  RTC_DCHECK(!control_handler_);

  if (!network_available_ || !observer_)
  {
    return;
  }
  control_handler_ = absl::make_unique<CongestionControlHandler>();

  initial_config_.constraints.at_time = Timestamp::ms(clock_->TimeInMilliseconds());
  initial_config_.stream_based_config = streams_config_;

  // TODO(srte): Use fallback controller if no feedback is available.
  if (controller_factory_override_) 
  {
    RTC_LOG(LS_INFO) << "Creating overridden congestion controller";
    controller_ = controller_factory_override_->Create(initial_config_);
    process_interval_ = controller_factory_override_->GetProcessInterval();
  } 
  else 
  {
    RTC_LOG(LS_INFO) << "Creating fallback congestion controller";
	// TODO@chensong 2023-05-04 创建GCC模块网络评估模块
    controller_ = controller_factory_fallback_->Create(initial_config_);
    process_interval_ = controller_factory_fallback_->GetProcessInterval();
  }
  UpdateControllerWithTimeInterval();
  StartProcessPeriodicTasks();
}

void RtpTransportControllerSend::UpdateInitialConstraints(
    TargetRateConstraints new_contraints) {
  if (!new_contraints.starting_rate)
    new_contraints.starting_rate = initial_config_.constraints.starting_rate;
  RTC_DCHECK(new_contraints.starting_rate);
  initial_config_.constraints = new_contraints;
}

void RtpTransportControllerSend::StartProcessPeriodicTasks() 
{
  if (!pacer_queue_update_task_.Running()) 
  {
    pacer_queue_update_task_ = RepeatingTaskHandle::DelayedStart(
        task_queue_.Get(), kPacerQueueUpdateInterval, [this]() 
	{
          RTC_DCHECK_RUN_ON(&task_queue_);
          TimeDelta expected_queue_time = TimeDelta::ms(pacer_.ExpectedQueueTimeMs());
          control_handler_->SetPacerQueue(expected_queue_time);
          UpdateControlState();
          return kPacerQueueUpdateInterval;
        });
  }
  controller_task_.Stop();
  if (process_interval_.IsFinite()) 
  {
    // 定时检测更新码率
    controller_task_ = RepeatingTaskHandle::DelayedStart(
        task_queue_.Get(), process_interval_, [this]() {
          RTC_DCHECK_RUN_ON(&task_queue_);
          UpdateControllerWithTimeInterval();
          return process_interval_;
        });
  }
}

void RtpTransportControllerSend::UpdateControllerWithTimeInterval() 
{
  RTC_DCHECK(controller_);
  ProcessInterval msg;
  msg.at_time = Timestamp::ms(clock_->TimeInMilliseconds());
  if (add_pacing_to_cwin_)
  {
	  // TODO@chensong 2023-04-29 单位时间内发送数据的字节数大小
    msg.pacer_queue = DataSize::bytes(pacer_.QueueSizeBytes());
	//RTC_LOG(LS_INFO) << "[pacer_queue = " << ToString(msg.pacer_queue.value()) << "]";
  }
  // 对码率进行检测和更新，将结果转发给pacer
  PostUpdates(controller_->OnProcessInterval(msg));
}

void RtpTransportControllerSend::UpdateStreamsConfig() {
  streams_config_.at_time = Timestamp::ms(clock_->TimeInMilliseconds());
  if (controller_)
  {
    PostUpdates(controller_->OnStreamsConfig(streams_config_));
  }
}

void RtpTransportControllerSend::PostUpdates(NetworkControlUpdate update) {
  if (update.congestion_window)
  {
	  if (update.congestion_window->IsFinite())
	  {
			pacer_.SetCongestionWindow(update.congestion_window->bytes());
	  }
	  else
	  {
            pacer_.SetCongestionWindow(PacedSender::kNoCongestionWindow);
	  }
  }
  if (update.pacer_config) 
  {
    pacer_.SetPacingRates(update.pacer_config->data_rate().bps(), update.pacer_config->pad_rate().bps());
  }
  for (const auto& probe : update.probe_cluster_configs) 
  {
    int64_t bitrate_bps = probe.target_data_rate.bps();
    pacer_.CreateProbeCluster(bitrate_bps, probe.id);
  }
  if (update.target_rate) 
  {
    control_handler_->SetTargetRate(*update.target_rate);
    UpdateControlState();
  }
}

void RtpTransportControllerSend::OnReceivedRtcpReceiverReportBlocks(const ReportBlockList& report_blocks, int64_t now_ms) 
{
	if (report_blocks.empty())
	{
    return;
  }

  int total_packets_lost_delta = 0;
  int total_packets_delta = 0;

  // Compute the packet loss from all report blocks.
  for (const RTCPReportBlock& report_block : report_blocks)
  {
    auto it = last_report_blocks_.find(report_block.source_ssrc);
    if (it != last_report_blocks_.end()) 
	{
	// TODO@chensong 2023-05-04 统计这次汇报接收包的数量
      auto number_of_packets = report_block.extended_highest_sequence_number - it->second.extended_highest_sequence_number;
      total_packets_delta += number_of_packets;
	  // TODO@chensong 2023-05-04 加到上次与当前汇报的数据掉包的总数量
      auto lost_delta = report_block.packets_lost - it->second.packets_lost;
      total_packets_lost_delta += lost_delta;
    }
    last_report_blocks_[report_block.source_ssrc] = report_block;
  }
  // Can only compute delta if there has been previous blocks to compare to. If
  // not, total_packets_delta will be unchanged and there's nothing more to do.
  // TODO@chensong 2023-05-04 说明再次没有发送数据包 直接退出
  if (!total_packets_delta)
  {
    return;
  }
  // TODO@chensong 2023-05-04   [这次汇报与上一次汇报接收包总数量差 - 当前汇报与上次汇报掉包总数差 = 接收包的总数量]
  int packets_received_delta = total_packets_delta - total_packets_lost_delta;
  // To detect lost packets, at least one packet has to be received. This check
  // is needed to avoid bandwith detection update in
  // VideoSendStreamTest.SuspendBelowMinBitrate
  // TODO@chensong 2023-05-04 这边很神奇 我也好奇呢  当前接收的包为小余0就直接退出了 有点懵逼 ^_^ 
  if (packets_received_delta < 1)
  {
    return;
  }
  Timestamp now = Timestamp::ms(now_ms);
  TransportLossReport msg;
  msg.packets_lost_delta = total_packets_lost_delta;
  msg.packets_received_delta = packets_received_delta;
  msg.receive_time = now;
  msg.start_time = last_report_block_time_;
  msg.end_time = now;
  if (controller_)
  {
    PostUpdates(controller_->OnTransportLossReport(msg));
  }
  last_report_block_time_ = now;
}

}  // namespace webrtc
