/*
 *  Copyright (c) 2015 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "modules/rtp_rtcp/source/rtcp_packet/transport_feedback.h"

#include <algorithm>
#include <cstdint>
#include <utility>

#include "modules/include/module_common_types_public.h"
#include "modules/rtp_rtcp/source/byte_io.h"
#include "modules/rtp_rtcp/source/rtcp_packet/common_header.h"
#include "rtc_base/checks.h"
#include "rtc_base/logging.h"
#include "rtc_base/trace_event.h"

namespace webrtc {
namespace rtcp {
namespace {
// Header size:
// * 4 bytes Common RTCP Packet Header
// * 8 bytes Common Packet Format for RTCP Feedback Messages
// * 8 bytes FeedbackPacket header
constexpr size_t kTransportFeedbackHeaderSizeBytes = 4 + 8 + 8;
constexpr size_t kChunkSizeBytes = 2;
// TODO(sprang): Add support for dynamic max size for easier fragmentation,
// eg. set it to what's left in the buffer or IP_PACKET_SIZE.
// Size constraint imposed by RTCP common header: 16bit size field interpreted
// as number of four byte words minus the first header word.
constexpr size_t kMaxSizeBytes = (1 << 16) * 4;
// Payload size:
// * 8 bytes Common Packet Format for RTCP Feedback Messages
// * 8 bytes FeedbackPacket header.
// * 2 bytes for one chunk.
constexpr size_t kMinPayloadSizeBytes = 8 + 8 + 2;
constexpr int kBaseScaleFactor = TransportFeedback::kDeltaScaleFactor * (1 << 8);
constexpr int64_t kTimeWrapPeriodUs = (1ll << 24) * kBaseScaleFactor;

//    Message format
//
//     0                   1                   2                   3
//     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//    |V=2|P|  FMT=15 |    PT=205     |           length              |
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//  0 |                     SSRC of packet sender                     |
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//  4 |                      SSRC of media source                     |
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//  8 |      base sequence number     |      packet status count      |
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
// 12 |                 reference time                | fb pkt. count |
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
// 16 |          packet chunk         |         packet chunk          |
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//    .                                                               .
//    .                                                               .
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//    |         packet chunk          |  recv delta   |  recv delta   |
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//    .                                                               .
//    .                                                               .
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//    |           recv delta          |  recv delta   | zero padding  |
//    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

// TODO@chensong 2022-12-07 
/*
Receive Delta
以250us(0.25ms)为单位，表示RTP包到达时间与前面一个RTP包到达时间的间隔，对于记录的第一个RTP包，该包的时间间隔是相对referencetime的。

1. 如果在packet chunk记录了一个"Packet received, smalldelta"状态的包，那么就会在receive delta列表中添加一个无符号1字节长度receive
delta，无符号1字节取值范围[0,255]，由于Receive
Delta以0.25ms为单位，故此时Receive Delta取值范围[0, 63.75]ms 

2. 如果在packetchunk记录了一个"Packet received, large or negative
delta"状态的包，那么就会在receive delta列表中添加一个有符号2字节长度的receive
delta，范围[-8192.0, 8191.75] ms


3. 如果时间间隔超过了最大限制，那么就会构建一个新的TransportFeedback
RTCP包，由于reference time长度为3字节，所以目前的包中3字节长度能够覆盖很大范围了

以上说明总结起来就是：对于收到的RTP包在TransportFeedback RTCP receive
delta列表中通过时间间隔记录到达时间，如果与前面包时间间隔小，那么使用1字节表示，否则2字节，超过最大取值范围，就另起新RTCP包了。

对于"Packet received, small delta"状态的包来说，receive
delta最大值63.75ms，那么一秒时间跨度最少能标识1000/63.75~=16个包。由于receive
delta为250us的倍数，所以一秒时间跨度最多能标识4000个包。

packet chunk以及receive delta的使用是为了尽可能减小RTCP包大小。packet
chunk用到了不同编码方式，对于收到的RTP包才添加到达时间信息，而且是通过时间间隔的方式记录到达时间。
 
 TODO@chensong 2023-03-31 
 编码方法有三种：（1）行程码；（2）1位状态向量码；（3）2位状态向量码。
*/


}  // namespace
constexpr uint8_t TransportFeedback::kFeedbackMessageType;
constexpr size_t TransportFeedback::kMaxReportedPackets;

constexpr size_t TransportFeedback::LastChunk::kMaxRunLengthCapacity;
constexpr size_t TransportFeedback::LastChunk::kMaxOneBitCapacity;
constexpr size_t TransportFeedback::LastChunk::kMaxTwoBitCapacity;
constexpr size_t TransportFeedback::LastChunk::kMaxVectorCapacity;

TransportFeedback::LastChunk::LastChunk() {
  Clear();
}

bool TransportFeedback::LastChunk::Empty() const {
  return size_ == 0;
}

void TransportFeedback::LastChunk::Clear() {
  size_ = 0;
  all_same_ = true;
  has_large_delta_ = false;
}

