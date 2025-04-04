/*
 *  Copyright 2012 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef EXAMPLES_PEERCONNECTION_DESKTOP_CONDUCTOR_H_
#define EXAMPLES_PEERCONNECTION_DESKTOP_CONDUCTOR_H_

#include <deque>
#include <map>
#include <memory>
#include <string>
#include <vector>
#include <thread>
#include <chrono>

#include "api/media_stream_interface.h"
#include "api/peer_connection_interface.h"
#include "examples/peerconnection/desktop/main_wnd.h"
#include "examples/peerconnection/desktop/peer_connection_client.h"
#include "pc/rtp_sender.h"
namespace webrtc {
class VideoCaptureModule;
}  // namespace webrtc

namespace cricket {
class VideoRenderer;
}  // namespace cricket

class crtc_static_observer {
 public:
  virtual void OnGetStats() = 0;
};

class crtc_static : public webrtc::RTCStatsCollectorCallback {
 public:
  void RegisterObserver(crtc_static_observer* o) { observer_ = o; }
  // crtc_static(PeerConnectionClientObserver o) : observer_ (o){}
  ~crtc_static() override = default;
  virtual void OnStatsDelivered(
      const rtc::scoped_refptr<const webrtc::RTCStatsReport>& report) override {
   /* RTC_LOG(LS_INFO) << __FUNCTION__
                     << "rtc stats repost = " << report->ToJson();*/
    std::thread([=](){
      std::this_thread::sleep_for(std::chrono::seconds(2));
      if (observer_) {
        observer_->OnGetStats();
      }
	}).detach();
  }
  crtc_static_observer* observer_{nullptr};
};
class Conductor
    : public webrtc::PeerConnectionObserver /*好玩东西给webrtc封装这个里面   */,
      public webrtc::CreateSessionDescriptionObserver,
      public PeerConnectionClientObserver,
      public crtc_static_observer,
      public MainWndCallback {
 public:
  enum CallbackID {
    MEDIA_CHANNELS_INITIALIZED = 1,
    PEER_CONNECTION_CLOSED,
    SEND_MESSAGE_TO_PEER,
    NEW_TRACK_ADDED,
    TRACK_REMOVED,
  };

  Conductor(PeerConnectionClient* client, MainWindow* main_wnd);

  bool connection_active() const;

  void Close() override;

 protected:
  ~Conductor();
  bool InitializePeerConnection();
  bool ReinitializePeerConnectionForLoopback();
  bool CreatePeerConnection(bool dtls);
  void DeletePeerConnection();
  void EnsureStreamingUI();
  void AddTracks();

  //
  // PeerConnectionObserver implementation.
  //

  void OnSignalingChange(
      webrtc::PeerConnectionInterface::SignalingState new_state) override {}

  // 好家伙  webrtc封装太好 ^_^  接口定义 PeerConnectionObserver
  void OnAddTrack(
      rtc::scoped_refptr<webrtc::RtpReceiverInterface> receiver,
      const std::vector<rtc::scoped_refptr<webrtc::MediaStreamInterface>>&
          streams) override;
  void OnRemoveTrack(
      rtc::scoped_refptr<webrtc::RtpReceiverInterface> receiver) override;
  void OnDataChannel(
      rtc::scoped_refptr<webrtc::DataChannelInterface> channel) override {}
  void OnRenegotiationNeeded() override {}
  void OnIceConnectionChange(
      webrtc::PeerConnectionInterface::IceConnectionState new_state) override {}
  void OnIceGatheringChange(
      webrtc::PeerConnectionInterface::IceGatheringState new_state) override {}
  void OnIceCandidate(const webrtc::IceCandidateInterface* candidate) override;
  void OnIceConnectionReceivingChange(bool receiving) override {}

  //
  // PeerConnectionClientObserver implementation.
  //

  void OnSignedIn() override;

  void OnDisconnected() override;

  void OnPeerConnected(int id, const std::string& name) override;

  void OnPeerDisconnected(int id) override;

  void OnMessageFromPeer(int peer_id, const std::string& message) override;

  void OnMessageSent(int err) override;

  void OnServerConnectionFailure() override;

  void OnGetStats() override;
  //
  // MainWndCallback implementation.
  //

  void StartLogin(const std::string& server,
                  int port,
                  const std::string& turn_url,
                  const std::string& user_name,
                  const std::string& pass_word) override;

  void DisconnectFromServer() override;

  void ConnectToPeer(int peer_id) override;

  void DisconnectFromCurrentPeer() override;

  void UIThreadCallback(int msg_id, void* data) override;

  // CreateSessionDescriptionObserver implementation.
  void OnSuccess(webrtc::SessionDescriptionInterface* desc) override;
  void OnFailure(webrtc::RTCError error) override;

  // static data
  /* void OnStatsDelivered(
     const rtc::scoped_refptr<const webrtc::RTCStatsReport>& report) override;*/
 protected:
  // Send a message to the remote peer.
  void SendMessage(const std::string& json_object);

  int peer_id_;
  bool loopback_;
  rtc::scoped_refptr<webrtc::PeerConnectionInterface> peer_connection_;
  rtc::scoped_refptr<webrtc::PeerConnectionFactoryInterface>
      peer_connection_factory_;
  PeerConnectionClient* client_;
  MainWindow* main_wnd_;
  std::deque<std::string*> pending_messages_;
  std::string server_;
  std::string turn_url_;
  std::string user_name_;
  std::string pass_word_;
  rtc::scoped_refptr<crtc_static> rtc_static_;
  rtc::scoped_refptr<webrtc::VideoTrackInterface> video_track_proxy_ptr_;

  //rtc::scoped_refptr<
  //    webrtc::RtpSenderProxyWithInternal<webrtc::RtpSenderInternal>>
  //    rtp_sender_ptr_;

  rtc::scoped_refptr<webrtc::RtpSenderInterface>
      rtp_sender_ptr_;
};

#endif  // EXAMPLES_PEERCONNECTION_DESKTOP_CONDUCTOR_H_
