/*
 *  Copyright (c) 2018 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_BITRATE_CONTROLLER_LOSS_BASED_BANDWIDTH_ESTIMATION_H_
#define MODULES_BITRATE_CONTROLLER_LOSS_BASED_BANDWIDTH_ESTIMATION_H_

#include <vector>

#include "api/units/data_rate.h"
#include "api/units/time_delta.h"
#include "api/units/timestamp.h"
#include "modules/rtp_rtcp/include/rtp_rtcp_defines.h"
#include "rtc_base/experiments/field_trial_parser.h"

namespace webrtc {

/**
*    TODO@chensong 20220825 
*       基于损失的控制配置
*/
struct LossBasedControlConfig {
  LossBasedControlConfig();
  LossBasedControlConfig(const LossBasedControlConfig&);
  LossBasedControlConfig& operator=(const LossBasedControlConfig&) = default;
  ~LossBasedControlConfig();
  bool enabled;
  // 最小和最大增长因子
  FieldTrialParameter<double> min_increase_factor;
  FieldTrialParameter<double> max_increase_factor;
  
  // 增长底的rtt和高的rtt
  FieldTrialParameter<TimeDelta> increase_low_rtt;
  FieldTrialParameter<TimeDelta> increase_high_rtt;

  //减少因素
  FieldTrialParameter<double> decrease_factor;
  
  // 损失窗口和最大损失窗口
  FieldTrialParameter<TimeDelta> loss_window;
  FieldTrialParameter<TimeDelta> loss_max_window;

  // 确认速率最大窗口
  FieldTrialParameter<TimeDelta> acknowledged_rate_max_window;

  // 增量偏移
  FieldTrialParameter<DataRate> increase_offset;

  // 损耗带宽平衡增加
  FieldTrialParameter<DataRate> loss_bandwidth_balance_increase;

  // 损耗带宽平衡减少
  FieldTrialParameter<DataRate> loss_bandwidth_balance_decrease;

  // 损耗带宽平衡指数
  FieldTrialParameter<double> loss_bandwidth_balance_exponent;

  // 允许重置
  FieldTrialParameter<bool> allow_resets;

  // 减少间隔
  FieldTrialParameter<TimeDelta> decrease_interval;

  // 丧失汇报超时
  FieldTrialParameter<TimeDelta> loss_report_timeout;
};
/**
* 
*  TODO@chensong 20220825 
*     损耗基带宽估计
*/
class LossBasedBandwidthEstimation {
 public:
  LossBasedBandwidthEstimation();
  void Update(Timestamp at_time,
              DataRate min_bitrate,
              TimeDelta last_round_trip_time);
  void UpdateAcknowledgedBitrate(DataRate acknowledged_bitrate,
                                 Timestamp at_time);
  void MaybeReset(DataRate bitrate);
  void SetInitialBitrate(DataRate bitrate);
  bool Enabled() const { return config_.enabled; }
  void UpdateLossStatistics(const std::vector<PacketResult>& packet_results,
                            Timestamp at_time);
  DataRate GetEstimate() const { return loss_based_bitrate_; }

 private:
  void Reset(DataRate bitrate);

  LossBasedControlConfig config_;
  // 平均损失和平均最大损失
  double average_loss_;
  double average_loss_max_;
  
  // 基于丢失的比特率
  DataRate loss_based_bitrate_;

  //已确认最大比特率
  DataRate acknowledged_bitrate_max_;

  // 上次更新的确认比特率
  Timestamp acknowledged_bitrate_last_update_;

  //上次减少的时间
  Timestamp time_last_decrease_;

  //自上次损失报告以来有所下降
  bool has_decreased_since_last_loss_report_;

  // 上次丢失数据包报告
  Timestamp last_loss_packet_report_;
  // 最后损失率
  double last_loss_ratio_;
};

}  // namespace webrtc

#endif  // MODULES_BITRATE_CONTROLLER_LOSS_BASED_BANDWIDTH_ESTIMATION_H_
