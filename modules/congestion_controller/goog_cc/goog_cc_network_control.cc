﻿/*
 *  Copyright (c) 2018 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "modules/congestion_controller/goog_cc/goog_cc_network_control.h"

#include <inttypes.h>
#include <stdio.h>
#include <algorithm>
#include <cstdint>
#include <memory>
#include <numeric>
#include <string>
#include <utility>
#include <vector>

#include "absl/memory/memory.h"
#include "api/units/time_delta.h"
#include "modules/congestion_controller/goog_cc/acknowledged_bitrate_estimator.h"
#include "modules/congestion_controller/goog_cc/alr_detector.h"
#include "modules/congestion_controller/goog_cc/probe_controller.h"
#include "modules/remote_bitrate_estimator/include/bwe_defines.h"
#include "modules/remote_bitrate_estimator/test/bwe_test_logging.h"
#include "modules/rtp_rtcp/include/rtp_rtcp_defines.h"
#include "rtc_base/checks.h"
#include "rtc_base/logging.h"

namespace webrtc {
namespace {
// From RTCPSender video report interval.
constexpr TimeDelta kLossUpdateInterval = TimeDelta::Millis<1000>();

// Pacing-rate relative to our target send rate.
// Multiplicative factor that is applied to the target bitrate to calculate
// the number of bytes that can be transmitted per interval.
// Increasing this factor will result in lower delays in cases of bitrate
// overshoots from the encoder.
const float kDefaultPaceMultiplier = 2.5f;

std::vector<PacketFeedback> ReceivedPacketsFeedbackAsRtp(const TransportPacketsFeedback report) 
{
  std::vector<PacketFeedback> packet_feedback_vector;
  for (auto& fb : report.PacketsWithFeedback()) 
  {
    if (fb.receive_time.IsFinite()) 
	{
      PacketFeedback pf(fb.receive_time.ms(), 0);
      pf.creation_time_ms = report.feedback_time.ms();
      pf.payload_size = fb.sent_packet.size.bytes();
      pf.pacing_info = fb.sent_packet.pacing_info;
      pf.send_time_ms = fb.sent_packet.send_time.ms();
      pf.unacknowledged_data = fb.sent_packet.prior_unacked_data.bytes();
      packet_feedback_vector.push_back(pf);
    }
  }
  std::sort(packet_feedback_vector.begin(), packet_feedback_vector.end(), PacketFeedbackComparator());
  return packet_feedback_vector;
}

int64_t GetBpsOrDefault(const absl::optional<DataRate>& rate,
                        int64_t fallback_bps) {
  if (rate && rate->IsFinite()) {
    return rate->bps();
  } else {
    return fallback_bps;
  }
}
bool IsEnabled(const WebRtcKeyValueConfig* config, absl::string_view key) {
  return config->Lookup(key).find("Enabled") == 0;
}
bool IsNotDisabled(const WebRtcKeyValueConfig* config, absl::string_view key) {
  return config->Lookup(key).find("Disabled") != 0;
}
}  // namespace

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////      TODO@chensong  2022-11-29  googcc  算法
 

///////////////////////////////////////////////////////////////////////////////////////////////////
GoogCcNetworkController::GoogCcNetworkController(
    RtcEventLog* event_log,
    NetworkControllerConfig config,
    bool feedback_only,
    std::unique_ptr<NetworkStatePredictor> network_state_predictor)
    : key_value_config_(config.key_value_config ? config.key_value_config
                                                : &trial_based_config_),
      event_log_(event_log),
      packet_feedback_only_(feedback_only),
      safe_reset_on_route_change_("Enabled"),
      safe_reset_acknowledged_rate_("ack"),
      use_stable_bandwidth_estimate_(
          IsEnabled(key_value_config_, "WebRTC-Bwe-StableBandwidthEstimate")),
      fall_back_to_probe_rate_(
          IsEnabled(key_value_config_, "WebRTC-Bwe-ProbeRateFallback")),
      use_min_allocatable_as_lower_bound_(
          IsNotDisabled(key_value_config_, "WebRTC-Bwe-MinAllocAsLowerBound")),
      rate_control_settings_(
          RateControlSettings::ParseFromKeyValueConfig(key_value_config_)),
      probe_controller_(new ProbeController(key_value_config_, event_log)),
      congestion_window_pushback_controller_(
          rate_control_settings_.UseCongestionWindowPushback()
              ? absl::make_unique<CongestionWindowPushbackController>(
                    key_value_config_)
              : nullptr),
      bandwidth_estimation_(absl::make_unique<SendSideBandwidthEstimation>(event_log_)),
      alr_detector_(absl::make_unique<AlrDetector>()),
      probe_bitrate_estimator_(new ProbeBitrateEstimator(event_log)),
      delay_based_bwe_(new DelayBasedBwe(key_value_config_, event_log_, network_state_predictor.get())),
      acknowledged_bitrate_estimator_(absl::make_unique<AcknowledgedBitrateEstimator>(key_value_config_)),
      initial_config_(config),
      last_raw_target_rate_(*config.constraints.starting_rate),
      last_pushback_target_rate_(last_raw_target_rate_),
      pacing_factor_(config.stream_based_config.pacing_factor.value_or(kDefaultPaceMultiplier)),
      min_total_allocated_bitrate_(config.stream_based_config.min_total_allocated_bitrate.value_or(DataRate::Zero())),
      max_padding_rate_(config.stream_based_config.max_padding_rate.value_or(DataRate::Zero())),
      max_total_allocated_bitrate_(DataRate::Zero()),
      network_state_predictor_(std::move(network_state_predictor)) 
{
  RTC_DCHECK(config.constraints.at_time.IsFinite());
  ParseFieldTrial({&safe_reset_on_route_change_, &safe_reset_acknowledged_rate_},
      key_value_config_->Lookup("WebRTC-Bwe-SafeResetOnRouteChange"));
  if (delay_based_bwe_)
  {
    delay_based_bwe_->SetMinBitrate(congestion_controller::GetMinBitrate());
  }
}

GoogCcNetworkController::~GoogCcNetworkController() {}

NetworkControlUpdate GoogCcNetworkController::OnNetworkAvailability(
    NetworkAvailability msg) {
  NetworkControlUpdate update;
  update.probe_cluster_configs = probe_controller_->OnNetworkAvailability(msg);
  return update;
}

NetworkControlUpdate GoogCcNetworkController::OnNetworkRouteChange(
    NetworkRouteChange msg) {
  if (safe_reset_on_route_change_) {
    absl::optional<DataRate> estimated_bitrate;
    if (safe_reset_acknowledged_rate_) {
      estimated_bitrate = acknowledged_bitrate_estimator_->bitrate();
      if (!estimated_bitrate)
        estimated_bitrate = acknowledged_bitrate_estimator_->PeekRate();
    } else {
      int32_t target_bitrate_bps;
      uint8_t fraction_loss;
      int64_t rtt_ms;

      bandwidth_estimation_->CurrentEstimate(&target_bitrate_bps,
                                             &fraction_loss, &rtt_ms);

 

      estimated_bitrate = DataRate::bps(target_bitrate_bps);
    }
    if (estimated_bitrate) {
      if (msg.constraints.starting_rate) {
        msg.constraints.starting_rate =
            std::min(*msg.constraints.starting_rate, *estimated_bitrate);
      } else {
        msg.constraints.starting_rate = estimated_bitrate;
      }
    }
  }

  acknowledged_bitrate_estimator_.reset(
      new AcknowledgedBitrateEstimator(key_value_config_));
  probe_bitrate_estimator_.reset(new ProbeBitrateEstimator(event_log_));
  delay_based_bwe_.reset(new DelayBasedBwe(key_value_config_, event_log_,
                                           network_state_predictor_.get()));
  bandwidth_estimation_->OnRouteChange();
 

  probe_controller_->Reset(msg.at_time.ms());
  NetworkControlUpdate update;
  update.probe_cluster_configs = ResetConstraints(msg.constraints);
  MaybeTriggerOnNetworkChanged(&update, msg.at_time);
  return update;
}

/*
TODO@chensong 得到目标码率 [update]
*/
NetworkControlUpdate GoogCcNetworkController::OnProcessInterval(ProcessInterval msg) 
{
  NetworkControlUpdate update;
  if (initial_config_) 
  {
    // 重设loss_based和delay_based码率探测器和probe的初始码率
    // 获得码率探测簇配置(probe_cluster_config)
    update.probe_cluster_configs =  ResetConstraints(initial_config_->constraints);
    // 获取当前pacing 的发送码率, padding， time_windows等
    update.pacer_config = GetPacingRates(msg.at_time);

	// probe探测完成后，允许其因为alr需要快速恢复码率而继续做probe
    if (initial_config_->stream_based_config.requests_alr_probing) 
	{
      probe_controller_->EnablePeriodicAlrProbing(*initial_config_->stream_based_config.requests_alr_probing);
    }
    absl::optional<DataRate> total_bitrate = initial_config_->stream_based_config.max_total_allocated_bitrate;
    if (total_bitrate) 
	{
      // 为probe设置最大的分配码率(MaxTotalAllocatedBitrate)作为探测的上边界
      // 并生成响应的probe_cluster_config去进行探测
      auto probes = probe_controller_->OnMaxTotalAllocatedBitrate(total_bitrate->bps(), msg.at_time.ms());
      update.probe_cluster_configs.insert(update.probe_cluster_configs.end(), probes.begin(), probes.end()); 
      max_total_allocated_bitrate_ = *total_bitrate;
    }
    // 释放initial_config_，下次进来就不通过init_config做初始化了
    initial_config_.reset();
  }
  // 更新拥塞窗口中的pacing数据长度
  if (congestion_window_pushback_controller_ && msg.pacer_queue) 
  {
    congestion_window_pushback_controller_->UpdatePacingQueue(msg.pacer_queue->bytes());
  }
  // 更新码率
  bandwidth_estimation_->UpdateEstimate(msg.at_time);
 
        // 检测当前是否处于alr
  absl::optional<int64_t> start_time_ms = alr_detector_->GetApplicationLimitedRegionStartTime();

  // 如果处于alr，告诉probe_controller处于alr，可以进行探测，进行快恢复
  probe_controller_->SetAlrStartTimeMs(start_time_ms);

  // 检测当前是否因alr状态而需要做probe了，获取probe_cluster_config
  
  std::vector<ProbeClusterConfig> probes = probe_controller_->Process(msg.at_time.ms());
  //RTC_LOG(LS_INFO)  << " [ProbeClusterConfig probes = " << probes.size() << "]";
  update.probe_cluster_configs.insert(update.probe_cluster_configs.end(), probes.begin(), probes.end());

   // 获取更新后的码率，probe等，同时对alr， probe_controller中的码率进行更新
  MaybeTriggerOnNetworkChanged(&update, msg.at_time);
  /*for (const ProbeClusterConfig& probecluster : update.probe_cluster_configs)
  {
	  RTC_LOG(LS_INFO)  << " [ProbeClusterConfig id = " << probecluster.id<< "][bitate = "<< ToString(probecluster.target_data_rate)<<"]";
  }*/
  return update;
}

