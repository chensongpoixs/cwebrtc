/*
 *  Copyright (c) 2013 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_REMOTE_BITRATE_ESTIMATOR_INTER_ARRIVAL_H_
#define MODULES_REMOTE_BITRATE_ESTIMATOR_INTER_ARRIVAL_H_

#include <stddef.h>
#include <stdint.h>

#include "rtc_base/constructor_magic.h"
/*
TODO@chensong 2022-11-30 
Trendline算法计算延时梯度是基于包组的，不是基于包的。而RTT延时计算是基于单个包的.

        Trendline是接收端计算延时，RTT是发起端计算延时，不要混淆。

*/
namespace webrtc {

// Helper class to compute the inter-arrival time delta and the size delta
// between two timestamp groups. A timestamp is a 32 bit unsigned number with
// a client defined rate.
class InterArrival {
 public:
  // After this many packet groups received out of order InterArrival will
  // reset, assuming that clocks have made a jump.
  static constexpr int kReorderedResetThreshold = 3;
  static constexpr int64_t kArrivalTimeOffsetThresholdMs = 3000;

  // A timestamp group is defined as all packets with a timestamp which are at
  // most timestamp_group_length_ticks older than the first timestamp in that
  // group.
  InterArrival(uint32_t timestamp_group_length_ticks,
               double timestamp_to_ms_coeff,
               bool enable_burst_grouping);

  // This function returns true if a delta was computed, or false if the current
  // group is still incomplete or if only one group has been completed.
  // |timestamp| is the timestamp.
  // |arrival_time_ms| is the local time at which the packet arrived.
  // |packet_size| is the size of the packet.
  // |timestamp_delta| (output) is the computed timestamp delta.
  // |arrival_time_delta_ms| (output) is the computed arrival-time delta.
  // |packet_size_delta| (output) is the computed size delta.
  bool ComputeDeltas(uint32_t timestamp,
                     int64_t arrival_time_ms,
                     int64_t system_time_ms,
                     size_t packet_size,
                     uint32_t* timestamp_delta,
                     int64_t* arrival_time_delta_ms,
                     int* packet_size_delta);

 private:
  
	 /*
	 TODO@chensong 2022-11-30 这个数据结果是非常讲究的哈 ^_^ 包组延时评估(InterArrival)


                               Sender                   Network                    Receiver                         
       TG1:first_timestamp        |         seq = 1        |                          |                              
                                  |                        |      time = 1            |     TG1:first_arrival_ms   
                                  |                        |                          |                            
                                  |         seq = 2        |                          |                            
                                  |                        |      time = 2            | 
                                  |                        |                          |                            
                                  |         seq = 3        |                          |                            
                                  |                        |      time = 3            |  
                                  |                        |                          |                            
       TG1:timestamp              |         seq = 4        |                          |                            
                                  |                        |      time = 4            |     TG1:complete_time_ms   
                                  |                        |                          |                            
                                  |                        |                          |                            
                                  |                        |                          |                           
------------------------------------------------------     |  --------------------------------------------------------
                                  |                        |                          |                            
       TG2:first_timestamp        |         seq = 5        |                          |                            
                                  |                        |      time = 10           |     TG2:first_arrival_ms
                                  |                        |                          |                            
                                  |         seq = 6        |                          |                            
                                  |                        |      time = 11           |  
                                  |                        |                          |                            
                                  |         seq = 7        |                          |                            
                                  |                        |      time = 12           | 
                                  |                        |                          |                            
       TG2:timestamp              |         seq = 8        |                          |                            
                                  |                        |      time = 13           |     TG2:complete_time_ms                       								  
                                  |                        |                          |                            								  
                                  |                        |                          |                            								  
  
          图中TG1包括seq 1~4，TG2包括 5~6，因此我们可以计算出 Trendline滤波器需要的三个参数：
             发送时间差值 delta_times、
              到达时间差值 delta_arrival、
              包组大小差值 delta_size。
 
               delta_times     = TG2:timestamp          -            TG1:timestamp;
               delta_arrival   = TG2:complete_time_ms   -            TG1:complete_time_ms;
               delta_size      = TG2:size               -            TG1:size;
	 */
  struct TimestampGroup 
  {
    TimestampGroup()
        : size(0),
          first_timestamp(0),
          timestamp(0),
          first_arrival_ms(-1),
          complete_time_ms(-1) {}

    bool IsFirstPacket() const { return complete_time_ms == -1; }

    size_t size;
    uint32_t first_timestamp;
    uint32_t timestamp;
    int64_t first_arrival_ms;
    int64_t complete_time_ms;
    int64_t last_system_time_ms;
  };

  // Returns true if the packet with timestamp |timestamp| arrived in order.
  bool PacketInOrder(uint32_t timestamp);

  // Returns true if the last packet was the end of the current batch and the
  // packet with |timestamp| is the first of a new batch.
  bool NewTimestampGroup(int64_t arrival_time_ms, uint32_t timestamp) const;

  bool BelongsToBurst(int64_t arrival_time_ms, uint32_t timestamp) const;

  void Reset();

  const uint32_t kTimestampGroupLengthTicks;
  TimestampGroup current_timestamp_group_;
  TimestampGroup prev_timestamp_group_;
  double timestamp_to_ms_coeff_; // 1.4901161193847656e-05
  bool burst_grouping_;
  int num_consecutive_reordered_packets_;

  RTC_DISALLOW_IMPLICIT_CONSTRUCTORS(InterArrival);
};
}  // namespace webrtc

#endif  // MODULES_REMOTE_BITRATE_ESTIMATOR_INTER_ARRIVAL_H_
