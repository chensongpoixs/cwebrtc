/*
 *  Copyright (c) 2012 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 *
 *  FEC and NACK added bitrate is handled outside class
 */

#ifndef MODULES_BITRATE_CONTROLLER_SEND_SIDE_BANDWIDTH_ESTIMATION_H_
#define MODULES_BITRATE_CONTROLLER_SEND_SIDE_BANDWIDTH_ESTIMATION_H_

#include <stdint.h>
#include <deque>
#include <utility>
#include <vector>

#include "absl/types/optional.h"
#include "api/transport/network_types.h"
#include "api/units/data_rate.h"
#include "api/units/time_delta.h"
#include "api/units/timestamp.h"
#include "modules/bitrate_controller/loss_based_bandwidth_estimation.h"
#include "modules/rtp_rtcp/include/rtp_rtcp_defines.h"
#include "rtc_base/experiments/field_trial_parser.h"

namespace webrtc {

class RtcEventLog;

/**  TODO@chensong 2022-10-19 基于丢包计算预估码率，结合延迟预估码率，得到最终的目标码率
*   TODO@chensong 20220825
*      链路容量跟踪器
*/
class LinkCapacityTracker {
 public:
  LinkCapacityTracker();
  ~LinkCapacityTracker();
  void OnOveruse(DataRate acknowledged_rate, Timestamp at_time);
  void OnStartingRate(DataRate start_rate);
  void OnRateUpdate(DataRate acknowledged, Timestamp at_time);
  void OnRttBackoff(DataRate backoff_rate, Timestamp at_time);
  DataRate estimate() const;

 private:
	 // 跟踪率
  FieldTrialParameter<TimeDelta> tracking_rate;

  // 容量估计bps
  double capacity_estimate_bps_ = 0;

  // 最后链路容量更新
  Timestamp last_link_capacity_update_ = Timestamp::MinusInfinity();
};
/**
*   TODO@chensong 20220825 
*     基于Rtt的回退
*/
class RttBasedBackoff {
 public:
  RttBasedBackoff();
  ~RttBasedBackoff();
  void OnRouteChange();
  void UpdatePropagationRtt(Timestamp at_time, TimeDelta propagation_rtt);
  TimeDelta CorrectedRtt(Timestamp at_time) const;

  // rtt极限
  FieldTrialParameter<TimeDelta> rtt_limit_;

  // 下降分数
  FieldTrialParameter<double> drop_fraction_;

  // 下降间隔
  FieldTrialParameter<TimeDelta> drop_interval_;

  // 坚持更改路线
  FieldTrialFlag persist_on_route_change_;

  //安全超时 
  FieldTrialParameter<bool> safe_timeout_;

  // 带宽下限
  FieldTrialParameter<DataRate> bandwidth_floor_;

 public:
	 // 上次传播rtt更新
  Timestamp last_propagation_rtt_update_;

  // rtt的最后传播
  TimeDelta last_propagation_rtt_;

  // 最后发送的数据包
  Timestamp last_packet_sent_;
};
/**
* TODO@chensong 20220825 
*   发送侧带宽估计
*/
class SendSideBandwidthEstimation {
 public:
  SendSideBandwidthEstimation() = delete;
  explicit SendSideBandwidthEstimation(RtcEventLog* event_log);
  ~SendSideBandwidthEstimation();

  void OnRouteChange();
  void CurrentEstimate(int* bitrate, uint8_t* loss, int64_t* rtt) const;
  DataRate GetEstimatedLinkCapacity() const;
  // Call periodically to update estimate.
  void UpdateEstimate(Timestamp at_time);
  void OnSentPacket(const SentPacket& sent_packet);
  void UpdatePropagationRtt(Timestamp at_time, TimeDelta propagation_rtt);

  // Call when we receive a RTCP message with TMMBR or REMB.
  void UpdateReceiverEstimate(Timestamp at_time, DataRate bandwidth);

  // Call when a new delay-based estimate is available.
  void UpdateDelayBasedEstimate(Timestamp at_time, DataRate bitrate);

  // Call when we receive a RTCP message with a ReceiveBlock.
  void UpdateReceiverBlock(uint8_t fraction_loss,
                           TimeDelta rtt_ms,
                           int number_of_packets,
                           Timestamp at_time);

