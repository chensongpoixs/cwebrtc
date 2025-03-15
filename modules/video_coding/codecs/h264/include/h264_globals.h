/*
 *  Copyright (c) 2012 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

// This file contains codec dependent definitions that are needed in
// order to compile the WebRTC codebase, even if this codec is not used.

#ifndef MODULES_VIDEO_CODING_CODECS_H264_INCLUDE_H264_GLOBALS_H_
#define MODULES_VIDEO_CODING_CODECS_H264_INCLUDE_H264_GLOBALS_H_

#include <string>
#include "modules/video_coding/codecs/interface/common_constants.h"


#include "rtc_base/checks.h"

namespace webrtc {

// The packetization types that we support: single, aggregated, and fragmented.
enum H264PacketizationTypes {
  kH264SingleNalu,  // This packet contains a single NAL unit.
  kH264StapA,       // This packet contains STAP-A (single time
                    // aggregation) packets. If this packet has an
                    // associated NAL unit type, it'll be for the
                    // first such aggregated packet.
  kH264FuA,         // This packet contains a FU-A (fragmentation
                    // unit) packet, meaning it is a part of a frame
                    // that was too large to fit into a single packet.
};

// Packetization modes are defined in RFC 6184 section 6
// Due to the structure containing this being initialized with zeroes
// in some places, and mode 1 being default, mode 1 needs to have the value
// zero. https://crbug.com/webrtc/6803
/*

在视频编码传输中，当 NAL（Network Abstraction Layer，网络抽象层）单元的大小超过网络最大传输单元（MTU）时，就需要对 NAL 单元进行切包处理。常见的切包模式主要有以下几种：

单一 NAL 单元模式（Single NAL Unit Mode）

原理：在这种模式下，每个网络数据包只包含一个完整的 NAL 单元。这种模式非常简单直接，适用于 NAL 单元大小小于或等于网络 MTU 的情况。
优点：处理逻辑简单，接收端解码时不需要进行复杂的重组操作，能够快速地对每个 NAL 单元进行解码。
缺点：当 NAL 单元较大时，无法适应网络传输要求，可能导致数据包无法正常传输。
应用场景：在局域网等网络环境较好、MTU 较大且 NAL 单元普遍较小的场景中使用。

非交错模式（Non - Interleaved Mode）

原理：该模式支持对大的 NAL 单元进行分片传输，主要使用两种类型的分片单元：FU - A（Fragmentation Unit - A）和 STAP - A（Single Time Aggregation Packet - A）。
FU - A：用于将一个较大的 NAL 单元分割成多个较小的片段进行传输。每个 FU - A 单元包含 FU 指示符、FU 头和分片数据。接收端根据 FU 头中的起始位（S）、结束位（E）等信息将这些片段重新组合成完整的 NAL 单元。
STAP - A：用于将多个较小的 NAL 单元聚合到一个网络数据包中进行传输。这样可以减少网络开销，提高传输效率。
优点：既可以处理大的 NAL 单元，又可以对小的 NAL 单元进行聚合，适应不同大小的 NAL 单元传输需求，提高了网络传输的灵活性和效率。
缺点：接收端需要进行复杂的解析和重组操作，增加了解码的复杂度。
应用场景：广泛应用于各种网络环境，尤其是在网络带宽有限、MTU 较小的情况下，能够有效地提高视频传输的可靠性和效率。

交错模式（Interleaved Mode）

原理：交错模式在非交错模式的基础上增加了对数据的交错处理，使用了 FU - B、STAP - B、MTAP16 和 MTAP24 等类型的单元。交错处理可以提高数据传输的抗丢包能力，当部分数据包丢失时，仍有可能通过其他交错的数据恢复出完整的 NAL 单元。
FU - B：类似于 FU - A，用于分片传输大的 NAL 单元，但增加了额外的信息用于交错处理。
STAP - B：类似于 STAP - A，用于聚合多个小的 NAL 单元，但也包含了交错相关的信息。
MTAP16 和 MTAP24：用于在交错模式下对多个 NAL 单元进行时间戳和偏移量的调整，以确保数据的正确重组和播放顺序。
优点：具有较强的抗丢包能力，在网络环境不稳定、丢包率较高的情况下，能够更好地保证视频数据的完整性和连续性。
缺点：处理逻辑最为复杂，需要更多的计算资源和内存来进行数据的交错和重组，同时也会增加一定的传输延迟。
应用场景：适用于无线网络、卫星通信等网络环境较差、丢包率较高的场景。



h264、H265 
并发
*/
enum class H264PacketizationMode {
  NonInterleaved = 0,  // Mode 1 - STAP-A, FU-A is allowed
  SingleNalUnit        // Mode 0 - only single NALU allowed
};

// This function is declared inline because it is not clear which
// .cc file it should belong to.
// TODO(hta): Refactor. https://bugs.webrtc.org/6842
// TODO(jonasolsson): Use absl::string_view instead when that's available.
inline std::string ToString(H264PacketizationMode mode) {
  if (mode == H264PacketizationMode::NonInterleaved) {
    return "NonInterleaved";
  } else if (mode == H264PacketizationMode::SingleNalUnit) {
    return "SingleNalUnit";
  }
  RTC_NOTREACHED();
  return "";
}

struct NaluInfo {
  uint8_t type;
  int sps_id;
  int pps_id;
};

const size_t kMaxNalusPerPacket = 10;

struct RTPVideoHeaderH264 {
  // The NAL unit type. If this is a header for a
  // fragmented packet, it's the NAL unit type of
  // the original data. If this is the header for an
  // aggregated packet, it's the NAL unit type of
  // the first NAL unit in the packet.
  uint8_t nalu_type;
  // The packetization type of this buffer - single, aggregated or fragmented.
  H264PacketizationTypes packetization_type;
  NaluInfo nalus[kMaxNalusPerPacket];
  size_t nalus_length;
  // The packetization mode of this transport. Packetization mode
  // determines which packetization types are allowed when packetizing.
  H264PacketizationMode packetization_mode;
};

}  // namespace webrtc

#endif  // MODULES_VIDEO_CODING_CODECS_H264_INCLUDE_H264_GLOBALS_H_
