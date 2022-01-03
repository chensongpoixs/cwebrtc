#include "cpeer_connection.h"
#include "api/create_peerconnection_factory.h"
#include "api/video_codecs/builtin_video_decoder_factory.h"
#include "api/video_codecs/builtin_video_encoder_factory.h"
#include "api/audio_codecs/builtin_audio_encoder_factory.h"
#include "api/audio_codecs/builtin_audio_decoder_factory.h"
#include "cmediasoup_sdp.h"
#include "rtc_base/thread.h"
namespace chen {
	cpeer_connection::cpeer_connection()
	{

	}
	 cpeer_connection::~cpeer_connection()
	{

	}
 
	 
	void cpeer_connection::OnSignalingChange(webrtc::PeerConnectionInterface::SignalingState new_state)
	{

	}

	 
	void cpeer_connection::OnAddStream(rtc::scoped_refptr<webrtc::MediaStreamInterface> stream)
	{}

 
	void cpeer_connection::OnRemoveStream(rtc::scoped_refptr<webrtc::MediaStreamInterface> stream)
	{}

	 
	void cpeer_connection::OnDataChannel(rtc::scoped_refptr<webrtc::DataChannelInterface> data_channel)
	{}

	 
	void cpeer_connection::OnRenegotiationNeeded()
	{}

 
	void cpeer_connection::OnIceConnectionChange(webrtc::PeerConnectionInterface::IceConnectionState new_state)
	{}

 
	void cpeer_connection::OnStandardizedIceConnectionChange(webrtc::PeerConnectionInterface::IceConnectionState new_state)
	{}

// Called any time the PeerConnectionState changes.
	void cpeer_connection::OnConnectionChange(webrtc::PeerConnectionInterface::PeerConnectionState new_state)
	{}

// Called any time the IceGatheringState changes.
	void cpeer_connection::OnIceGatheringChange(webrtc::PeerConnectionInterface::IceGatheringState new_state)
	{}

// A new ICE candidate has been gathered.
	void cpeer_connection::OnIceCandidate(const webrtc::IceCandidateInterface* candidate)
	{}

	 
	void cpeer_connection::OnIceCandidatesRemoved(const std::vector<cricket::Candidate>& candidates)
	{}

// Called when the ICE connection receiving status changes.
	void cpeer_connection::OnIceConnectionReceivingChange(bool receiving)
	{}

	 
	void cpeer_connection::OnAddTrack(rtc::scoped_refptr<webrtc::RtpReceiverInterface> receiver,
		const std::vector<rtc::scoped_refptr<webrtc::MediaStreamInterface>>& streams)
	{}


	void cpeer_connection::OnTrack(rtc::scoped_refptr<webrtc::RtpTransceiverInterface> transceiver)
	{}

	void cpeer_connection::OnRemoveTrack(rtc::scoped_refptr<webrtc::RtpReceiverInterface> receiver)
	{}

	 
	void cpeer_connection::OnInterestingUsage(int usage_pattern)
	{}
 

	void cpeer_connection::OnSuccess(webrtc::SessionDescriptionInterface* desc)
	{
		// 分创建offer sdp
		/*std::string dec;
		desc->ToString(&dec);*/

		Json::StyledWriter writer;
		Json::Value mediasopu_sdp =  parse(desc);
		std::string mediasoup = writer.write(mediasopu_sdp);

	}
 
	void cpeer_connection::OnFailure(webrtc::RTCError error)
	{}
	void cpeer_connection::OnFailure(const std::string& error)
	{}


	bool cpeer_connection::init()
	{
		m_net_thread = rtc::Thread::CreateWithSocketServer() ;
		m_work_thread = rtc::Thread::Create() ;
		m_signal_thread = rtc::Thread::Create() ;


		if (!m_net_thread->Start() || !m_work_thread->Start() || !m_signal_thread->Start())
		{
			return false;
		}

		m_peer_connection_factory = webrtc::CreatePeerConnectionFactory(
			m_net_thread.get(), 
			m_work_thread.get(),
			m_signal_thread.get(), 
			nullptr,
			webrtc::CreateBuiltinAudioEncoderFactory(),
			webrtc::CreateBuiltinAudioDecoderFactory(),
		webrtc::CreateBuiltinVideoEncoderFactory(),
		webrtc::CreateBuiltinVideoDecoderFactory(),
			nullptr, nullptr
		);
		webrtc::PeerConnectionInterface::RTCConfiguration config;
		config.sdp_semantics = webrtc::SdpSemantics::kUnifiedPlan;
		//config.enable_dtls_srtp = dtls;
		m_peer_connection = m_peer_connection_factory->CreatePeerConnection(config, nullptr, nullptr, this);
		//只增加视频轨道
		(void)m_peer_connection->AddTransceiver(cricket::MEDIA_TYPE_AUDIO);
		(void)m_peer_connection->AddTransceiver(cricket::MEDIA_TYPE_VIDEO);


		m_peer_connection->CreateOffer(this /*CreateSessionDescriptionObserver*/, webrtc::PeerConnectionInterface::RTCOfferAnswerOptions());

		return m_peer_connection != nullptr;
		
	}
}