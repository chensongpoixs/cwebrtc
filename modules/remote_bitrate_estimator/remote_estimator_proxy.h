﻿/*
 *  Copyright (c) 2015 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_REMOTE_BITRATE_ESTIMATOR_REMOTE_ESTIMATOR_PROXY_H_
#define MODULES_REMOTE_BITRATE_ESTIMATOR_REMOTE_ESTIMATOR_PROXY_H_

#include <map>
#include <vector>

#include "modules/remote_bitrate_estimator/include/remote_bitrate_estimator.h"
#include "rtc_base/critical_section.h"
#include "rtc_base/numerics/sequence_number_util.h"

namespace webrtc {

class Clock;
class PacketRouter;
namespace rtcp {
class TransportFeedback;
}

// Class used when send-side BWE is enabled: This proxy is instantiated on the
// receive side. It buffers a number of receive timestamps and then sends
// transport feedback messages back too the send side.
//启用发送端BWE时使用的类：此代理在
//接收侧。它缓冲多个接收时间戳，然后发送
//将反馈消息传输回发送方。
class RemoteEstimatorProxy : public RemoteBitrateEstimator {
 public:
  static const int kMinSendIntervalMs;
  static const int kMaxSendIntervalMs;
  static const int kDefaultSendIntervalMs;
  static const int kBackWindowMs;
  RemoteEstimatorProxy(Clock* clock, TransportFeedbackSenderInterface* feedback_sender);
  ~RemoteEstimatorProxy() override;

  void IncomingPacket(int64_t arrival_time_ms, size_t payload_size, const RTPHeader& header) override;
  void RemoveStream(uint32_t ssrc) override {}
  bool LatestEstimate(std::vector<unsigned int>* ssrcs, unsigned int* bitrate_bps) const override;
  void OnRttUpdate(int64_t avg_rtt_ms, int64_t max_rtt_ms) override {}
  void SetMinBitrate(int min_bitrate_bps) override {}
  int64_t TimeUntilNextProcess() override;
  void Process() override;
  void OnBitrateChanged(int bitrate);
  void SetSendPeriodicFeedback(bool send_periodic_feedback);

 private:
  static const int kMaxNumberOfPackets;
  void OnPacketArrival(uint16_t sequence_number, int64_t arrival_time, absl::optional<FeedbackRequest> feedback_request) RTC_EXCLUSIVE_LOCKS_REQUIRED(&lock_);
  void SendPeriodicFeedbacks() RTC_EXCLUSIVE_LOCKS_REQUIRED(&lock_);
  void SendFeedbackOnRequest(int64_t sequence_number, const FeedbackRequest& feedback_request)  RTC_EXCLUSIVE_LOCKS_REQUIRED(&lock_);
  static int64_t BuildFeedbackPacket(uint8_t feedback_packet_count, uint32_t media_ssrc, int64_t base_sequence_number,
      std::map<int64_t, int64_t>::const_iterator begin_iterator,  // |begin_iterator| is inclusive.
      std::map<int64_t, int64_t>::const_iterator end_iterator,  // |end_iterator| is exclusive.
      rtcp::TransportFeedback* feedback_packet);

  Clock* const clock_;
  TransportFeedbackSenderInterface* const feedback_sender_; //TODO@chensong 2022-12-02  ==> PacketRouter 
  int64_t last_process_time_ms_;

  rtc::CriticalSection lock_;

  uint32_t media_ssrc_ RTC_GUARDED_BY(&lock_);
  // TODO@chensong 2023-03-31 feedback 反馈网络带宽评估的计算包序列号 --->>> 
  uint8_t feedback_packet_count_ RTC_GUARDED_BY(&lock_);
  SeqNumUnwrapper<uint16_t> unwrapper_ RTC_GUARDED_BY(&lock_);
  absl::optional<int64_t> periodic_window_start_seq_ RTC_GUARDED_BY(&lock_);
  // Map unwrapped seq -> time.  TODO@chensong  2022-12-04 这边增加500毫秒这样做有什么好处
  std::map<int64_t, int64_t> packet_arrival_times_ RTC_GUARDED_BY(&lock_);
  int64_t send_interval_ms_ RTC_GUARDED_BY(&lock_);// default : 100 
  bool send_periodic_feedback_ RTC_GUARDED_BY(&lock_);
};

}  // namespace webrtc

#endif  //  MODULES_REMOTE_BITRATE_ESTIMATOR_REMOTE_ESTIMATOR_PROXY_H_
