/*
 *  Copyright (c) 2018 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_INCLUDE_MODULE_FEC_TYPES_H_
#define MODULES_INCLUDE_MODULE_FEC_TYPES_H_

namespace webrtc {

// Types for the FEC packet masks. The type |kFecMaskRandom| is based on a
// random loss model. The type |kFecMaskBursty| is based on a bursty/consecutive
// loss model. The packet masks are defined in
// modules/rtp_rtcp/fec_private_tables_random(bursty).h

	// FEC数据包掩码的类型。类型|kFecMaskRandom|基于
//随机损失模型。类型|kFecMaskBursty|基于突发/连续
//损失模型。数据包掩码在中定义
// modules/rtp_rtcp/fec_private_tables_random（突发）.h
enum FecMaskType {
  kFecMaskRandom,
  kFecMaskBursty,
};

// Struct containing forward error correction settings.
struct FecProtectionParams {
  int fec_rate;  // 保护因子（定点数，范围 0~255，对应 0%~100% 冗余比例）。
  int max_fec_frames;
  FecMaskType fec_mask_type;
};

}  // namespace webrtc

#endif  // MODULES_INCLUDE_MODULE_FEC_TYPES_H_