bool TransportFeedback::LastChunk::CanAdd(DeltaSize delta_size) const 
{
  RTC_DCHECK_LE(delta_size, 2);
  // 1.  如果当前的delta数量<7个，肯定可以添加，所以返回true（因为至少可以添加7个状态）
  if (size_ < kMaxTwoBitCapacity /*7*/) 
  {
    return true;
  }
  // 2. size_ >7 && size_ < 14 && 不存在larger delta 而且输入delta_size != 2，也是可以添加的
  if (size_ < kMaxOneBitCapacity/*14*/ && !has_large_delta_ && delta_size != kLarge) 
  {
    return true;
  }
  // TODO@chensong 2023-03-31   最大行程数据  是 14 个bit   即[11 1111 1111 1111]
  // 3. 上面两个是状态向量编码，对于行程编码只要<最大数量 && 是一样的，第一个和当前的也一样，则可以添加
  if (size_ < kMaxRunLengthCapacity /*0x1fff*/ && all_same_ && delta_sizes_[0] == delta_size) 
  {
    return true;
  }
  return false;
}
//记录第size_个packet的recv delta的字节数，并更新all_same和has_large_delta的状态
//这些都是后面选择编码样式的依据
void TransportFeedback::LastChunk::Add(DeltaSize delta_size) 
{
  // CanAdd检验
  RTC_DCHECK(CanAdd(delta_size));
  // size_是当前有几个了packets了 delta_sizes_[size_]是第size_的delta size
  if (size_ < kMaxVectorCapacity) 
  {
    //记录第size_个packet的recv delta占据的字节数
    delta_sizes_[size_] = delta_size;
  }
  size_++;
  //判断是不是都一样大小的delta size（也就是状态，small delta？large delta?
  //更新all_same状态和has_large_delta_状态（根据这些状态来选择编码方式）
  all_same_ = all_same_ && delta_size == delta_sizes_[0];
  has_large_delta_ = has_large_delta_ || delta_size == kLarge;
}
// TODO@chensong 2023-03-31  
// 编码方法有三种：
//			    （1）行程码；
//				（2）1位状态向量码；
//				（3）2位状态向量码。
uint16_t TransportFeedback::LastChunk::Emit() 
{
  RTC_DCHECK(!CanAdd(0) || !CanAdd(1) || !CanAdd(2));
  if (all_same_) 
  {
    uint16_t chunk = EncodeRunLength();
    Clear();
    return chunk;
  }
  if (size_ == kMaxOneBitCapacity) 
  {
    uint16_t chunk = EncodeOneBit();
    Clear();
    return chunk;
  }
  RTC_DCHECK_GE(size_, kMaxTwoBitCapacity);
  uint16_t chunk = EncodeTwoBit(kMaxTwoBitCapacity);
  // Remove |kMaxTwoBitCapacity| encoded delta sizes:
  // Shift remaining delta sizes and recalculate all_same_ && has_large_delta_.
  size_ -= kMaxTwoBitCapacity;
  all_same_ = true;
  has_large_delta_ = false;
  for (size_t i = 0; i < size_; ++i) 
  {
    DeltaSize delta_size = delta_sizes_[kMaxTwoBitCapacity + i];
    delta_sizes_[i] = delta_size;
    all_same_ = all_same_ && delta_size == delta_sizes_[0];
    has_large_delta_ = has_large_delta_ || delta_size == kLarge;
  }

  return chunk;
}
//根据all_same和size_大小来确定使用什么样的编码方式
uint16_t TransportFeedback::LastChunk::EncodeLast() const 
{
  RTC_DCHECK_GT(size_, 0);
  if (all_same_) 
  {//如果delta类型都一样（00,01,10）[没有收到，small delta, large delta]，则选择行程码
    return EncodeRunLength();
  }
  if (size_ <= kMaxTwoBitCapacity) 
  {//如果size_ <= 7, 则选择2bit码（因为容量足够）
    return EncodeTwoBit(size_);
  }//否则，使用1bit 编码方式
  return EncodeOneBit();
}

// Appends content of the Lastchunk to |deltas|.
//采用了两种不同的vector的insert的用法，结果都是把delta_sizes_数组的元素插入到deltas里面（最后面）
void TransportFeedback::LastChunk::AppendTo(std::vector<DeltaSize>* deltas) const 
{
  if (all_same_) 
  {
    //因为all_same_,所以都等于delta_sizes_[0]，所以是在deltas->end()之前插入size_个delta_sizes[0]的元素
    //也就是把last chunk里面的delta_sizes的元素都插入到了deltas的末尾
    deltas->insert(deltas->end(), size_, delta_sizes_[0]);
  }
  else 
  {
    deltas->insert(deltas->end(), delta_sizes_, delta_sizes_ + size_);
  }
}

