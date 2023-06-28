/*
 *  Copyright (c) 2012 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "modules/bitrate_controller/send_side_bandwidth_estimation.h"

#include <algorithm>
#include <cstdio>
#include <limits>
#include <string>

#include "absl/memory/memory.h"
#include "logging/rtc_event_log/events/rtc_event.h"
#include "logging/rtc_event_log/events/rtc_event_bwe_update_loss_based.h"
#include "logging/rtc_event_log/rtc_event_log.h"
#include "modules/remote_bitrate_estimator/include/bwe_defines.h"
#include "rtc_base/checks.h"
#include "rtc_base/logging.h"
#include "system_wrappers/include/field_trial.h"
#include "system_wrappers/include/metrics.h"

namespace webrtc {
namespace {
	// TODO@chensong 2022-10-19 [TimeDelta::Millis<1000> => 1ms]
constexpr TimeDelta kBweIncreaseInterval = TimeDelta::Millis<1000>();
constexpr TimeDelta kBweDecreaseInterval = TimeDelta::Millis<300>();
constexpr TimeDelta kStartPhase = TimeDelta::Millis<2000>();
constexpr TimeDelta kBweConverganceTime = TimeDelta::Millis<20000>();
constexpr int kLimitNumPackets = 20;
constexpr DataRate kDefaultMaxBitrate = DataRate::BitsPerSec<1000000000>();
constexpr TimeDelta kLowBitrateLogPeriod = TimeDelta::Millis<10000>();
constexpr TimeDelta kRtcEventLogPeriod = TimeDelta::Millis<5000>();
// Expecting that RTCP feedback is sent uniformly within [0.5, 1.5]s intervals.
constexpr TimeDelta kMaxRtcpFeedbackInterval = TimeDelta::Millis<5000>();
constexpr int kFeedbackTimeoutIntervals = 3;
constexpr TimeDelta kTimeoutInterval = TimeDelta::Millis<1000>();

constexpr float kDefaultLowLossThreshold = 0.02f;
constexpr float kDefaultHighLossThreshold = 0.1f;
constexpr DataRate kDefaultBitrateThreshold = DataRate::Zero();

struct UmaRampUpMetric {
  const char* metric_name;
  int bitrate_kbps;
};
// TODO@chensong 2023-05-01 
// WebRTC.BWE.RampUpTimeTo500kbpsInMs是WebRTC中的一个参数，它用于控制视频比特率的自适应调整。当接收端网络状况变好时，发送端需要逐渐增加视频比特率以提高视频质量。
//这个过程称为“ramp-up”（加速），而WebRTC.BWE.RampUpTimeTo500kbpsInMs则控制了从当前比特率到500 kbps的加速时间。默认值为2000毫秒（2秒），也可以根据应用程序需求进行更改。
const UmaRampUpMetric kUmaRampupMetrics[] = {
    {"WebRTC.BWE.RampUpTimeTo500kbpsInMs", 500},
    {"WebRTC.BWE.RampUpTimeTo1000kbpsInMs", 1000},
    {"WebRTC.BWE.RampUpTimeTo2000kbpsInMs", 2000}};
const size_t kNumUmaRampupMetrics = sizeof(kUmaRampupMetrics) / sizeof(kUmaRampupMetrics[0]);

const char kBweLosExperiment[] = "WebRTC-BweLossExperiment";

bool BweLossExperimentIsEnabled() {
  std::string experiment_string =
      webrtc::field_trial::FindFullName(kBweLosExperiment);
  // The experiment is enabled iff the field trial string begins with "Enabled".
  return experiment_string.find("Enabled") == 0;
}

// static std::string out_bandwidth_file =
//    "./bandwidth/send_side_bandwidth_estimation.log";
//static FILE* out_bandwidth_ptr = NULL;
// 
///*
//if (!out_bandwidth_ptr)
//    {
//      out_bandwidth_ptr =
//          ::fopen("./bandwidth/send_side_bandwidth_estimation.log", "wb+");
//        }
//*/
//
//#define BANDWIDTH_FILE_LOG if (!out_bandwidth_ptr)\
//{  \
//  /*out_bandwidth_ptr = ::fopen("./bandwidth/send_side_bandwidth_estimation.log", "wb+");*/ \
//} 
//
//#define BANDWIDTH_ESTIMATION_LOG()                                      \
//  BANDWIDTH_FILE_LOG \
// if (out_bandwidth_ptr) { \
//  ::fprintf(out_bandwidth_ptr, "[%s][%d]\n", __FUNCTION__, __LINE__); \
//  ::fflush(out_bandwidth_ptr);  \
//}
//
//#define BANDWIDTH_ESTIMATION_FORMAT(format, ...)                                      \
//  BANDWIDTH_FILE_LOG                                                    \
//  if (out_bandwidth_ptr) {                                              \
//    ::fprintf(out_bandwidth_ptr, "[%s][%d]" format, __FUNCTION__, __LINE__, ##__VA_ARGS__); \
//    ::fflush(out_bandwidth_ptr);                                        \
//  }

 

    