NetworkControlUpdate GoogCcNetworkController::OnRemoteBitrateReport(RemoteBitrateReport msg) 
{
  if (packet_feedback_only_) 
  {
    RTC_LOG(LS_ERROR) << "Received REMB for packet feedback only GoogCC";
    return NetworkControlUpdate();
  }
  RTC_LOG(LS_INFO) << "["<<__FUNCTION__<<"][receive_time = "<<msg.receive_time<<"][bandwidth = "<<msg.bandwidth<<"]";
  bandwidth_estimation_->UpdateReceiverEstimate(msg.receive_time, msg.bandwidth);

 

  BWE_TEST_LOGGING_PLOT(1, "REMB_kbps", msg.receive_time.ms(), msg.bandwidth.bps() / 1000);
  return NetworkControlUpdate();
}

NetworkControlUpdate GoogCcNetworkController::OnRoundTripTimeUpdate(RoundTripTimeUpdate msg)
{
	if (packet_feedback_only_ || msg.smoothed)
	{
		return NetworkControlUpdate();
	}
  RTC_DCHECK(!msg.round_trip_time.IsZero());
  if (delay_based_bwe_)
  {
	  delay_based_bwe_->OnRttUpdate(msg.round_trip_time);
  }
  bandwidth_estimation_->UpdateRtt(msg.round_trip_time, msg.receive_time);

 

  return NetworkControlUpdate();
}

