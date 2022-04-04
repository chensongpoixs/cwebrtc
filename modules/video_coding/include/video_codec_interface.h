/*
 *  Copyright (c) 2012 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_VIDEO_CODING_INCLUDE_VIDEO_CODEC_INTERFACE_H_
#define MODULES_VIDEO_CODING_INCLUDE_VIDEO_CODEC_INTERFACE_H_

#include <vector>

#include "absl/types/optional.h"
#include "api/video/video_frame.h"
#include "api/video_codecs/video_decoder.h"
#include "api/video_codecs/video_encoder.h"
#include "common_video/generic_frame_descriptor/generic_frame_info.h"
#include "modules/include/module_common_types.h"
#include "modules/video_coding/include/video_error_codes.h"
#include "rtc_base/system/rtc_export.h"

namespace webrtc {

class RTPFragmentationHeader;  // forward declaration

// Note: If any pointers are added to this struct, it must be fitted
// with a copy-constructor. See below.
// Hack alert - the code assumes that thisstruct is memset when constructed.
struct CodecSpecificInfoVP8 {
  bool nonReference;
  uint8_t temporalIdx;
  bool layerSync;
  int8_t keyIdx;  // Negative value to skip keyIdx.

  // Used to generate the list of dependency frames.
  // |referencedBuffers| and |updatedBuffers| contain buffer IDs.
  // Note that the buffer IDs here have a one-to-one mapping with the actual
  // codec buffers, but the exact mapping (i.e. whether 0 refers to Last,
  // to Golden or to Arf) is not pre-determined.
  // More references may be specified than are strictly necessary, but not less.
  // TODO(bugs.webrtc.org/10242): Remove |useExplicitDependencies| once all
  // encoder-wrappers are updated.
  bool useExplicitDependencies;
  static constexpr size_t kBuffersCount = 3;
  size_t referencedBuffers[kBuffersCount];
  size_t referencedBuffersCount;
  size_t updatedBuffers[kBuffersCount];
  size_t updatedBuffersCount;
};
static_assert(std::is_pod<CodecSpecificInfoVP8>::value, "");

// Hack alert - the code assumes that thisstruct is memset when constructed.
struct CodecSpecificInfoVP9 {
  bool first_frame_in_picture;  // First frame, increment picture_id.
  bool inter_pic_predicted;     // This layer frame is dependent on previously
                                // coded frame(s).
  bool flexible_mode;
  bool ss_data_available;
  bool non_ref_for_inter_layer_pred;

  uint8_t temporal_idx;
  bool temporal_up_switch;
  bool inter_layer_predicted;  // Frame is dependent on directly lower spatial
                               // layer frame.
  uint8_t gof_idx;

  // SS data.
  size_t num_spatial_layers;  // Always populated.
  bool spatial_layer_resolution_present;
  uint16_t width[kMaxVp9NumberOfSpatialLayers];
  uint16_t height[kMaxVp9NumberOfSpatialLayers];
  GofInfoVP9 gof;

  // Frame reference data.
  uint8_t num_ref_pics;
  uint8_t p_diff[kMaxVp9RefPics];

  bool end_of_picture;
};
static_assert(std::is_pod<CodecSpecificInfoVP9>::value, "");

// Hack alert - the code assumes that thisstruct is memset when constructed.
struct CodecSpecificInfoH264 
{
/************************************************************************/
/* 在SDP中也说明了本次会话的属性

SDP 参数
下面描述了如何在 SDP 中表示一个 H.264 流:
. "m=" 行中的媒体名必须是 "video"
. "a=rtpmap" 行中的编码名称必须是 "H264".
. "a=rtpmap" 行中的时钟频率必须是 90000.
. 其他参数都包括在 "a=fmtp" 行中.
如:
m=video 49170 RTP/AVP 98
a=rtpmap:98 H264/90000
a=fmtp:98 profile-level-id=42A01E; packetization-mode=1; sprop-parameter-sets=Z0IACpZTBYmI,aMljiA==

下面介绍一些常用的参数.
3.1 packetization-mode:
表示支持的封包模式.
当 packetization-mode 的值为 0 时或不存在时, 必须使用单一 NALU 单元模式.
当 packetization-mode 的值为 1 时必须使用非交错(non-interleaved)封包模式.

当 packetization-mode 的值为 2 时必须使用交错(interleaved)封包模式.   
每个打包方式允许的NAL单元类型总结(yes = 允许, no = 不允许, ig = 忽略)
Type   Packet    Single NAL    Non-Interleaved    Interleaved
Unit Mode           Mode             Mode
-------------------------------------------------------------

0      undefined     ig               ig               ig
1-23   NAL unit     yes              yes               no
24     STAP-A        no              yes               no
25     STAP-B        no               no              yes
26     MTAP16        no               no              yes
27     MTAP24        no               no              yes
28     FU-A          no              yes              yes
29     FU-B          no               no              yes
30-31  undefined     ig               ig               ig



这个参数不可以取其他的值.

3.2 sprop-parameter-sets: SPS,PPS
这个参数可以用于传输 H.264 的序列参数集和图像参数 NAL 单元. 这个参数的值采用 Base64 进行编码. 不同的参数集间用","号隔开.


3.3 profile-level-id:
这个参数用于指示 H.264 流的 profile 类型和级别. 由 Base16(十六进制) 表示的 3 个字节. 第一个字节表示 H.264 的 Profile 类型, 第三个字节表示 H.264 的 Profile 级别:

3.4 max-mbps:
这个参数的值是一个整型, 指出了每一秒最大的宏块处理速度.

Rtp payload的第一个字节和264的NALU类似



+---------------+
|0|1|2|3|4|5|6|7|
+-+-+-+-+-+-+-+-+
|F|NRI| Type    |
+---------------+



F: 1 个比特.

forbidden_zero_bit. 在 H.264 规范中规定了这一位必须为 0.

NRI: 2 个比特.

nal_ref_idc. 取 00 ~ 11, 似乎指示这个 NALU 的重要性, 如 00 的 NALU 解码器可以丢弃它而不影响图像的回放. 不过一般情况下不太关心这个属性.

Type: 5 个比特.

nal_unit_type. 这个 NALU 单元的类型. 简述如下:
0     没有定义
1-23 NAL单元 单个 NAL 单元包.
24    STAP-A   单一时间的组合包
24    STAP-B   单一时间的组合包
26    MTAP16   多个时间的组合包
27    MTAP24   多个时间的组合包
28    FU-A     分片的单元
29    FU-B     分片的单元
30-31 没有定义

例子：

0x5C=01011100 (F:0  NRI:10  Type:28) FU-A

0x41=01000001 (F:0  NRI:10  Type:01)Single NAL

0x68=01000100 (F:0  NRI:10  Type:08)Single NAL



Single NAL Unit Mode :Type[1-23] packetization-mode=0



对于 NALU 的长度小于 MTU 大小的包, 一般采用单一 NAL 单元模式.
对于一个原始的 H.264 NALU 单元常由 [Start Code] [NALU Header] [NALU Payload] 三部分组成, 其中 Start Code 用于标示这是一个 NALU 单元的开始, 必须是 "00 00 00 01" 或 "00 00 01", NALU 头仅一个字节, 其后都是 NALU 单元内容.
打包时去除 "00 00 01" 或 "00 00 00 01" 的开始码, 把其他数据封包的 RTP 包即可.

Non-interleaved Mode:Type[1-23,24,28] packetization-mode=1

Type=[1-23]的情况 参照 packetization-mode=0

Type=28 FU-A

+---------------+---------------+
|0|1|2|3|4|5|6|7|0|1|2|3|4|5|6|7|
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|F|NRI| Type:28 |S|E|R| Type    |
+---------------+---------------+



S:开始标志

E:结束标志 (与 Mark相同）

R:必须为0



Type:h264的NALU Type



例：

0x7C85=01111100 10000101 (开始包)

0x7C05=01111100 00000101 (中间包)

0x7C45=01111100 01000101 (结束包)



Type=23  STAP-A

0               1             2                 3
|0 1 2 3 4 5 6 7|8 9 0 1 2 3 4|5 6 7 8 9 0 1 2 3|4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                          RTP Header                           |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|STAP-A NAL HDR |         NALU 1 Size           | NALU 1 HDR    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                         NALU 1 Data                           |
:                                                               :
+               +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

|               | NALU 2 Size                   | NALU 2 HDR    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                         NALU 2 Data                           |
:                                                               :
|                               +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                               :...OPTIONAL RTP padding        |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


Interleaved Mode:Type[26-29] packetization-mode=2



待续



STAP-B

MTAP16

MTAP24

FU-B


*/
/************************************************************************/
  H264PacketizationMode packetization_mode;
  uint8_t temporal_idx;
  bool base_layer_sync;
  bool idr_frame;
};
static_assert(std::is_pod<CodecSpecificInfoH264>::value, "");

union CodecSpecificInfoUnion {
  CodecSpecificInfoVP8 VP8;
  CodecSpecificInfoVP9 VP9;
  CodecSpecificInfoH264 H264;
};
static_assert(std::is_pod<CodecSpecificInfoUnion>::value, "");

// Note: if any pointers are added to this struct or its sub-structs, it
// must be fitted with a copy-constructor. This is because it is copied
// in the copy-constructor of VCMEncodedFrame.
struct RTC_EXPORT CodecSpecificInfo {
  CodecSpecificInfo();
  CodecSpecificInfo(const CodecSpecificInfo&);
  ~CodecSpecificInfo();

  VideoCodecType codecType;
  CodecSpecificInfoUnion codecSpecific;
  absl::optional<GenericFrameInfo> generic_frame_info;
  absl::optional<TemplateStructure> template_structure;
};

}  // namespace webrtc

#endif  // MODULES_VIDEO_CODING_INCLUDE_VIDEO_CODEC_INTERFACE_H_