bool ReadBweLossExperimentParameters(float* low_loss_threshold,
                                     float* high_loss_threshold,
                                     uint32_t* bitrate_threshold_kbps) {
//  BANDWIDTH_ESTIMATION_LOG();
  RTC_DCHECK(low_loss_threshold);
  RTC_DCHECK(high_loss_threshold);
  RTC_DCHECK(bitrate_threshold_kbps);
  std::string experiment_string =
      webrtc::field_trial::FindFullName(kBweLosExperiment);
  int parsed_values =
      sscanf(experiment_string.c_str(), "Enabled-%f,%f,%u", low_loss_threshold,
             high_loss_threshold, bitrate_threshold_kbps);
  if (parsed_values == 3) {
    RTC_CHECK_GT(*low_loss_threshold, 0.0f)
        << "Loss threshold must be greater than 0.";
    RTC_CHECK_LE(*low_loss_threshold, 1.0f)
        << "Loss threshold must be less than or equal to 1.";
    RTC_CHECK_GT(*high_loss_threshold, 0.0f)
        << "Loss threshold must be greater than 0.";
    RTC_CHECK_LE(*high_loss_threshold, 1.0f)
        << "Loss threshold must be less than or equal to 1.";
    RTC_CHECK_LE(*low_loss_threshold, *high_loss_threshold)
        << "The low loss threshold must be less than or equal to the high loss "
           "threshold.";
    RTC_CHECK_GE(*bitrate_threshold_kbps, 0)
        << "Bitrate threshold can't be negative.";
    RTC_CHECK_LT(*bitrate_threshold_kbps,
                 std::numeric_limits<int>::max() / 1000)
        << "Bitrate must be smaller enough to avoid overflows.";
    return true;
  }
  RTC_LOG(LS_WARNING) << "Failed to parse parameters for BweLossExperiment "
                         "experiment from field trial string. Using default.";
  *low_loss_threshold = kDefaultLowLossThreshold;
  *high_loss_threshold = kDefaultHighLossThreshold;
  *bitrate_threshold_kbps = kDefaultBitrateThreshold.kbps();
  return false;
}
}  // namespace

LinkCapacityTracker::LinkCapacityTracker()
    : tracking_rate("rate", TimeDelta::seconds(10)) 
{ 
  ParseFieldTrial({&tracking_rate},
                  field_trial::FindFullName("WebRTC-Bwe-LinkCapacity"));
}

LinkCapacityTracker::~LinkCapacityTracker() {}

void LinkCapacityTracker::OnOveruse(DataRate acknowledged_rate, Timestamp at_time) 
{ 
  capacity_estimate_bps_ = std::min(capacity_estimate_bps_, acknowledged_rate.bps<double>());
  last_link_capacity_update_ = at_time;
}

void LinkCapacityTracker::OnStartingRate(DataRate start_rate) 
{ 
	if (last_link_capacity_update_.IsInfinite())
	{
		capacity_estimate_bps_ = start_rate.bps<double>();
  }
}

void LinkCapacityTracker::OnRateUpdate(DataRate acknowledged, Timestamp at_time) 
{ 
	// TODO@chensong 2023-05-04  根据网络掉包评估处理的码流大于当前就使用
  if (acknowledged.bps() > capacity_estimate_bps_) 
  {
    TimeDelta delta = at_time - last_link_capacity_update_;
	// alpha 公式 TODO@chensong 2023-05-04 
    double alpha = delta.IsFinite() ? exp(-(delta / tracking_rate.Get())) : 0;
    capacity_estimate_bps_ = alpha * capacity_estimate_bps_ + (1 - alpha) * acknowledged.bps<double>();
  }
  last_link_capacity_update_ = at_time;
}

void LinkCapacityTracker::OnRttBackoff(DataRate backoff_rate, Timestamp at_time) 
{ 
  capacity_estimate_bps_ = std::min(capacity_estimate_bps_, backoff_rate.bps<double>());
  last_link_capacity_update_ = at_time;
}

DataRate LinkCapacityTracker::estimate() const 
{ 
  return DataRate::bps(capacity_estimate_bps_);
}

RttBasedBackoff::RttBasedBackoff()
    : rtt_limit_("limit", TimeDelta::PlusInfinity()),
      drop_fraction_("fraction", 0.5),
      drop_interval_("interval", TimeDelta::ms(300)),
      persist_on_route_change_("persist"),
      safe_timeout_("safe_timeout", true),
      bandwidth_floor_("floor", DataRate::kbps(5)),
      // By initializing this to plus infinity, we make sure that we never
      // trigger rtt backoff unless packet feedback is enabled.
      last_propagation_rtt_update_(Timestamp::PlusInfinity()),
      last_propagation_rtt_(TimeDelta::Zero()),
      last_packet_sent_(Timestamp::MinusInfinity())
{
 // BANDWIDTH_ESTIMATION_LOG();
  ParseFieldTrial(
      {&rtt_limit_, &drop_fraction_, &drop_interval_, &persist_on_route_change_,
       &safe_timeout_, &bandwidth_floor_},
      field_trial::FindFullName("WebRTC-Bwe-MaxRttLimit"));
}