std::string TransportFeedback::LastChunk::ToString() const
{
  /*
   DeltaSize delta_sizes_[kMaxVectorCapacity];
    size_t size_;
    bool all_same_;
    bool has_large_delta_;
  */
  char buffer[1024 * 50] = {0};

  std::string vec_delta_size;
  for (size_t i = 0; i < size_; ++i)
  {
	  if (0 != i)
	  {
		vec_delta_size += "\n";
	  }
          vec_delta_size += "[delta_sizes_[" + std::to_string(i) + "]" +
                            std::to_string(delta_sizes_[i]) + "]";
  }
  ::sprintf(&buffer[0], "[delta_sizes_ = %s][size_ = %llu][all_same_ = %s][has_large_delta_ = %s]",
            vec_delta_size.c_str(), size_, (all_same_ ? "true" : "false"),
            (has_large_delta_ ? "true" : "false"));
  return buffer;

}

void TransportFeedback::LastChunk::Decode(uint16_t chunk, size_t max_size) 
{ 
	  //根据不同的类型进行解码
  // 1. 行程码，根据第1位判断类型 0是行程码 1 状态向量码
  if ((chunk & 0x8000 /*1000 0000 0000 0000*/) == 0) 
  {
    DecodeRunLength(chunk, max_size);
  }
  else if ((chunk & 0x4000 /*0100 0000 0000 0000*/) == 0) //1 bit状态向量
  {//1 bit状态向量
    DecodeOneBit(chunk, max_size);
  }
  else 
  {//2 bit状态向量
    DecodeTwoBit(chunk, max_size);
  }
}

//  One Bit Status Vector Chunk
//
//  0                   1
//  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5
//  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//  |T|S|       symbol list         |
//  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
//  T = 1
//  S = 0
//  Symbol list = 14 entries where 0 = not received, 1 = received 1-byte delta.
/// TODO@chensong 2023-03-31 ====>>> 1bit 状态向量编码
uint16_t TransportFeedback::LastChunk::EncodeOneBit() const 
{
  RTC_DCHECK(!has_large_delta_);
  RTC_DCHECK_LE(size_, kMaxOneBitCapacity);
  uint16_t chunk = 0x8000;// 1(T)0(S)00 0000 0000 0000
  for (size_t i = 0; i < size_; ++i)
  {
    //逐个的把delta_sizes_的状态（0,1）编码到chunk里面（注意：这里只有0,1两种状态）
    chunk |= delta_sizes_[i] << (kMaxOneBitCapacity - 1 - i);
  }
  return chunk;
}

void TransportFeedback::LastChunk::DecodeOneBit(uint16_t chunk,
                                                size_t max_size) {
  RTC_DCHECK_EQ(chunk & 0xc000, 0x8000);
  size_ = std::min(kMaxOneBitCapacity /*14*/, max_size);
  has_large_delta_ = false;
  all_same_ = false;
  for (size_t i = 0; i < size_; ++i) 
  {
	  // 0100 0000 0000 0000
    delta_sizes_[i] = (chunk >> (kMaxOneBitCapacity - 1 - i)) & 0x01;
  }
}

//  Two Bit Status Vector Chunk
//
//  0                   1
//  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5
//  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//  |T|S|       symbol list         |
//  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
//  T = 1
//  S = 1
//  symbol list = 7 entries of two bits each.
uint16_t TransportFeedback::LastChunk::EncodeTwoBit(size_t size) const {
  RTC_DCHECK_LE(size, size_);
  // T,S位进行赋值 
  uint16_t chunk = 0xc000; //1(T)1(S)00 0000 0000 0000
  for (size_t i = 0; i < size; ++i)
  {
	  //每次移位数量不同
    chunk |= delta_sizes_[i] << 2 * (kMaxTwoBitCapacity - 1 - i);
  }
  return chunk;
}

void TransportFeedback::LastChunk::DecodeTwoBit(uint16_t chunk,
                                                size_t max_size) {
  RTC_DCHECK_EQ(chunk & 0xc000, 0xc000);
  size_ = std::min(kMaxTwoBitCapacity, max_size);
  has_large_delta_ = true;
  all_same_ = false;
  for (size_t i = 0; i < size_; ++i) {
    delta_sizes_[i] = (chunk >> 2 * (kMaxTwoBitCapacity - 1 - i)) & 0x03;
  }
}

//  Run Length Status Vector Chunk
//
//  0                   1
//  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5
//  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//  |T| S |       Run Length        |
//  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
//  T = 0
//  S = symbol
//  Run Length = Unsigned integer denoting the run length of the symbol
// TODO@chensong 2023-03-31   行程码 编码
uint16_t TransportFeedback::LastChunk::EncodeRunLength() const 
{
  RTC_DCHECK(all_same_);
  RTC_DCHECK_LE(size_, kMaxRunLengthCapacity);
  //这种T位为0，S为delta_sizes_[0]的状态，左移13就相当于T，S赋值了
  //然后后面的13位就是size_的大小（完美）
  return (delta_sizes_[0] << 13) | static_cast<uint16_t>(size_);
}

void TransportFeedback::LastChunk::DecodeRunLength(uint16_t chunk,
                                                   size_t max_count) {
  RTC_DCHECK_EQ(chunk & 0x8000, 0);
  //解析出size_相同的status的个数
  size_ = std::min<size_t>(chunk & 0x1fff, max_count);
  //解析出S(状态)
  DeltaSize delta_size = (chunk >> 13) & 0x03;
  has_large_delta_ = delta_size >= kLarge;
  all_same_ = true;
  // To make it consistent with Add function, populate delta_sizes_ beyound 1st.
  //一致性处理
  for (size_t i = 0; i < std::min<size_t>(size_, kMaxVectorCapacity /*14*/);
       ++i) 
  {
    delta_sizes_[i] = delta_size;
  }
}