NetworkControlUpdate GoogCcNetworkController::OnSentPacket(
    SentPacket sent_packet) {
  alr_detector_->OnBytesSent(sent_packet.size.bytes(),
                             sent_packet.send_time.ms());
  if (!first_packet_sent_) {
    first_packet_sent_ = true;
    // Initialize feedback time to send time to allow estimation of RTT until
    // first feedback is received.
    bandwidth_estimation_->UpdatePropagationRtt(sent_packet.send_time,
                                                TimeDelta::Zero());
 
  }
  bandwidth_estimation_->OnSentPacket(sent_packet);
 
  if (congestion_window_pushback_controller_) {
    congestion_window_pushback_controller_->UpdateOutstandingData(
        sent_packet.data_in_flight.bytes());
    NetworkControlUpdate update;
    MaybeTriggerOnNetworkChanged(&update, sent_packet.send_time);
    return update;
  } else {
    return NetworkControlUpdate();
  }
}

NetworkControlUpdate GoogCcNetworkController::OnStreamsConfig(StreamsConfig msg) 
{
  NetworkControlUpdate update;
  if (msg.requests_alr_probing)
  {
    probe_controller_->EnablePeriodicAlrProbing(*msg.requests_alr_probing);
  }
  if (msg.max_total_allocated_bitrate &&
      *msg.max_total_allocated_bitrate != max_total_allocated_bitrate_) 
  {
    if (rate_control_settings_.TriggerProbeOnMaxAllocatedBitrateChange()) 
	{
      update.probe_cluster_configs = probe_controller_->OnMaxTotalAllocatedBitrate(
              msg.max_total_allocated_bitrate->bps(), msg.at_time.ms());
    }
	else 
	{
		//TODO@chensong 20230628 修改码流
      probe_controller_->SetMaxBitrate(msg.max_total_allocated_bitrate->bps());
    }
    max_total_allocated_bitrate_ = *msg.max_total_allocated_bitrate;
  }
  bool pacing_changed = false;
  if (msg.pacing_factor && *msg.pacing_factor != pacing_factor_) 
  {
    pacing_factor_ = *msg.pacing_factor;
    pacing_changed = true;
  }
  if (msg.min_total_allocated_bitrate && *msg.min_total_allocated_bitrate != min_total_allocated_bitrate_) 
  {
    min_total_allocated_bitrate_ = *msg.min_total_allocated_bitrate;
    pacing_changed = true;

    if (use_min_allocatable_as_lower_bound_)
	{
      ClampConstraints();
      delay_based_bwe_->SetMinBitrate(min_data_rate_);
      bandwidth_estimation_->SetMinMaxBitrate(min_data_rate_, max_data_rate_);
 
    }
  }
  if (msg.max_padding_rate && *msg.max_padding_rate != max_padding_rate_)
  {
    max_padding_rate_ = *msg.max_padding_rate;
    pacing_changed = true;
  }

  if (pacing_changed)
  {
	  update.pacer_config = GetPacingRates(msg.at_time);
  }

  return update;
}

