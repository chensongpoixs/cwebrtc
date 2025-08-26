/*
 *  Copyright (c) 2016 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "modules/congestion_controller/goog_cc/trendline_estimator.h"

#include <math.h>

#include <algorithm>

#include "absl/types/optional.h"
#include "modules/remote_bitrate_estimator/include/bwe_defines.h"
#include "modules/remote_bitrate_estimator/test/bwe_test_logging.h"
#include "rtc_base/checks.h"
#include "rtc_base/numerics/safe_minmax.h"

namespace webrtc {

namespace {
// TODO@chensong 2022-11-30 线性回归函数最小二乘法
/*
 TODO@chensong 2022-11-30 
 时间作为                     : x
 平滑延迟值smoothed_delay作为  : y


 x/y


 TODO@chensong 2025-08-26 线性回归函数最小二乘法 trend 
 
 1. trend值含义
      ①   表示延迟趋势，也是线性回归最小二乘法拟合的直线斜率
	  ② 当发送码率 send_rate 小于网络链路的容量 link_capacity
		时，数据包不会在网络队列中排队积压，延迟趋势 trend 值基本为
		0（网络存在波动，不可能完全等于0） 
	  ③ 当发送码率 send_rate 大于网络链路的容量 link_capacity
		时，数据包会在网络队列中排队积压，数据包的传输延迟逐步增大，此时的延迟趋势 trend
		值 > 0，表示网络出现拥塞  
	  ④ 当网络拥塞得到缓解时，网络队列会逐渐排空，数据包的传输延迟开始下降，此时的延迟趋势trend 值 < 0 
	  ⑤ trend 等价于 estimate ((send_rate – link_capacity) / link_capacity) 
	  
	  
2. trend

值我们可以利用包组延迟样本数据，通过线性回归最小二乘法计算斜率获得，有了 trend
值我们就能判断网络是否出现过载拥塞，然后调整发送码率
send_rate，使得网络不处于过载或者负载过低的状态，此时的发送码率就接近于网络的容量，即比较准确的网络带宽估计值。

*/



absl::optional<double> LinearFitSlope(const std::deque<std::pair<double, double>>& points) 
{
  RTC_DCHECK(points.size() >= 2);
  // Compute the "center of mass".
  double sum_x = 0;
  double sum_y = 0;
  for (const auto& point : points) 
  {
    sum_x += point.first;
    sum_y += point.second;
  }
  double x_avg = sum_x / points.size();
  double y_avg = sum_y / points.size();
  // TODO@chensong 2022-11-30 直线方程y=bx+a的斜率b按如下公式计算:
  // Compute the slope k = \sum (x_i-x_avg)(y_i-y_avg) / \sum (x_i-x_avg)^2

  double numerator = 0;
  double denominator = 0;
  for (const auto& point : points) 
  {
    numerator += (point.first - x_avg) * (point.second - y_avg);
    denominator += (point.first - x_avg) * (point.first - x_avg);
  }
  if (denominator == 0) 
  {
    return absl::nullopt;
  }
  return numerator / denominator;
}

constexpr double kMaxAdaptOffsetMs = 15.0;
constexpr double kOverUsingTimeThreshold = 10;
constexpr int kMinNumDeltas = 60;
constexpr int kDeltaCounterMax = 1000;

}  // namespace

TrendlineEstimator::TrendlineEstimator(
    size_t window_size,
    double smoothing_coef,
    double threshold_gain,
    NetworkStatePredictor* network_state_predictor)
    : window_size_(window_size),
      smoothing_coef_(smoothing_coef),
      threshold_gain_(threshold_gain),
      num_of_deltas_(0),
      first_arrival_time_ms_(-1),
      accumulated_delay_(0),
      smoothed_delay_(0),
      delay_hist_(),
      k_up_(0.0087),
      k_down_(0.039),
      overusing_time_threshold_(kOverUsingTimeThreshold),
      threshold_(12.5), // 20250402 这边为什么定义12.5？ 丢包率   认为大于12.5就是 带宽使用过载，网络发生拥塞。
      prev_modified_trend_(NAN),
      last_update_ms_(-1),
      prev_trend_(0.0),
      time_over_using_(-1),
      overuse_counter_(0),
      hypothesis_(BandwidthUsage::kBwNormal),
      hypothesis_predicted_(BandwidthUsage::kBwNormal),
      network_state_predictor_(network_state_predictor) {}