TransportFeedback::TransportFeedback()
    : TransportFeedback(/*include_timestamps=*/true) {}

TransportFeedback::TransportFeedback(bool include_timestamps)
    : base_seq_no_(0),
      num_seq_no_(0),
      base_time_ticks_(0),
      feedback_seq_(0),
      include_timestamps_(include_timestamps),
      last_timestamp_us_(0),
      size_bytes_(kTransportFeedbackHeaderSizeBytes) {}

TransportFeedback::TransportFeedback(const TransportFeedback&) = default;

TransportFeedback::TransportFeedback(TransportFeedback&& other)
    : base_seq_no_(other.base_seq_no_),
      num_seq_no_(other.num_seq_no_),
      base_time_ticks_(other.base_time_ticks_),
      feedback_seq_(other.feedback_seq_),
      include_timestamps_(other.include_timestamps_),
      last_timestamp_us_(other.last_timestamp_us_),
      packets_(std::move(other.packets_)),
      encoded_chunks_(std::move(other.encoded_chunks_)),
      last_chunk_(other.last_chunk_),
      size_bytes_(other.size_bytes_) {
  other.Clear();
}

TransportFeedback::~TransportFeedback() {}

void TransportFeedback::SetBase(uint16_t base_sequence, int64_t ref_timestamp_us) 
{
  RTC_DCHECK_EQ(num_seq_no_, 0);
  RTC_DCHECK_GE(ref_timestamp_us, 0);
  base_seq_no_ = base_sequence;
  base_time_ticks_ = (ref_timestamp_us % kTimeWrapPeriodUs) / kBaseScaleFactor;
  last_timestamp_us_ = GetBaseTimeUs();
}

void TransportFeedback::SetFeedbackSequenceNumber(uint8_t feedback_sequence) 
{
  feedback_seq_ = feedback_sequence;
}

bool TransportFeedback::AddReceivedPacket(uint16_t sequence_number, int64_t timestamp_us) 
{
  // Set delta to zero if timestamps are not included, this will simplify the
  // encoding process.
  //如果不包括时间戳，则将delta设置为零，这将简化编码过程。
  int16_t delta = 0;
  if (include_timestamps_) 
  {
    // Convert to ticks and round.
    // 转换为记号和圆形。
    int64_t delta_full = (timestamp_us - last_timestamp_us_) % kTimeWrapPeriodUs;
    if (delta_full > kTimeWrapPeriodUs / 2) 
	{
      delta_full -= kTimeWrapPeriodUs;
    }
    delta_full += delta_full < 0 ? -(kDeltaScaleFactor/*250*/ / 2) : kDeltaScaleFactor/*250*/ / 2;
    delta_full /= kDeltaScaleFactor/*250*/;
	// 得到毫秒数 delta ms  需要乘以 250us
    delta = static_cast<int16_t>(delta_full);
    // If larger than 16bit signed, we can't represent it - need new fb packet.
    // 如果大于16位 ，我们无法表示它-需要新的fb数据包。
    if (delta != delta_full) 
	{
      RTC_LOG(LS_WARNING) << "Delta value too large ( >= 2^16 ticks )";
      return false;
    }
  }

  uint16_t next_seq_no = base_seq_no_ + num_seq_no_;
  if (sequence_number != next_seq_no) 
  {
    uint16_t last_seq_no = next_seq_no - 1;
    if (!IsNewerSequenceNumber(sequence_number, last_seq_no)) 
	{
      return false;
    }
    for (; next_seq_no != sequence_number; ++next_seq_no) 
	{
      if (!AddDeltaSize(0)) 
	  {
        return false;
      }
    }
  }
  // TODO@chensong 2023-03-31  非常有趣东西出来啦  ^_^ 
  DeltaSize delta_size = (delta >= 0 && delta <= 0xff) ? 1 : 2;
  if (!AddDeltaSize(delta_size)) 
  {
    return false;
  }

  packets_.emplace_back(sequence_number, delta);
  // TODO@chensong 2023-03-31   delta 计算公式 ---->>>>>>>
  last_timestamp_us_ += delta * kDeltaScaleFactor/*250*/;
  if (include_timestamps_) 
  {
    size_bytes_ += delta_size;
  }
  return true;
}

const std::vector<TransportFeedback::ReceivedPacket>&TransportFeedback::GetReceivedPackets() const 
{
  return packets_;
}

uint16_t TransportFeedback::GetBaseSequence() const {
  return base_seq_no_;
}

int64_t TransportFeedback::GetBaseTimeUs() const {
  return static_cast<int64_t>(base_time_ticks_) * kBaseScaleFactor;
}