void RttBasedBackoff::OnRouteChange() 
{
 // BANDWIDTH_ESTIMATION_LOG();
  if (!persist_on_route_change_) 
  {
    last_propagation_rtt_update_ = Timestamp::PlusInfinity();
    last_propagation_rtt_ = TimeDelta::Zero();
  }
}

void RttBasedBackoff::UpdatePropagationRtt(Timestamp at_time, TimeDelta propagation_rtt) 
{ 
	//记录当前时间传播rtt最小时的时间
  last_propagation_rtt_update_ = at_time;
  //rtt的最后传播 （最小传播rtt的时间）
  last_propagation_rtt_ = propagation_rtt;
}

TimeDelta RttBasedBackoff::CorrectedRtt(Timestamp at_time) const 
{ 
  TimeDelta time_since_rtt = at_time - last_propagation_rtt_update_;
  TimeDelta timeout_correction = time_since_rtt; 
  if (safe_timeout_) 
  {
    // Avoid timeout when no packets are being sent. //在没有传输数据包时避免超时。
    TimeDelta time_since_packet_sent = at_time - last_packet_sent_;
    timeout_correction = std::max(time_since_rtt - time_since_packet_sent, TimeDelta::Zero());
  }
  return timeout_correction + last_propagation_rtt_;
}

RttBasedBackoff::~RttBasedBackoff() = default;

SendSideBandwidthEstimation::SendSideBandwidthEstimation(RtcEventLog* event_log)
    : lost_packets_since_last_loss_update_(0),
      expected_packets_since_last_loss_update_(0),
      current_bitrate_(DataRate::Zero()),
      min_bitrate_configured_(
          DataRate::bps(congestion_controller::GetMinBitrateBps())),
      max_bitrate_configured_(kDefaultMaxBitrate),
      last_low_bitrate_log_(Timestamp::MinusInfinity()),
      has_decreased_since_last_fraction_loss_(false),
      last_loss_feedback_(Timestamp::MinusInfinity()),
      last_loss_packet_report_(Timestamp::MinusInfinity()),
      last_timeout_(Timestamp::MinusInfinity()),
      last_fraction_loss_(0),
      last_logged_fraction_loss_(0),
      last_round_trip_time_(TimeDelta::Zero()),
      bwe_incoming_(DataRate::Zero()),
      delay_based_bitrate_(DataRate::Zero()),
      time_last_decrease_(Timestamp::MinusInfinity()),
      first_report_time_(Timestamp::MinusInfinity()),
      initially_lost_packets_(0),
      bitrate_at_2_seconds_(DataRate::Zero()),
      uma_update_state_(kNoUpdate),
      uma_rtt_state_(kNoUpdate),
      rampup_uma_stats_updated_(kNumUmaRampupMetrics, false),
      event_log_(event_log),
      last_rtc_event_log_(Timestamp::MinusInfinity()),
      in_timeout_experiment_(
          webrtc::field_trial::IsEnabled("WebRTC-FeedbackTimeout/Enabled/")), // TODO@chensong 2022-11-29 feedback timeout 具体什么作用还不知道
      low_loss_threshold_(kDefaultLowLossThreshold /*0.02f;*/),
      high_loss_threshold_(kDefaultHighLossThreshold /*0.1f*/),
      bitrate_threshold_(kDefaultBitrateThreshold /*0.0f*/) { 
  RTC_DCHECK(event_log);
  if (BweLossExperimentIsEnabled()) {
    uint32_t bitrate_threshold_kbps;
    if (ReadBweLossExperimentParameters(&low_loss_threshold_,
                                        &high_loss_threshold_,
                                        &bitrate_threshold_kbps)) {
      RTC_LOG(LS_INFO) << "Enabled BweLossExperiment with parameters "
                       << low_loss_threshold_ << ", " << high_loss_threshold_
                       << ", " << bitrate_threshold_kbps;
      bitrate_threshold_ = DataRate::kbps(bitrate_threshold_kbps);
    }
  }
}

SendSideBandwidthEstimation::~SendSideBandwidthEstimation() { 
}

