/*
 *  Copyright (c) 2012 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_PACING_PACED_SENDER_H_
#define MODULES_PACING_PACED_SENDER_H_

#include <stddef.h>
#include <stdint.h>
#include <atomic>
#include <memory>

#include "absl/types/optional.h"
#include "api/transport/field_trial_based_config.h"
#include "api/transport/network_types.h"
#include "api/transport/webrtc_key_value_config.h"
#include "modules/pacing/bitrate_prober.h"
#include "modules/pacing/interval_budget.h"
#include "modules/pacing/pacer.h"
#include "modules/pacing/round_robin_packet_queue.h"
#include "modules/rtp_rtcp/include/rtp_rtcp_defines.h"
#include "modules/utility/include/process_thread.h"
#include "rtc_base/critical_section.h"
#include "rtc_base/deprecation.h"
#include "rtc_base/experiments/field_trial_parser.h"
#include "rtc_base/thread_annotations.h"

namespace webrtc {
class AlrDetector;
class Clock;
class RtcEventLog;
/*
TODO@chensong 2023-04-29 
PacedSender类是WebRTC中用于控制传输速率的一个重要组件，主要用于调整发送方的发送速率以满足网络带宽的限制。PacedSender类的实现原理如下：

1.根据网络带宽动态调整发送速率：PacedSender类会根据网络带宽的情况调整发送速率，以保证数据包能够在网络上正常传输。具体而言，PacedSender会先统计一定时间内网络的平均带宽，并根据平均带宽和目标带宽之间的差值来调整发送速率。

2.使用Leaky Bucket算法进行流量控制：PacedSender类基于Leaky Bucket算法实现了流量控制，即在发送端维护一个固定大小的队列，当有新数据包需要发送时，先将其放入队列中，然后按照一定的速率从队列中取出数据包发送。这样可以避免瞬时爆发式的数据传输，从而平稳地控制发送速率。

3.考虑丢包情况进行自适应调整：PacedSender类还会根据网络丢包的情况进行自适应调整，以尽量减少数据包的丢失率。具体而言，当检测到网络丢包时，PacedSender会降低发送速率，以便等待网络恢复。同时，在网络恢复后，PacedSender会逐渐增加发送速率，以达到最大可用带宽。

综上所述，PacedSender类通过动态调整发送速率、使用Leaky Bucket算法进行流量控制和考虑丢包情况进行自适应调整来保证数据包能够在网络上正常传输。这些机制使得PacedSender类成为WebRTC中重要的传输控制组件。
*/
class PacedSender : public Pacer {
 public:
  class PacketSender {
   public:
    // Note: packets sent as a result of a callback should not pass by this
    // module again.
    // Called when it's time to send a queued packet.
    // Returns false if packet cannot be sent.
    virtual bool TimeToSendPacket(uint32_t ssrc,
                                  uint16_t sequence_number,
                                  int64_t capture_time_ms,
                                  bool retransmission,
                                  const PacedPacketInfo& cluster_info) = 0;
    // Called when it's a good time to send a padding data.
    // Returns the number of bytes sent.
    virtual size_t TimeToSendPadding(size_t bytes,
                                     const PacedPacketInfo& cluster_info) = 0;

   protected:
    virtual ~PacketSender() {}
  };
  static constexpr int64_t kNoCongestionWindow = -1;

  // Expected max pacer delay in ms. If ExpectedQueueTimeMs() is higher than
  // this value, the packet producers should wait (eg drop frames rather than
  // encoding them). Bitrate sent may temporarily exceed target set by
  // UpdateBitrate() so that this limit will be upheld.
  static const int64_t kMaxQueueLengthMs;
  // Pacing-rate relative to our target send rate.
  // Multiplicative factor that is applied to the target bitrate to calculate
  // the number of bytes that can be transmitted per interval.
  // Increasing this factor will result in lower delays in cases of bitrate
  // overshoots from the encoder.
  static const float kDefaultPaceMultiplier;

  PacedSender(Clock* clock,
              PacketSender* packet_sender,
              RtcEventLog* event_log,
              const WebRtcKeyValueConfig* field_trials = nullptr);