// De-serialize packet.
bool TransportFeedback::Parse(const CommonHeader& packet) 
{
  // 1. 不变式检查
  RTC_DCHECK_EQ(packet.type(), kPacketType);
  RTC_DCHECK_EQ(packet.fmt(), kFeedbackMessageType);
  TRACE_EVENT0("webrtc", "TransportFeedback::Parse");

  if (packet.payload_size_bytes() < kMinPayloadSizeBytes) 
  {
    RTC_LOG(LS_WARNING) << "Buffer too small (" << packet.payload_size_bytes()
                        << " bytes) to fit a "
                           "FeedbackPacket. Minimum size = "
                        << kMinPayloadSizeBytes;
    return false;
  }
  // 2. 得到payload的位置
  const uint8_t* const payload = packet.payload();
  // 3. 解析出sender ssrc和media ssrc
  ParseCommonFeedback(payload);
  // 4. 解析出序列号基
  base_seq_no_ = ByteReader<uint16_t>::ReadBigEndian(&payload[8]);
  // 5. 解析出packets数量
  uint16_t status_count = ByteReader<uint16_t>::ReadBigEndian(&payload[10]);
  // 6. 解析出参考时间
  base_time_ticks_ = ByteReader<int32_t, 3>::ReadBigEndian(&payload[12]);
  // 7. 解析出反馈序列号标识 
  feedback_seq_ = payload[15];
  Clear();
  // 8. 第一个packet chunk从payload的16偏移处开始
  size_t index = 16;
  const size_t end_index = packet.payload_size_bytes();

  if (status_count == 0) 
  {
    RTC_LOG(LS_WARNING) << "Empty feedback messages not allowed.";
    return false;
  }

  std::vector<uint8_t> delta_sizes;
  // delta的数量和packets的数量相同，预留了这么大的空间（capacity，但size还是0）
  delta_sizes.reserve(status_count);
  //把所有的packet chunk提取出来，放入encoded_chunks中，并且一个极其重要的工作时提取delta size，这样可以在后面解析recv delta的时候用到 
  while (delta_sizes.size() < status_count) 
  {
    if (index + kChunkSizeBytes > end_index) 
	{
      RTC_LOG(LS_WARNING) << "Buffer overflow while parsing packet.";
      Clear();
      return false;
    }
    //读取当前的packet chunk，注意packet chunk是2字节的无符号数
    uint16_t chunk = ByteReader<uint16_t>::ReadBigEndian(&payload[index]);
    //索引前进2字节
    index += kChunkSizeBytes;
    // packet chunk保存到vector中
    encoded_chunks_.push_back(chunk);
    //进行解码（解码会根据chunk来判断类型， delta_sizes是已经解码出来的size，
    // status_count是总的packets个数，本次解码的数量肯定应该小与status_count - delta_sizes.size()
    last_chunk_.Decode(chunk, status_count - delta_sizes.size());
    //把解码的结果置入delta_sizes（delta_size会随着解析的过程不断的增大，直至完毕）
    last_chunk_.AppendTo(&delta_sizes);
  }
  // Last chunk is stored in the |last_chunk_|.
  //最后一个packet chunk已经在last chunk里面，encoded_chunks不需要，所以弹出
  encoded_chunks_.pop_back();
  //解析完毕后delta_sizes应该和status_count的数量相等
  RTC_DCHECK_EQ(delta_sizes.size(), status_count);
  //序列号的数量 = packets 数量
  num_seq_no_ = status_count;

  uint16_t seq_no = base_seq_no_;
  size_t recv_delta_size = 0;
  //把总的delta的长度加起来
  for (size_t delta_size : delta_sizes) 
  {
    recv_delta_size += delta_size;
  }

  // Determine if timestamps, that is, recv_delta are included in the packet.
  // end_index是最后一个字节之后的位置，index到达了recv delta的起始位置
  if (end_index >= index + recv_delta_size) 
  {
    for (size_t delta_size : delta_sizes) 
	{
      //对于每个delta
      if (index + delta_size > end_index) 
	  {
        RTC_LOG(LS_WARNING) << "Buffer overflow while parsing packet.";
        Clear();
        return false;
      }
      //对每个delta = 0,1,2的情况分别处理
      switch (delta_size) 
	  {
        case 0:
          break;
        case 1: 
		{
          //取出1个字节
          int16_t delta = payload[index];
          //接收到的packet(序列号，delta)
          packets_.emplace_back(seq_no, delta);
          //时间戳更新
          last_timestamp_us_ += delta * kDeltaScaleFactor /*default 250 */;
          index += delta_size;
          break;
        }
        case 2: 
		{
          // 2个字节的情形
          int16_t delta = ByteReader<int16_t>::ReadBigEndian(&payload[index]);
          packets_.emplace_back(seq_no, delta);
          //时间戳更新
          last_timestamp_us_ += delta * kDeltaScaleFactor /*default 250*/;
          index += delta_size;
          break;
        }
        case 3:
          Clear();
          RTC_LOG(LS_WARNING) << "Invalid delta_size for seq_no " << seq_no;

          return false;
        default:
          RTC_NOTREACHED();
          break;
      }
      //序列号递增
      ++seq_no;
    }
  } 
  else 
  {
    // The packet does not contain receive deltas.
    //如果payload size < index + recv_delta_size（因为这个地方是把recv delta算在内了），小则说明不包括recv delta 
    //设置不包括recv delta的标识 
    include_timestamps_ = false;
    //这里只有0（没有收到）和1（收到）两种情况
    for (size_t delta_size : delta_sizes) 
	{
      // Use delta sizes to detect if packet was received.
      if (delta_size > 0) 
	  {
        //收到则产生ReceivedPacket，否则不做任何工作
        packets_.emplace_back(seq_no, 0);
      }
      ++seq_no;//下一个序列号
    }
  }
  //得到真实的字节数
  size_bytes_ = RtcpPacket::kHeaderLength + index;
  RTC_DCHECK_LE(index, end_index);
  return true;
}

