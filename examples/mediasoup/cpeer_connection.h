#ifndef _C_PEER_CONNECTION_H_
#define _C_PEER_CONNECTION_H_
#include "api/media_stream_interface.h"
#include "api/peer_connection_interface.h"
namespace chen {
	class cpeer_connection : public webrtc::PeerConnectionObserver,
		public webrtc::CreateSessionDescriptionObserver 
	{
	public:
		cpeer_connection();
		virtual ~cpeer_connection();


	public :
		bool init();
	public:
		 // PeerConnectionObserver impli
			// Triggered when the SignalingState changed.
		virtual void OnSignalingChange(webrtc::PeerConnectionInterface::SignalingState new_state);

			// Triggered when media is received on a new stream from remote peer.
		virtual void OnAddStream(rtc::scoped_refptr<webrtc::MediaStreamInterface> stream);

			// Triggered when a remote peer closes a stream.
		virtual void OnRemoveStream(rtc::scoped_refptr<webrtc::MediaStreamInterface> stream);

			// Triggered when a remote peer opens a data channel.
		virtual void OnDataChannel(rtc::scoped_refptr<webrtc::DataChannelInterface> data_channel);

			// Triggered when renegotiation is needed. For example, an ICE restart
			// has begun.
		virtual void OnRenegotiationNeeded();

			// Called any time the legacy IceConnectionState changes.
			//
			// Note that our ICE states lag behind the standard slightly. The most
			// notable differences include the fact that "failed" occurs after 15
			// seconds, not 30, and this actually represents a combination ICE + DTLS
			// state, so it may be "failed" if DTLS fails while ICE succeeds.
			//
			// TODO(jonasolsson): deprecate and remove this.
			virtual void OnIceConnectionChange(webrtc::PeerConnectionInterface::IceConnectionState new_state);

			// Called any time the standards-compliant IceConnectionState changes.
			virtual void OnStandardizedIceConnectionChange(
				webrtc::PeerConnectionInterface::IceConnectionState new_state);

			// Called any time the PeerConnectionState changes.
			virtual void OnConnectionChange(webrtc::PeerConnectionInterface::PeerConnectionState new_state);

			// Called any time the IceGatheringState changes.
			virtual void OnIceGatheringChange(webrtc::PeerConnectionInterface::IceGatheringState new_state);

			// A new ICE candidate has been gathered.
			virtual void OnIceCandidate(const webrtc::IceCandidateInterface* candidate);

			// Ice candidates have been removed.
			// TODO(honghaiz): Make this a pure virtual method when all its subclasses
			// implement it.
			virtual void OnIceCandidatesRemoved(const std::vector<cricket::Candidate>& candidates);

			// Called when the ICE connection receiving status changes.
			virtual void OnIceConnectionReceivingChange(bool receiving);

			// This is called when a receiver and its track are created.
			// TODO(zhihuang): Make this pure virtual when all subclasses implement it.
			// Note: This is called with both Plan B and Unified Plan semantics. Unified
			// Plan users should prefer OnTrack, OnAddTrack is only called as backwards
			// compatibility (and is called in the exact same situations as OnTrack).
			virtual void OnAddTrack(rtc::scoped_refptr<webrtc::RtpReceiverInterface> receiver,
				const std::vector<rtc::scoped_refptr<webrtc::MediaStreamInterface>>& streams);

		
			virtual void OnTrack(
				rtc::scoped_refptr<webrtc::RtpTransceiverInterface> transceiver);

			virtual void OnRemoveTrack(
				rtc::scoped_refptr<webrtc::RtpReceiverInterface> receiver);

			// Called when an interesting usage is detected by WebRTC.
			// An appropriate action is to add information about the context of the
			// PeerConnection and write the event to some kind of "interesting events"
			// log function.
			// The heuristics for defining what constitutes "interesting" are
			// implementation-defined.
			virtual void OnInterestingUsage(int usage_pattern);
		 public:
			 //CreateSessionDescriptionObserver
			 virtual void OnSuccess(webrtc::SessionDescriptionInterface* desc) ;
			
			 virtual void OnFailure(webrtc::RTCError error);
			 virtual void OnFailure(const std::string& error);
	private:
		// not copy 
	private:
		std::unique_ptr<rtc::Thread>									m_net_thread;
		std::unique_ptr<rtc::Thread>									m_work_thread;
		std::unique_ptr<rtc::Thread>									m_signal_thread;
		rtc::scoped_refptr<webrtc::PeerConnectionFactoryInterface>		m_peer_connection_factory;
		rtc::scoped_refptr<webrtc::PeerConnectionInterface>				m_peer_connection;
		
	};
}

#endif // _C_PEER_CONNECTION_H_