TrendlineEstimator::~TrendlineEstimator() {}

void TrendlineEstimator::Update(double recv_delta_ms, double send_delta_ms, int64_t send_time_ms, int64_t arrival_time_ms, bool calculated_deltas) 
{
  if (calculated_deltas) 
  {
    const double delta_ms = recv_delta_ms - send_delta_ms;
    ++num_of_deltas_;
    num_of_deltas_ = std::min(num_of_deltas_, kDeltaCounterMax /* 1000 */);
    if (first_arrival_time_ms_ == -1) 
	{
      first_arrival_time_ms_ = arrival_time_ms;
    }

    // Exponential backoff filter.
    accumulated_delay_ += delta_ms;
    BWE_TEST_LOGGING_PLOT(1, "accumulated_delay_ms", arrival_time_ms, accumulated_delay_);
    /*
    TODO@chensong 2022-11-30
        到达时间滤波器(arrival-time filter)
   为减少网络波动影响，使用中会将最近1000个
   包组传输时延进行叠加，计算出一个平滑延迟值 smoothed_delay。 WebRTC
   使用了线性回归进行时延梯度趋势预测，通过最小二乘法求拟合直线的斜率，根据斜率判断增长趋势
   
   平滑延迟公式 = 平滑系数 * 平滑延迟 + (1 - 平滑系数) * 累积的延迟
   

   TODO@chensong 2025-04-02  平滑延迟ₙ = α × 平滑延迟  + (1 - α) × 累积的延迟
   ‌平滑系数（α）‌： 取值范围为0到1，决定历史数据与新数据的权重。α越大，历史数据影响越大，结果更平滑；α越小，新数据影响越显著，结果更敏感

    
   */
    smoothed_delay_ = smoothing_coef_ * smoothed_delay_ + (1 - smoothing_coef_ /*0.9*/) * accumulated_delay_;
    BWE_TEST_LOGGING_PLOT(1, "smoothed_delay_ms", arrival_time_ms, smoothed_delay_);

    // Simple linear regression. ==>>> 简单线性回归
    delay_hist_.push_back(std::make_pair(static_cast<double>(arrival_time_ms - first_arrival_time_ms_), smoothed_delay_));
    if (delay_hist_.size() > window_size_)
	{
      delay_hist_.pop_front();
    }
    double trend = prev_trend_;
    if (delay_hist_.size() == window_size_ /*20*/) 
	{
      // Update trend_ if it is possible to fit a line to the data. The delay
      // trend can be seen as an estimate of (send_rate - capacity)/capacity.
      // 0 < trend < 1   ->  the delay increases, queues are filling up		==> 1、延时增大，路由buffer 正在被填充。
      //   trend == 0    ->  the delay does not change						==> 2、延时没有发生变化。
      //   trend < 0     ->  the delay decreases, queues are being emptied	==> 3、延时开始降低，路由buffer正在排空。
	  // 20250402 最小二乘法计算斜率（核心逻辑）  有可能斜率会是负数
      trend = LinearFitSlope(delay_hist_).value_or(trend);
    }

    BWE_TEST_LOGGING_PLOT(1, "trendline_slope", arrival_time_ms, trend);

    Detect(trend, send_delta_ms, arrival_time_ms);
  }
  if (network_state_predictor_)
  {
    hypothesis_predicted_ = network_state_predictor_->Update(send_time_ms, arrival_time_ms, hypothesis_);
  }
}

BandwidthUsage TrendlineEstimator::State() const {
  return network_state_predictor_ ? hypothesis_predicted_ : hypothesis_;
}