std::unique_ptr<TransportFeedback> TransportFeedback::ParseFrom(const uint8_t* buffer, size_t length) 
{
  // 1. 解析RTP header，并根据解析结果校验到底是不是这种类型的包（合法性检查）
  CommonHeader header;
  if (!header.Parse(buffer, length))
  {
    return nullptr;
  }
  if (header.type() != kPacketType || header.fmt() != kFeedbackMessageType)
  {
    return nullptr;
  }
  // 2. 解析出具体的各个字段
  std::unique_ptr<TransportFeedback> parsed(new TransportFeedback);
  if (!parsed->Parse(header))
  {
    return nullptr;
  }
  return parsed;
}

bool TransportFeedback::IsConsistent() const {
  size_t packet_size = kTransportFeedbackHeaderSizeBytes;
  std::vector<DeltaSize> delta_sizes;
  LastChunk chunk_decoder;
  for (uint16_t chunk : encoded_chunks_) {
    chunk_decoder.Decode(chunk, kMaxReportedPackets);
    chunk_decoder.AppendTo(&delta_sizes);
    packet_size += kChunkSizeBytes;
  }
  if (!last_chunk_.Empty()) {
    last_chunk_.AppendTo(&delta_sizes);
    packet_size += kChunkSizeBytes;
  }
  if (num_seq_no_ != delta_sizes.size()) {
    RTC_LOG(LS_ERROR) << delta_sizes.size() << " packets encoded. Expected "
                      << num_seq_no_;
    return false;
  }
  int64_t timestamp_us = base_time_ticks_ * kBaseScaleFactor;
  auto packet_it = packets_.begin();
  uint16_t seq_no = base_seq_no_;
  for (DeltaSize delta_size : delta_sizes) {
    if (delta_size > 0) {
      if (packet_it == packets_.end()) {
        RTC_LOG(LS_ERROR) << "Failed to find delta for seq_no " << seq_no;
        return false;
      }
      if (packet_it->sequence_number() != seq_no) {
        RTC_LOG(LS_ERROR) << "Expected to find delta for seq_no " << seq_no
                          << ". Next delta is for "
                          << packet_it->sequence_number();
        return false;
      }
      if (delta_size == 1 &&
          (packet_it->delta_ticks() < 0 || packet_it->delta_ticks() > 0xff)) {
        RTC_LOG(LS_ERROR) << "Delta " << packet_it->delta_ticks()
                          << " for seq_no " << seq_no
                          << " doesn't fit into one byte";
        return false;
      }
      timestamp_us += packet_it->delta_us();
      ++packet_it;
    }
    if (include_timestamps_) {
      packet_size += delta_size;
    }
    ++seq_no;
  }
  if (packet_it != packets_.end()) {
    RTC_LOG(LS_ERROR) << "Unencoded delta for seq_no "
                      << packet_it->sequence_number();
    return false;
  }
  if (timestamp_us != last_timestamp_us_) {
    RTC_LOG(LS_ERROR) << "Last timestamp mismatch. Calculated: " << timestamp_us
                      << ". Saved: " << last_timestamp_us_;
    return false;
  }
  if (size_bytes_ != packet_size) {
    RTC_LOG(LS_ERROR) << "Rtcp packet size mismatch. Calculated: "
                      << packet_size << ". Saved: " << size_bytes_;
    return false;
  }
  return true;
}

size_t TransportFeedback::BlockLength() const 
{
  // Round size_bytes_ up to multiple of 32bits.
  return (size_bytes_ + 3) & (~static_cast<size_t>(3));
}

size_t TransportFeedback::PaddingLength() const 
{
  return BlockLength() - size_bytes_;
}