void SendSideBandwidthEstimation::OnRouteChange() { 
  lost_packets_since_last_loss_update_ = 0;
  expected_packets_since_last_loss_update_ = 0;
  current_bitrate_ = DataRate::Zero();
  min_bitrate_configured_ =
      DataRate::bps(congestion_controller::GetMinBitrateBps());
  max_bitrate_configured_ = kDefaultMaxBitrate;
  last_low_bitrate_log_ = Timestamp::MinusInfinity();
  has_decreased_since_last_fraction_loss_ = false;
  last_loss_feedback_ = Timestamp::MinusInfinity();
  last_loss_packet_report_ = Timestamp::MinusInfinity();
  last_timeout_ = Timestamp::MinusInfinity();
  last_fraction_loss_ = 0;
  last_logged_fraction_loss_ = 0;
  last_round_trip_time_ = TimeDelta::Zero();
  bwe_incoming_ = DataRate::Zero();
  delay_based_bitrate_ = DataRate::Zero();
  time_last_decrease_ = Timestamp::MinusInfinity();
  first_report_time_ = Timestamp::MinusInfinity();
  initially_lost_packets_ = 0;
  bitrate_at_2_seconds_ = DataRate::Zero();
  uma_update_state_ = kNoUpdate;
  uma_rtt_state_ = kNoUpdate;
  last_rtc_event_log_ = Timestamp::MinusInfinity();

  rtt_backoff_.OnRouteChange();
}

void SendSideBandwidthEstimation::SetBitrates(
    absl::optional<DataRate> send_bitrate,
    DataRate min_bitrate,
    DataRate max_bitrate,
    Timestamp at_time) { 
  SetMinMaxBitrate(min_bitrate, max_bitrate);
  if (send_bitrate) {
    link_capacity_.OnStartingRate(*send_bitrate);
    SetSendBitrate(*send_bitrate, at_time);
  }
}

void SendSideBandwidthEstimation::SetSendBitrate(DataRate bitrate,
                                                 Timestamp at_time) {
  //BANDWIDTH_ESTIMATION_LOG();
  RTC_DCHECK(bitrate > DataRate::Zero());
  // Reset to avoid being capped by the estimate.
  delay_based_bitrate_ = DataRate::Zero();
  if (loss_based_bandwidth_estimation_.Enabled()) {
    loss_based_bandwidth_estimation_.MaybeReset(bitrate);
  }
  CapBitrateToThresholds(at_time, bitrate);
  // Clear last sent bitrate history so the new value can be used directly
  // and not capped.
  min_bitrate_history_.clear();
}

void SendSideBandwidthEstimation::SetMinMaxBitrate(DataRate min_bitrate,
                                                   DataRate max_bitrate) {
  //BANDWIDTH_ESTIMATION_LOG();
  min_bitrate_configured_ =
      std::max(min_bitrate, congestion_controller::GetMinBitrate());
  if (max_bitrate > DataRate::Zero() && max_bitrate.IsFinite()) {
    max_bitrate_configured_ = std::max(min_bitrate_configured_, max_bitrate);
  } else {
    max_bitrate_configured_ = kDefaultMaxBitrate;
  }
}

int SendSideBandwidthEstimation::GetMinBitrate() const {
 // BANDWIDTH_ESTIMATION_LOG();
  return min_bitrate_configured_.bps<int>();
}

void SendSideBandwidthEstimation::CurrentEstimate(int* bitrate,
                                                  uint8_t* loss,
                                                  int64_t* rtt) const {
 // BANDWIDTH_ESTIMATION_LOG();
  *bitrate = std::max<int32_t>(current_bitrate_.bps<int>(), GetMinBitrate());
  *loss = last_fraction_loss_;
  *rtt = last_round_trip_time_.ms<int64_t>();
}

DataRate SendSideBandwidthEstimation::GetEstimatedLinkCapacity() const {
  //BANDWIDTH_ESTIMATION_LOG();
  return link_capacity_.estimate();
}
// TODO@chensong 2023-04-30  goog-remb宽带评估算法调用的 
void SendSideBandwidthEstimation::UpdateReceiverEstimate(Timestamp at_time, DataRate bandwidth) 
{
 // BANDWIDTH_ESTIMATION_LOG();
  bwe_incoming_ = bandwidth;
  CapBitrateToThresholds(at_time, current_bitrate_);
}

void SendSideBandwidthEstimation::UpdateDelayBasedEstimate(Timestamp at_time, DataRate bitrate) 
{
  if (acknowledged_rate_) 
  {
    if (bitrate < delay_based_bitrate_) 
	{
      link_capacity_.OnOveruse(*acknowledged_rate_, at_time);
    }
  }
  delay_based_bitrate_ = bitrate;
  CapBitrateToThresholds(at_time, current_bitrate_);
}
// TODO@chensong 2023-04-30 
// PostUpdates(controller_->OnTransportPacketsFeedback(*feedback_msg));
// GoogCcNetworkController::OnTransportPacketsFeedback
void SendSideBandwidthEstimation::SetAcknowledgedRate(absl::optional<DataRate> acknowledged_rate, Timestamp at_time) 
{
  acknowledged_rate_ = acknowledged_rate;
  if (acknowledged_rate && loss_based_bandwidth_estimation_.Enabled()) 
  {
    loss_based_bandwidth_estimation_.UpdateAcknowledgedBitrate(*acknowledged_rate, at_time);
  }
}

void SendSideBandwidthEstimation::IncomingPacketFeedbackVector(const TransportPacketsFeedback& report) 
{ 
  if (loss_based_bandwidth_estimation_.Enabled()) 
  {
    loss_based_bandwidth_estimation_.UpdateLossStatistics(report.packet_feedbacks, report.feedback_time);
  }
}