  ~PacedSender() override;

  virtual void CreateProbeCluster(int bitrate_bps, int cluster_id);

  // Temporarily pause all sending.
  // Pause方法用于暂停发送。在暂停状态下，发送速率会被忽略，直接以最大速率发送数据包
  void Pause();

  // Resume sending packets.
  //Resume方法用于恢复发送。在恢复状态下，PacedSender将根据带宽和网络条件自动控制发送速率。
  void Resume();

  void SetCongestionWindow(int64_t congestion_window_bytes);
  void UpdateOutstandingData(int64_t outstanding_bytes);

  // Enable bitrate probing. Enabled by default, mostly here to simplify
  // testing. Must be called before any packets are being sent to have an
  // effect.
  // TODO@chensong 2023-04-29
  // SetProbingEnabled方法设置是否处于探测模式。在探测模式下，发送速率会被忽略，直接以最大速率发送数据包。
  void SetProbingEnabled(bool enabled);

  // Deprecated, SetPacingRates should be used instead.
  void SetEstimatedBitrate(uint32_t bitrate_bps) override;
  // Deprecated, SetPacingRates should be used instead.
  void SetSendBitrateLimits(int min_send_bitrate_bps,
                            int max_padding_bitrate_bps);

  // Sets the pacing rates. Must be called once before packets can be sent.
  void SetPacingRates(uint32_t pacing_rate_bps,
                      uint32_t padding_rate_bps) override;

  // Returns true if we send the packet now, else it will add the packet
  // information to the queue and call TimeToSendPacket when it's time to send.
  // TODO@chensong 2023-04-29 
  // InsertPacket方法用于向发送队列中插入一个待发送的数据包。该方法首先检查当前是否处于探测模式，如果是，则直接将数据包发送出去；否则，将数据包加入发送队列。
  //
  void InsertPacket(RtpPacketSender::Priority priority,
                    uint32_t ssrc,
                    uint16_t sequence_number,
                    int64_t capture_time_ms,
                    size_t bytes,
                    bool retransmission) override;

  // Currently audio traffic is not accounted by pacer and passed through.
  // With the introduction of audio BWE audio traffic will be accounted for
  // the pacer budget calculation. The audio traffic still will be injected
  // at high priority.
  void SetAccountForAudioPackets(bool account_for_audio) override;

  // Returns the time since the oldest queued packet was enqueued.
  virtual int64_t QueueInMs() const;

  virtual size_t QueueSizePackets() const;
  virtual int64_t QueueSizeBytes() const;

  // Returns the time when the first packet was sent, or -1 if no packet is
  // sent.
  virtual int64_t FirstSentPacketTimeMs() const;

  // Returns the number of milliseconds it will take to send the current
  // packets in the queue, given the current size and bitrate, ignoring prio.
  virtual int64_t ExpectedQueueTimeMs() const;

  // Deprecated, alr detection will be moved out of the pacer.
  virtual absl::optional<int64_t> GetApplicationLimitedRegionStartTime();

  // Returns the number of milliseconds until the module want a worker thread
  // to call Process.
  int64_t TimeUntilNextProcess() override;

  // Process any pending packets in the queue(s).
  void Process() override;

  // Called when the prober is associated with a process thread.
  void ProcessThreadAttached(ProcessThread* process_thread) override;
  // Deprecated, SetPacingRates should be used instead.
  void SetPacingFactor(float pacing_factor);
  void SetQueueTimeLimit(int limit_ms);

 private:
  PacedSender(Clock* clock,
              PacketSender* packet_sender,
              RtcEventLog* event_log,
              const WebRtcKeyValueConfig& field_trials);

  int64_t UpdateTimeAndGetElapsedMs(int64_t now_us) RTC_EXCLUSIVE_LOCKS_REQUIRED(critsect_);
  bool ShouldSendKeepalive(int64_t at_time_us) const RTC_EXCLUSIVE_LOCKS_REQUIRED(critsect_);

