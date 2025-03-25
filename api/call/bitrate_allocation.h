/*
 *  Copyright 2018 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */
#ifndef API_CALL_BITRATE_ALLOCATION_H_
#define API_CALL_BITRATE_ALLOCATION_H_

#include "api/units/data_rate.h"
#include "api/units/time_delta.h"

namespace webrtc {

// BitrateAllocationUpdate provides information to allocated streams about their
// bitrate allocation. It originates from the BitrateAllocater class and is
// propagated from there.
struct BitrateAllocationUpdate {
  // The allocated target bitrate. Media streams should produce this amount of
  // data. (Note that this may include packet overhead depending on
  // configuration.)
	// 目标码率
  DataRate target_bitrate = DataRate::Zero();
  // The allocated part of the estimated link capacity. This is more stable than
  // the target as it is based on the underlying link capacity estimate. This
  // should be used to change encoder configuration when the cost of change is
  // high.
  //  估计链路容量的分配部分。这比
//目标是基于基础链路容量估计的。这
//当更改成本为 高。
  DataRate link_capacity = DataRate::Zero();
  // Predicted packet loss ratio.
  // 丢包率 近期传输的丢包统计信息，用于触发码率下调或冗余保护（如 FEC）的启用?
  double packet_loss_ratio = 0;
  // Predicted round trip time. rtt 
  TimeDelta round_trip_time = TimeDelta::PlusInfinity();
  // |bwe_period| is deprecated, use the link capacity allocation instead.
  // |bwe_period |已弃用，请改用链路容量分配
  TimeDelta bwe_period = TimeDelta::PlusInfinity();
};

}  // namespace webrtc

#endif  // API_CALL_BITRATE_ALLOCATION_H_