// Serialize packet.
bool TransportFeedback::Create(uint8_t* packet, size_t* position, size_t max_length, PacketReadyCallback callback) const
{
  // 1. 当前收到的包的个数
  if (num_seq_no_ == 0) 
  {
    return false;
  }
  // 2. packet是否足以容纳数据包长度的信息？
  while (*position + BlockLength() > max_length) 
  {
    if (!OnBufferFull(packet, position, callback)) 
	{
      return false;
    }
  }
  // 3. 数据包封装之后的末尾
  const size_t position_end = *position + BlockLength();
  // 4. 应该填充的长度
  const size_t padding_length = PaddingLength();
  // 5. 如果长度>0，设置填充标志（P字段用到）
  bool has_padding = padding_length > 0;
  // TODO@chensong 2022-12-01  创建rtcp中feedback fb的fmt = 15 的内容
  // TODO@chensong 2022-12-02  [ Generic RTP Feedback ]
  // 6. 创建头部（在RtcpPacket中实现）
  CreateHeader(kFeedbackMessageType, kPacketType, HeaderLength(), has_padding, packet, position);
  // 7. 创建公共头（sender ssrc和media ssrc）在Rtpfb中实现
  CreateCommonFeedback(packet + *position);
  //位置递进
  *position += kCommonFeedbackLength;

  // 2. [Transport-cc]
  //    2.1 [ Base Sequence Number ]
  // 8. 写入feedback具体内容
  // 8.1 写入序列号基
  ByteWriter<uint16_t>::WriteBigEndian(&packet[*position], base_seq_no_);
  *position += 2;
  //    2.2 [ Packet Status Count ]
  // 8.2 写入packet status count
  ByteWriter<uint16_t>::WriteBigEndian(&packet[*position], num_seq_no_);
  *position += 2;
  //    2.3 [ Reference Time ]
  // 8.3 写入reference time
  ByteWriter<int32_t, 3>::WriteBigEndian(&packet[*position], base_time_ticks_);
  *position += 3;

  //    2.4 [ Feedback Packets Count ]
  // 8.4 写入反馈序号（这个反馈序号是逐渐递增的）
  packet[(*position)++] = feedback_seq_;

  //    2.5 [ Packet Chunks ]
  // 8.5 写入除最后一个外所有的packet chunk
  for (uint16_t chunk : encoded_chunks_) 
  {
    // 2.5.1 [ Packet Chunk index ]
    ByteWriter<uint16_t>::WriteBigEndian(&packet[*position], chunk);
    *position += 2;
  }
  // 8.6 写入最后一个packet chunk
  if (!last_chunk_.Empty()) 
  {
    uint16_t chunk = last_chunk_.EncodeLast();
    ByteWriter<uint16_t>::WriteBigEndian(&packet[*position], chunk);
    *position += 2;
  }
  // 8.7 写入receive deltas
  if (include_timestamps_) 
  {
    for (const auto& received_packet : packets_) 
	{
      int16_t delta = received_packet.delta_ticks();
      if (delta >= 0 && delta <= 0xFF)
	  {//1字节情形
        packet[(*position)++] = delta;
      }
	  else 
	  {//2字节情形
        ByteWriter<int16_t>::WriteBigEndian(&packet[*position], delta);
        *position += 2;
      }
    }
  }
  // 8.7 填充（用0填充，最后一个字节是填充长度）
  if (padding_length > 0) 
  {
    for (size_t i = 0; i < padding_length - 1; ++i) 
	{
      packet[(*position)++] = 0;
    }
    packet[(*position)++] = padding_length;
  }
  // 9. 封包有效性检查（做完了前面的工作，做的是不是正确呢？检查一下，是根据封入的长度和理论长度是否一致来判断的
  RTC_DCHECK_EQ(*position, position_end);
  return true;
}

const std::string TransportFeedback::ToString() const {
  char buffer[1024 * 100] = {0};

  std::string vec_packet;

  for (size_t i = 0; i < packets_.size(); ++i) {
    if (i != 0) {
      vec_packet = "\n";
    }
    vec_packet +=
        "packets_[ " + std::to_string(i) + "] = " + webrtc::ToString(packets_[i]);
  }

  std::string vec_encoded_chunks;
  for (size_t i = 0; i < encoded_chunks_.size(); ++i) {
    if (i != 0) {
      vec_encoded_chunks = "\n";
    }
    vec_encoded_chunks +=
        "encoded_chunks_[ " + std::to_string(i) + "] = " + std::to_string(encoded_chunks_[i]);
  }

  ::sprintf(&buffer[0],
            "[base_seq_no_ = %u][num_seq_no_ = %u][base_time_ticks_ = "
            "%d][feedback_seq_ = %hhu][include_timestamps_ = "
            "%s][last_timestamp_us_ = %llu]\n [packets_ = %s] [encoded_chunks_ "
            "= %s][last_chunk_ = %s][size_bytes_ = %llu]",
            base_seq_no_, num_seq_no_, base_time_ticks_, feedback_seq_,
            (include_timestamps_ == true ? "true" : "false"),
            last_timestamp_us_, vec_packet.c_str(), vec_encoded_chunks.c_str(),
            last_chunk_.ToString().c_str(), size_bytes_);
  return buffer;
}

