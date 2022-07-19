/*
 *  Copyright (c) 2016 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef COMMON_VIDEO_H264_PPS_PARSER_H_
#define COMMON_VIDEO_H264_PPS_PARSER_H_

#include "absl/types/optional.h"

namespace rtc {
class BitBuffer;
}

namespace webrtc {

// A class for parsing out picture parameter set (PPS) data from a H264 NALU.
class PpsParser {
 public:
  // The parsed state of the PPS. Only some select values are stored.
  // Add more as they are actually needed.
  struct PpsState {
    PpsState() = default;
    /*
    标识位，用于表示另外条带头中的两个语法元素 
    delta_pic_order_cnt_bottom 和 delta_pic_order_cn 是否存在的标识。
    这两个语法元素表示了某一帧的底场的 POC 的计算方法。
    */
    bool bottom_field_pic_order_in_frame_present_flag = false;
    //weighted_pred_flag 等于 0 表示加权的预测不应用于 P 和 SP 条带。
    //weighted_pred_flag 等于 1 表示在 P 和 SP 条带中应使用加权的预测。
    bool weighted_pred_flag = false;
    /*
    entropy_coding_mode_flag 用于选取语法元素的熵编码方式，在语法表中由两个标识符代表，具体如下：

        如果 entropy_coding_mode_flag 等于 0，那么采用语法表中左边的描述符所指定的方法
        否则（entropy_coding_mode_flag 等于 1），就采用语法表中右边的描述符所指定的方法

    例如：在一个宏块语法元素中，宏块类型 mb_type 的语法元素描述符为 “ue (v) | ae (v)”，
        在 baseline profile 等设置下采用指数哥伦布编码，
        在 main profile 等设置下采用 CABAC 编码。
    */
    bool entropy_coding_mode_flag = false;
    /*
    weighted_bipred_idc 的值应该在 0 到 2 之间（包括 0 和 2）:

        weighted_bipred_idc 等于 0 表示 B 条带应该采用默认的加权预测。
        weighted_bipred_idc 等于 1 表示 B 条带应该采用具体指明的加权预测。
        weighted_bipred_idc 等于 2 表示 B 条带应该采用隐含的加权预测。
    */
    uint32_t weighted_bipred_idc = false;
    uint32_t redundant_pic_cnt_present_flag = 0;
    // pic_init_qp_minus26 表示每个条带的 SliceQPY 初始值减 26。
    // 当解码非 0 值的 slice_qp_delta 时，该初始值在条带层被修正，
    // 并且在宏块层解码非 0 值的 mb_qp_delta 时进一步被修正。
    //pic_init_qp_minus26 的值应该在 -(26 + QpBdOffsetY) 到 +25 之间（包括边界值）
    int pic_init_qp_minus26 = 0; 
    uint32_t id = 0;
    uint32_t sps_id = 0;

    /*
    
    可选参数部分
        slice_group_map_type
        slice_group_map_type 表示条带组中条带组映射单元的映射是如何编码的。lice_group_map_type 的取值范围应该在 0 到 6 内（包括 0 和 6）。

        slice_group_map_type 等于 0 表示隔行扫描的条带组。
        slice_group_map_type 等于 1 表示一种分散的条带组映射。
        slice_group_map_type 等于 2 表示一个或多个前景条带组和一个残余条带组。
        slice_group_map_type 的值等于 3、4 和 5 表示变换的条带组。当 num_slice_groups_minus1 不等于 1 时，slice_group_map_type 不应等于 3、4 或 5。
        slice_group_map_type 等于 6 表示对每个条带组映射单元清楚地分配一个条带组。条带组映射单元规定如下：

        如果 frame_mbs_only_flag 等于 0，mb_adaptive_frame_field_flag 等于 1，而且编码图像是一个帧，那么条带组映射单元就是宏块对单元。
        否则，如果 frame_mbs_only_flag 等于 1 或者一个编码图像是一个场，条带组映射单元就是宏块的单元。
        否则（frame_mbs_only_flag 等于 0， mb_adaptive_frame_field_flag 等于 0，并且编码图像是一个帧），条带组映射单元就是像在一个 MBAFF 帧中的一个帧宏块对中一样垂直相邻的两个宏块的单元。
        run_length_minus1
        run_length_minus1 [i] 用来指定条带组映射单元的光栅扫描顺序中分配给第 i 个条带组的连续条带组映射单元的数目。run_length_minus1 [i] 的取值范围应该在 0 到 PicSizeInMapUnits – 1 内（包括边界值）。
    */
  };

  // Unpack RBSP and parse PPS state from the supplied buffer.
  static absl::optional<PpsState> ParsePps(const uint8_t* data, size_t length);

  static bool ParsePpsIds(const uint8_t* data,
                          size_t length,
                          uint32_t* pps_id,
                          uint32_t* sps_id);

  static absl::optional<uint32_t> ParsePpsIdFromSlice(const uint8_t* data,
                                                      size_t length);

 protected:
  // Parse the PPS state, for a bit buffer where RBSP decoding has already been
  // performed.
  static absl::optional<PpsState> ParseInternal(rtc::BitBuffer* bit_buffer);
  static bool ParsePpsIdsInternal(rtc::BitBuffer* bit_buffer,
                                  uint32_t* pps_id,
                                  uint32_t* sps_id);
};

}  // namespace webrtc

#endif  // COMMON_VIDEO_H264_PPS_PARSER_H_
