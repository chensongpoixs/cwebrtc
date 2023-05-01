/*
 *  Copyright (c) 2016 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_CONGESTION_CONTROLLER_GOOG_CC_DELAY_BASED_BWE_H_
#define MODULES_CONGESTION_CONTROLLER_GOOG_CC_DELAY_BASED_BWE_H_

#include <stddef.h>
#include <stdint.h>
#include <memory>
#include <vector>

#include "absl/types/optional.h"
#include "api/network_state_predictor.h"
#include "api/transport/webrtc_key_value_config.h"
#include "modules/congestion_controller/goog_cc/delay_increase_detector_interface.h"
#include "modules/congestion_controller/goog_cc/probe_bitrate_estimator.h"
#include "modules/remote_bitrate_estimator/aimd_rate_control.h"
#include "modules/remote_bitrate_estimator/include/bwe_defines.h"
#include "modules/remote_bitrate_estimator/inter_arrival.h"
#include "modules/rtp_rtcp/include/rtp_rtcp_defines.h"  // For PacketFeedback
#include "rtc_base/constructor_magic.h"
#include "rtc_base/race_checker.h"

namespace webrtc {
class RtcEventLog;
/*
TODO@chensong 2023-05-01 

1. 收集网络延迟信息
   DelayBasedBwe通过收集网络延迟来估计网络带宽。具体地，每个传输周期内，
DelayBasedBwe将记录发送方发送数据的时间戳和接收方接收数据的时间戳，并计算出当前网络的单向传输延迟。

2. 计算反馈延迟差值
在WebRTC中，接收方会定期向发送方发送RTCP包来提供反馈信息。DelayBasedBwe会通过检查RTCP包中的反馈延迟差值来了解网络状况。
反馈延迟差值表示接收方接收到数据的时间与发送反馈信息的时间之间的延迟差，该值通常与当前网络拥塞程度有关。

3. 预测网络拥塞程度
根据上述两个步骤所得到的网络延迟信息和反馈延迟差值，DelayBasedBwe会预测当前网络的拥塞程度。如果反馈延迟差值较大，则说明网络存在拥塞，
而网络延迟也可能增加。如果多次预测结果都表明网络拥塞程度较高，则DelayBasedBwe会减少发送带宽，避免进一步加重拥塞情况。

4. 动态调整发送带宽
DelayBasedBwe会根据预测结果动态调整发送带宽。如果网络拥塞程度较低，则发送带宽可能会增加；反之，如果网络拥塞程度较高，则发送带宽可能会减少。
通过这种方式，DelayBasedBwe可以在最小化数据包丢失的同时，尽可能地利用可用的带宽资源，提高通信质量



5. 基于延迟的带宽估算
DelayBasedBwe通过测量网络传输的延迟，计算出网络的带宽瓶颈。具体来说，它会在每个RTCP SR报文中记录发送时间戳和接收时间戳，
通过计算两者之差得到网络延迟值。然后将延迟值转换成带宽估算值，这个值可以用来调整视频编码器的码率，以达到更好的视频质量。

6. 窗口滑动平均
为了更准确地估计网络带宽，DelayBasedBwe使用了一个窗口滑动平均算法。它会维护一个固定大小的窗口，每当收到一个新的延迟值时，
就将其加入窗口并计算窗口内所有延迟值的平均值。这样可以避免单个延迟值对带宽估算的影响，提高估算结果的稳定性。

7. 带宽调整
根据估算出的带宽值，DelayBasedBwe会动态地调整视频编码器的码率，以适应当前网络状况。具体来说，如果带宽估算值较低，
则会降低编码器的码率，减少发送数据量，以避免网络拥塞。反之，如果带宽估算值较高，则会增加编码器的码率，提高视频质量。

*/
class DelayBasedBwe {
 public:
  struct Result {
    Result();
    Result(bool probe, DataRate target_bitrate);
    ~Result();
    bool updated;
    bool probe;
    DataRate target_bitrate = DataRate::Zero();
    bool recovered_from_overuse;
    bool backoff_in_alr;
  };

  explicit DelayBasedBwe(const WebRtcKeyValueConfig* key_value_config,
                         RtcEventLog* event_log,
                         NetworkStatePredictor* network_state_predictor);
  virtual ~DelayBasedBwe();

  Result IncomingPacketFeedbackVector(
      const std::vector<PacketFeedback>& packet_feedback_vector,
      absl::optional<DataRate> acked_bitrate,
      absl::optional<DataRate> probe_bitrate,
      bool in_alr,
      Timestamp at_time);
  void OnRttUpdate(TimeDelta avg_rtt);
  bool LatestEstimate(std::vector<uint32_t>* ssrcs, DataRate* bitrate) const;
  void SetStartBitrate(DataRate start_bitrate);
  void SetMinBitrate(DataRate min_bitrate);
  TimeDelta GetExpectedBwePeriod() const;
  void SetAlrLimitedBackoffExperiment(bool enabled);

 private:
  friend class GoogCcStatePrinter;
  void IncomingPacketFeedback(const PacketFeedback& packet_feedback,
                              Timestamp at_time);
  Result MaybeUpdateEstimate(absl::optional<DataRate> acked_bitrate,
                             absl::optional<DataRate> probe_bitrate,
                             bool recovered_from_overuse,
                             bool in_alr,
                             Timestamp at_time);
  // Updates the current remote rate estimate and returns true if a valid
  // estimate exists.
  bool UpdateEstimate(Timestamp now,
                      absl::optional<DataRate> acked_bitrate,
                      DataRate* target_bitrate);

  rtc::RaceChecker network_race_;
  RtcEventLog* const event_log_;
  std::unique_ptr<InterArrival> inter_arrival_;
  std::unique_ptr<DelayIncreaseDetectorInterface> delay_detector_;
  Timestamp last_seen_packet_;
  bool uma_recorded_;
  AimdRateControl rate_control_;
  size_t trendline_window_size_;
  double trendline_smoothing_coeff_;
  double trendline_threshold_gain_;
  DataRate prev_bitrate_;
  BandwidthUsage prev_state_;
  bool alr_limited_backoff_enabled_;
  NetworkStatePredictor* network_state_predictor_;

  RTC_DISALLOW_IMPLICIT_CONSTRUCTORS(DelayBasedBwe);
};

}  // namespace webrtc

#endif  // MODULES_CONGESTION_CONTROLLER_GOOG_CC_DELAY_BASED_BWE_H_