std::string TransportFeedback::ToString() {
  char buffer[1024 * 100] = {0};
   
  std::string vec_packet;
  
  for (size_t i = 0; i < packets_.size(); ++i) {
    if (i != 0) 
	{
      vec_packet = "\n";
    }
    vec_packet += "[ " + std::to_string(i) + "] " + webrtc::ToString(packets_[i]);
  }

  std::string vec_encoded_chunks; 
  for (size_t i = 0; i < encoded_chunks_.size(); ++i) {
    if (i != 0) {
      vec_encoded_chunks = "\n";
    }
    vec_encoded_chunks +=
        "[ " + std::to_string(i) + "] " + std::to_string(encoded_chunks_[i]);
  }

  ::sprintf(&buffer[0],
            "[base_seq_no_ = %u][num_seq_no_ = %u][base_time_ticks_ = "
            "%d][feedback_seq_ = %hhu][include_timestamps_ = "
            "%s][last_timestamp_us_ = %llu]\n [packets_ = %s] [encoded_chunks_ "
            "= %s][last_chunk_ = %s][size_bytes_ = %llu]",
             base_seq_no_,  num_seq_no_,
             base_time_ticks_,  feedback_seq_,
            ( include_timestamps_ == true ? "true" : "false"),
             last_timestamp_us_, vec_packet.c_str(),
            vec_encoded_chunks.c_str(),  last_chunk_.ToString().c_str(),
             size_bytes_);
  return buffer;
}

void TransportFeedback::Clear() {
  num_seq_no_ = 0;
  last_timestamp_us_ = GetBaseTimeUs();
  packets_.clear();
  encoded_chunks_.clear();
  last_chunk_.Clear();
  size_bytes_ = kTransportFeedbackHeaderSizeBytes;
}

bool TransportFeedback::AddDeltaSize(DeltaSize delta_size) 
{
	// 判断是否等于最大包的数量了
  if (num_seq_no_ == kMaxReportedPackets) 
  {
    return false;
  }
  
  size_t add_chunk_size = last_chunk_.Empty() ? kChunkSizeBytes : 0;
  if (size_bytes_ + delta_size + add_chunk_size > kMaxSizeBytes) 
  {
    return false;
  }

  if (last_chunk_.CanAdd(delta_size)) 
  {
    size_bytes_ += add_chunk_size;
    last_chunk_.Add(delta_size);
    ++num_seq_no_;
    return true;
  }
  if (size_bytes_ + delta_size + kChunkSizeBytes > kMaxSizeBytes) 
  {
    return false;
  }

  encoded_chunks_.push_back(last_chunk_.Emit());
  size_bytes_ += kChunkSizeBytes;
  last_chunk_.Add(delta_size);
  ++num_seq_no_;
  return true;
}

}  // namespace rtcp

std::string ToString(const webrtc::rtcp::TransportFeedback::ReceivedPacket& packet) 
{
  char buffer[1024] = {0};

  ::sprintf(&buffer[0], "[sequence_number_ = %u][delta_ticks_ = %u] ",
            packet.sequence_number(), packet.delta_ticks());

  return buffer;
}

//std::string ToString(const webrtc::rtcp::TransportFeedback& feedback) 
//{
//  char buffer[1024 * 100] = {0};
//  /*
//   uint16_t base_seq_no_;
//  uint16_t num_seq_no_;
//  int32_t base_time_ticks_;
//  uint8_t feedback_seq_; // Packet Chunks 的数量  -> 即encoded_chunks_中有多少个
//  bool include_timestamps_;
//
//  int64_t last_timestamp_us_;
//  std::vector<ReceivedPacket> packets_;
//  // All but last encoded packet chunks.
//  std::vector<uint16_t> encoded_chunks_;
//  LastChunk last_chunk_;
//  size_t size_bytes_;
//  */
//  std::string vec_packet;
//  const std::vector <webrtc::rtcp::TransportFeedback::ReceivedPacket>& old_packet =
//      feedback.GetPacket();
//  for (size_t i = 0; i < old_packet.size(); ++i)
//  {
//    if (i != 0)
//	{
//      vec_packet = "\n";
//	}
//    vec_packet += "[ " + std::to_string(i) + "] " + webrtc::ToString(old_packet[i]);
//  }
//
//  std::string vec_encoded_chunks;
//  const std::vector<uint16_t>& encoded_chunks = feedback.GetEncodedChunks();
//  for (size_t i = 0; i < encoded_chunks.size(); ++i)
//  {
//    if (i != 0) 
//	{
//      vec_encoded_chunks = "\n";
//    }
//    vec_encoded_chunks +=
//        "[ " + std::to_string(i) + "] " + std::to_string(encoded_chunks[i]);
//
//  }
//
//  ::sprintf(&buffer[0],
//            "[base_seq_no_ = %u][num_seq_no_ = %u][base_time_ticks_ = "
//            "%d][feedback_seq_ = %hhu][include_timestamps_ = "
//            "%s][last_timestamp_us_ = %llu]\n [packets_ = %s] [encoded_chunks_ = %s][last_chunk_ = %s][size_bytes_ = %llu]",
//            feedback.base_seq_no_, feedback.num_seq_no_,
//            feedback.base_time_ticks_, feedback.feedback_seq_,
//            (feedback.include_timestamps_ == true ? "true" : "false"),
//            feedback.last_timestamp_us_, vec_packet.c_str(),
//            vec_encoded_chunks.c_str(), feedback.last_chunk_.ToString().c_str(),
//            eedback.size_bytes_);
//  return buffer;
//}
}  // namespace webrtc