void SendSideBandwidthEstimation::UpdateReceiverBlock(uint8_t fraction_loss, TimeDelta rtt,  int number_of_packets, Timestamp at_time)
{
  const int kRoundingConstant = 128;
  int packets_lost = (static_cast<int>(fraction_loss) * number_of_packets +
                      kRoundingConstant) >>
                     8;
  UpdatePacketsLost(packets_lost, number_of_packets, at_time);
  UpdateRtt(rtt, at_time);
}

void SendSideBandwidthEstimation::UpdatePacketsLost(int packets_lost, int number_of_packets, Timestamp at_time) 
{ 
  last_loss_feedback_ = at_time;
  if (first_report_time_.IsInfinite())
  {
	  first_report_time_ = at_time;
  }

  // Check sequence number diff and weight loss report
  if (number_of_packets > 0) 
  {
    // Accumulate reports.
	  // TODO@chensong 2023-05-01 累加数据包
    lost_packets_since_last_loss_update_ += packets_lost;
    expected_packets_since_last_loss_update_ += number_of_packets;

    // Don't generate a loss rate until it can be based on enough packets.
	// TODO@chensong 2023-05-04 预期接收包的总数量 小于20时啥事情都不干哈 ^_^
	if (expected_packets_since_last_loss_update_ < kLimitNumPackets /*20*/)
	{
		return;
	}

    has_decreased_since_last_fraction_loss_ = false;
	//这边为什么要是  8呢 ---   >>>>> 
	// TODO@chensong 2023-05-04   2的8次方正好是256 计算掉包乘以256  也就是<<8  ， 这样做的目的避免后面计算使用浮点表示
    int64_t lost_q8 = lost_packets_since_last_loss_update_ << 8;
    int64_t expected = expected_packets_since_last_loss_update_;

	///// 非常关键一步得到掉包比例啦
	// TODO@chensong 2023-05-04 这边掉包概率 为什么是 [0, 255] 好奇
	// 这边我就好奇 这个公式？？？？？？？？ = (掉包数 * 256)/ 正在应该收的数据包(不掉包)   好奇吧  这是放大系数为了更好计算出精确的掉包率
    last_fraction_loss_ = std::min<int>(lost_q8 / expected, 255);

    // Reset accumulators.
	//  清除累加的数据
    lost_packets_since_last_loss_update_ = 0;
    expected_packets_since_last_loss_update_ = 0;
    last_loss_packet_report_ = at_time;
	//TODO@chensong 2023-05-01 非常关键的方法 需要花大量精力看的方法
    UpdateEstimate(at_time);
  }
  UpdateUmaStatsPacketsLost(at_time, packets_lost);
}

void SendSideBandwidthEstimation::UpdateUmaStatsPacketsLost(Timestamp at_time, int packets_lost)
{ 
  DataRate bitrate_kbps = DataRate::kbps((current_bitrate_.bps() + 500) / 1000);
  for (size_t i = 0; i < kNumUmaRampupMetrics; ++i) 
  {
    if (!rampup_uma_stats_updated_[i] && bitrate_kbps.kbps() >= kUmaRampupMetrics[i].bitrate_kbps) 
	{
      RTC_HISTOGRAMS_COUNTS_100000(i, kUmaRampupMetrics[i].metric_name, (at_time - first_report_time_).ms());
      rampup_uma_stats_updated_[i] = true;
    }
  }
  if (IsInStartPhase(at_time)) 
  {
    initially_lost_packets_ += packets_lost;
  } 
  else if (uma_update_state_ == kNoUpdate)
  {
    uma_update_state_ = kFirstDone;
    bitrate_at_2_seconds_ = bitrate_kbps;
    RTC_HISTOGRAM_COUNTS("WebRTC.BWE.InitiallyLostPackets", initially_lost_packets_, 0, 100, 50);
    RTC_HISTOGRAM_COUNTS("WebRTC.BWE.InitialBandwidthEstimate", bitrate_at_2_seconds_.kbps(), 0, 2000, 50);
  } 
  else if (uma_update_state_ == kFirstDone && at_time - first_report_time_ >= kBweConverganceTime) 
  {
    uma_update_state_ = kDone;
    int bitrate_diff_kbps = std::max(bitrate_at_2_seconds_.kbps<int>() - bitrate_kbps.kbps<int>(), 0);
    RTC_HISTOGRAM_COUNTS("WebRTC.BWE.InitialVsConvergedDiff", bitrate_diff_kbps, 0, 2000, 50);
  }
}

