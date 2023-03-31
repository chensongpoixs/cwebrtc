/*
 *  Copyright (c) 2015 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_RTP_RTCP_SOURCE_RTCP_PACKET_TRANSPORT_FEEDBACK_H_
#define MODULES_RTP_RTCP_SOURCE_RTCP_PACKET_TRANSPORT_FEEDBACK_H_

#include <memory>
#include <vector>

#include "modules/rtp_rtcp/source/rtcp_packet/rtpfb.h"

namespace webrtc {
namespace rtcp {
class CommonHeader;

class TransportFeedback : public Rtpfb {
 public:
  class ReceivedPacket {
   public:
    ReceivedPacket(uint16_t sequence_number, int16_t delta_ticks)
        : sequence_number_(sequence_number), delta_ticks_(delta_ticks) {}
    ReceivedPacket(const ReceivedPacket&) = default;
    ReceivedPacket& operator=(const ReceivedPacket&) = default;

    uint16_t sequence_number() const { return sequence_number_; }
    int16_t delta_ticks() const { return delta_ticks_; }
    int32_t delta_us() const { return delta_ticks_ * kDeltaScaleFactor; }

   private:
    uint16_t sequence_number_;
    int16_t delta_ticks_;
  };
  // TODO(sprang): IANA reg?
  static constexpr uint8_t kFeedbackMessageType = 15;
  // Convert to multiples of 0.25ms.
  static constexpr int kDeltaScaleFactor = 250;
  // Maximum number of packets (including missing) TransportFeedback can report.
  //TODO@chensong 2023-03-31 一个transportfeedback可以报告的最大packets数量,2字节的最大值
  static constexpr size_t kMaxReportedPackets = 0xffff;

  TransportFeedback();
  explicit TransportFeedback(bool include_timestamps);  // If |include_timestamps| is set to false, the
                                 // created packet will not contain the receive
                                 // delta block. 也就是说，只保留是否收到的信息
  TransportFeedback(const TransportFeedback&);
  TransportFeedback(TransportFeedback&&);

  ~TransportFeedback() override;
  // TransportFeedback都有base_sequence和ref time
  void SetBase(uint16_t base_sequence,     // Seq# of first packet in this msg.
               int64_t ref_timestamp_us);  // Reference timestamp for this msg.
  void SetFeedbackSequenceNumber(uint8_t feedback_sequence);
  // NOTE: This method requires increasing sequence numbers (excepting wraps).
  //序列号和接收到的时间
  bool AddReceivedPacket(uint16_t sequence_number, int64_t timestamp_us);
  const std::vector<ReceivedPacket>& GetReceivedPackets() const;

  uint16_t GetBaseSequence() const;

  // Returns number of packets (including missing) this feedback describes.
  size_t GetPacketStatusCount() const { return num_seq_no_; }

  // Get the reference time in microseconds, including any precision loss.
  int64_t GetBaseTimeUs() const;

  // Does the feedback packet contain timestamp information?
  bool IncludeTimestamps() const { return include_timestamps_; }

  bool Parse(const CommonHeader& packet);
  static std::unique_ptr<TransportFeedback> ParseFrom(const uint8_t* buffer, size_t length);
  // Pre and postcondition for all public methods. Should always return true.
  // This function is for tests.
  bool IsConsistent() const;

  size_t BlockLength() const override;
  size_t PaddingLength() const;

  bool Create(uint8_t* packet, size_t* position, size_t max_length, PacketReadyCallback callback) const override;
  const std::vector<ReceivedPacket>& GetPacket() const { return packets_; }
  const std::vector<uint16_t>& GetEncodedChunks() const { return encoded_chunks_; }
  const std::string ToString() const;
  std::string ToString();
 private:
  // Size in bytes of a delta time in rtcp packet.
  // Valid values are 0 (packet wasn't received), 1 or 2.
  // delta大：2字节描述；delta小：1字节描述
  using DeltaSize = uint8_t;//1 个time delta占据的字节数
  // Keeps DeltaSizes that can be encoded into single chunk if it is last chunk.
  //核心的功能都在LastChunk里面实现的，是对单个packet
  // chunk的处理方法（包括了不同方式的编解码 行程编解码，1 bit状态向量编解码  2 bits状态向量编解码
  class LastChunk {
   public:
    using DeltaSize = TransportFeedback::DeltaSize; //取值为0， 1， 2

    LastChunk();

    bool Empty() const;
    void Clear();
    // Return if delta sizes still can be encoded into single chunk with added
    // |delta_size|.
    bool CanAdd(DeltaSize delta_size) const;
    // Add |delta_size|, assumes |CanAdd(delta_size)|,
    void Add(DeltaSize delta_size);

    // Encode chunk as large as possible removing encoded delta sizes.
    // Assume CanAdd() == false for some valid delta_size.
    uint16_t Emit();
    // Encode all stored delta_sizes into single chunk, pad with 0s if needed.
    uint16_t EncodeLast() const;

    // Decode up to |max_size| delta sizes from |chunk|.
    void Decode(uint16_t chunk, size_t max_size);
    // Appends content of the Lastchunk to |deltas|.
    void AppendTo(std::vector<DeltaSize>* deltas) const;

    std::string ToString() const;

   private:
    //最大行程长度 13个1
    static constexpr size_t kMaxRunLengthCapacity = 0x1fff;
    // status vector： 1 bit(0):没有接收到，14个状态
    static constexpr size_t kMaxOneBitCapacity = 14;
    // status vector: 1 bit（1）：接收到（2位1个状态），7个packets的状态
    static constexpr size_t kMaxTwoBitCapacity = 7;
    static constexpr size_t kMaxVectorCapacity = kMaxOneBitCapacity;
    static constexpr DeltaSize kLarge = 2;

    uint16_t EncodeOneBit() const;
    void DecodeOneBit(uint16_t chunk, size_t max_size);

    uint16_t EncodeTwoBit(size_t size) const;
    void DecodeTwoBit(uint16_t chunk, size_t max_size);

    uint16_t EncodeRunLength() const;
    void DecodeRunLength(uint16_t chunk, size_t max_size);

    DeltaSize delta_sizes_[kMaxVectorCapacity];
    size_t size_;
	// TODO@chensong 2023-03-31    判断当前字节与第一个字节是否相等
    bool all_same_;
    bool has_large_delta_;
  };

  // Reset packet to consistent empty state.
  void Clear();

  bool AddDeltaSize(DeltaSize delta_size);
  // TODO@chensong 2023-03-31
  uint16_t base_seq_no_; //序列号基
  uint16_t num_seq_no_;//packets数量
  int32_t base_time_ticks_;//参考时间

  // TODO@chensong 2022-12-07 RTCP Transport-wide Congestion control (Transport-cc (15))的反馈信息包自动增加字段
  uint8_t feedback_seq_;  //反馈序列号（标识）
  bool include_timestamps_;//是否包含time

  int64_t last_timestamp_us_;//上一个RTP packet的接收时间
  std::vector<ReceivedPacket> packets_;//需要把接收到的packets打入transport feedback
  // All but last encoded packet chunks.
  std::vector<uint16_t> encoded_chunks_;//除了最后一个packet chunk
  LastChunk last_chunk_;//最后一个chunk
  size_t size_bytes_;
};

}  // namespace rtcp

std::string ToString(
    const webrtc::rtcp::TransportFeedback::ReceivedPacket& packet);
//std::string ToString(const webrtc::rtcp::TransportFeedback& feedback);
}  // namespace webrtc
#endif  // MODULES_RTP_RTCP_SOURCE_RTCP_PACKET_TRANSPORT_FEEDBACK_H_
