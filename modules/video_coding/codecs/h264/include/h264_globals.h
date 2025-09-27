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

打包模式简单介绍

Single NAL Unit Mode，单个NAL单元模式(NAL unit)。这种模式用于单个一个RTP包封装一个NAL unit的情况
Non-Interleaved Mode，非交错模式(NAL unit/STAP-A/FU-A)。这种模式用于非B帧类型的NAL单元封装
Interleaved Mode，交错模式(STAP-B/MTAP16/MTAP24/FU-A/FU-B)，这种模式可以用于带B帧类型的NAL单元封装


负载结构简单介绍

NAL unit，这种结构就是直接把编码器输出的编码后的数据封装为一个RTP包
STAP-A，STAP-B，MTAP16和MTAP24，这几种结构用于多个NAL单元封装到一个RTP包中。STAP类型用于多个具有相同时间戳的NAL单元，MTAP类型用于多个具有不同时间戳的NAL单元
FU-A和FU-B，这种结构用于一个NAL单元拆分为多个RTP包的情况，封装同一个NAL单元的多个RTP包拥有相同的时间戳和不同的序号
 
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
