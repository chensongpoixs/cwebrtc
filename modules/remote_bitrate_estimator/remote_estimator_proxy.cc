﻿/*
 *  Copyright (c) 2015 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "modules/remote_bitrate_estimator/remote_estimator_proxy.h"

#include <algorithm>
#include <limits>

#include "modules/rtp_rtcp/source/rtcp_packet/transport_feedback.h"
#include "rtc_base/checks.h"
#include "rtc_base/logging.h"
#include "rtc_base/numerics/safe_minmax.h"
#include "system_wrappers/include/clock.h"

namespace webrtc {


	////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////      TODO@chensong  2022-11-29  googcc  算法

//#if 0
//
//static FILE* out_rtc_remote_estimator_proxy_file_ptr = NULL;
//static void rtc_gcc_log() {
//  if (!out_rtc_remote_estimator_proxy_file_ptr) {
//    out_rtc_remote_estimator_proxy_file_ptr =
//        ::fopen("./debug/remote_estimator_proxy.log", "wb+");
//  }
//
//  // va_list argptr;
//  // va_start(argptr, format);
//  // ::fprintf(out_rtc_gcc_file_ptr, format, ##__VA_ARGS__);
//  // ::fprintf(out_rtc_gcc_file_ptr, "\n");
//  // ::fflush(out_rtc_gcc_file_ptr);
//
//  // va_end(argptr);
//}
//
//#define RTC_GCC_NETWORK_CONTROL_LOG()
//#define RTC_NORMAL_LOG(out_file, format, ...)                           \
//  rtc_gcc_log();                                          \
//  if (out_file) {                             \
//    fprintf(out_file, format, ##__VA_ARGS__); \
//    fprintf(out_file, "\n");                  \
//    fflush(out_file);                         \
//  }
//
//#define RTC_NORMAL_EX_LOG(format, ...) \
//  RTC_NORMAL_LOG(out_rtc_remote_estimator_proxy_file_ptr, "[%s][%d][info]" format, \
//             __FUNCTION__, __LINE__, \
//             ##__VA_ARGS__)
// 
//#endif  // _DEBUG


// TODO(sprang): Tune these!
const int RemoteEstimatorProxy::kBackWindowMs = 500;
const int RemoteEstimatorProxy::kMinSendIntervalMs = 50;
const int RemoteEstimatorProxy::kMaxSendIntervalMs = 250;
const int RemoteEstimatorProxy::kDefaultSendIntervalMs = 100;
// Impossible to request feedback older than what can be represented by 15 bits.
const int RemoteEstimatorProxy::kMaxNumberOfPackets = (1 << 15);

// The maximum allowed value for a timestamp in milliseconds. This is lower
// than the numerical limit since we often convert to microseconds.
static constexpr int64_t kMaxTimeMs = std::numeric_limits<int64_t>::max() / 1000;

RemoteEstimatorProxy::RemoteEstimatorProxy(Clock* clock, TransportFeedbackSenderInterface* feedback_sender)
    : clock_(clock),
      feedback_sender_(feedback_sender),
      last_process_time_ms_(-1),
      media_ssrc_(0),
      feedback_packet_count_(0),
      send_interval_ms_(kDefaultSendIntervalMs),
      send_periodic_feedback_(true) {}

RemoteEstimatorProxy::~RemoteEstimatorProxy() {}

void RemoteEstimatorProxy::IncomingPacket(int64_t arrival_time_ms, size_t payload_size, const RTPHeader& header)
{
  if (!header.extension.hasTransportSequenceNumber) 
  {
    RTC_LOG(LS_WARNING)
        << "RemoteEstimatorProxy: Incoming packet "
           "is missing the transport sequence number extension!";
    return;
  }
  rtc::CritScope cs(&lock_);
  media_ssrc_ = header.ssrc;
  OnPacketArrival(header.extension.transportSequenceNumber, arrival_time_ms, header.extension.feedback_request);
}

bool RemoteEstimatorProxy::LatestEstimate(std::vector<unsigned int>* ssrcs, unsigned int* bitrate_bps) const 
{
  return false;
}

int64_t RemoteEstimatorProxy::TimeUntilNextProcess() 
{
  rtc::CritScope cs(&lock_);
  if (!send_periodic_feedback_)
  {
    // Wait a day until next process.
    return (24 * 60 * 60 * 1000);
  } 
  else if (last_process_time_ms_ != -1) 
  {
    int64_t now = clock_->TimeInMilliseconds();
    if (now - last_process_time_ms_ < send_interval_ms_)
    {
      return last_process_time_ms_ + send_interval_ms_ - now;
	}
  }
  return 0;
}

void RemoteEstimatorProxy::Process() 
{
  rtc::CritScope cs(&lock_);
  if (!send_periodic_feedback_) 
  {
    return;
  }
  last_process_time_ms_ = clock_->TimeInMilliseconds();
  // TODO@chensong 2022-12-05 单独模块发送接受数据的信息
  SendPeriodicFeedbacks();
}

void RemoteEstimatorProxy::OnBitrateChanged(int bitrate_bps) 
{
  // TwccReportSize = Ipv4(20B) + UDP(8B) + SRTP(10B) +
  // AverageTwccReport(30B)
  // TwccReport size at 50ms interval is 24 byte.
  // TwccReport size at 250ms interval is 36 byte.
  // AverageTwccReport = (TwccReport(50ms) + TwccReport(250ms)) / 2
  constexpr int kTwccReportSize = 20 + 8 + 10 + 30;
  constexpr double kMinTwccRate = kTwccReportSize * 8.0 * 1000.0 / kMaxSendIntervalMs;
  constexpr double kMaxTwccRate = kTwccReportSize * 8.0 * 1000.0 / kMinSendIntervalMs;

  // Let TWCC reports occupy 5% of total bandwidth.
  rtc::CritScope cs(&lock_);
  send_interval_ms_ = static_cast<int>( 0.5 + kTwccReportSize * 8.0 * 1000.0 / rtc::SafeClamp(0.05 * bitrate_bps, kMinTwccRate, kMaxTwccRate));
}

void RemoteEstimatorProxy::SetSendPeriodicFeedback(bool send_periodic_feedback) 
{
  rtc::CritScope cs(&lock_);
  send_periodic_feedback_ = send_periodic_feedback;
}

void RemoteEstimatorProxy::OnPacketArrival(uint16_t sequence_number, int64_t arrival_time, absl::optional<FeedbackRequest> feedback_request)
{
  if (arrival_time < 0 || arrival_time > kMaxTimeMs) 
  {
    RTC_LOG(LS_WARNING) << "Arrival time out of bounds: " << arrival_time;
    return;
  }

  int64_t seq = unwrapper_.Unwrap(sequence_number);

  if (send_periodic_feedback_) 
  {
	 
	 // lower_bound(key)返回的是大于、等于key的iterator，如果没有，返回空。  
	 //  使用upper_bound(key)时，如果没有找到大于key的iterator时，返回为空
    if (periodic_window_start_seq_ && packet_arrival_times_.lower_bound(*periodic_window_start_seq_) == packet_arrival_times_.end()) 
	{
      // Start new feedback packet, cull old packets.
		//TODO@chensong 2022-12-02 删除小于sequence_number且时间小于当前秒数500毫秒
		// TODO@chensong 2023-03-31  fackback 205 中反馈网络带宽的500毫秒以内数据包网络带宽 超过500毫秒时常删除了----我也很好奇啊 ~~~ ^_^
      for (auto it = packet_arrival_times_.begin(); 
		  it != packet_arrival_times_.end() && it->first < seq && arrival_time - it->second >= kBackWindowMs/*500*/;) 
	  {
        it = packet_arrival_times_.erase(it);
      }
    }
	// TODO@chensong 2023-03-31 判断是否刚刚开始发送数据包
    if (!periodic_window_start_seq_ || seq < *periodic_window_start_seq_) 
	{
      periodic_window_start_seq_ = seq;
    }
  }

  // We are only interested in the first time a packet is received.
  // TODO@chensong 判断数据是否已经接收到了 保存起来哈 ^_^ 
  if (packet_arrival_times_.find(seq) != packet_arrival_times_.end())
  {
    return;
  }

  packet_arrival_times_[seq] = arrival_time;

  // Limit the range of sequence numbers to send feedback for.
  // TODO@chensong 2023-03-31 判断接受包队列中不能超过kMaxNumberOfPackets包的最大数据 多余从第一个开始删除了
  auto first_arrival_time_to_keep = packet_arrival_times_.lower_bound(packet_arrival_times_.rbegin()->first - kMaxNumberOfPackets /* 32768 */);
  if (first_arrival_time_to_keep != packet_arrival_times_.begin()) 
  {
    packet_arrival_times_.erase(packet_arrival_times_.begin(), first_arrival_time_to_keep);
    if (send_periodic_feedback_) 
	{
      // |packet_arrival_times_| cannot be empty since we just added one element
      // and the last element is not deleted.
      RTC_DCHECK(!packet_arrival_times_.empty());
      periodic_window_start_seq_ = packet_arrival_times_.begin()->first;
    }
  }

  if (feedback_request) 
  {
    // Send feedback packet immediately.
    SendFeedbackOnRequest(seq, *feedback_request);
  }
}

