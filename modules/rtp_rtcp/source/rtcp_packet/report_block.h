﻿/*
 *  Copyright (c) 2015 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 *
 */

#ifndef MODULES_RTP_RTCP_SOURCE_RTCP_PACKET_REPORT_BLOCK_H_
#define MODULES_RTP_RTCP_SOURCE_RTCP_PACKET_REPORT_BLOCK_H_

#include <stddef.h>
#include <stdint.h>

namespace webrtc {
namespace rtcp {

// A ReportBlock represents the Sender Report packet from
// RFC 3550 section 6.4.1.
class ReportBlock {
 public:
  static const size_t kLength = 24;

  ReportBlock();
  ~ReportBlock() {}

  bool Parse(const uint8_t* buffer, size_t length);

  // Fills buffer with the ReportBlock.
  // Consumes ReportBlock::kLength bytes.
  void Create(uint8_t* buffer) const;

  void SetMediaSsrc(uint32_t ssrc) { source_ssrc_ = ssrc; }
  void SetFractionLost(uint8_t fraction_lost) {
    fraction_lost_ = fraction_lost;
  }
  bool SetCumulativeLost(int32_t cumulative_lost);
  void SetExtHighestSeqNum(uint32_t ext_highest_seq_num) {
    extended_high_seq_num_ = ext_highest_seq_num;
  }
  void SetJitter(uint32_t jitter) { jitter_ = jitter; }
  void SetLastSr(uint32_t last_sr) { last_sr_ = last_sr; }
  void SetDelayLastSr(uint32_t delay_last_sr) {
    delay_since_last_sr_ = delay_last_sr;
  }

  uint32_t source_ssrc() const { return source_ssrc_; }
  uint8_t fraction_lost() const { return fraction_lost_; }
  int32_t cumulative_lost_signed() const { return cumulative_lost_; }
  // Deprecated - returns max(0, cumulative_lost_), not negative values.
  uint32_t cumulative_lost() const;
  uint32_t extended_high_seq_num() const { return extended_high_seq_num_; }
  uint32_t jitter() const { return jitter_; }
  uint32_t last_sr() const { return last_sr_; }
  uint32_t delay_since_last_sr() const { return delay_since_last_sr_; }

 private:
  uint32_t source_ssrc_;     // 32 bits 接收到的每个媒体源
  uint8_t fraction_lost_;    // 8 bits representing a fixed point value 0..1 上一次报告之后从SSRC_n来包的漏包比列
  int32_t cumulative_lost_;  // Signed 24-bit value 自接收开始漏包总数，迟到包不算漏包，重传有可以导致负数
  uint32_t extended_high_seq_num_;  // 32 bits  低16位表式收到的最大seq，高16位表式seq循环次数 
  uint32_t jitter_;                 // 32 bits RTP包到达时间间隔的统计方差
  uint32_t last_sr_;                // 32 bits NTP时间戳的中间32位 --> 从源 SSRC_n 来的最近的 RTCPSR。如果尚未接收到 SR，域设置为零。
  uint32_t delay_since_last_sr_;    // 32 bits, units of 1/65536 seconds//记录接收SR的时间与发送SR的时间差
};

}  // namespace rtcp
}  // namespace webrtc
#endif  // MODULES_RTP_RTCP_SOURCE_RTCP_PACKET_REPORT_BLOCK_H_
