/*
 *  Copyright (c) 2013 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef VIDEO_VIDEO_RECEIVE_STREAM_H_
#define VIDEO_VIDEO_RECEIVE_STREAM_H_

#include <memory>
#include <vector>

#include "api/media_transport_interface.h"
#include "api/task_queue/task_queue_factory.h"
#include "call/rtp_packet_sink_interface.h"
#include "call/syncable.h"
#include "call/video_receive_stream.h"
#include "modules/rtp_rtcp/include/flexfec_receiver.h"
#include "modules/video_coding/frame_buffer2.h"
#include "modules/video_coding/video_coding_impl.h"
#include "rtc_base/synchronization/sequence_checker.h"
#include "rtc_base/task_queue.h"
#include "system_wrappers/include/clock.h"
#include "video/receive_statistics_proxy.h"
#include "video/rtp_streams_synchronizer.h"
#include "video/rtp_video_stream_receiver.h"
#include "video/transport_adapter.h"
#include "video/video_stream_decoder.h"

namespace webrtc {

class CallStats;
class ProcessThread;
class RTPFragmentationHeader;
class RtpStreamReceiverInterface;
class RtpStreamReceiverControllerInterface;
class RtxReceiveStream;
class VCMTiming;
class VCMJitterEstimator;

namespace internal {

class VideoReceiveStream : public webrtc::VideoReceiveStream,
                           public rtc::VideoSinkInterface<VideoFrame>,
                           public NackSender,
                           public KeyFrameRequestSender,
                           public video_coding::OnCompleteFrameCallback,
                           public Syncable,
                           public CallStatsObserver,
                           public MediaTransportVideoSinkInterface,
                           public MediaTransportRttObserver {
 public:
  VideoReceiveStream(TaskQueueFactory* task_queue_factory,
                     RtpStreamReceiverControllerInterface* receiver_controller,
                     int num_cpu_cores,
                     PacketRouter* packet_router,
                     VideoReceiveStream::Config config,
                     ProcessThread* process_thread,
                     CallStats* call_stats,
                     Clock* clock,
                     VCMTiming* timing);
  VideoReceiveStream(TaskQueueFactory* task_queue_factory,
                     RtpStreamReceiverControllerInterface* receiver_controller,
                     int num_cpu_cores,
                     PacketRouter* packet_router,
                     VideoReceiveStream::Config config,
                     ProcessThread* process_thread,
                     CallStats* call_stats,
                     Clock* clock);
  ~VideoReceiveStream() override;

  const Config& config() const { return config_; }

  void SignalNetworkState(NetworkState state);
  bool DeliverRtcp(const uint8_t* packet, size_t length);

  void SetSync(Syncable* audio_syncable);

  // Implements webrtc::VideoReceiveStream.
  void Start() override;
  void Stop() override;

  webrtc::VideoReceiveStream::Stats GetStats() const override;

  void AddSecondarySink(RtpPacketSinkInterface* sink) override;
  void RemoveSecondarySink(const RtpPacketSinkInterface* sink) override;

  // SetBaseMinimumPlayoutDelayMs and GetBaseMinimumPlayoutDelayMs are called
  // from webrtc/api level and requested by user code. For e.g. blink/js layer
  // in Chromium.
  bool SetBaseMinimumPlayoutDelayMs(int delay_ms) override;
  int GetBaseMinimumPlayoutDelayMs() const override;

  void SetFrameDecryptor(
      rtc::scoped_refptr<FrameDecryptorInterface> frame_decryptor) override;

  // Implements rtc::VideoSinkInterface<VideoFrame>.
  void OnFrame(const VideoFrame& video_frame) override;

  // Implements NackSender.
  void SendNack(const std::vector<uint16_t>& sequence_numbers) override;

  // Implements KeyFrameRequestSender.
  void RequestKeyFrame() override;

  // Implements video_coding::OnCompleteFrameCallback.
  void OnCompleteFrame(
      std::unique_ptr<video_coding::EncodedFrame> frame) override;

  // Implements MediaTransportVideoSinkInterface, converts the received frame to
  // OnCompleteFrameCallback
  void OnData(uint64_t channel_id,
              MediaTransportEncodedVideoFrame frame) override;

  // Implements CallStatsObserver::OnRttUpdate
  void OnRttUpdate(int64_t avg_rtt_ms, int64_t max_rtt_ms) override;

  // Implements MediaTransportRttObserver::OnRttUpdated
  void OnRttUpdated(int64_t rtt_ms) override;

  // Implements Syncable.
  int id() const override;
  absl::optional<Syncable::Info> GetInfo() const override;
  uint32_t GetPlayoutTimestamp() const override;

  // SetMinimumPlayoutDelay is only called by A/V sync.
  void SetMinimumPlayoutDelay(int delay_ms) override;

  std::vector<webrtc::RtpSource> GetSources() const override;

 private:
  int64_t GetWaitMs() const;
  void StartNextDecode() RTC_RUN_ON(decode_queue_);
  static void DecodeThreadFunction(void* ptr);
  bool Decode();
  void HandleEncodedFrame(std::unique_ptr<video_coding::EncodedFrame> frame);
  void HandleFrameBufferTimeout();

  void UpdatePlayoutDelays() const
      RTC_EXCLUSIVE_LOCKS_REQUIRED(playout_delay_lock_);

  SequenceChecker worker_sequence_checker_;
  SequenceChecker module_process_sequence_checker_;
  SequenceChecker network_sequence_checker_;

  TaskQueueFactory* const task_queue_factory_;

  TransportAdapter transport_adapter_;
  const VideoReceiveStream::Config config_;
  const int num_cpu_cores_;
  ProcessThread* const process_thread_;
  Clock* const clock_;

  const bool use_task_queue_;

  rtc::PlatformThread decode_thread_;

  CallStats* const call_stats_;

  bool decoder_running_ RTC_GUARDED_BY(worker_sequence_checker_) = false;
  bool decoder_stopped_ RTC_GUARDED_BY(decode_queue_) = true;

  ReceiveStatisticsProxy stats_proxy_;
  // Shared by media and rtx stream receivers, since the latter has no RtpRtcp
  // module of its own.
  const std::unique_ptr<ReceiveStatistics> rtp_receive_statistics_;

  std::unique_ptr<VCMTiming> timing_;  // Jitter buffer experiment.
  vcm::VideoReceiver video_receiver_;
  std::unique_ptr<rtc::VideoSinkInterface<VideoFrame>> incoming_video_stream_;
  RtpVideoStreamReceiver rtp_video_stream_receiver_; // --> nack_module --> init 
  std::unique_ptr<VideoStreamDecoder> video_stream_decoder_;
  RtpStreamsSynchronizer rtp_stream_sync_;

  // TODO(nisse, philipel): Creation and ownership of video encoders should be
  // moved to the new VideoStreamDecoder.
  std::vector<std::unique_ptr<VideoDecoder>> video_decoders_;

  // Members for the new jitter buffer experiment.
  std::unique_ptr<VCMJitterEstimator> jitter_estimator_;
  std::unique_ptr<video_coding::FrameBuffer> frame_buffer_;

  std::unique_ptr<RtpStreamReceiverInterface> media_receiver_;
  std::unique_ptr<RtxReceiveStream> rtx_receive_stream_;
  std::unique_ptr<RtpStreamReceiverInterface> rtx_receiver_;

  // Whenever we are in an undecodable state (stream has just started or due to
  // a decoding error) we require a keyframe to restart the stream.
  bool keyframe_required_ = true;

  // If we have successfully decoded any frame.
  bool frame_decoded_ = false;

  int64_t last_keyframe_request_ms_ = 0;
  int64_t last_complete_frame_time_ms_ = 0;

  // Keyframe request intervals are configurable through field trials.
  const int max_wait_for_keyframe_ms_;
  const int max_wait_for_frame_ms_;

  rtc::CriticalSection playout_delay_lock_;

  // All of them tries to change current min_playout_delay on |timing_| but
  // source of the change request is different in each case. Among them the
  // biggest delay is used. -1 means use default value from the |timing_|.
  //
  // Minimum delay as decided by the RTP playout delay extension.
  int frame_minimum_playout_delay_ms_ RTC_GUARDED_BY(playout_delay_lock_) = -1;
  // Minimum delay as decided by the setLatency function in "webrtc/api".
  int base_minimum_playout_delay_ms_ RTC_GUARDED_BY(playout_delay_lock_) = -1;
  // Minimum delay as decided by the A/V synchronization feature.
  int syncable_minimum_playout_delay_ms_ RTC_GUARDED_BY(playout_delay_lock_) =
      -1;

  // Maximum delay as decided by the RTP playout delay extension.
  int frame_maximum_playout_delay_ms_ RTC_GUARDED_BY(playout_delay_lock_) = -1;

  // Defined last so they are destroyed before all other members.
  rtc::TaskQueue decode_queue_;
};
}  // namespace internal
}  // namespace webrtc

#endif  // VIDEO_VIDEO_RECEIVE_STREAM_H_
