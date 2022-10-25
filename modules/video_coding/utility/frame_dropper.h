/*
 *  Copyright (c) 2011 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_VIDEO_CODING_UTILITY_FRAME_DROPPER_H_
#define MODULES_VIDEO_CODING_UTILITY_FRAME_DROPPER_H_

#include <stddef.h>
#include <stdint.h>

#include "rtc_base/numerics/exp_filter.h"

namespace webrtc {

// The Frame Dropper implements a variant of the leaky bucket algorithm
// for keeping track of when to drop frames to avoid bit rate
// over use when the encoder can't keep its bit rate.
//帧滴管实现了漏桶算法的一种变体
//用于跟踪何时丢弃帧以避免比特率
//编码器无法保持其比特率时过度使用。
//  移帧器
class FrameDropper {
 public:
  FrameDropper();
  ~FrameDropper();

  // Resets the FrameDropper to its initial state.
  void Reset();

  void Enable(bool enable);

  // Answers the question if it's time to drop a frame if we want to reach a
  // given frame rate. Must be called for every frame.
  //
  // Return value     : True if we should drop the current frame.
  //回答了这样一个问题：如果我们想要达到一个
  //给定帧速率。必须为每个帧调用。
  //返回值：如果要删除当前帧，则返回True
  bool DropFrame();

  // Updates the FrameDropper with the size of the latest encoded frame.
  // The FrameDropper calculates a new drop ratio (can be seen as the
  // probability to drop a frame) and updates its internal statistics.
  //
  // Input:
  //          - framesize_bytes    : The size of the latest frame returned
  //                                 from the encoder.
  //          - delta_frame        : True if the encoder returned a key frame.
  void Fill(size_t framesize_bytes, bool delta_frame);

  void Leak(uint32_t input_framerate);

  // Sets the target bit rate and the frame rate produced by the camera.
  //
  // Input:
  //          - bitrate       : The target bit rate.
  void SetRates(float bitrate, float incoming_frame_rate);

 private:
  void UpdateRatio();
  void CapAccumulator();

  rtc::ExpFilter key_frame_ratio_;
  rtc::ExpFilter delta_frame_size_avg_kbits_;

  // Key frames and large delta frames are not immediately accumulated in the
  // bucket since they can immediately overflow the bucket leading to large
  // drops on the following packets that may be much smaller. Instead these
  // large frames are accumulated over several frames when the bucket leaks.

  // |large_frame_accumulation_spread_| represents the number of frames over
  // which a large frame is accumulated.
  //关键帧和大增量帧不会立即累积在
  //因为它们可以立即使铲斗溢出，从而导致较大的
  //在以下可能小得多的数据包上丢弃。相反，这些
  //当铲斗泄漏时，大的机架累积在多个机架上。
  //| large_frame_cumulation_spread|表示上的帧数
  //积累了一个大的框架。
  float large_frame_accumulation_spread_;
  // |large_frame_accumulation_count_| represents the number of frames left
  // to finish accumulating a large frame.
  int large_frame_accumulation_count_;
  // |large_frame_accumulation_chunk_size_| represents the size of a single
  // chunk for large frame accumulation.
  float large_frame_accumulation_chunk_size_;

  float accumulator_;
  float accumulator_max_;
  float target_bitrate_;
  bool drop_next_;
  rtc::ExpFilter drop_ratio_;
  int drop_count_;
  float incoming_frame_rate_;
  bool was_below_max_;
  bool enabled_;
  const float max_drop_duration_secs_;
};

}  // namespace webrtc

#endif  // MODULES_VIDEO_CODING_UTILITY_FRAME_DROPPER_H_
