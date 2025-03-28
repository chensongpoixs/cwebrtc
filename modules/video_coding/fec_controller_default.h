/*
 *  Copyright (c) 2016 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_VIDEO_CODING_FEC_CONTROLLER_DEFAULT_H_
#define MODULES_VIDEO_CODING_FEC_CONTROLLER_DEFAULT_H_

#include <stddef.h>
#include <stdint.h>
#include <memory>
#include <vector>

#include "api/fec_controller.h"
#include "modules/video_coding/media_opt_util.h"
#include "rtc_base/constructor_magic.h"
#include "rtc_base/critical_section.h"
#include "rtc_base/thread_annotations.h"
#include "system_wrappers/include/clock.h"

namespace webrtc {

/*

            几个对象之间的关系

FecControllerDefault   => FEC控制器  用于计算FEC保护因子和各种参数

VCMLossProtectionLogic => FEC生成器 类似于对象工厂用于产生FEC对象

UlpfecGenerator        => FEC对象  用于对媒体包生成FEC冗余，它使用FEC控制器

根据RtpVideoSender提供的目标码率、帧率、丢包率等实时参数，结合网络带宽估计（BWE）结果，动态计算FEC保护比率

‌运行时更新‌

接收来自RtpVideoSender的码率更新事件
调用FecControllerDefault生成最新FEC保护比率‌  [delta_params key_params] rate_fec = > [0, 255]
通过VideoFecGenerator接口调整冗余包生成速率‌




*/
class FecControllerDefault : public FecController {
 public:
  FecControllerDefault(Clock* clock,
                       VCMProtectionCallback* protection_callback);
  explicit FecControllerDefault(Clock* clock);
  ~FecControllerDefault() override;
  void SetProtectionCallback(
      VCMProtectionCallback* protection_callback) override;
  void SetProtectionMethod(bool enable_fec, bool enable_nack) override;
  void SetEncodingData(size_t width,
                       size_t height,
                       size_t num_temporal_layers,
                       size_t max_payload_size) override;
  uint32_t UpdateFecRates(uint32_t estimated_bitrate_bps,
                          int actual_framerate_fps,
                          uint8_t fraction_lost,
                          std::vector<bool> loss_mask_vector,
                          int64_t round_trip_time_ms) override;
  void UpdateWithEncodedData(
      const size_t encoded_image_length,
      const VideoFrameType encoded_image_frametype) override;
  bool UseLossVectorMask() override;
  float GetProtectionOverheadRateThreshold();

 private:
  enum { kBitrateAverageWinMs = 1000 };
  Clock* const clock_;
  VCMProtectionCallback* protection_callback_;
  rtc::CriticalSection crit_sect_;
  std::unique_ptr<media_optimization::VCMLossProtectionLogic> loss_prot_logic_
      RTC_GUARDED_BY(crit_sect_);
  size_t max_payload_size_ RTC_GUARDED_BY(crit_sect_);
  RTC_DISALLOW_COPY_AND_ASSIGN(FecControllerDefault);
  const float overhead_threshold_;
};

}  // namespace webrtc
#endif  // MODULES_VIDEO_CODING_FEC_CONTROLLER_DEFAULT_H_