  // Updates the number of bytes that can be sent for the next time interval.
  void UpdateBudgetWithElapsedTime(int64_t delta_time_in_ms) RTC_EXCLUSIVE_LOCKS_REQUIRED(critsect_);
  void UpdateBudgetWithBytesSent(size_t bytes) RTC_EXCLUSIVE_LOCKS_REQUIRED(critsect_);

  const RoundRobinPacketQueue::Packet* GetPendingPacket(const PacedPacketInfo& pacing_info)
      RTC_EXCLUSIVE_LOCKS_REQUIRED(critsect_);
  void OnPacketSent(const RoundRobinPacketQueue::Packet* packet) RTC_EXCLUSIVE_LOCKS_REQUIRED(critsect_);
  void OnPaddingSent(size_t padding_sent) RTC_EXCLUSIVE_LOCKS_REQUIRED(critsect_);

  bool Congested() const RTC_EXCLUSIVE_LOCKS_REQUIRED(critsect_);
  int64_t TimeMilliseconds() const RTC_EXCLUSIVE_LOCKS_REQUIRED(critsect_);

  Clock* const clock_;
  PacketSender* const packet_sender_;
  std::unique_ptr<AlrDetector> alr_detector_ RTC_PT_GUARDED_BY(critsect_);

  const bool drain_large_queues_;
  const bool send_padding_if_silent_;
  const bool pace_audio_;
  FieldTrialParameter<int> min_packet_limit_ms_;

  rtc::CriticalSection critsect_;
  // TODO(webrtc:9716): Remove this when we are certain clocks are monotonic.
  // The last millisecond timestamp returned by |clock_|.
  mutable int64_t last_timestamp_ms_ RTC_GUARDED_BY(critsect_);
  bool paused_ RTC_GUARDED_BY(critsect_);
  // This is the media budget, keeping track of how many bits of media
  // we can pace out during the current interval.
  IntervalBudget media_budget_ RTC_GUARDED_BY(critsect_);
  // This is the padding budget, keeping track of how many bits of padding we're
  // allowed to send out during the current interval. This budget will be
  // utilized when there's no media to send.
  IntervalBudget padding_budget_ RTC_GUARDED_BY(critsect_);

  BitrateProber prober_ RTC_GUARDED_BY(critsect_);
  bool probing_send_failure_ RTC_GUARDED_BY(critsect_);
  // Actual configured bitrates (media_budget_ may temporarily be higher in
  // order to meet pace time constraint).
  uint32_t estimated_bitrate_bps_ RTC_GUARDED_BY(critsect_);
  uint32_t min_send_bitrate_kbps_ RTC_GUARDED_BY(critsect_);
  uint32_t max_padding_bitrate_kbps_ RTC_GUARDED_BY(critsect_);
  uint32_t pacing_bitrate_kbps_ RTC_GUARDED_BY(critsect_);

  int64_t time_last_process_us_ RTC_GUARDED_BY(critsect_);
  int64_t last_send_time_us_ RTC_GUARDED_BY(critsect_);
  int64_t first_sent_packet_ms_ RTC_GUARDED_BY(critsect_);

  RoundRobinPacketQueue packets_ RTC_GUARDED_BY(critsect_);
  uint64_t packet_counter_ RTC_GUARDED_BY(critsect_);

  int64_t congestion_window_bytes_ RTC_GUARDED_BY(critsect_) =
      kNoCongestionWindow;
  int64_t outstanding_bytes_ RTC_GUARDED_BY(critsect_) = 0;
  float pacing_factor_ RTC_GUARDED_BY(critsect_);
  // Lock to avoid race when attaching process thread. This can happen due to
  // the Call class setting network state on SendSideCongestionController, which
  // in turn calls Pause/Resume on Pacedsender, before actually starting the
  // pacer process thread. If SendSideCongestionController is running on a task
  // queue separate from the thread used by Call, this causes a race.
  rtc::CriticalSection process_thread_lock_;
  ProcessThread* process_thread_ RTC_GUARDED_BY(process_thread_lock_) = nullptr;

  int64_t queue_time_limit RTC_GUARDED_BY(critsect_);
  bool account_for_audio_ RTC_GUARDED_BY(critsect_);
};
}  // namespace webrtc
#endif  // MODULES_PACING_PACED_SENDER_H_
