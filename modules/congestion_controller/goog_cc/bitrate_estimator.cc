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
//<<<<<<< HEAD
  // 计算当前时刻观测码率
//=======
  // 计算当前时刻码率即卡尔曼率滤波中的观测码率
//>>>>>>> 2338bf33e724ef75eb23e3e169732ca201f1ffe5
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
  // 此处定义了一个sample_uncertainty，含义上是预估码率和观测码率的偏差
  // 偏差越大说明采样点的方差越大，可信度越低
  // bitrate_estimate_kbps_: 上一个时刻观测码率
  float sample_uncertainty = uncertainty_scale_ * std::abs(bitrate_estimate_kbps_ - bitrate_sample_kbps) /
      (bitrate_estimate_kbps_ +  std::min(bitrate_sample_kbps, uncertainty_symmetry_cap_.Get().kbps<float>()));

  float sample_var = sample_uncertainty * sample_uncertainty;
  // Update a bayesian estimate of the rate, weighting it lower if the sample
  // uncertainty is large.
  // The bitrate estimate uncertainty is increased with each update to model
  // that the bitrate changes over time.
  float pred_bitrate_estimate_var = bitrate_estimate_var_ + 5.f;

  // 这其实对应的是一个卡尔曼滤波的后验期望的更新过程
  // 后验期望:exp[k]+ = exp[k]ˉ + k*(y[k] - h* exp[k]ˉ)
  // 其中 k = var[k]ˉ / (var[k]ˉ + sample_var) (var 和 sample_var 分别为预测误差方差和观测误差方差)
  bitrate_estimate_kbps_ = (sample_var * bitrate_estimate_kbps_ + pred_bitrate_estimate_var * bitrate_sample_kbps) /
                           (sample_var + pred_bitrate_estimate_var);
  bitrate_estimate_kbps_ = std::max(bitrate_estimate_kbps_, estimate_floor_.Get().kbps<float>());

  // 这其实对应的是一个卡尔曼滤波的后验方差的更新过程,
  // 后验方差: var[k] = (1 - k) * var[k]ˉ
  // 其中 k = var[k]ˉ / (var[k]ˉ + sample_var) (var 和 sample_var 分别为预测误差方差和观测误差方差)
  bitrate_estimate_var_ = sample_var * pred_bitrate_estimate_var /
                          (sample_var + pred_bitrate_estimate_var);
  BWE_TEST_LOGGING_PLOT(1, "acknowledged_bitrate", now_ms,
                        bitrate_estimate_kbps_ * 1000);
}
/************************************************************************/
/* 将当前计算出来当前码率(bitrate_sample_kbps)作为观测值, 把上一个预测码率(bitrate_estimate_kbps_)当作预测值, 
使用贝叶斯滤波去修正当前观测码率 , 其中引入了一个基于观测值和预测值的差的变量sample_uncertainty去作为样本标准差.                                                                     */
/************************************************************************/
float BitrateEstimator::UpdateWindow(int64_t now_ms,
                                     int bytes,
                                     int rate_window_ms) 
{
	//        rate_window_ms(预设评估窗口大小)
	//      |**********************|------------------------------|
	//      |-----------------------------------------------------|
	// prev_time_ms_      current_window_ms_(当前窗口大小)       now_ms
  // Reset if time moves backwards.
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
    // Reset if nothing has been received for more than a full window.
	//          rate_windows_ms(预设窗口大小)
	//  |***************************************|
	//  .......|-----------------------------------------------------|
	//       prev_time_ms_                                         now_ms
	//  |......----------------current_window_ms_--------------------|
	//                                         |*********************| 规定窗口大小rate_window_ms
	//                                         |---------------------| 被缩减后的窗口

	// 超过一个窗口没有接收到东西了，把过去窗口累加的size重置为0, 并把窗口大小
	// 进行缩减，减去一个周期前的长度，因为sum_置0后，会+=bytes，所以窗口
	// 不是直接置0而是保存在在一个窗口的部分
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
    return absl::nullopt;
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