NetworkControlUpdate GoogCcNetworkController::OnTargetRateConstraints(
    TargetRateConstraints constraints) {
  NetworkControlUpdate update;
  update.probe_cluster_configs = ResetConstraints(constraints);
  MaybeTriggerOnNetworkChanged(&update, constraints.at_time);
  return update;
}

void GoogCcNetworkController::ClampConstraints() {
  // TODO(holmer): We should make sure the default bitrates are set to 10 kbps,
  // and that we don't try to set the min bitrate to 0 from any applications.
  // The congestion controller should allow a min bitrate of 0.
  min_data_rate_ = std::max(min_data_rate_, congestion_controller::GetMinBitrate());
  if (use_min_allocatable_as_lower_bound_)
  {
	  min_data_rate_ = std::max(min_data_rate_, min_total_allocated_bitrate_);
  }
  if (max_data_rate_ < min_data_rate_) 
  {
    RTC_LOG(LS_WARNING) << "max bitrate smaller than min bitrate";
    max_data_rate_ = min_data_rate_;
  }
  if (starting_rate_ && starting_rate_ < min_data_rate_) 
  {
    RTC_LOG(LS_WARNING) << "start bitrate smaller than min bitrate";
    starting_rate_ = min_data_rate_;
  }
}

std::vector<ProbeClusterConfig> GoogCcNetworkController::ResetConstraints(TargetRateConstraints new_constraints) 
{
  min_data_rate_ = new_constraints.min_data_rate.value_or(DataRate::Zero());
  max_data_rate_ = new_constraints.max_data_rate.value_or(DataRate::PlusInfinity());
  starting_rate_ = new_constraints.starting_rate;
  ClampConstraints();

  bandwidth_estimation_->SetBitrates(starting_rate_, min_data_rate_,
                                     max_data_rate_, new_constraints.at_time);
 

  if (starting_rate_)
  {
	  delay_based_bwe_->SetStartBitrate(*starting_rate_);
  }
  delay_based_bwe_->SetMinBitrate(min_data_rate_);

  return probe_controller_->SetBitrates(
      min_data_rate_.bps(), GetBpsOrDefault(starting_rate_, -1),
      max_data_rate_.bps_or(-1), new_constraints.at_time.ms());
}

