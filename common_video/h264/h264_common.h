/*
 *  Copyright (c) 2016 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef COMMON_VIDEO_H264_H264_COMMON_H_
#define COMMON_VIDEO_H264_H264_COMMON_H_

#include <stddef.h>
#include <stdint.h>
#include <vector>

#include "rtc_base/buffer.h"

namespace webrtc {

namespace H264 {
// The size of a full NALU start sequence {0 0 0 1}, used for the first NALU
// of an access unit, and for SPS and PPS blocks.
const size_t kNaluLongStartSequenceSize = 4;

// The size of a shortened NALU start sequence {0 0 1}, that may be used if
// not the first NALU of an access unit or an SPS or PPS block.
const size_t kNaluShortStartSequenceSize = 3;

// The size of the NALU type byte (1).
const size_t kNaluTypeSize = 1;
/*
1、 H264 NAL解析

NAL全称Network Abstract Layer，即网络抽象层。在H.264/AVC视频编码标准中，整个系统框架被分为了两个层面：视频编码层面（VCL）和网络抽象层面（NAL）。其中，前者负责有效表示视频数据的内容，而后者则负责格式化数据并提供头信息，以保证数据适合各种信道和存储介质上的传输。NAL单元是NAL的基本语法结构，它包含一个字节的头信息和一系列来自VCL的称为原始字节序列载荷（RBSP）的字节流。

如果NALU对应的Slice为一帧的开始，则用4字节表示，即0x00000001；否则用3字节表示，0x000001。

NAL Header：forbidden_bit，nal_reference_bit（优先级）2bit，nal_unit_type（类型）5bit。

标识NAL单元中的RBSP数据类型，其中，nal_unit_type为1， 2， 3， 4， 5的NAL单元称为VCL的NAL单元，其他类型的NAL单元为非VCL的NAL单元。


2、如何判断帧类型（是图像参考帧还是I、P帧等）？

NALU类型是我们判断帧类型的利器，从官方文档中得出如下图：


我们还是接着看最上面图的码流对应的数据来层层分析，以00 00 00 01分割之后的下一个字节就是NALU类型，将其转为二进制数据后，解读顺序为从左往右算，如下:
（1）第1位禁止位，值为1表示语法出错
（2）第2~3位为参考级别
（3）第4~8为是nal单元类型

例如上面00000001后有67,68以及65

其中0x67的二进制码为：
0110 0111
4-8为00111，转为十进制7，参考第二幅图：7对应序列参数集SPS

其中0x68的二进制码为：
0110 1000
4-8为01000，转为十进制8，参考第二幅图：8对应图像参数集PPS

其中0x65的二进制码为：
0110 0101
4-8为00101，转为十进制5，参考第二幅图：5对应IDR图像中的片(I帧)



所以判断是否为I帧的算法为： （NALU类型  & 0001  1111） = 5   即   NALU类型  & 31 = 5

比如0x65 & 31 = 5




3、 帧格式
H264帧由NALU头和NALU主体组成。
NALU头由一个字节组成,它的语法如下:

+---------------+
|0|1|2|3|4|5|6|7|
+-+-+-+-+-+-+-+-+
|F|NRI|  Type   |
+---------------+

F: 1个比特.
forbidden_zero_bit. 在 H.264 规范中规定了这一位必须为 0.

NRI: 2个比特.
nal_ref_idc. 取00~11,似乎指示这个NALU的重要性,如00的NALU解码器可以丢弃它而不影响图像的回放,0～3，取值越大，表示当前NAL越重要，需要优先受到保护。如果当前NAL是属于参考帧的片，或是序列参数集，或是图像参数集这些重要的单位时，本句法元素必需大于0。

Type: 5个比特.
nal_unit_type. 这个NALU单元的类型,1～12由H.264使用，24～31由H.264以外的应用使用,简述如下:



0：未规定
1：非IDR图像中不采用数据划分的片段
2：非IDR图像中A类数据划分片段
3：非IDR图像中B类数据划分片段
4：非IDR图像中C类数据划分片段
5：IDR图像的片段
6：补充增强信息（SEI）
7：序列参数集（SPS）
8：图像参数集（PPS）
9：分割符
10：序列结束符
11：流结束符
12：填充数据
13：序列参数集扩展
14：带前缀的NAL单元
15：子序列参数集
16 – 18：保留
19：不采用数据划分的辅助编码图像片段
20：编码片段扩展
21 – 23：保留
24 – 31：未规定
NAL的头占用了一个字节，按照比特自高至低排列可以表示如下：

0AABBBBB

其中，AA用于表示该NAL是否可以丢弃（有无被其后的NAL参考），00b表示没有参考作用，可丢弃，如B slice、SEI等，非零——包括01b、10b、11b——表示该NAL不可丢弃，如SPS、PPS、I Slice、P Slice等。常用的NAL头的取值如：

0x67: SPS
0x68: PPS
0x65: IDR
0x61: non-IDR Slice
0x01: B Slice
0x06: SEI
0x09: AU Delimiter
由于NAL的语法中没有给出长度信息，实际的传输、存储系统需要增加额外的头实现各个NAL单元的定界。

其中，AVI文件和MPEG TS广播流采取的是字节流的语法格式，即在NAL单元之前增加0x00000001的同步码，则从AVI文件或MPEG TS PES包中读出的一个H.264视频帧以下面的形式存在：

00 00 00 01 06 ... 00 00 00 01 67 ... 00 00 00 01 68 ... 00 00 00 01 65 ...
SEI信息             SPS                PPS                IDR Slice
而对于MP4文件，NAL单元之前没有同步码，却有若干字节的长度码，来表示NAL单元的长度，这个长度码所占用的字节数由MP4文件头给出；此外，从MP4读出来的视频帧不包含PPS和SPS，这些信息位于MP4的文件头中，解析器必须在打开文件的时候就获取它们。从MP4文件读出的一个H.264帧往往是下面的形式（假设长度码为2字节）：

00 19 06 [... 25 字节...] 24 aa 65 [... 9386 字节...]
SEI信息                   IDR Slice


*/
enum NaluType : uint8_t {
  kSlice = 1,
  kIdr = 5,
  kSei = 6,
  kSps = 7,
  kPps = 8,
  kAud = 9,
  kEndOfSequence = 10,
  kEndOfStream = 11,
  kFiller = 12,
  kStapA = 24,
  kFuA = 28
};

