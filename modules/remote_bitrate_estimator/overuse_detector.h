/*
 *  Copyright (c) 2012 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */
#ifndef MODULES_REMOTE_BITRATE_ESTIMATOR_OVERUSE_DETECTOR_H_
#define MODULES_REMOTE_BITRATE_ESTIMATOR_OVERUSE_DETECTOR_H_

#include <stdint.h>

#include "modules/remote_bitrate_estimator/include/bwe_defines.h"
#include "rtc_base/constructor_magic.h"

namespace webrtc {

bool AdaptiveThresholdExperimentIsDisabled();
/*
TODO@chensong 2022-11-29 
过载检测器(over-use detector)
将trend值与动态阈值 threshold
进行比较，决策当前网络处于哪种状态。WebRTC中网络状态有如下三种。

normal 带宽常态使用，既不过载、也不拥塞。
overuse 带宽使用过载，网络发生拥塞。
underuse 当前带宽利用不足，可充分利用。
实际使用中，由于trend
是一个非常小的值，会乘以包组数量和增益系数进行放大得到modified_trend。

modified_trend > threshold ,持续时间超过100ms并且 trend值持续变大，认为此时处于
overuse 状态。 modified_trend < – threshold ,认为此时处于underuse 状态。
-threshold < modifed_trend < threshold ,认为此时处于normal 状态。
判断依据是，网络发生拥塞时，数据包会在中间网络设备排队等待转发，延迟梯度就会增长。网络流量开始回落时，中间网络设备快速转发其它发送队列中的数据包，延迟梯队开始降低。网络流量回归正常后，中简网络设备转发数据包耗时更短，这时延迟梯度减小或为负值。

从判断过程可以看出动态阈值threshold很关键，它决定了算法对时延梯度的灵敏度。

阈值不能过于敏感，否则会导致网络一直处于拥塞状态；
如果灵敏度过低，无法检测到网络拥塞。
采用固定值，会被TCP流饿死。
这个阈值threshold根据如下公式计算：


每处理一个新包组信息，就会更新一次阈值，其中ΔT表示距离上次阈值更新经历的时间，m(ti)是前面说到的调整后的斜率值modified_trend。

kγ(ti)按如下定义：


kd与ku分别决定阈值增加以及减小的速度。
*/
class OveruseDetector {
 public:
  OveruseDetector();
  virtual ~OveruseDetector();

  // Update the detection state based on the estimated inter-arrival time delta
  // offset. |timestamp_delta| is the delta between the last timestamp which the
  // estimated offset is based on and the last timestamp on which the last
  // offset was based on, representing the time between detector updates.
  // |num_of_deltas| is the number of deltas the offset estimate is based on.
  // Returns the state after the detection update.
  BandwidthUsage Detect(double offset,
                        double timestamp_delta,
                        int num_of_deltas,
                        int64_t now_ms);

  // Returns the current detector state.
  BandwidthUsage State() const;

 private:
  void UpdateThreshold(double modified_offset, int64_t now_ms);
  void InitializeExperiment();

  bool in_experiment_;
  double k_up_;
  double k_down_;
  double overusing_time_threshold_;
  double threshold_;
  int64_t last_update_ms_;
  double prev_offset_;
  double time_over_using_;
  int overuse_counter_;
  BandwidthUsage hypothesis_;

  RTC_DISALLOW_COPY_AND_ASSIGN(OveruseDetector);
};
}  // namespace webrtc

#endif  // MODULES_REMOTE_BITRATE_ESTIMATOR_OVERUSE_DETECTOR_H_