void SendSideBandwidthEstimation::UpdateRtt(TimeDelta rtt, Timestamp at_time) 
{
  
  // Update RTT if we were able to compute an RTT based on this RTCP.
  // FlexFEC doesn't send RTCP SR, which means we won't be able to compute RTT.
	if (rtt > TimeDelta::Zero())
	{
		last_round_trip_time_ = rtt;
  }

  if (!IsInStartPhase(at_time) && uma_rtt_state_ == kNoUpdate) 
  {
    uma_rtt_state_ = kDone;
    RTC_HISTOGRAM_COUNTS("WebRTC.BWE.InitialRtt", rtt.ms<int>(), 0, 2000, 50);
  }
}
/*
首先获取当前时间戳now_ms，然后根据上次接收反馈的时间和最小延迟时间计算是否需要等待下一次更新码率。

接着获取远端的带宽信息，并计算当前的最大发送码率。

然后根据丢包率、接收到的反馈信息以及当前时间来计算新的码率，并通过observer_回调通知应用程序进行调整。最后将新的码率保存在last_send_bitrate_中，以便下一次更新时使用。
*/
void SendSideBandwidthEstimation::UpdateEstimate(Timestamp at_time) 
{
  DataRate new_bitrate = current_bitrate_;
  if (rtt_backoff_.CorrectedRtt(at_time) > rtt_backoff_.rtt_limit_) 
  {
    if (at_time - time_last_decrease_ >= rtt_backoff_.drop_interval_ && current_bitrate_ > rtt_backoff_.bandwidth_floor_) 
	{
      time_last_decrease_ = at_time;
      new_bitrate = std::max(current_bitrate_ * rtt_backoff_.drop_fraction_, rtt_backoff_.bandwidth_floor_.Get());
      link_capacity_.OnRttBackoff(new_bitrate, at_time);
    }
    CapBitrateToThresholds(at_time, new_bitrate);
    return;
  }

  // We trust the REMB and/or delay-based estimate during the first 2 seconds if
  // we haven't had any packet loss reported, to allow startup bitrate probing.
  if (last_fraction_loss_ == 0 && IsInStartPhase(at_time))
  {
    new_bitrate = std::max(bwe_incoming_, new_bitrate);
    new_bitrate = std::max(delay_based_bitrate_, new_bitrate);
    if (loss_based_bandwidth_estimation_.Enabled()) 
	{
      loss_based_bandwidth_estimation_.SetInitialBitrate(new_bitrate);
    }

    if (new_bitrate != current_bitrate_) 
	{
      min_bitrate_history_.clear();
      if (loss_based_bandwidth_estimation_.Enabled()) 
	  {
        min_bitrate_history_.push_back(std::make_pair(at_time, new_bitrate));
      } 
	  else 
	  {
        min_bitrate_history_.push_back(std::make_pair(at_time, current_bitrate_));
      }
      CapBitrateToThresholds(at_time, new_bitrate);
      return;
    }
  }

  // TODO@chensong 2023-05-02 保存当前时刻的码流数据插入到队列中去
  UpdateMinHistory(at_time);
  if (last_loss_packet_report_.IsInfinite()) 
  {
    // No feedback received.
	  // TODO@chensong 2023-05-02 这边是没有接收到feedback反馈接收包数据的走这边？？？
    CapBitrateToThresholds(at_time, current_bitrate_);
    return;
  }
  //TODO@chensong 2023-05-02 默认是不开启的 
  if (loss_based_bandwidth_estimation_.Enabled()) 
  {
    loss_based_bandwidth_estimation_.Update(at_time, min_bitrate_history_.front().second, last_round_trip_time_);
    new_bitrate = MaybeRampupOrBackoff(new_bitrate, at_time);
    CapBitrateToThresholds(at_time, new_bitrate);
    return;
  }

  // TODO@chensong 2023-05-04 正常情况下面两个反馈时间都是0 
  TimeDelta time_since_loss_packet_report = at_time - last_loss_packet_report_;
  TimeDelta time_since_loss_feedback = at_time - last_loss_feedback_;
  // TODO@chensong 2022-10-19  [1.2 * 5 = 6ms]   rtcp feedback反馈包在6ms内反馈数据就走下面逻辑
  
  if (time_since_loss_packet_report < 1.2 * kMaxRtcpFeedbackInterval) 
  {
    // We only care about loss above a given bitrate threshold.
    float loss = last_fraction_loss_ / 256.0f; // 取出掉包概率  2的8次方 
	// We only make decisions based on loss when the bitrate is above a
    // threshold. This is a crude way of handling loss which is uncorrelated
    // to congestion.
	// TODO@chensong 2023-05-04 掉包概率小于等于0.02f就需要增大码流
    if (current_bitrate_ < bitrate_threshold_ || loss <= low_loss_threshold_ /*0.02f*/) 
	{
		
      // Loss < 2%: Increase rate by 8% of the min bitrate in the last
      // kBweIncreaseInterval.
      // Note that by remembering the bitrate over the last second one can
      // rampup up one second faster than if only allowed to start ramping
      // at 8% per second rate now. E.g.:
      //   If sending a constant 100kbps it can rampup immediately to 108kbps
      //   whenever a receiver report is received with lower packet loss.
      //   If instead one would do: current_bitrate_ *= 1.08^(delta time),
      //   it would take over one second since the lower packet loss to achieve
      //   108kbps.
      new_bitrate = DataRate::bps(min_bitrate_history_.front().second.bps() * 1.08 + 0.5);

      // Add 1 kbps extra, just to make sure that we do not get stuck
      // (gives a little extra increase at low rates, negligible at higher
      // rates).
      new_bitrate += DataRate::bps(1000);
    } 
	else if (current_bitrate_ > bitrate_threshold_) 
	{
		// TODO@chensong 2023-05-04 掉包概率小于等于0.1f时啥都不处理
      if (loss <= high_loss_threshold_) 
	  {
        // Loss between 2% - 10%: Do nothing.
      }
	  else 
	  {
		  // TODO@chensong 2023-05-04 掉包概率打印百分之十就需要降低码流啦 ^_^
		  // 降低码流
        // Loss > 10%: Limit the rate decreases to once a kBweDecreaseInterval
        // + rtt.
		  // TODO@chensong 2023-05-04
		  // 1. has_decreased_since_last_fraction_loss_ 该变量在SendSideBandwidthEstimation::UpdatePacketsLost方法中更新false变量
		  // 2. time_last_decrease_这个变量几乎可以忽略在其它地方更新， 正常情况下只有在下面更新一下呢
		  // 3. last_round_trip_time_ 即是最近的一个rtt的时长  ---> [接收端发送RR ---> 到发送端时长]
		  // 
		  // TODO@chensong 2023-05-04 
		  // 问题： 
		  // 1. kBweDecreaseInterval 这个值是300毫秒 我第一觉得会不会太大了呢 ~~~~

        if (!has_decreased_since_last_fraction_loss_ &&  (at_time - time_last_decrease_) >= (kBweDecreaseInterval/*300微妙*/ + last_round_trip_time_)) 
		{

          time_last_decrease_ = at_time;

          // Reduce rate:
          //   newRate = rate * (1 - 0.5*lossRate);
          //   where packetLoss = 256*lossRate;
		  // TODO@chensong 2023-05-04  这个降低码流公式   上面有一个乘以256 即就是 0.5 计算机的字节整数是1024 
		  // 把系数放到512倍数 精确系数     然后在还原系数
		  // 根据掉包率 从新评估网络带宽的大小发送
          new_bitrate = DataRate::bps((current_bitrate_.bps() * static_cast<double>(512 - last_fraction_loss_)) /  512.0);
          has_decreased_since_last_fraction_loss_ = true;
        }
      }
    }

	RTC_LOG(LS_INFO) << "[bitrate_threshold_ " << bitrate_threshold_ << "][loss = " << loss << "][low_loss_threshold_ = " << low_loss_threshold_ << "][high_loss_threshold_ " << high_loss_threshold_ << "][new_bitrate = "<<new_bitrate<<"]";

  } 
  else if (time_since_loss_feedback > kFeedbackTimeoutIntervals/*3*/ * kMaxRtcpFeedbackInterval &&
             (last_timeout_.IsInfinite() || at_time - last_timeout_ > kTimeoutInterval)) 
  {
	  // [(5 * 3 ) = 15ms ]
    if (in_timeout_experiment_) 
	{
      RTC_LOG(LS_WARNING) << "Feedback timed out (" << ToString(time_since_loss_feedback)<< "), reducing bitrate.";
	  // TODO@chensong 2023-05-04 降低码流到原理0.8的码流
      new_bitrate = new_bitrate * 0.8;
      // Reset accumulators since we've already acted on missing feedback and
      // shouldn't to act again on these old lost packets.
      lost_packets_since_last_loss_update_ = 0;
      expected_packets_since_last_loss_update_ = 0;
      last_timeout_ = at_time;
    }
  }

  CapBitrateToThresholds(at_time, new_bitrate);
}

