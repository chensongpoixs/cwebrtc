﻿/*
 *  Copyright (c) 2019 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef VIDEO_ENCODER_BITRATE_ADJUSTER_H_
#define VIDEO_ENCODER_BITRATE_ADJUSTER_H_

#include <memory>

#include "api/video/encoded_image.h"
#include "api/video/video_bitrate_allocation.h"
#include "api/video_codecs/video_encoder.h"
#include "video/encoder_overshoot_detector.h"

namespace webrtc {
	/*
	TODO@chensong 2023-04-29 
	EncoderBitrateAdjuster是WebRTC中负责调整编码器比特率的模块。其原理如下：

	1.获取网络状况：EncoderBitrateAdjuster会从与远端的连接中获取网络状况，例如延迟、丢包率等。

	2.计算可用带宽：根据网络状况，EncoderBitrateAdjuster会计算出当前可用的带宽大小。

	3.调整比特率：EncoderBitrateAdjuster根据可用带宽大小，调整编码器的比特率，以达到最佳图像质量和视频传输性能的平衡。

	4.反馈控制：EncoderBitrateAdjuster会将调整后的比特率反馈给编码器，以确保编码器一直处于最佳状态。

	总之，EncoderBitrateAdjuster通过实时监测网络状况并调整编码器比特率，保证了视频传输的稳定性和质量。
	*/
class EncoderBitrateAdjuster {
 public:
  // Size of sliding window used to track overshoot rate.
  static constexpr int64_t kWindowSizeMs = 3000;
  // Minimum number of frames since last layout change required to trust the
  // overshoot statistics. Otherwise falls back to default utilization.
  // By layout change, we mean any spatial/temporal layer being either enabled
  // or disabled.
  static constexpr size_t kMinFramesSinceLayoutChange = 30;
  // Default utilization, before reliable metrics are available, is set to 20%
  // overshoot. This is conservative so that badly misbehaving encoders don't
  // build too much queue at the very start.
  static constexpr double kDefaultUtilizationFactor = 1.2;

  explicit EncoderBitrateAdjuster(const VideoCodec& codec_settings);
  ~EncoderBitrateAdjuster();

  // Adjusts the given rate allocation to make it paceable within the target
  // rates.
  VideoBitrateAllocation AdjustRateAllocation( const VideoBitrateAllocation& bitrate_allocation,
      int framerate_fps);

  // Updated overuse detectors with data about the encoder, specifically about
  // the temporal layer frame rate allocation.
  void OnEncoderInfo(const VideoEncoder::EncoderInfo& encoder_info);

  // Updates the overuse detectors according to the encoded image size.
  void OnEncodedFrame(const EncodedImage& encoded_image, int temporal_index);

  void Reset();

 private:
  VideoBitrateAllocation current_bitrate_allocation_;
  int current_total_framerate_fps_;
  // FPS allocation of temporal layers, per spatial layer. Represented as a Q8
  // fraction; 0 = 0%, 255 = 100%. See VideoEncoder::EncoderInfo.fps_allocation.
  absl::InlinedVector<uint8_t, kMaxTemporalStreams> current_fps_allocation_[kMaxSpatialLayers];

  // Frames since layout was changed, mean that any spatial or temporal layer
  // was either disabled or enabled.
  size_t frames_since_layout_change_;
  std::unique_ptr<EncoderOvershootDetector> overshoot_detectors_[kMaxSpatialLayers][kMaxTemporalStreams];

  // Minimum bitrates allowed, per spatial layer.
  uint32_t min_bitrates_bps_[kMaxSpatialLayers];
};

}  // namespace webrtc

#endif  // VIDEO_ENCODER_BITRATE_ADJUSTER_H_
