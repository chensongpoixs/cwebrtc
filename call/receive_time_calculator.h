﻿/*
 *  Copyright (c) 2018 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */
#ifndef CALL_RECEIVE_TIME_CALCULATOR_H_
#define CALL_RECEIVE_TIME_CALCULATOR_H_

#include <stdint.h>
#include <memory>

#include "api/units/time_delta.h"
#include "rtc_base/experiments/field_trial_parser.h"

namespace webrtc {

struct ReceiveTimeCalculatorConfig {
  ReceiveTimeCalculatorConfig();
  ReceiveTimeCalculatorConfig(const ReceiveTimeCalculatorConfig&);
  ReceiveTimeCalculatorConfig& operator=(const ReceiveTimeCalculatorConfig&) =
      default;
  ~ReceiveTimeCalculatorConfig();
  FieldTrialParameter<TimeDelta> max_packet_time_repair;
  FieldTrialParameter<TimeDelta> stall_threshold;
  FieldTrialParameter<TimeDelta> tolerance;
  FieldTrialParameter<TimeDelta> max_stall;
};

// The receive time calculator serves the purpose of combining packet time
// stamps with a safely incremental clock. This assumes that the packet time
// stamps are based on lower layer timestamps that have more accurate time
// increments since they are based on the exact receive time. They might
// however, have large jumps due to clock resets in the system. To compensate
// this they are combined with a safe clock source that is guaranteed to be
// consistent, but it will not be able to measure the exact time when a packet
// is received.
//接收时间计算器用于组合分组时间
//使用安全递增时钟标记。这假设数据包时间
//时间戳基于具有更精确时间的较低层时间戳
//因为它们基于准确的接收时间。他们可能会
//但是由于系统中的时钟重置。补偿
//它们与安全的时钟源相结合
//一致，但无法测量数据包的确切时间
//接收到。
class ReceiveTimeCalculator {
 public:
  static std::unique_ptr<ReceiveTimeCalculator> CreateFromFieldTrial();
  ReceiveTimeCalculator();
  int64_t ReconcileReceiveTimes(int64_t packet_time_us_,
                                int64_t system_time_us_,
                                int64_t safe_time_us_);

 private:
  int64_t last_corrected_time_us_ = -1;
  int64_t last_packet_time_us_ = -1;
  int64_t last_system_time_us_ = -1;
  int64_t last_safe_time_us_ = -1;
  int64_t total_system_time_passed_us_ = 0;
  int64_t static_clock_offset_us_ = 0;
  int64_t small_reset_during_stall_ = false;
  ReceiveTimeCalculatorConfig config_;
};
}  // namespace webrtc
#endif  // CALL_RECEIVE_TIME_CALCULATOR_H_
