/*
 *  Copyright (c) 2017 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "modules/congestion_controller/goog_cc/bitrate_estimator.h"

#include <stdio.h>
#include <algorithm>
#include <cmath>
#include <string>

#include "api/units/data_rate.h"
#include "modules/remote_bitrate_estimator/test/bwe_test_logging.h"
#include "rtc_base/logging.h"

namespace webrtc {

namespace {
constexpr int kInitialRateWindowMs = 500;
constexpr int kRateWindowMs = 150;
constexpr int kMinRateWindowMs = 150;
constexpr int kMaxRateWindowMs = 1000;

const char kBweThroughputWindowConfig[] = "WebRTC-BweThroughputWindowConfig";

}  // namespace

BitrateEstimator::BitrateEstimator(const WebRtcKeyValueConfig* key_value_config)
    : sum_(0),
      initial_window_ms_("initial_window_ms",
                         kInitialRateWindowMs,
                         kMinRateWindowMs,
                         kMaxRateWindowMs),
      noninitial_window_ms_("window_ms",
                            kRateWindowMs,
                            kMinRateWindowMs,
                            kMaxRateWindowMs),
      uncertainty_scale_("scale", 10.0),
      uncertainty_symmetry_cap_("symmetry_cap", DataRate::Zero()),
      estimate_floor_("floor", DataRate::Zero()),
      current_window_ms_(0),
      prev_time_ms_(-1),
      bitrate_estimate_kbps_(-1.0f),
      bitrate_estimate_var_(50.0f) {
  // E.g WebRTC-BweThroughputWindowConfig/initial_window_ms:350,window_ms:250/
  ParseFieldTrial(
      {&initial_window_ms_, &noninitial_window_ms_, &uncertainty_scale_,
       &uncertainty_symmetry_cap_, &estimate_floor_},
      key_value_config->Lookup(kBweThroughputWindowConfig));
}

BitrateEstimator::~BitrateEstimator() = default;

/**
* 1. 观测码率
* 2. 预估码率
*/
void BitrateEstimator::Update(int64_t now_ms, int bytes) 
{
	//这边使用默认值  kRateWindowMs =  150
  int rate_window_ms = noninitial_window_ms_.Get();
  // We use a larger window at the beginning to get a more stable sample that
  // we can use to initialize the estimate.
  if (bitrate_estimate_kbps_ < 0.f)
  {
	  // 
	  rate_window_ms = initial_window_ms_.Get();
  }
  // TODO@chensong 2025-04-02  计算窗口内平均码率公式： bitrate_sample=  (窗口内总字节数×8)/窗口时间跨度（秒）
  
  float bitrate_sample_kbps = UpdateWindow(now_ms, bytes, rate_window_ms);
  if (bitrate_sample_kbps < 0.0f)
  {
	  return;
  }
  if (bitrate_estimate_kbps_ < 0.0f) 
  {
    // This is the very first sample we get. Use it to initialize the estimate.
	  // 第一次使用的时候 使用当前默认值 0
    bitrate_estimate_kbps_ = bitrate_sample_kbps;
    return;
  }
  // Define the sample uncertainty as a function of how far away it is from the
  // current estimate. With low values of uncertainty_symmetry_cap_ we add more
  // uncertainty to increases than to decreases. For higher values we approach
  // symmetry.
  // 1. 预估码率
  // 2. 观测码率
  
  ///TODO@chensong 2025-04-02  贝叶斯估计更新 
  // ==> 计算样本不确定性公式 ： sample_uncertainty=10.0× （∣bitrate_estimate_−bitrate_sample_kbps∣）/bitrate_estimate_

  // sample_uncertainty = 10 * |估计值 - 采样值| / 估计值 
  float sample_uncertainty = uncertainty_scale_ /*10.0*/ * std::abs(bitrate_estimate_kbps_ - bitrate_sample_kbps) /
      (bitrate_estimate_kbps_ +  std::min(bitrate_sample_kbps, uncertainty_symmetry_cap_.Get().kbps<float>()));

  float sample_var = sample_uncertainty * sample_uncertainty;
  
  float pred_bitrate_estimate_var = bitrate_estimate_var_ + 5.f;

  // TODO@chensong 2025-04-02 根据不确定性调整权重，更新估计值公式: 
  // bitrate_estimate_ = (bitrate_sample_kbps ×sample_var +  bitrate_sample_kbps×pred_bitrate_estimate_var)/  (sample_var + pred_bitrate_estimate_var)
  // 其中 pred_bitrate_estimate_var 为先验方差，反映历史估计的可信度‌
  //  公式  = （偏差动态调整权重 * 上一次估计码率  + 滑动窗口200ms * 一个窗口码率） / (偏差动态调整权重 + 滑动窗口的大小)
  // 根据上面公式 sample_var 变大 ==》 带宽bitrate_estimate_kbps_值也会变大 
  bitrate_estimate_kbps_ = (sample_var * bitrate_estimate_kbps_ + pred_bitrate_estimate_var * bitrate_sample_kbps) /
                           (sample_var + pred_bitrate_estimate_var);
  bitrate_estimate_kbps_ = std::max(bitrate_estimate_kbps_, estimate_floor_.Get().kbps<float>());

  // 后验协方差‌（估计误差的度量）
  bitrate_estimate_var_ = sample_var * pred_bitrate_estimate_var / (sample_var + pred_bitrate_estimate_var);
  BWE_TEST_LOGGING_PLOT(1, "acknowledged_bitrate", now_ms, bitrate_estimate_kbps_ * 1000);
}
/************************************************************************/
/*  TODO@chensong 2025-04-02 .  计算rate_window_ms窗口大小码率是多少                                                                    */
/************************************************************************/
float BitrateEstimator::UpdateWindow(int64_t now_ms,
                                     int bytes,
                                     int rate_window_ms) 
{  
  if (now_ms < prev_time_ms_) 
  {
    prev_time_ms_ = -1;
    sum_ = 0;
    current_window_ms_ = 0;
  }
  if (prev_time_ms_ >= 0) 
  {
	  // 计算当前窗口大小
    current_window_ms_ += now_ms - prev_time_ms_;
    // TODO@chensong 2025-04-02 判断当前窗口是否已经大于rate_window_ms窗口的大小 了 如果大于就 重置窗口大小 
    if (now_ms - prev_time_ms_ > rate_window_ms) 
	{
      sum_ = 0;// 重置
      current_window_ms_ %= rate_window_ms; //?????
    }
  }
  prev_time_ms_ = now_ms;
  float bitrate_sample = -1.0f;
  if (current_window_ms_ >= rate_window_ms) 
  {
	  // 满足一个窗口了，计算当前窗口内的码率
    bitrate_sample = 8.0f * sum_ / static_cast<float>(rate_window_ms);
	// 减去窗口
	current_window_ms_ -= rate_window_ms;
    sum_ = 0;
  }
  sum_ += bytes;
  return bitrate_sample;
}

absl::optional<uint32_t> BitrateEstimator::bitrate_bps() const {
  if (bitrate_estimate_kbps_ < 0.f)
  {
    return absl::nullopt;
  }
  return bitrate_estimate_kbps_ * 1000;
}

absl::optional<uint32_t> BitrateEstimator::PeekBps() const {
  if (current_window_ms_ > 0)
    return sum_ * 8000 / current_window_ms_;
  return absl::nullopt;
}

void BitrateEstimator::ExpectFastRateChange() {
  // By setting the bitrate-estimate variance to a higher value we allow the
  // bitrate to change fast for the next few samples.
  bitrate_estimate_var_ += 200;
}

}  // namespace webrtc