enum SliceType : uint8_t { kP = 0, kB = 1, kI = 2, kSp = 3, kSi = 4 };

struct NaluIndex {
  // Start index of NALU, including start sequence.
  size_t start_offset;
  // Start index of NALU payload, typically type header.
  size_t payload_start_offset;
  // Length of NALU payload, in bytes, counting from payload_start_offset.
  size_t payload_size;
};

// Returns a vector of the NALU indices in the given buffer.
std::vector<NaluIndex> FindNaluIndices(const uint8_t* buffer,
                                       size_t buffer_size);

// Get the NAL type from the header byte immediately following start sequence.
NaluType ParseNaluType(uint8_t data);

// Methods for parsing and writing RBSP. See section 7.4.1 of the H264 spec.
//
// The following sequences are illegal, and need to be escaped when encoding:
// 00 00 00 -> 00 00 03 00
// 00 00 01 -> 00 00 03 01
// 00 00 02 -> 00 00 03 02
// And things in the source that look like the emulation byte pattern (00 00 03)
// need to have an extra emulation byte added, so it's removed when decoding:
// 00 00 03 -> 00 00 03 03
//
// Decoding is simply a matter of finding any 00 00 03 sequence and removing
// the 03 emulation byte.

// Parse the given data and remove any emulation byte escaping.
std::vector<uint8_t> ParseRbsp(const uint8_t* data, size_t length);

// Write the given data to the destination buffer, inserting and emulation
// bytes in order to escape any data the could be interpreted as a start
// sequence.
void WriteRbsp(const uint8_t* bytes, size_t length, rtc::Buffer* destination);
}  // namespace H264
}  // namespace webrtc

#endif  // COMMON_VIDEO_H264_H264_COMMON_H_