void RemoteEstimatorProxy::SendPeriodicFeedbacks() 
{
  // |periodic_window_start_seq_| is the first sequence number to include in the
  // current feedback packet. Some older may still be in the map, in case a
  // reordering happens and we need to retransmit them.
  if (!periodic_window_start_seq_)
  {
    return;
  }
  //  TODO@chensong 2022-12-02 WebRTC中网络带宽信息 反馈信息[ Real-time Transport Control Protocol ( Generic RTP Feedback ) ]
  for (auto begin_iterator = packet_arrival_times_.lower_bound(*periodic_window_start_seq_);
       begin_iterator != packet_arrival_times_.cend(); begin_iterator = packet_arrival_times_.lower_bound(*periodic_window_start_seq_)) 
  {
    rtcp::TransportFeedback feedback_packet;
	// TODO@chensong 2022-12-01  发送feedback packet check data size
    periodic_window_start_seq_ = BuildFeedbackPacket(feedback_packet_count_++, media_ssrc_, *periodic_window_start_seq_,
        begin_iterator, packet_arrival_times_.cend(), &feedback_packet);

    RTC_DCHECK(feedback_sender_ != nullptr);
    feedback_sender_->SendTransportFeedback(&feedback_packet);
    // Note: Don't erase items from packet_arrival_times_ after sending, in case
    // they need to be re-sent after a reordering. Removal will be handled
    // by OnPacketArrival once packets are too old.
  }
}

