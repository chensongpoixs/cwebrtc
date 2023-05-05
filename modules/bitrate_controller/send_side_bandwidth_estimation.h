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
RttBasedBackoff是一种拥塞控制算法，其原理如下：

1. 首先，RttBasedBackoff会通过发送数据包并测量往返时间（RTT）来估计网络延迟。
  RTT是数据包从发送方到接收方再返回发送方所用的时间。
2. 如果RTT值较小，则表明网络延迟较低，可以继续发送数据包。但如果RTT值较大，
  则可能存在网络拥塞，此时应该减少发送数据包的频率以避免网络拥塞加剧。
3. 当出现网络拥塞时，RttBasedBackoff会根据当前RTT值和一定的退避策略来调整数据包发送的频率。
  例如，可以将发送数据包的时间间隔增加一定的倍数（如2倍、4倍等），以避免网络拥塞进一步恶化。
4. 随着时间的推移，如果网络延迟逐渐恢复，则RttBasedBackoff会逐渐降低退避策略，从而提高数据包发送的频率。

总之，RttBasedBackoff通过实时测量网络延迟并根据退避策略调整数据包发送的频率，
可以在保证数据传输速度的同时避免网络拥塞的发生。
*/
class RttBasedBackoff {
 public:
  RttBasedBackoff();
  ~RttBasedBackoff();
  void OnRouteChange();
  void UpdatePropagationRtt(Timestamp at_time, TimeDelta propagation_rtt);
  //TODO@chensong 2023-04-30  是指已经校正过网络延迟和计算机处理时间的往返时延。它是TCP协议中用于测量网络延迟的重要参数之一，可以帮助判断网络连接质量和诊断网络故障。
  TimeDelta CorrectedRtt(Timestamp at_time) const;

 //private:
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

  // rtt的最后传播（最小的rtt）
  TimeDelta last_propagation_rtt_;

  // 最后发送的数据包
  Timestamp last_packet_sent_;
};
/**
* TODO@chensong 2022-08-25 
*   发送侧带宽估计
* 
1. SendSideBandwidthEstimation的主要功能是进行带宽估算，即根据网络状况动态调整码率和分辨率。具体实现是通过计算发送端的丢包率、延迟等信息来判断网络状况，然后根据网络状况来调整发送端的码率和分辨率。

2. 在源码中，SendSideBandwidthEstimation主要由以下几个部分组成：
  ①. ProbeController：控制发送端的带宽探测，以及根据探测结果来调整码率。
  ②. RembSender：在RTCP报文中发送REM（Receiver Estimated Maximum Bitrate）信息，通知接收端当前可以接受的最大码率。
  ③. BitrateAllocator：根据ProbeController和RembSender的控制信号来分配发送端的带宽，以达到最佳的视频质量和稳定性。
  ④. QualityScaler：根据网络状况和分辨率来动态调整视频的质量因子，以提高视频质量和稳定性。

5. 在源码中，ProbeController是实现带宽探测的关键部分。ProbeController会周期性地发送一些数据包，并根据这些数据包的丢失率和延迟来判断网络状况。如果网络状况不佳，则ProbeController会降低发送端的码率；反之，则ProbeController会增加发送端的码率。
6. 在源码中，RembSender则是用于向接收端发送REM信息的模块。REM信息通知接收端当前可以接受的最大码率。在发送REM信息时，RembSender会根据ProbeController的控制信号来动态地调整REM信息中的码率值。
5. BitrateAllocator则是用于根据ProbeController和RembSender的控制信号来分配发送端的带宽的模块。具体实现是通过计算当前可用的总带宽和各个流的比例来分配带宽。
6.最后，QualityScaler则是通过根据网络状况和分辨率来动态调整视频的质量因子，以提高视频质量和稳定性的模块。具体实现是根据网络状况和分辨率的变化来调整视频质量因子的阈值，以达到最佳的视频质量和稳定性。
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
  // 该方法用于根据网络状况调整当前的发送码率
  void UpdateEstimate(Timestamp at_time);
  // TODO@chensong 2023-04-30 该方法在每次发送数据包时被触发，用于更新网络延迟和丢包率等信息
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
  // TODO@chensong 2023-05-04 该变量在SendSideBandwidthEstimation::UpdatePacketsLost方法中更新false变量
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

  // bwe传入 --->> goog-remb算法 TODO@chensong  2023-04-30 
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
