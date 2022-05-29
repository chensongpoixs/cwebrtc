/*
 *  Copyright (c) 2016 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include <algorithm>
#include <limits>

#include "modules/video_coding/nack_module.h"

#include "modules/utility/include/process_thread.h"
#include "rtc_base/checks.h"
#include "rtc_base/logging.h"
#include "system_wrappers/include/field_trial.h"

namespace webrtc {

namespace {
const int kMaxPacketAge = 10000;
const int kMaxNackPackets = 1000;
const int kDefaultRttMs = 100;
const int kMaxNackRetries = 10;
const int kProcessFrequency = 50;
const int kProcessIntervalMs = 1000 / kProcessFrequency;
const int kMaxReorderedPackets = 128;
const int kNumReorderingBuckets = 10;
const int kDefaultSendNackDelayMs = 0;

int64_t GetSendNackDelay() {
  int64_t delay_ms = strtol(
      webrtc::field_trial::FindFullName("WebRTC-SendNackDelayMs").c_str(),
      nullptr, 10);
  if (delay_ms > 0 && delay_ms <= 20) {
    RTC_LOG(LS_INFO) << "SendNackDelay is set to " << delay_ms;
    return delay_ms;
  }
  return kDefaultSendNackDelayMs;
}
}  // namespace

NackModule::NackInfo::NackInfo()
    : seq_num(0), send_at_seq_num(0), sent_at_time(-1), retries(0) {}

NackModule::NackInfo::NackInfo(uint16_t seq_num,
                               uint16_t send_at_seq_num,
                               int64_t created_at_time)
    : seq_num(seq_num),
      send_at_seq_num(send_at_seq_num),
      created_at_time(created_at_time),
      sent_at_time(-1),
      retries(0) {}

NackModule::NackModule(Clock* clock,
                       NackSender* nack_sender,
                       KeyFrameRequestSender* keyframe_request_sender)
    : clock_(clock),
      nack_sender_(nack_sender),
      keyframe_request_sender_(keyframe_request_sender),
      reordering_histogram_(kNumReorderingBuckets, kMaxReorderedPackets),
      initialized_(false),
      rtt_ms_(kDefaultRttMs),
      newest_seq_num_(0),
      next_process_time_ms_(-1),
      send_nack_delay_ms_(GetSendNackDelay()) {
  RTC_DCHECK(clock_);
  RTC_DCHECK(nack_sender_);
  RTC_DCHECK(keyframe_request_sender_);
}

int NackModule::OnReceivedPacket(uint16_t seq_num, bool is_keyframe) {
  return OnReceivedPacket(seq_num, is_keyframe, false);
}

int NackModule::OnReceivedPacket(uint16_t seq_num,
                                 bool is_keyframe,
                                 bool is_recovered) {
  rtc::CritScope lock(&crit_);
  // TODO(philipel): When the packet includes information whether it is
  //                 retransmitted or not, use that value instead. For
  //                 now set it to true, which will cause the reordering
  //                 statistics to never be updated.
  bool is_retransmitted = true;
  // 1. 判断是否第一次， 初始化  完成就退出
  if (!initialized_) {
    newest_seq_num_ = seq_num;
    if (is_keyframe)// 这个包是否关键帧===》》 为什么要识别关键帧？？？
      keyframe_list_.insert(seq_num);
    initialized_ = true;
    return 0;
  }

  // Since the |newest_seq_num_| is a packet we have actually received we know
  // that packet has never been Nacked.
  // 2. 如果这次来的seq与上次一样，是重复包， 退出
  if (seq_num == newest_seq_num_)
    return 0;
  // 即不是第一个包和重复包就判断包顺序哈 seq_num在newest_seq_num之前就要删除了哈  
  // 3. 如果是上次处理前面的包， 这个包已经失效了， 如果还在nack列表中， 需要删除的
  // 说明这个包晚到达了 
  if (AheadOf(newest_seq_num_, seq_num)) {
    // An out of order packet has been received.
    auto nack_list_it = nack_list_.find(seq_num);
    int nacks_sent_for_packet = 0;
    if (nack_list_it != nack_list_.end()) {
      nacks_sent_for_packet = nack_list_it->second.retries;
      nack_list_.erase(nack_list_it);
    }
    if (!is_retransmitted)
      UpdateReorderingStatistics(seq_num);
    return nacks_sent_for_packet;
  }

  // Keep track of new keyframes.
  // 4. 如果判断是否是key帧？？？ 哈
  if (is_keyframe)
    keyframe_list_.insert(seq_num); // 如果该报属于key帧， 保持起来

  // And remove old ones so we don't accumulate keyframes.
  // 5. 找到最小边界点，   超出10000个就要删除之前的数据 ， 这个是实时系统
  auto it = keyframe_list_.lower_bound(seq_num - kMaxPacketAge);
  if (it != keyframe_list_.begin())
    keyframe_list_.erase(keyframe_list_.begin(), it);
  // 6. 如何判断是否找回来的包？？？  恢复包
  if (is_recovered) {
    recovered_list_.insert(seq_num); // 如果该包是属于key帧，保持起来

    // Remove old ones so we don't accumulate recovered packets.
	//  是否超出项 超出项也删除了  ， 最大项也是10000哈
    auto it = recovered_list_.lower_bound(seq_num - kMaxPacketAge);
    if (it != recovered_list_.begin())
      recovered_list_.erase(recovered_list_.begin(), it);

    // Do not send nack for packets recovered by FEC or RTX.
    return 0;
  }
  // 7. 什么情况会走到这边呢 
  //     1、不是第一个包
  //     2. 不是一个重复的包
  //     3、 不是在new_seq_num之前的包
  //     4、 不是一个恢复包
  //   有两种情况会走到这边
  //     1、  上一次处理的包的后面的一个包哈   有序的包
  //     2、  上一次处理的包 后面隔好几个包   
  AddPacketsToNack(newest_seq_num_ + 1, seq_num);
  newest_seq_num_ = seq_num;

  // Are there any nacks that are waiting for this seq_num.
  // 8. 哪些包是真真丢包的  就告诉对方从新发送包哈
  std::vector<uint16_t> nack_batch = GetNackBatch(kSeqNumOnly);
  if (!nack_batch.empty()) 
    nack_sender_->SendNack(nack_batch);  //  需要重传哈   放到缓冲区了 ??????

  return 0;
}

void NackModule::ClearUpTo(uint16_t seq_num) {
  rtc::CritScope lock(&crit_);
  nack_list_.erase(nack_list_.begin(), nack_list_.lower_bound(seq_num));
  keyframe_list_.erase(keyframe_list_.begin(),
                       keyframe_list_.lower_bound(seq_num));
  recovered_list_.erase(recovered_list_.begin(),
                        recovered_list_.lower_bound(seq_num));
}

void NackModule::UpdateRtt(int64_t rtt_ms) {
  rtc::CritScope lock(&crit_);
  rtt_ms_ = rtt_ms;
}

void NackModule::Clear() {
  rtc::CritScope lock(&crit_);
  nack_list_.clear();
  keyframe_list_.clear();
  recovered_list_.clear();
}

int64_t NackModule::TimeUntilNextProcess() {
  return std::max<int64_t>(next_process_time_ms_ - clock_->TimeInMilliseconds(),
                           0);
}

void NackModule::Process() {
  if (nack_sender_) {
    std::vector<uint16_t> nack_batch;
    {
      rtc::CritScope lock(&crit_);
      nack_batch = GetNackBatch(kTimeOnly);
    }

    if (!nack_batch.empty())
      nack_sender_->SendNack(nack_batch);
  }

  // Update the next_process_time_ms_ in intervals to achieve
  // the targeted frequency over time. Also add multiple intervals
  // in case of a skip in time as to not make uneccessary
  // calls to Process in order to catch up.
  int64_t now_ms = clock_->TimeInMilliseconds();
  if (next_process_time_ms_ == -1) {
    next_process_time_ms_ = now_ms + kProcessIntervalMs;
  } else {
    next_process_time_ms_ = next_process_time_ms_ + kProcessIntervalMs +
                            (now_ms - next_process_time_ms_) /
                                kProcessIntervalMs * kProcessIntervalMs;
  }
}

bool NackModule::RemovePacketsUntilKeyFrame() {
  while (!keyframe_list_.empty()) {
    auto it = nack_list_.lower_bound(*keyframe_list_.begin());

    if (it != nack_list_.begin()) {
      // We have found a keyframe that actually is newer than at least one
      // packet in the nack list.
      nack_list_.erase(nack_list_.begin(), it);
      return true;
    }

    // If this keyframe is so old it does not remove any packets from the list,
    // remove it from the list of keyframes and try the next keyframe.
    keyframe_list_.erase(keyframe_list_.begin());
  }
  return false;
}

void NackModule::AddPacketsToNack(uint16_t seq_num_start,
                                  uint16_t seq_num_end) {
  // Remove old packets.
  auto it = nack_list_.lower_bound(seq_num_end - kMaxPacketAge);
  nack_list_.erase(nack_list_.begin(), it);

  // If the nack list is too large, remove packets from the nack list until
  // the latest first packet of a keyframe. If the list is still too large,
  // clear it and request a keyframe.
  // 1. 开始到结束之间有多大距离 
  uint16_t num_new_nacks = ForwardDiff(seq_num_start, seq_num_end);
  if (nack_list_.size() + num_new_nacks > kMaxNackPackets) {
    while (RemovePacketsUntilKeyFrame() &&
           nack_list_.size() + num_new_nacks > kMaxNackPackets) {
    }
	// 1.1、 极端情况  没有删除， 就要清除nack， 然后发送请求关键帧给对方  让解码器从新工作哈
    if (nack_list_.size() + num_new_nacks > kMaxNackPackets) {
      nack_list_.clear();
      RTC_LOG(LS_WARNING) << "NACK list full, clearing NACK"
                             " list and requesting keyframe.";
      keyframe_request_sender_->RequestKeyFrame();
      return;
    }
  }
  // 2、 遍历seq_num_start 到seq_num_end 之间 是否有丢包 有的话 就放到nack_list_中哈
  for (uint16_t seq_num = seq_num_start; seq_num != seq_num_end; ++seq_num) {
    // Do not send nack for packets that are already recovered by FEC or RTX
	// 2.1 是否已经通过FEC或者RTX恢复了 该包 恢复了 就不需要放到nack_list_列表中去哈
    if (recovered_list_.find(seq_num) != recovered_list_.end())
      continue;
    NackInfo nack_info(seq_num, seq_num + WaitNumberOfPackets(0.5),
                       clock_->TimeInMilliseconds());
    RTC_DCHECK(nack_list_.find(seq_num) == nack_list_.end());
    nack_list_[seq_num] = nack_info;
  }
}
// 遍历所有可疑包 如果包符合条件 就插入nack_batch中
std::vector<uint16_t> NackModule::GetNackBatch(NackFilterOptions options) {
	// 1. 标识以seq_num为判断条件
  bool consider_seq_num = options != kTimeOnly;
  // 2. 标识以timestamp为判断条件 
  bool consider_timestamp = options != kSeqNumOnly;
  int64_t now_ms = clock_->TimeInMilliseconds();
  std::vector<uint16_t> nack_batch;
  auto it = nack_list_.begin();
  while (it != nack_list_.end()) {
	  // 1. send_nack_delay_ms_ 默认为0 ， 可修改
    bool delay_timed_out = now_ms - it->second.created_at_time >= send_nack_delay_ms_;
	// 2. 从一次发送开始到现在， 是否超过了一个RTT的回路的时长 时间  
	// 需要得到一个RTT防止重复传送的情况 
    bool nack_on_rtt_passed = now_ms - it->second.sent_at_time >= rtt_ms_;
	// 3、 第一次发送和最后处理包之前的
    bool nack_on_seq_num_passed = it->second.sent_at_time /*如果是第一次发送*/== -1 &&
        AheadOrAt(newest_seq_num_, it->second.send_at_seq_num)/*该包在最后处理的包之前*/;
	// 符合条件
    if (delay_timed_out && ((consider_seq_num && nack_on_seq_num_passed) ||
                            (consider_timestamp && nack_on_rtt_passed))) {
      nack_batch.emplace_back(it->second.seq_num);
      ++it->second.retries;
      it->second.sent_at_time = now_ms;
	  // 尝试10次 在nack_list列表中没有发现 就要删除了
      if (it->second.retries >= kMaxNackRetries/*kMaxNackRetries= 10*/) {
        RTC_LOG(LS_WARNING) << "Sequence number " << it->second.seq_num
                            << " removed from NACK list due to max retries.";
        it = nack_list_.erase(it);
      } else {
        ++it;
      }
      continue;
    }
    ++it;
  }
  return nack_batch;
}

void NackModule::UpdateReorderingStatistics(uint16_t seq_num) {
  RTC_DCHECK(AheadOf(newest_seq_num_, seq_num));
  uint16_t diff = ReverseDiff(newest_seq_num_, seq_num);
  reordering_histogram_.Add(diff);
}

int NackModule::WaitNumberOfPackets(float probability) const {
  if (reordering_histogram_.NumValues() == 0)
    return 0;
  return reordering_histogram_.InverseCdf(probability);
}

}  // namespace webrtc