NetworkControlUpdate GoogCcNetworkController::OnTransportLossReport(TransportLossReport msg) 
{
	if (packet_feedback_only_)
	{
		return NetworkControlUpdate();
  }
	// TODO@chensong 2023-05-04 神奇一面出现啦    接收的总包 + 掉包的总数量  要干嘛 没有看懂你   看看下面的逻辑
  int64_t total_packets_delta = msg.packets_received_delta + msg.packets_lost_delta;
  bandwidth_estimation_->UpdatePacketsLost( msg.packets_lost_delta, total_packets_delta, msg.receive_time);
 

  return NetworkControlUpdate();
}
// TODO@chensong 2022-12-05 根据接收端接受数据 进行评估带宽 
NetworkControlUpdate GoogCcNetworkController::OnTransportPacketsFeedback(TransportPacketsFeedback report) 
{
  if (report.packet_feedbacks.empty()) 
  {
    // TODO(bugs.webrtc.org/10125): Design a better mechanism to safe-guard
    // against building very large network queues.
    return NetworkControlUpdate();
  }

  if (congestion_window_pushback_controller_) 
  {
	  //TODO@chensong 2023-05-01 更新网络通道数据的大小~~~
    congestion_window_pushback_controller_->UpdateOutstandingData(report.data_in_flight.bytes());
  }
  TimeDelta max_feedback_rtt = TimeDelta::MinusInfinity();
  TimeDelta min_propagation_rtt = TimeDelta::PlusInfinity();
  Timestamp max_recv_time = Timestamp::MinusInfinity();

  std::vector<PacketResult> feedbacks = report.ReceivedWithSendInfo();
  for (const auto& feedback : feedbacks)
  {
	  //所有的seq包中最大接收的时间戳
    max_recv_time = std::max(max_recv_time, feedback.receive_time);
  }

  for (const auto& feedback : feedbacks) 
  {
	  // TODO@chensong 2023-05-01 
	  // 当前seq中接收feedback包时间戳 与接收端接收的时间差 好奇为什么使用这样的公式
	  ///    |   send_time   |  receive_time | feedback_time |  
	  //    三个时间戳有关系呢好奇啦 ~~~~
    TimeDelta feedback_rtt = report.feedback_time - feedback.sent_packet.send_time;
	// 非常有意思的东西啦 出现啦~~~~~~  而且肯定是负值呢 好奇心满满啦^_^
    TimeDelta min_pending_time = feedback.receive_time - max_recv_time;
    TimeDelta propagation_rtt = feedback_rtt - min_pending_time;
	// |||
    max_feedback_rtt = std::max(max_feedback_rtt, feedback_rtt);
	// rtt的传播时间最短的
    min_propagation_rtt = std::min(min_propagation_rtt, propagation_rtt);
  }

  if (max_feedback_rtt.IsFinite()) 
  {
    feedback_max_rtts_.push_back(max_feedback_rtt.ms());
    const size_t kMaxFeedbackRttWindow = 32;
    if (feedback_max_rtts_.size() > kMaxFeedbackRttWindow) 
	{
      feedback_max_rtts_.pop_front();
    }
    // TODO(srte): Use time since last unacknowledged packet.
	// TODO@chensong 2023-05-01 记录当前时间中最小rtt 更新bandwidth模块中去
    bandwidth_estimation_->UpdatePropagationRtt(report.feedback_time, min_propagation_rtt);

  }
  if (packet_feedback_only_) 
  {
    if (!feedback_max_rtts_.empty()) 
	{
		// accumulate : v.	积累; 积聚; (数量)逐渐增加; (数额)逐渐增长;
      int64_t sum_rtt_ms = std::accumulate(feedback_max_rtts_.begin(), feedback_max_rtts_.end(), 0);
      int64_t mean_rtt_ms = sum_rtt_ms / feedback_max_rtts_.size();
	  // 得到当前最新的rtt的平均值
      if (delay_based_bwe_)
      {
        delay_based_bwe_->OnRttUpdate(TimeDelta::ms(mean_rtt_ms));
	  }
    }

    TimeDelta feedback_min_rtt = TimeDelta::PlusInfinity();
    for (const auto& packet_feedback : feedbacks) 
	{
	  //每个seq包与最大接收时间的差值
      TimeDelta pending_time = packet_feedback.receive_time - max_recv_time;
	  // 当前接收到feedback包时间减去发送的时间 在减去 接收时间戳去最大接收时间的差值    得到是当前没有使用的rtt的时间 

      TimeDelta rtt = report.feedback_time - packet_feedback.sent_packet.send_time - pending_time;
      // Value used for predicting NACK round trip time in FEC controller.
      feedback_min_rtt = std::min(rtt, feedback_min_rtt);
    }
    if (feedback_min_rtt.IsFinite()) 
	{
      bandwidth_estimation_->UpdateRtt(feedback_min_rtt, report.feedback_time);

    }

    expected_packets_since_last_loss_update_ += report.PacketsWithFeedback().size();
    for (const auto& packet_feedback : report.PacketsWithFeedback()) 
	{
		if (packet_feedback.receive_time.IsInfinite())
		{
			lost_packets_since_last_loss_update_ += 1;
	  }
    }
	// TODO@chensong 20233-05-01 哈哈找到你吧 ~~~~ 网络掉包严重啦 延迟较高啦
    if (report.feedback_time > next_loss_update_)
	{
      next_loss_update_ = report.feedback_time + kLossUpdateInterval;
      bandwidth_estimation_->UpdatePacketsLost(lost_packets_since_last_loss_update_, expected_packets_since_last_loss_update_, report.feedback_time);


      expected_packets_since_last_loss_update_ = 0;
      lost_packets_since_last_loss_update_ = 0;
    }
  }
  // TODO@chensong 2022-11-30 接受的feedback信息包数组
  std::vector<PacketFeedback> received_feedback_vector = ReceivedPacketsFeedbackAsRtp(report);

  absl::optional<int64_t> alr_start_time = alr_detector_->GetApplicationLimitedRegionStartTime();

  if (previously_in_alr && !alr_start_time.has_value())
  {
    int64_t now_ms = report.feedback_time.ms();
    acknowledged_bitrate_estimator_->SetAlrEndedTimeMs(now_ms);
    probe_controller_->SetAlrEndedTimeMs(now_ms);
  }
  previously_in_alr = alr_start_time.has_value();
  acknowledged_bitrate_estimator_->IncomingPacketFeedbackVector(received_feedback_vector);
  absl::optional<DataRate> acknowledged_bitrate = acknowledged_bitrate_estimator_->bitrate();
  for (const auto& feedback : received_feedback_vector)
  {
    if (feedback.pacing_info.probe_cluster_id != PacedPacketInfo::kNotAProbe) 
	{
      probe_bitrate_estimator_->HandleProbeAndEstimateBitrate(feedback);
    }
  }

  absl::optional<DataRate> probe_bitrate = probe_bitrate_estimator_->FetchAndResetLastEstimatedBitrate();
  if (fall_back_to_probe_rate_ && !acknowledged_bitrate)
  {
    acknowledged_bitrate = probe_bitrate_estimator_->last_estimate();
  }
  bandwidth_estimation_->SetAcknowledgedRate(acknowledged_bitrate, report.feedback_time);



  bandwidth_estimation_->IncomingPacketFeedbackVector(report);
 

  NetworkControlUpdate update;
  bool recovered_from_overuse = false;
  bool backoff_in_alr = false;
  // TODO@chensong 2022-11-30  基于延迟（delay-based）的拥塞控制算法
  DelayBasedBwe::Result result;
  result = delay_based_bwe_->IncomingPacketFeedbackVector( received_feedback_vector, acknowledged_bitrate, probe_bitrate, alr_start_time.has_value(), report.feedback_time);

  if (result.updated)
  {
    if (result.probe) 
	{
      bandwidth_estimation_->SetSendBitrate(result.target_bitrate, report.feedback_time);
 
    }
    // Since SetSendBitrate now resets the delay-based estimate, we have to
    // call UpdateDelayBasedEstimate after SetSendBitrate.
    bandwidth_estimation_->UpdateDelayBasedEstimate(report.feedback_time, result.target_bitrate);
 

    // Update the estimate in the ProbeController, in case we want to probe.
    MaybeTriggerOnNetworkChanged(&update, report.feedback_time);
  }
  recovered_from_overuse = result.recovered_from_overuse;
  backoff_in_alr = result.backoff_in_alr;

  if (recovered_from_overuse) 
  {
    probe_controller_->SetAlrStartTimeMs(alr_start_time);
    auto probes = probe_controller_->RequestProbe(report.feedback_time.ms());
    update.probe_cluster_configs.insert(update.probe_cluster_configs.end(),
                                        probes.begin(), probes.end());
  } 
  else if (backoff_in_alr) 
  {
    // If we just backed off during ALR, request a new probe.
    auto probes = probe_controller_->RequestProbe(report.feedback_time.ms());
    update.probe_cluster_configs.insert(update.probe_cluster_configs.end(),
                                        probes.begin(), probes.end());
  }

  // No valid RTT could be because send-side BWE isn't used, in which case
  // we don't try to limit the outstanding packets.
  if (rate_control_settings_.UseCongestionWindow() && max_feedback_rtt.IsFinite()) 
  {
    int64_t min_feedback_max_rtt_ms = *std::min_element(feedback_max_rtts_.begin(), feedback_max_rtts_.end());

    const DataSize kMinCwnd = DataSize::bytes(2 * 1500);
    TimeDelta time_window = TimeDelta::ms( min_feedback_max_rtt_ms + rate_control_settings_.GetCongestionWindowAdditionalTimeMs());
    DataSize data_window = last_raw_target_rate_ * time_window;
    if (current_data_window_) 
	{
      data_window = std::max(kMinCwnd, (data_window + current_data_window_.value()) / 2);
    }
	else 
	{
      data_window = std::max(kMinCwnd, data_window);
    }
    current_data_window_ = data_window;
  }
  if (congestion_window_pushback_controller_ && current_data_window_) 
  {
	  congestion_window_pushback_controller_->SetDataWindow(*current_data_window_);
  } 
  else 
  {
    update.congestion_window = current_data_window_;
  }

  return update;
}