void SendSideBandwidthEstimation::UpdatePropagationRtt(Timestamp at_time, TimeDelta propagation_rtt)
{ 
  rtt_backoff_.UpdatePropagationRtt(at_time, propagation_rtt);
}

void SendSideBandwidthEstimation::OnSentPacket(const SentPacket& sent_packet) 
{ 
  // Only feedback-triggering packets will be reported here.
  rtt_backoff_.last_packet_sent_ = sent_packet.send_time;
}

bool SendSideBandwidthEstimation::IsInStartPhase(Timestamp at_time) const 
{ 
  return first_report_time_.IsInfinite() || at_time - first_report_time_ < kStartPhase;
}

void SendSideBandwidthEstimation::UpdateMinHistory(Timestamp at_time) 
{
  // Remove old data points from history.
  // Since history precision is in ms, add one so it is able to increase
  // bitrate if it is off by as little as 0.5ms
  // TODO@chensong 2023-05-02 从队列中前面开始比较当前时间是否大于1000微妙 如果大于就移除， 没有大于就跳过啦~~~~
  while (!min_bitrate_history_.empty() && at_time - min_bitrate_history_.front().first + TimeDelta::ms(1) > kBweIncreaseInterval) 
  {
    min_bitrate_history_.pop_front();
  }

  // Typical minimum sliding-window algorithm: Pop values higher than current
  // bitrate before pushing it.
  // TODO@chensong 2023-05-02 移除队列中从后面去除比当前码流大的数据
  while (!min_bitrate_history_.empty() && current_bitrate_ <= (min_bitrate_history_.back().second * 0.65)) 
  {
    min_bitrate_history_.pop_back();
  }
  // TODO@chensong 2023-05-02 保存当前时间的码流
  RTC_LOG(LS_INFO) << "[min bitrate_history insert --> "<<current_bitrate_<<"]";
  min_bitrate_history_.push_back(std::make_pair(at_time, current_bitrate_));
}