void TrendlineEstimator::Detect(double trend, double ts_delta, int64_t now_ms) 
{
  if (num_of_deltas_ < 2) 
  {
    hypothesis_ = BandwidthUsage::kBwNormal;
    return;
  }
  //TODO@chensong 2022-11-30 过载检测器(over-use detector)
  //实际使用中，由于trend 是一个非常小的值，会乘以包组数量和增益系数进行放大得到modified_trend
  // TODO@chensong  2025-04-02 
  // 一、‌延迟梯度趋势的物理意义
  //    1. 表示网络延迟的线性变化趋势。
  //     ①  正斜率表示延迟上升（拥塞加剧）
  //     ②  负斜率表示延迟下降（网络恢复）‌
  //    2. 原始斜率值范围较小‌：直接使用未缩放的斜率可能导致检测算法对微小变化不敏感，尤其在高速网络下难以区分噪声与真实拥塞信号‌
  // 二、放大趋势值的必要性‌
  //  ‌提高灵敏度‌：乘以4 .0将趋势值放大，使算法能更快捕捉到延迟的微小波动。例如，若原始斜率为0.25，放大后为1.0，更容易触发阈值判断‌
  const double modified_trend = std::min(num_of_deltas_, kMinNumDeltas) * trend * threshold_gain_ /*增益系数 =  4.0*/;
  prev_modified_trend_ = modified_trend;
  BWE_TEST_LOGGING_PLOT(1, "T", now_ms, modified_trend);
  BWE_TEST_LOGGING_PLOT(1, "threshold", now_ms, threshold_);
  if (modified_trend > threshold_) //持续时间超过100ms并且 trend值持续变大，认为此时处于 overuse 状态。
  {
    if (time_over_using_ == -1) 
	{
      // Initialize the timer. Assume that we've been
      // over-using half of the time since the previous
      // sample.
      time_over_using_ = ts_delta / 2;
    }
	else 
	{
      // Increment timer
      time_over_using_ += ts_delta;
    }
    overuse_counter_++;
    if (time_over_using_ > overusing_time_threshold_ && overuse_counter_ > 1) 
	{
      if (trend >= prev_trend_) 
	  {
        time_over_using_ = 0;
        overuse_counter_ = 0;
		// 20250402 带宽使用过载，网络发生拥塞。
        hypothesis_ = BandwidthUsage::kBwOverusing; 

      }
    }
  } 
  else if (modified_trend < -threshold_) //认为此时处于underuse 状态
  {
    time_over_using_ = -1;
    overuse_counter_ = 0;
	// 20250402 当前带宽利用不足，可充分利用。
    hypothesis_ = BandwidthUsage::kBwUnderusing;
  }
  else  //-threshold < modifed_trend < threshold  认为此时处于normal 状态。
  {
    time_over_using_ = -1;
    overuse_counter_ = 0;
	// 20250402 带宽常态使用，既不过载、也不拥塞。
    hypothesis_ = BandwidthUsage::kBwNormal;
  }
  prev_trend_ = trend;
  UpdateThreshold(modified_trend, now_ms);
}

void TrendlineEstimator::UpdateThreshold(double modified_trend, int64_t now_ms)
{
  if (last_update_ms_ == -1)
  {
    last_update_ms_ = now_ms;
  }

  if (fabs(modified_trend) > threshold_ + kMaxAdaptOffsetMs) 
  {
    // Avoid adapting the threshold to big latency spikes, caused e.g.,
    // by a sudden capacity drop.
    last_update_ms_ = now_ms;
    return;
  }
  /*
  TODO@chensong 2025-04-02 
  ‌1. 输入参数‌

	‌当前延迟梯度斜率‌：由Trendline滤波器计算得出（trendline_slope） 
	‌历史阈值‌：上一次计算的阈值（threshold_prev） 
	‌时间衰减因子‌：控制阈值调整速度的参数（通常取0.9-0.95） 
	‌调整幅度系数‌：根据斜率偏离阈值的程度动态计算  
‌
  2. 计算公式‌

 
	threshold_new = threshold_prev * time_decay + k * |trendline_slope|

	‌time_decay‌：时间衰减因子，防止阈值突变‌
	‌k‌：动态调整系数，根据当前网络负载状态（如延迟变化率）缩放调整幅度‌

  3. ‌更新策略‌

	‌过载检测时‌：若延迟梯度斜率持续高于阈值，增大k以快速提升阈值，避免误判‌ 
	‌正常状态下‌：降低k使阈值缓慢衰减，适应网络性能改善 
  */
  // / 根据趋势线斜率调整阈值
  const double k = fabs(modified_trend) < threshold_ ? k_down_ : k_up_;
  const int64_t kMaxTimeDeltaMs = 100;
  int64_t time_delta_ms = std::min(now_ms - last_update_ms_, kMaxTimeDeltaMs);
  threshold_ += k * (fabs(modified_trend) - threshold_) * time_delta_ms;
  threshold_ = rtc::SafeClamp(threshold_, 6.f, 600.f);
  last_update_ms_ = now_ms;
}

}  // namespace webrtc