  // Call when we receive a RTCP message with a ReceiveBlock.
  void UpdatePacketsLost(int packets_lost,
                         int number_of_packets,
                         Timestamp at_time);

  // Call when we receive a RTCP message with a ReceiveBlock.
  void UpdateRtt(TimeDelta rtt, Timestamp at_time);

  void SetBitrates(absl::optional<DataRate> send_bitrate,
                   DataRate min_bitrate,
                   DataRate max_bitrate,
                   Timestamp at_time);
  void SetSendBitrate(DataRate bitrate, Timestamp at_time);
  void SetMinMaxBitrate(DataRate min_bitrate, DataRate max_bitrate);
  int GetMinBitrate() const;
  void SetAcknowledgedRate(absl::optional<DataRate> acknowledged_rate,
                           Timestamp at_time);
  void IncomingPacketFeedbackVector(const TransportPacketsFeedback& report);

 private:
  enum UmaState { kNoUpdate, kFirstDone, kDone };

  bool IsInStartPhase(Timestamp at_time) const;

  void UpdateUmaStatsPacketsLost(Timestamp at_time, int packets_lost);

  // Updates history of min bitrates.
  // After this method returns min_bitrate_history_.front().second contains the
  // min bitrate used during last kBweIncreaseIntervalMs.
  void UpdateMinHistory(Timestamp at_time);

  DataRate MaybeRampupOrBackoff(DataRate new_bitrate, Timestamp at_time);

  // Cap |bitrate| to [min_bitrate_configured_, max_bitrate_configured_] and
  // set |current_bitrate_| to the capped value and updates the event log.
  void CapBitrateToThresholds(Timestamp at_time, DataRate bitrate);

  RttBasedBackoff rtt_backoff_; // 基于Rtt的回退
  LinkCapacityTracker link_capacity_; //链路容量跟踪器

  // 最小比特率历史记录
  std::deque<std::pair<Timestamp, DataRate> > min_bitrate_history_;

  // incoming filters
  // 自上次丢失更新以来丢失的数据包
  int lost_packets_since_last_loss_update_;
  // 上次丢失更新后的预期数据包
  int expected_packets_since_last_loss_update_;
  

  // 确认率
  absl::optional<DataRate> acknowledged_rate_;

  // 当前的比特率
  DataRate current_bitrate_;

  // 最小比特率配置和最大比特率配置
  DataRate min_bitrate_configured_;
  DataRate max_bitrate_configured_;

  // 最后一个低比特率日志
  Timestamp last_low_bitrate_log_;

  // 自上次部分损失以来已减少
  bool has_decreased_since_last_fraction_loss_;

  // 最后损失反馈
  Timestamp last_loss_feedback_;
  // 上次丢失数据包报告
  Timestamp last_loss_packet_report_;

  // 最后超时
  Timestamp last_timeout_;

  // 最后一部分损失
  uint8_t last_fraction_loss_;

  // 最后记录的分数损失
  uint8_t last_logged_fraction_loss_;

  // 最后一次往返时间
  TimeDelta last_round_trip_time_;

  // bwe传入
  DataRate bwe_incoming_;

  // 基于延迟的比特率
  DataRate delay_based_bitrate_;

  // 上次减少的时间
  Timestamp time_last_decrease_;

  // 第一次报告时间
  Timestamp first_report_time_;

  // 最初丢失的数据包
  int initially_lost_packets_;

  // 2秒时的比特率
  DataRate bitrate_at_2_seconds_;

  // uma更新状态
  UmaState uma_update_state_;

  // uma rtt状态
  UmaState uma_rtt_state_;

  // 升级uma统计数据
  std::vector<bool> rampup_uma_stats_updated_;
  RtcEventLog* event_log_;

  // 上次rtc事件日志
  Timestamp last_rtc_event_log_;
  // 超时实验
  bool in_timeout_experiment_;
  // 低损耗阈值
  float low_loss_threshold_;
  // 高损耗阈值
  float high_loss_threshold_;
  // 比特率_阈值
  DataRate bitrate_threshold_;
  LossBasedBandwidthEstimation loss_based_bandwidth_estimation_;
};
}  // namespace webrtc
#endif  // MODULES_BITRATE_CONTROLLER_SEND_SIDE_BANDWIDTH_ESTIMATION_H_