DataRate SendSideBandwidthEstimation::MaybeRampupOrBackoff(DataRate new_bitrate, Timestamp at_time) 
{ 
  // TODO(crodbro): reuse this code in UpdateEstimate instead of current
  // inlining of very similar functionality.
  const TimeDelta time_since_loss_packet_report =
      at_time - last_loss_packet_report_;
  const TimeDelta time_since_loss_feedback = at_time - last_loss_feedback_;
  if (time_since_loss_packet_report < 1.2 * kMaxRtcpFeedbackInterval) {
    new_bitrate = min_bitrate_history_.front().second * 1.08;
    new_bitrate += DataRate::bps(1000);
  } else if (time_since_loss_feedback >
                 kFeedbackTimeoutIntervals * kMaxRtcpFeedbackInterval &&
             (last_timeout_.IsInfinite() ||
              at_time - last_timeout_ > kTimeoutInterval)) {
    if (in_timeout_experiment_) {
      RTC_LOG(LS_WARNING) << "Feedback timed out ("
                          << ToString(time_since_loss_feedback)
                          << "), reducing bitrate.";
      new_bitrate = new_bitrate * 0.8;
      // Reset accumulators since we've already acted on missing feedback and
      // shouldn't to act again on these old lost packets.
      lost_packets_since_last_loss_update_ = 0;
      expected_packets_since_last_loss_update_ = 0;
      last_timeout_ = at_time;
    }
  }
  return new_bitrate;
}
// TODO@chensong 2023-05-02 上限比特率到阈值
void SendSideBandwidthEstimation::CapBitrateToThresholds(Timestamp at_time, DataRate bitrate) 
{ 
	//TODO@chensong 20230628  网络评估bwe出问题 在世注释该代码
 // if (  bitrate > bwe_incoming_ && bwe_incoming_ > DataRate::Zero()) 
 // { //TODO@chensong 2023-04-30  goog-remb 算法会走到这里啦
 //   bitrate = bwe_incoming_;
	//RTC_LOG(LS_INFO) << "[bwe_incoming_ = "<<bwe_incoming_<<"]";
 // }
  if (bitrate > delay_based_bitrate_ && delay_based_bitrate_ > DataRate::Zero() )
  {
    bitrate = delay_based_bitrate_;
	RTC_LOG(LS_INFO) << "[delay_based_bitrate_ = "<<delay_based_bitrate_<<"]";
  }
  if (loss_based_bandwidth_estimation_.Enabled() &&
      loss_based_bandwidth_estimation_.GetEstimate() > DataRate::Zero()) 
  {
    bitrate = std::min(bitrate, loss_based_bandwidth_estimation_.GetEstimate());
	RTC_LOG(LS_INFO) << "[bitrate = "<<bitrate<<"]";
  }
  if (bitrate > max_bitrate_configured_)
  {
    bitrate = max_bitrate_configured_;
	RTC_LOG(LS_INFO) << "[max_bitrate_configured_ = "<<max_bitrate_configured_<<"]";
  }
  if (bitrate < min_bitrate_configured_) 
  {
    if (last_low_bitrate_log_.IsInfinite() ||
        at_time - last_low_bitrate_log_ > kLowBitrateLogPeriod) 
	{
      RTC_LOG(LS_WARNING) << "Estimated available bandwidth "
                          << ToString(bitrate)
                          << " is below configured min bitrate "
                          << ToString(min_bitrate_configured_) << ".";
      last_low_bitrate_log_ = at_time;
    }
    bitrate = min_bitrate_configured_;
	RTC_LOG(LS_INFO) << "[min_bitrate_configured_ = "<<min_bitrate_configured_<<"]";
  }

  if (bitrate != current_bitrate_ || last_fraction_loss_ != last_logged_fraction_loss_ || at_time - last_rtc_event_log_ > kRtcEventLogPeriod) 
  {
    event_log_->Log(absl::make_unique<RtcEventBweUpdateLossBased>(
        bitrate.bps(), last_fraction_loss_, expected_packets_since_last_loss_update_));
    last_logged_fraction_loss_ = last_fraction_loss_;
    last_rtc_event_log_ = at_time;
  }
  current_bitrate_ = bitrate;

  if (acknowledged_rate_) 
  {
    link_capacity_.OnRateUpdate(std::min(current_bitrate_, *acknowledged_rate_), at_time);
  }
}
}  // namespace webrtc