NetworkControlUpdate GoogCcNetworkController::GetNetworkState(
    Timestamp at_time) const {
  DataRate bandwidth = use_stable_bandwidth_estimate_
                           ? bandwidth_estimation_->GetEstimatedLinkCapacity()
                           : last_raw_target_rate_;
 
  TimeDelta rtt = TimeDelta::ms(last_estimated_rtt_ms_);
  NetworkControlUpdate update;
  update.target_rate = TargetTransferRate();
  update.target_rate->network_estimate.at_time = at_time;
  update.target_rate->network_estimate.bandwidth = bandwidth;
  update.target_rate->network_estimate.loss_rate_ratio =
      last_estimated_fraction_loss_ / 255.0;
  update.target_rate->network_estimate.round_trip_time = rtt;
  update.target_rate->network_estimate.bwe_period =
      delay_based_bwe_->GetExpectedBwePeriod();

  update.target_rate->at_time = at_time;
  update.target_rate->target_rate = bandwidth;
  update.pacer_config = GetPacingRates(at_time);
  update.congestion_window = current_data_window_;
  return update;
}

void GoogCcNetworkController::MaybeTriggerOnNetworkChanged(NetworkControlUpdate* update, Timestamp at_time) 
{
  int32_t estimated_bitrate_bps;
  uint8_t fraction_loss;
  int64_t rtt_ms;
  bandwidth_estimation_->CurrentEstimate(&estimated_bitrate_bps, &fraction_loss, &rtt_ms);
 
  BWE_TEST_LOGGING_PLOT(1, "fraction_loss_%", at_time.ms(),
                        (fraction_loss * 100) / 256);
  BWE_TEST_LOGGING_PLOT(1, "rtt_ms", at_time.ms(), rtt_ms);
  BWE_TEST_LOGGING_PLOT(1, "Target_bitrate_kbps", at_time.ms(),
                        estimated_bitrate_bps / 1000);

  DataRate target_rate = DataRate::bps(estimated_bitrate_bps);
  RTC_LOG(LS_INFO) << "[target_rate = " << ToString(target_rate) << "]";
  if (congestion_window_pushback_controller_) {
    int64_t pushback_rate =
        congestion_window_pushback_controller_->UpdateTargetBitrate(
            target_rate.bps());
    pushback_rate = std::max<int64_t>(bandwidth_estimation_->GetMinBitrate(),
                                      pushback_rate);
    target_rate = DataRate::bps(pushback_rate);
  }

  if ((estimated_bitrate_bps != last_estimated_bitrate_bps_) ||
      (fraction_loss != last_estimated_fraction_loss_) ||
      (rtt_ms != last_estimated_rtt_ms_) ||
      (target_rate != last_pushback_target_rate_)) {
    last_pushback_target_rate_ = target_rate;
    last_estimated_bitrate_bps_ = estimated_bitrate_bps;
    last_estimated_fraction_loss_ = fraction_loss;
    last_estimated_rtt_ms_ = rtt_ms;

    alr_detector_->SetEstimatedBitrate(estimated_bitrate_bps);

    last_raw_target_rate_ = DataRate::bps(estimated_bitrate_bps);
    DataRate bandwidth = use_stable_bandwidth_estimate_
                             ? bandwidth_estimation_->GetEstimatedLinkCapacity()
                             : last_raw_target_rate_;
 

    TimeDelta bwe_period = delay_based_bwe_->GetExpectedBwePeriod();

    TargetTransferRate target_rate_msg;
    target_rate_msg.at_time = at_time;
    target_rate_msg.target_rate = target_rate;
    target_rate_msg.network_estimate.at_time = at_time;
    target_rate_msg.network_estimate.round_trip_time = TimeDelta::ms(rtt_ms);
    target_rate_msg.network_estimate.bandwidth = bandwidth;
    target_rate_msg.network_estimate.loss_rate_ratio = fraction_loss / 255.0f;
    target_rate_msg.network_estimate.bwe_period = bwe_period;

    update->target_rate = target_rate_msg;

    auto probes = probe_controller_->SetEstimatedBitrate(last_raw_target_rate_.bps(), at_time.ms());
    update->probe_cluster_configs.insert(update->probe_cluster_configs.end(), probes.begin(), probes.end());
    update->pacer_config = GetPacingRates(at_time);

    RTC_LOG(LS_VERBOSE) << "bwe " << at_time.ms() << " pushback_target_bps="
                        << last_pushback_target_rate_.bps()
                        << " estimate_bps=" << last_raw_target_rate_.bps();
  }
}
// RtpTransportControllerSend::UpdateControllerWithTimeInterval() 
//RtpTransportControllerSend::PostUpdates(NetworkControlUpdate update)
// GoogCcNetworkController::OnProcessInterval
// GoogCcNetworkController::MaybeTriggerOnNetworkChanged
// TODO@chensong 2023-04-29 获取码流字节数据
PacerConfig GoogCcNetworkController::GetPacingRates(Timestamp at_time) const {
  // Pacing rate is based on target rate before congestion window pushback,
  // because we don't want to build queues in the pacer when pushback occurs.
  DataRate pacing_rate = std::max(min_total_allocated_bitrate_, last_raw_target_rate_) * pacing_factor_/*2.5f*/;
  DataRate padding_rate = std::min(max_padding_rate_, last_pushback_target_rate_);
  PacerConfig msg;
  msg.at_time = at_time;
  msg.time_window = TimeDelta::seconds(1);
  msg.data_window = pacing_rate * msg.time_window;
  msg.pad_window = padding_rate * msg.time_window;
  return msg;
}

}  // namespace webrtc
