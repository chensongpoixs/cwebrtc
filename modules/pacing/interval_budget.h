/*
 *  Copyright (c) 2016 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_PACING_INTERVAL_BUDGET_H_
#define MODULES_PACING_INTERVAL_BUDGET_H_

#include <stddef.h>
#include <stdint.h>

namespace webrtc {

// TODO(tschumim): Reflector IntervalBudget so that we can set a under- and
// over-use budget in ms.
class IntervalBudget {
 public:
  explicit IntervalBudget(int initial_target_rate_kbps);
  IntervalBudget(int initial_target_rate_kbps, bool can_build_up_underuse);
  // 设置目标发送码率
  void set_target_rate_kbps(int target_rate_kbps);

  // TODO(tschumim): Unify IncreaseBudget and UseBudget to one function.
  // 时间流逝后增加budget
  void IncreaseBudget(int64_t delta_time_ms);
  // 发送数据后减少budget
  void UseBudget(size_t bytes);
  // 剩余budget
  size_t bytes_remaining() const;
  // 剩余budget占当前窗口数据量比例
  int budget_level_percent() const;
  // 目标发送码率
  int target_rate_kbps() const;

 private:
  // 设置的目标码率，按照这个码率控制数据发送
  int target_rate_kbps_;
  // 窗口内（500ms）对应的最大字节数=窗口大小*target_rate_kbps_/8
  int max_bytes_in_budget_;
  // 剩余可发送字节数，限制范围:[-max_bytes_in_budget_, max_bytes_in_budget_]
  int bytes_remaining_;
  // 上个周期underuse，本周期是否可以借用上个周期的剩余量
  bool can_build_up_underuse_;
};

}  // namespace webrtc

#endif  // MODULES_PACING_INTERVAL_BUDGET_H_
