/*
 *  Copyright (c) 2012 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_RTP_RTCP_SOURCE_RTP_SENDER_VIDEO_H_
#define MODULES_RTP_RTCP_SOURCE_RTP_SENDER_VIDEO_H_

#include <map>
#include <memory>
#include <vector>

#include "absl/strings/string_view.h"
#include "absl/types/optional.h"
#include "api/array_view.h"
#include "modules/rtp_rtcp/include/flexfec_sender.h"
#include "modules/rtp_rtcp/include/rtp_rtcp_defines.h"
#include "modules/rtp_rtcp/source/playout_delay_oracle.h"
#include "modules/rtp_rtcp/source/rtp_rtcp_config.h"
#include "modules/rtp_rtcp/source/rtp_sender.h"
#include "modules/rtp_rtcp/source/rtp_sequence_number_map.h"
#include "modules/rtp_rtcp/source/ulpfec_generator.h"
#include "rtc_base/critical_section.h"
#include "rtc_base/one_time_event.h"
#include "rtc_base/rate_statistics.h"
#include "rtc_base/synchronization/sequence_checker.h"
#include "rtc_base/thread_annotations.h"

namespace webrtc {

class FrameEncryptorInterface;
class RtpPacketizer;
class RtpPacketToSend;

// kConditionallyRetransmitHigherLayers allows retransmission of video frames
// in higher layers if either the last frame in that layer was too far back in
// time, or if we estimate that a new frame will be available in a lower layer
// in a shorter time than it would take to request and receive a retransmission.
enum RetransmissionMode : uint8_t {
  kRetransmitOff = 0x0,
  kRetransmitBaseLayer = 0x2,
  kRetransmitHigherLayers = 0x4,
  kConditionallyRetransmitHigherLayers = 0x8,
};

class RTPSenderVideo {
 public:
  static constexpr int64_t kTLRateWindowSizeMs = 2500;

  RTPSenderVideo(Clock* clock,
                 RTPSender* rtpSender,
                 FlexfecSender* flexfec_sender,
                 PlayoutDelayOracle* playout_delay_oracle,
                 FrameEncryptorInterface* frame_encryptor,
                 bool require_frame_encryption,
                 const WebRtcKeyValueConfig& field_trials);
  virtual ~RTPSenderVideo();

  bool SendVideo(VideoFrameType frame_type,
                 int8_t payload_type,
                 uint32_t capture_timestamp,
                 int64_t capture_time_ms,
                 const uint8_t* payload_data,
                 size_t payload_size,
                 const RTPFragmentationHeader* fragmentation,
                 const RTPVideoHeader* video_header,
                 int64_t expected_retransmission_time_ms);

  void RegisterPayloadType(int8_t payload_type, absl::string_view payload_name);

  // Set RED and ULPFEC payload types. A payload type of -1 means that the
  // corresponding feature is turned off. Note that we DO NOT support enabling
  // ULPFEC without enabling RED, and RED is only ever used when ULPFEC is
  // enabled.
  void SetUlpfecConfig(int red_payload_type, int ulpfec_payload_type);

  // FlexFEC/ULPFEC.
  // Set FEC rates, max frames before FEC is sent, and type of FEC masks.
  // Returns false on failure.
  void SetFecParameters(const FecProtectionParams& delta_params,
                        const FecProtectionParams& key_params);

  // FlexFEC.
  absl::optional<uint32_t> FlexfecSsrc() const;

  uint32_t VideoBitrateSent() const;
  uint32_t FecOverheadRate() const;

  // Returns the current packetization overhead rate, in bps. Note that this is
  // the payload overhead, eg the VP8 payload headers, not the RTP headers
  // or extension/
  uint32_t PacketizationOverheadBps() const;

  // For each sequence number in |sequence_number|, recall the last RTP packet
  // which bore it - its timestamp and whether it was the first and/or last
  // packet in that frame. If all of the given sequence numbers could be
  // recalled, return a vector with all of them (in corresponding order).
  // If any could not be recalled, return an empty vector.
  std::vector<RtpSequenceNumberMap::Info> GetSentRtpPacketInfos(
      rtc::ArrayView<const uint16_t> sequence_numbers) const;

 protected:
  static uint8_t GetTemporalId(const RTPVideoHeader& header);
  StorageType GetStorageType(uint8_t temporal_id,
                             int32_t retransmission_settings,
                             int64_t expected_retransmission_time_ms);

 private:
  struct TemporalLayerStats {
    TemporalLayerStats()
        : frame_rate_fp1000s(kTLRateWindowSizeMs, 1000 * 1000),
          last_frame_time_ms(0) {}
    // Frame rate, in frames per 1000 seconds. This essentially turns the fps
    // value into a fixed point value with three decimals. Improves precision at
    // low frame rates.
    RateStatistics frame_rate_fp1000s;
    int64_t last_frame_time_ms;
  };

  size_t CalculateFecPacketOverhead() const RTC_EXCLUSIVE_LOCKS_REQUIRED(crit_);

  void SendVideoPacket(std::unique_ptr<RtpPacketToSend> packet,
                       StorageType storage);

  void SendVideoPacketAsRedMaybeWithUlpfec(
      std::unique_ptr<RtpPacketToSend> media_packet,
      StorageType media_packet_storage,
      bool protect_media_packet);

  // TODO(brandtr): Remove the FlexFEC functions when FlexfecSender has been
  // moved to PacedSender.
  void SendVideoPacketWithFlexfec(std::unique_ptr<RtpPacketToSend> media_packet,
                                  StorageType media_packet_storage,
                                  bool protect_media_packet);

  bool LogAndSendToNetwork(std::unique_ptr<RtpPacketToSend> packet,
                           StorageType storage,
                           RtpPacketSender::Priority priority);

  bool red_enabled() const RTC_EXCLUSIVE_LOCKS_REQUIRED(crit_) {
    return red_payload_type_ >= 0;
  }

  bool ulpfec_enabled() const RTC_EXCLUSIVE_LOCKS_REQUIRED(crit_) {
    return ulpfec_payload_type_ >= 0;
  }

  bool flexfec_enabled() const { return flexfec_sender_ != nullptr; }

  bool UpdateConditionalRetransmit(uint8_t temporal_id,
                                   int64_t expected_retransmission_time_ms)
      RTC_EXCLUSIVE_LOCKS_REQUIRED(stats_crit_);

  RTPSender* const rtp_sender_;
  Clock* const clock_;

  // Maps payload type to codec type, for packetization.
  // TODO(nisse): Set on construction, to avoid lock.
  rtc::CriticalSection payload_type_crit_;
  std::map<int8_t, VideoCodecType> payload_type_map_
      RTC_GUARDED_BY(payload_type_crit_);

  // Should never be held when calling out of this class.
  rtc::CriticalSection crit_;

  int32_t retransmission_settings_ RTC_GUARDED_BY(crit_);
  VideoRotation last_rotation_ RTC_GUARDED_BY(crit_);
  absl::optional<ColorSpace> last_color_space_ RTC_GUARDED_BY(crit_);
  bool transmit_color_space_next_frame_ RTC_GUARDED_BY(crit_);
  // Tracks the current request for playout delay limits from application
  // and decides whether the current RTP frame should include the playout
  // delay extension on header.
  PlayoutDelayOracle* const playout_delay_oracle_;

  // Maps sent packets' sequence numbers to a tuple consisting of:
  // 1. The timestamp, without the randomizing offset mandated by the RFC.
  // 2. Whether the packet was the first in its frame.
  // 3. Whether the packet was the last in its frame.
  const std::unique_ptr<RtpSequenceNumberMap> rtp_sequence_number_map_
      RTC_PT_GUARDED_BY(crit_);


  ///////////////////////////////////////////////////////////////////////
  //    TODO@chensong 2022-07-24  RTC 中FEC中前向纠错，  
  //    ULPFEC(Uneven Level Protection FEC  直译为非均等保护前向纠错）
  // RED/ULPFEC.
  int red_payload_type_ RTC_GUARDED_BY(crit_);
  int ulpfec_payload_type_ RTC_GUARDED_BY(crit_);
  /*20250324 关键帧 XOR */
  UlpfecGenerator ulpfec_generator_ RTC_GUARDED_BY(crit_);

  //RTC 对抗网络丢包:
  //     1. 丢包重传(NACK)
  //     2. 前向纠错(FEC)
  ///////////////////////////////////////////////////////////////
    

  // FlexFEC.
  /*
  ‌一、协议标准与编码方式‌

技术	协议/草案	编码方式	冗余生成策略
‌ULPFEC‌	RFC5109	XOR（异或）	针对关键帧生成冗余包，抗离散丢包能力有限 ‌34
‌FlexFEC‌	IETF 草案（未最终定稿）	Reed-Solomon 等	支持更大冗余块，可恢复连续丢包 ‌58
‌X-ULPFECUC‌	无明确公开标准	未明确（推测类似ULPFEC）	可能是定制扩展，具体实现未公开（无搜索结果支持）
‌RED‌	RFC2198	无独立编码	直接复制旧包到新包，仅冗余封装 ‌45

‌二、冗余能力与恢复效果‌

‌ULPFEC‌

‌优势‌：计算效率高，适合实时场景（如 WebRTC 视频通话）‌38。
‌限制‌：仅能恢复单个丢包或少量离散丢包，冗余比例固定 ‌

‌FlexFEC‌

‌优势‌：支持动态冗余块数量，恢复连续丢包能力更强（如 30% 连续丢包）‌58。
‌限制‌：计算复杂度较高，需额外带宽开销 ‌58。

‌X-ULPFECUC‌

‌推测‌：可能针对特定场景优化（如超低延迟），但无公开技术细节支持。
‌RED‌

‌劣势‌：冗余数据直接复制旧包，带宽占用高，恢复能力弱（仅恢复单包丢失）‌46。

‌三、封装方式与依赖关系‌

技术	封装依赖	数据独立性
‌ULPFEC‌	需依赖 RED 格式封装	冗余包与原始包分离，通过 RED 协议打包 ‌48
‌FlexFEC‌	独立封装	不依赖 RED，直接生成独立冗余包 ‌58
‌RED‌	自封装	冗余包直接嵌入原始包中，无独立编解码 ‌58

‌四、应用场景‌

‌ULPFEC‌：

‌适用场景‌：WebRTC 视频通话中保护关键帧（如 SVC 时域层 Level 0），丢包时降帧率保流畅 ‌48。
‌典型用例‌：实时会议、在线教育 ‌34。
‌FlexFEC‌：

‌适用场景‌：高丢包网络（如移动蜂窝网络），需恢复连续丢包的关键数据 ‌58。
‌典型用例‌：云游戏、4K 直播 ‌58。
‌RED‌：

‌历史场景‌：早期传真（T38）、收号（RFC2833），音视频领域已逐步淘汰 ‌68。

‌五、WebRTC 中的实现差异‌

‌ULPFEC‌：

仅对 SVC 编码的时域基础层生成冗余包，丢包时逐步降帧率 ‌48。
与 RED 配合使用，冗余包通过 RFC2198 格式封装 ‌8。
‌FlexFEC‌：

独立于 RED，支持更灵活的冗余策略（如跨帧冗余）‌58。
目前处于草案阶段，WebRTC 中尚未完全标准化 ‌58。
‌RED‌：

WebRTC 中仅用于封装 ULPFEC 冗余包，不直接参与编解码 ‌48。
‌总结‌
‌抗丢包能力‌：FlexFEC > ULPFEC > RED ‌58。
‌带宽效率‌：ULPFEC（动态调整） > FlexFEC（高冗余） > RED（固定复制）‌45。
‌适用性‌：实时交互场景优选 ULPFEC；高丢包网络可尝试 FlexFEC；RED 已逐渐被替代
  */
  FlexfecSender* const flexfec_sender_; // 支持更大冗余块，可恢复连续丢包

  // FEC parameters, applicable to either ULPFEC or FlexFEC.
  FecProtectionParams delta_fec_params_ RTC_GUARDED_BY(crit_);
  FecProtectionParams key_fec_params_ RTC_GUARDED_BY(crit_);

  rtc::CriticalSection stats_crit_;
  // Bitrate used for FEC payload, RED headers, RTP headers for FEC packets
  // and any padding overhead.
  RateStatistics fec_bitrate_ RTC_GUARDED_BY(stats_crit_);
  // Bitrate used for video payload and RTP headers.
  RateStatistics video_bitrate_ RTC_GUARDED_BY(stats_crit_);
  RateStatistics packetization_overhead_bitrate_ RTC_GUARDED_BY(stats_crit_);

  std::map<int, TemporalLayerStats> frame_stats_by_temporal_layer_
      RTC_GUARDED_BY(stats_crit_);

  OneTimeEvent first_frame_sent_;

  // E2EE Custom Video Frame Encryptor (optional)
  FrameEncryptorInterface* const frame_encryptor_ = nullptr;
  // If set to true will require all outgoing frames to pass through an
  // initialized frame_encryptor_ before being sent out of the network.
  // Otherwise these payloads will be dropped.
  bool require_frame_encryption_;
  // Set to true if the generic descriptor should be authenticated.
  const bool generic_descriptor_auth_experiment_;
};

}  // namespace webrtc

#endif  // MODULES_RTP_RTCP_SOURCE_RTP_SENDER_VIDEO_H_