void RemoteEstimatorProxy::SendFeedbackOnRequest(int64_t sequence_number, const FeedbackRequest& feedback_request) 
{
  if (feedback_request.sequence_count == 0) 
  {
    return;
  }
  rtcp::TransportFeedback feedback_packet(feedback_request.include_timestamps);

  int64_t first_sequence_number = sequence_number - feedback_request.sequence_count + 1;
  auto begin_iterator = packet_arrival_times_.lower_bound(first_sequence_number);
  auto end_iterator = packet_arrival_times_.upper_bound(sequence_number);
#if 0
  RTC_NORMAL_EX_LOG("[first_sequence_number = %llu][sequence_number = %llu]",
                first_sequence_number, sequence_number);
  #endif
  // TODO@chensong 2023-03-31 生成feedback反馈包fmt=205信息
  BuildFeedbackPacket(feedback_packet_count_++, media_ssrc_, first_sequence_number, begin_iterator, end_iterator, &feedback_packet);

  // Clear up to the first packet that is included in this feedback packet.
  // TODO@chensong 2023-03-31 清除feedback中反馈过的数据包的信息
  packet_arrival_times_.erase(packet_arrival_times_.begin(), begin_iterator);

  RTC_DCHECK(feedback_sender_ != nullptr);
  feedback_sender_->SendTransportFeedback(&feedback_packet);
}

int64_t RemoteEstimatorProxy::BuildFeedbackPacket(uint8_t feedback_packet_count, uint32_t media_ssrc, int64_t base_sequence_number, 
	std::map<int64_t, int64_t>::const_iterator begin_iterator, std::map<int64_t, int64_t>::const_iterator end_iterator, 
	rtcp::TransportFeedback* feedback_packet) 
{
  RTC_DCHECK(begin_iterator != end_iterator);

  // TODO(sprang): Measure receive times in microseconds and remove the
  // conversions below.
  feedback_packet->SetMediaSsrc(media_ssrc);
  // Base sequence number is the expected first sequence number. This is known,
  // but we might not have actually received it, so the base time shall be the
  // time of the first received packet in the feedback.
  // TODO@chensong 2023-03-31   设置基类数  和时间戳毫秒还是微妙呢
  feedback_packet->SetBase(static_cast<uint16_t>(base_sequence_number & 0xFFFF), begin_iterator->second * 1000);
  // TODO@chensong 2022-12-02 RTCP的反馈信息 中 feedback_packet_number
  feedback_packet->SetFeedbackSequenceNumber(feedback_packet_count);
  int64_t next_sequence_number = base_sequence_number;

  #if 0

  RTC_NORMAL_EX_LOG("[base_sequence_number = %llu]", base_sequence_number);
#endif  // _DEBUG


  for (auto it = begin_iterator; it != end_iterator; ++it) 
  {
#if 0

    RTC_NORMAL_EX_LOG("[it->first = %llu][it->second == %llu]", it->first, it->second);
#endif  // _DEBUG
    if (!feedback_packet->AddReceivedPacket(static_cast<uint16_t>(it->first & 0xFFFF), it->second * 1000)) 
	{
      // If we can't even add the first seq to the feedback packet, we won't be
      // able to build it at all.
      RTC_CHECK(begin_iterator != it);

      // Could not add timestamp, feedback packet might be full. Return and
      // try again with a fresh packet.
      break;
    }
    next_sequence_number = it->first + 1;
  }
  return next_sequence_number;
}

}  // namespace webrtc
