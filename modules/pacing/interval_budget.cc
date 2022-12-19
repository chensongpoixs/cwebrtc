/*
 *  Copyright (c) 2016 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include <algorithm>

#include "modules/pacing/interval_budget.h"
#include "rtc_base/numerics/safe_conversions.h"

namespace webrtc {
namespace {
/*
这里的窗口目前主要是用来控制can_build_up_underuse_开关打开下，build_up的上限。
考虑到存在这样的情况，随着时间流逝，我们每5ms都有5ms的budget可供使用，但是并不是每一个5ms我们都能够完全使用掉这5ms的budget，这里称作underuse。
因此，can_build_up_underuse_开关允许我们将这些没有用完的预算累计起来，以供后续使用。kWindowMs = 500ms意味着我们可以累积500ms这么多没有用完的预算。

打开这个开关好处在于某些时刻，我们短时间内可供发送的预算更多，在码率抖动较大的时候，我们可以更快地将数据发送出去。
带来的缺陷是，短时间内的码率控制不够平滑，在一些低带宽场景影响更大。
*/
constexpr int kWindowMs = 500;
}

IntervalBudget::IntervalBudget(int initial_target_rate_kbps)
    : IntervalBudget(initial_target_rate_kbps, false) {}

IntervalBudget::IntervalBudget(int initial_target_rate_kbps, bool can_build_up_underuse)
    : bytes_remaining_(0)
	, can_build_up_underuse_(can_build_up_underuse) 
{
  set_target_rate_kbps(initial_target_rate_kbps);
}

void IntervalBudget::set_target_rate_kbps(int target_rate_kbps) 
{
  target_rate_kbps_ = target_rate_kbps;
  max_bytes_in_budget_ = (kWindowMs * target_rate_kbps_) / 8;
  bytes_remaining_ = std::min(std::max(-max_bytes_in_budget_, bytes_remaining_), max_bytes_in_budget_);
}

void IntervalBudget::IncreaseBudget(int64_t delta_time_ms) 
{
  // 一般来说，can_build_up_underuse_ 都会关闭，关于这个开关的介绍见最后一部分介绍
  int bytes = rtc::dchecked_cast<int>(target_rate_kbps_ * delta_time_ms / 8);
  if (bytes_remaining_ < 0 || can_build_up_underuse_) 
  {
    // We overused last interval, compensate this interval.
    // 如果上次发送的过多（bytes_remaining_ < 0），那么本次发送的数据量会变少
    // 如果开启can_build_up_underuse_，则表明可以累积之前没有用完的预算
    bytes_remaining_ = std::min(bytes_remaining_ + bytes, max_bytes_in_budget_);
  }
  else 
  {
    // If we underused last interval we can't use it this interval.
    // 1） 如果上次的budget没有用完（bytes_remaining_ >
    // 0），如果没有设置can_build_up_underuse_
    // 不会对上次的补偿，直接清空所有预算，开始新的一轮

    // 2） 如果设置了can_build_up_underuse_标志，那意味着要考虑上次的underuse，
    // 如果上次没有发送完，则本次需要补偿，见上面if逻辑
    bytes_remaining_ = std::min(bytes, max_bytes_in_budget_);
  }
}

void IntervalBudget::UseBudget(size_t bytes) 
{
  bytes_remaining_ = std::max(bytes_remaining_ - static_cast<int>(bytes), -max_bytes_in_budget_);
}

size_t IntervalBudget::bytes_remaining() const 
{
  return static_cast<size_t>(std::max(0, bytes_remaining_));
}

int IntervalBudget::budget_level_percent() const 
{
  if (max_bytes_in_budget_ == 0)
  {
    return 0;
  }
  return rtc::dchecked_cast<int>(int64_t{bytes_remaining_} * 100 / max_bytes_in_budget_);
}

int IntervalBudget::target_rate_kbps() const 
{
  return target_rate_kbps_;
}

}  // namespace webrtc
