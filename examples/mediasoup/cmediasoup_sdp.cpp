#include "cmediasoup_sdp.h"
#include <string>
#include <regex>
#include <ostream>
#include <strstream>
#include <string>
#include <unordered_map>
#include <cstddef>   // size_t
#include <memory>    // std::addressof()
#include <sstream>   // std::stringstream, std::istringstream
#include <ios>       // std::noskipws
#include <algorithm> // std::find_if()
#include <cctype>    // std::isspace()

#include "cpeer_connection.h"
#include "api/jsep_session_description.h"
#include "pc/session_description.h"
#include "api/jsep.h"
#include "media/sctp/sctp_transport_internal.h"
#include "absl/strings/match.h"
namespace chen {
	static const int kPreferenceUnknown = 0;
	static const int kPreferenceHost = 1;
	static const int kPreferenceReflexive = 2;
	static const int kPreferenceRelayed = 3;
	static int GetCandidatePreferenceFromType(const std::string& type) {
		int preference = kPreferenceUnknown;
		if (type == cricket::LOCAL_PORT_TYPE) {
			preference = kPreferenceHost;
		}
		else if (type == cricket::STUN_PORT_TYPE) {
			preference = kPreferenceReflexive;
		}
		else if (type == cricket::RELAY_PORT_TYPE) {
			preference = kPreferenceRelayed;
		}
		else {
			 // warring 
		}
		return preference;
	}

	// Get ip and port of the default destination from the |candidates| with the
	// given value of |component_id|. The default candidate should be the one most
	// likely to work, typically IPv4 relay.
	// RFC 5245
	// The value of |component_id| currently supported are 1 (RTP) and 2 (RTCP).
	// TODO(deadbeef): Decide the default destination in webrtcsession and
	// pass it down via SessionDescription.
	static void GetDefaultDestination(const std::vector<cricket::Candidate>& candidates,
		int component_id,
		std::string* port,
		std::string* ip,
		std::string* addr_type) {
		*addr_type = "4";
		*port = "9";
		*ip = "0.0.0.0";
		int current_preference = kPreferenceUnknown;
		int current_family = AF_UNSPEC;
		for (const cricket::Candidate& candidate : candidates) {
			if (candidate.component() != component_id) {
				continue;
			}
			// Default destination should be UDP only.
			if (candidate.protocol() != cricket::UDP_PROTOCOL_NAME) {
				continue;
			}
			const int preference = GetCandidatePreferenceFromType(candidate.type());
			const int family = candidate.address().ipaddr().family();
			// See if this candidate is more preferable then the current one if it's the
			// same family. Or if the current family is IPv4 already so we could safely
			// ignore all IPv6 ones. WebRTC bug 4269.
			// http://code.google.com/p/webrtc/issues/detail?id=4269
			if ((preference <= current_preference && current_family == family) ||
				(current_family == AF_INET && family == AF_INET6)) {
				continue;
			}
			if (family == AF_INET) {
				addr_type->assign("4");
			}
			else if (family == AF_INET6) {
				addr_type->assign("6");
			}
			current_preference = preference;
			current_family = family;
			*port = candidate.address().PortAsString();
			*ip = candidate.address().ipaddr().ToString();
		}
	}
	
	Json::Value parse(const webrtc::SessionDescriptionInterface*  jdesc)
	{ 
		if (!jdesc)
		{
			return Json::Value();
		}
		const cricket::SessionDescription* desc = jdesc->description();
		if (!desc ) {
			return Json::Value();
		}

		Json::Value  meessage ;
		// 1. version
		meessage["version"] = 0;
		// 2. name
		meessage["name"] = "-";
		// 3. origin
		meessage["origin"] = Json::objectValue;
		meessage["origin"]["address"] = "127.0.0.1";
		meessage["origin"]["ipVer"] = 4;
		meessage["origin"]["netType"] = "IN";
		meessage["origin"]["sessionId"] = std::atoll(jdesc->session_id().c_str());
		meessage["origin"]["sessionVersion"] = std::stoi(jdesc->session_version().c_str());
		meessage["origin"]["username"] = "-";

		// 4. timing object
		meessage["timing"] = Json::objectValue;
		meessage["timing"]["start"] = 0;
		meessage["timing"]["stop"] = 0;
		
		// 5. group 
		// Group
		
		if (desc->HasGroup(cricket::GROUP_TYPE_BUNDLE)) 
		{
			
   
			
			
			std::string group_line ;
			const cricket::ContentGroup* group = desc->GetGroupByName(cricket::GROUP_TYPE_BUNDLE);
			if (group)
			{
				meessage["groups"] = Json::arrayValue;
				Json::Value  GroupValue = Json::objectValue;
				GroupValue["type"] = "BUNDLE";
				for (const std::string& content_name : group->content_names())
				{
					group_line.append(" ");
					group_line.append(content_name);
				}
				GroupValue["mids"] = group_line;
				meessage["groups"] = GroupValue;
			}
			// warraing 
		}
		
		// 6. msidSemantic 
		meessage["msidSemantic"] = Json::objectValue;
		meessage["msidSemantic"]["token"] = "WMS";  // WebRTC  Media Stream


		// 7. media info 
		meessage["media"] = Json::arrayValue;

		{
			// 7.1 audio config
			Json::Value audio_value = Json::objectValue;
			std::set<std::string> media_stream_ids;
			for (const cricket::ContentInfo& content : desc->contents())
			{
				if (!content.media_description()) 
				{
					continue;
				}
				if (content.media_description()->type() == cricket::MEDIA_TYPE_AUDIO)
				{
					for (const cricket::StreamParams& stream_params : content.media_description()->streams()) 
					{
						for (const std::string& stream_id : stream_params.stream_ids()) 
						{
							media_stream_ids.insert(stream_id);
						}
					}
					break;
				}
			}
		}

		// 8. ice-lite
		for (const cricket::TransportInfo& transport : desc->transport_infos()) 
		{
			if (transport.description.ice_mode == cricket::ICEMODE_LITE) 
			{
				// sturn server -> server <-> client  
				break;
			}
		}
		// media contents
		int32_t mline_index = -1;
		for (const cricket::ContentInfo& content : desc->contents()) 
		{
			Json::Value media_info;
			std::vector<cricket::Candidate> candidates;
			const webrtc::IceCandidateCollection* cc = jdesc->candidates(mline_index);
			if (cc)
			{
				for (size_t i = 0; i < cc->count(); ++i)
				{
					const webrtc::IceCandidateInterface* candidate = cc->at(i);
					candidates.push_back(candidate->candidate());
				}
			}
			//cricket::GetCandidatesByMindex(jdesc, ++mline_index, &candidates);
			/*BuildMediaDescription(&content, desc->GetTransportInfoByName(content.name),
				content.media_description()->type(), candidates,
				desc->msid_signaling(), &message);*/

			const cricket::MediaContentDescription*media_desc=	content.media_description();
			int32_t  sctp_port = cricket::kSctpDefaultPort;

			 

			const char* type = NULL;
			if (content.media_description()->type() == cricket::MEDIA_TYPE_AUDIO)
			{
				type = "audio";
			}
			else if (content.media_description()->type() == cricket::MEDIA_TYPE_VIDEO)
			{
				type = "video";
			}
			else if (content.media_description()->type() == cricket::MEDIA_TYPE_DATA)
			{
				type = "application";
			}
			else
			{
				// warring 
			}
			std::string fmt;
			if (content.media_description()->type() == cricket::MEDIA_TYPE_VIDEO) 
			{
				const cricket::VideoContentDescription* video_desc = media_desc->as_video();
				for (const cricket::VideoCodec& codec : video_desc->codecs()) 
				{
					fmt.append(" ");
					fmt.append(rtc::ToString(codec.id));
				}
			}
			else if (content.media_description()->type() == cricket::MEDIA_TYPE_AUDIO) 
			{
				const cricket::AudioContentDescription* audio_desc = media_desc->as_audio();
				for (const cricket::AudioCodec& codec : audio_desc->codecs()) 
				{
					fmt.append(" ");
					fmt.append(rtc::ToString(codec.id));
				}
			}
			else if (content.media_description()->type() == cricket::MEDIA_TYPE_DATA)
			{
				const cricket::DataContentDescription* data_desc = media_desc->as_data();
				if (media_desc->protocol().find(cricket::kMediaProtocolDtlsSctp) != std::string::npos   ) 
				{
					fmt.append(" ");

					if (data_desc->use_sctpmap()) {
						for (const cricket::DataCodec& codec : data_desc->codecs()) 
						{
							if (absl::EqualsIgnoreCase(codec.name,
								cricket::kGoogleSctpDataCodecName) &&
								codec.GetParam(cricket::kCodecParamPort, &sctp_port)) 
							{
								break;
							}
						}

						fmt.append(rtc::ToString(sctp_port));
					}
					else {
						fmt.append("webrtc-datachannel");
					}
				}
				else {
					for (const cricket::DataCodec& codec : data_desc->codecs()) 
					{
						fmt.append(" ");
						fmt.append(rtc::ToString(codec.id));
					}
				}
			}

			std::string port = "9";
			if (content.rejected || content.bundle_only) 
			{
				port = "0";
			}
			else if (!media_desc->connection_address().IsNil()) 
			{
				port = rtc::ToString(media_desc->connection_address().port());
			}

			rtc::SSLFingerprint* fp =
				(desc->GetTransportInfoByName(content.name)) ? desc->GetTransportInfoByName(content.name)->description.identity_fingerprint.get()
				: NULL;
			// m=audio 9 UPD/TLS/RTP/SAVPF 111 113 ...
			media_info["type"] = type;
			media_info["port"] = std::atoi(port.c_str());
			media_info["protocol"] = media_desc->protocol();
			media_info["payloads"] = fmt;

			// C net 
			Json::Value  media_type_net;
			media_info["connection"] = Json::objectValue;
			if (media_desc->connection_address().IsNil()) 
			{
				//os << " " << kConnectionIpv4Addrtype << " " << kDummyAddress;
				media_type_net["ip"] = "0.0.0.0";
				media_type_net["version"] = 4;
			}
			else if (media_desc->connection_address().family() == AF_INET) 
			{
				/*os << " " << kConnectionIpv4Addrtype << " "
					<< media_desc->connection_address().ipaddr().ToString();*/
				media_type_net["ip"] = media_desc->connection_address().ipaddr().ToString();
				media_type_net["version"] = 4;
			}
			else if (media_desc->connection_address().family() == AF_INET6) 
			{
				/*os << " " << kConnectionIpv6Addrtype << " "
					<< media_desc->connection_address().ipaddr().ToString();*/
				media_type_net["ip"] = media_desc->connection_address().ipaddr().ToString();
				media_type_net["version"] = 6;
			}
			else if (!media_desc->connection_address().hostname().empty()) 
			{
				// For hostname candidates, we use c=IN IP4 <hostname>.
				/*os << " " << kConnectionIpv4Addrtype << " "
					<< media_desc->connection_address().hostname();*/
				media_type_net["ip"] = media_desc->connection_address().hostname();
				media_type_net["version"] = 4;
			}
			else 
			{
				//os << " " << kConnectionIpv4Addrtype << " " << kDummyAddress;
				media_type_net["ip"] = "0.0.0.0";
				media_type_net["version"] = 4;
			}
			media_info["connection"] = media_type_net;

			// RFC 4566
			// b=AS:<bandwidth>
			if (media_desc->bandwidth() >= 1000) 
			{
				//InitLine(kLineTypeSessionBandwidth, kApplicationSpecificMaximum, &os);
				//os << kSdpDelimiterColon << (media_desc->bandwidth() / 1000);
				//AddLine(os.str(), message);
			}

			// Add the a=bundle-only line.
			if (content.bundle_only) 
			{
				/*InitAttrLine(kAttributeBundleOnly, &os);
				AddLine(os.str(), message);*/
			}

			// Add the a=rtcp line.
		 
			if (media_desc->protocol().empty() ||
				(media_desc->protocol().find(cricket::kMediaProtocolRtpPrefix) != std::string::npos)  )
			{
				media_info["rtcp"] = Json::objectValue;
				Json::Value media_rtcp;
				std::string rtcp_line, rtcp_port, rtcp_ip, addr_type;
				GetDefaultDestination(candidates, cricket::ICE_CANDIDATE_COMPONENT_RTCP, &rtcp_port,
					&rtcp_ip, &addr_type);
				media_rtcp["address"] = rtcp_ip;
				media_rtcp["ipVer"] = std::atoi(addr_type.c_str());
				media_rtcp["netType"] = "IN";
				media_rtcp["port"] = std::atoi(rtcp_port.c_str());
				media_info["rtcp"] = media_rtcp;
			}

			// Build the a=candidate lines. We don't include ufrag and pwd in the
			// candidates in the SDP to avoid redundancy.
			//BuildCandidate(candidates, false, message);


			// Use the transport_info to build the media level ice-ufrag and ice-pwd.
			if (desc->GetTransportInfoByName(content.name)) {
				// RFC 5245
				// ice-pwd-att           = "ice-pwd" ":" password
				// ice-ufrag-att         = "ice-ufrag" ":" ufrag
				// ice-ufrag
				if (!desc->GetTransportInfoByName(content.name)->description.ice_ufrag.empty())
				{
					/*InitAttrLine(kAttributeIceUfrag, &os);
					os << kSdpDelimiterColon << desc->GetTransportInfoByName(content.name)->description.ice_ufrag;
					AddLine(os.str(), message);*/
					media_info["iceUfrag"] = desc->GetTransportInfoByName(content.name)->description.ice_ufrag;
				}
				// ice-pwd
				if (!desc->GetTransportInfoByName(content.name)->description.ice_pwd.empty()) 
				{
					/*InitAttrLine(kAttributeIcePwd, &os);
					os << kSdpDelimiterColon << desc->GetTransportInfoByName(content.name)->description.ice_pwd;
					AddLine(os.str(), message);*/
					media_info ["icePwd"] = desc->GetTransportInfoByName(content.name)->description.ice_pwd;
				}

				// draft-petithuguenin-mmusic-ice-attributes-level-03
				//BuildIceOptions(desc->GetTransportInfoByName(content.name)->description.transport_options, message);
				if (!desc->GetTransportInfoByName(content.name)->description.transport_options.empty())
				{
					std::ostringstream ice_options;

					for (size_t i = 0; i < desc->GetTransportInfoByName(content.name)->description.transport_options.size(); ++i) 
					{
						if (i > 0)
						{
							ice_options << " ";
						}
						ice_options << desc->GetTransportInfoByName(content.name)->description.transport_options[i];
					}
					media_info ["iceOptions"] = ice_options.str() ;

				}
				// RFC 4572
				// fingerprint-attribute  =
				//   "fingerprint" ":" hash-func SP fingerprint
				if (fp) 
				{
					media_info["fingerprint"] = Json::objectValue;

					// Insert the fingerprint attribute.
					Json::Value media_fingerprint = Json::objectValue;
					media_fingerprint["type"] = fp->algorithm;
					media_fingerprint["hash"] = fp->GetRfc4572Fingerprint();
					
					media_info["fingerprint"] = media_fingerprint;
					 
					// Inserting setup attribute.
					if (desc->GetTransportInfoByName(content.name)->description.connection_role !=
						cricket::CONNECTIONROLE_NONE) 
					{
						// Making sure we are not using "passive" mode.
						cricket::ConnectionRole role =
							desc->GetTransportInfoByName(content.name)->description.connection_role;
						std::string dtls_role_str;
						const bool success = cricket::ConnectionRoleToString(role, &dtls_role_str);
						RTC_DCHECK(success);
						media_info["setup"]= dtls_role_str;
						/*InitAttrLine(kAttributeSetup, &os);
						os << kSdpDelimiterColon << dtls_role_str;
						AddLine(os.str(), message);*/
					}
				}

				
				


			}
			// RFC 3388
			// mid-attribute      = "a=mid:" identification-tag
			// identification-tag = token
			// Use the content name as the mid identification-tag. 
			media_info["mid"] = content.name;
			// TODO@chensong 2022-01-04 协议加密和不加密的操作 目前只有不加密的程序哈
			if (media_desc->protocol().find(cricket::kMediaProtocolDtlsSctp) != std::string::npos)
			{
				//const cricket::DataContentDescription* data_desc = media_desc->as_data();
				//bool use_sctpmap = data_desc->use_sctpmap();
				//BuildSctpContentAttributes(message, sctp_port, use_sctpmap);
			}
			else if (media_desc->protocol().empty() ||
				(media_desc->protocol().find(cricket::kMediaProtocolRtpPrefix) != std::string::npos))
			{
				// RFC 8285
				// a=extmap-allow-mixed
				// The attribute MUST be either on session level or media level. We support
				// responding on both levels, however, we don't respond on media level if it's
				// set on session level.
				if (media_desc->extmap_allow_mixed_enum() == cricket::MediaContentDescription::kMedia) 
				{
					/*InitAttrLine(kAttributeExtmapAllowMixed, &os);
					AddLine(os.str(), message);*/

				}

				// RFC 8285
				// a=extmap:<value>["/"<direction>] <URI> <extensionattributes>
				// The definitions MUST be either all session level or all media level. This
				// implementation uses all media level.
				Json::Value ext_value = Json::arrayValue;
				for (size_t i = 0; i < media_desc->rtp_header_extensions().size(); ++i) 
				{
					Json::Value ext_object;
					const webrtc::RtpExtension& extension = media_desc->rtp_header_extensions()[i];
					/*InitAttrLine(kAttributeExtmap, &os);
					os << kSdpDelimiterColon << extension.id;*/
					ext_object ["value"] = extension.id;
					ext_object["uri"] = extension.uri;
					if (extension.encrypt) 
					{
						//os << kSdpDelimiterSpace << RtpExtension::kEncryptHeaderExtensionsUri;
					}
					//os << kSdpDelimiterSpace << extension.uri;
					//AddLine(os.str(), message);
					//ext_value = ext_object;
					ext_value.append(ext_object);
				}
				media_info["ext"] = ext_value;

				// RFC 3264
				// a=sendrecv || a=sendonly || a=sendrecv || a=inactive
				switch (media_desc->direction()) {
				case webrtc::RtpTransceiverDirection::kInactive:
					//InitAttrLine(kAttributeInactive, &os);
					media_info["direction"] = "inactive";
					break;
				case webrtc::RtpTransceiverDirection::kSendOnly:
					//InitAttrLine(kAttributeSendOnly, &os);
					media_info["direction"] = "sendonly";
					break;
				case webrtc::RtpTransceiverDirection::kRecvOnly:
					//InitAttrLine(kAttributeRecvOnly, &os);
					media_info["direction"] = "recvonly";
					break;
				case webrtc::RtpTransceiverDirection::kSendRecv:
				default:
					//InitAttrLine(kAttributeSendRecv, &os);
					media_info["direction"] = "sendrecv";
					break;
				}
				//AddLine(os.str(), message);


				// Specified in https://datatracker.ietf.org/doc/draft-ietf-mmusic-msid/16/
				// a=msid:<msid-id> <msid-appdata>
				// The msid-id is a 1*64 token char representing the media stream id, and the
				// msid-appdata is a 1*64 token char representing the track id. There is a
				// line for every media stream, with a special msid-id value of "-"
				// representing no streams. The value of "msid-appdata" MUST be identical for
				// all lines.
				if (desc->msid_signaling() & cricket::kMsidSignalingMediaSection) 
				{
					const cricket::StreamParamsVec& streams = media_desc->streams();
					if (streams.size() == 1u) {
						const cricket::StreamParams& track = streams[0];
						std::vector<std::string> stream_ids = track.stream_ids();
						if (stream_ids.empty()) {
							stream_ids.push_back("-");
						}
						for (const std::string& stream_id : stream_ids) 
						{
							/*InitAttrLine("msid", &os);
							os << kSdpDelimiterColon << stream_id << kSdpDelimiterSpace << track.id;
							AddLine(os.str(), message);*/
							std::ostringstream os;
							os << stream_id << " " << track.id;
							media_info["msid"] = os.str().data();
						}
					}
					else if (streams.size() > 1u) 
					{
						RTC_LOG(LS_WARNING)
							<< "Trying to serialize Unified Plan SDP with more than "
							"one track in a media section. Omitting 'a=msid'.";
					}
				}

				// RFC 5761
				// a=rtcp-mux
				if (media_desc->rtcp_mux())
				{
					/*InitAttrLine(kAttributeRtcpMux, &os);
					AddLine(os.str(), message);*/
					media_info["rtcpMux"] = "rtcp-mux";
				}


				// RFC 5506
				// a=rtcp-rsize
				if (media_desc->rtcp_reduced_size()) 
				{
					/*InitAttrLine(kAttributeRtcpReducedSize, &os);
					AddLine(os.str(), message);*/
					media_info["rtcpRsize"] = "rtcp-rsize";
				}


				if (media_desc->conference_mode()) 
				{
					/*InitAttrLine(kAttributeXGoogleFlag, &os);
					os << kSdpDelimiterColon << kValueConference;
					AddLine(os.str(), message);*/
				}

				// RFC 4568
				// a=crypto:<tag> <crypto-suite> <key-params> [<session-params>]
				//for (const cricket::CryptoParams& crypto_params : media_desc->cryptos()) 
				{
					/*InitAttrLine(kAttributeCrypto, &os);
					os << kSdpDelimiterColon << crypto_params.tag << " "
						<< crypto_params.cipher_suite << " " << crypto_params.key_params;
					if (!crypto_params.session_params.empty()) {
						os << " " << crypto_params.session_params;
					}
					AddLine(os.str(), message);*/
				}

				// RFC 4566
				// a=rtpmap:<payload type> <encoding name>/<clock rate>
				// [/<encodingparameters>]
				//BuildRtpMap(media_desc, media_type, message);
				rtc::StringBuilder os;
				media_info["rtp"] = Json::arrayValue;
				media_info["rtcpFb"] = Json::arrayValue;
				media_info["fmtp"] = Json::arrayValue;
				if (content.media_description()->type() == cricket::MEDIA_TYPE_VIDEO) 
				{
					for (const cricket::VideoCodec& codec : media_desc->as_video()->codecs()) {
						// RFC 4566
						// a=rtpmap:<payload type> <encoding name>/<clock rate>
						// [/<encodingparameters>]
						Json::Value codec_value;
						if (codec.id != -1) 
						{
							codec_value["payload"] = codec.id;
							codec_value["codec"] = codec.name;
							codec_value["rate"] = cricket::kVideoCodecClockrate;
							 
						}
						media_info["rtp"].append( codec_value);
						 
						for (const cricket::FeedbackParam& param : codec.feedback_params.params()) 
						{
							Json::Value rtcpfb;
							rtcpfb["type"] = param.id();
							if (!param.param().empty())
							{
								rtcpfb["subtype"] = param.param();
							}

							if (codec.id == -1)
							{
								rtcpfb["payload"] = "*";
							}
							else
							{
								rtcpfb["payload"] = codec.id;
							}

							media_info["rtcpFb"].append(rtcpfb);
							/*rtc::StringBuilder os;
							WriteRtcpFbHeader(codec.id, &os);
							os << " " << param.id();
							if (!param.param().empty()) {
								os << " " << param.param();
							}
							AddLine(os.str(), message);*/
						}
						//AddRtcpFbLines(codec, message);
						//AddFmtpLine(codec, message);


						cricket::CodecParameterMap fmtp_parameters;
						//GetFmtpParams(codec.params, &fmtp_parameters);
						for (const auto& entry : codec.params) {
							const std::string& key = entry.first;
							const std::string& value = entry.second;
							if (key != cricket::kCodecParamPTime && key != cricket::kCodecParamMaxPTime ) 
							{
								fmtp_parameters[key] = value;
							}
						}
						if (!fmtp_parameters.empty()) 
						{
							Json::Value fmtp_parameter;
							fmtp_parameter["payload"] = codec.id;
							std::ostringstream os;
							bool first = true;
							for (const auto& entry : fmtp_parameters) 
							{
								const std::string& key = entry.first;
								const std::string& value = entry.second;
								// Parameters are a semicolon-separated list, no spaces.
								// The list is separated from the header by a space.
								if (first)
								{ 
									first = false;
								}
								else 
								
								{
									os << ";";
								}
								os << key << "=" << value;
								 
							}

							fmtp_parameter["config"] = os.str().data();
							media_info["fmtp"].append(fmtp_parameter);
							/*rtc::StringBuilder os;
							WriteFmtpHeader(codec.id, &os);
							WriteFmtpParameters(fmtp_parameters, &os);
							AddLine(os.str(), message);*/
						}
						


					}
				}
				else if (content.media_description()->type() == cricket::MEDIA_TYPE_AUDIO) 
				{
					std::vector<int> ptimes;
					std::vector<int> maxptimes;
					//int max_minptime = 0;
					for (const cricket::AudioCodec& codec : media_desc->as_audio()->codecs()) 
					{
						RTC_DCHECK(!codec.name.empty());
						// RFC 4566
						// a=rtpmap:<payload type> <encoding name>/<clock rate>
						// [/<encodingparameters>]
						Json::Value codec_value;
						if (codec.id != -1)
						{
							codec_value["payload"] = codec.id;
							codec_value["codec"] = codec.name;
							codec_value["rate"] = codec.clockrate;

						}
						media_info["rtp"].append(codec_value);
						/*InitAttrLine(kAttributeRtpmap, &os);
						os << kSdpDelimiterColon << codec.id << " ";
						os << codec.name << "/" << codec.clockrate;
						if (codec.channels != 1) {
							os << "/" << codec.channels;
						}
						AddLine(os.str(), message);*/
						/*AddRtcpFbLines(codec, message);
						AddFmtpLine(codec, message);*/

						for (const cricket::FeedbackParam& param : codec.feedback_params.params()) 
						{
							Json::Value rtcpfb;
							rtcpfb["type"] = param.id();
							if (!param.param().empty())
							{
								rtcpfb["subtype"] = param.param();
							}
							
							if (codec.id == -1)
							{
								rtcpfb["payload"] = "*";
							}
							else
							{
								rtcpfb["payload"] = codec.id;
							}

							media_info["rtcpFb"].append( rtcpfb);
							/*rtc::StringBuilder os;
							WriteRtcpFbHeader(codec.id, &os);
							os << " " << param.id();
							if (!param.param().empty()) {
							os << " " << param.param();
							}
							AddLine(os.str(), message);*/
						}
						//AddRtcpFbLines(codec, message);
						//AddFmtpLine(codec, message);


						cricket::CodecParameterMap fmtp_parameters;
						//GetFmtpParams(codec.params, &fmtp_parameters);
						for (const auto& entry : codec.params) {
							const std::string& key = entry.first;
							const std::string& value = entry.second;
							if (key != cricket::kCodecParamPTime && key != cricket::kCodecParamMaxPTime ) 
							{
								fmtp_parameters[key] = value;
							}
						}
						if (!fmtp_parameters.empty()) 
						{
							Json::Value fmtp_parameter;
							fmtp_parameter["payload"] = codec.id;
							std::ostringstream os;
							bool first = true;
							for (const auto& entry : fmtp_parameters) 
							{
								const std::string& key = entry.first;
								const std::string& value = entry.second;
								// Parameters are a semicolon-separated list, no spaces.
								// The list is separated from the header by a space.
								if (first)
								{ 
									first = false;
								}
								else 

								{
									os << ";";
								}
								os << key << "=" << value;

							}

							fmtp_parameter["config"] = os.str().data();
							media_info["fmtp"].append(fmtp_parameter);
							/*rtc::StringBuilder os;
							WriteFmtpHeader(codec.id, &os);
							WriteFmtpParameters(fmtp_parameters, &os);
							AddLine(os.str(), message);*/
						}


						////////////////////////////////////////// TODO@chensong 2022-01-04
						/*int minptime = 0;
						if (GetParameter(kCodecParamMinPTime, codec.params, &minptime)) {
							max_minptime = std::max(minptime, max_minptime);
						}
						int ptime;
						if (GetParameter(kCodecParamPTime, codec.params, &ptime)) {
							ptimes.push_back(ptime);
						}
						int maxptime;
						if (GetParameter(kCodecParamMaxPTime, codec.params, &maxptime)) {
							maxptimes.push_back(maxptime);
						}*/
					}
					// Populate the maxptime attribute with the smallest maxptime of all codecs
					// under the same m-line.
					//int min_maxptime = INT_MAX;
					//if (GetMinValue(maxptimes, &min_maxptime)) {
					//	AddAttributeLine(kCodecParamMaxPTime, min_maxptime, message);
					//}
					//RTC_DCHECK(min_maxptime > max_minptime);
					//// Populate the ptime attribute with the smallest ptime or the largest
					//// minptime, whichever is the largest, for all codecs under the same m-line.
					//int ptime = INT_MAX;
					//if (GetMinValue(ptimes, &ptime)) {
					//	ptime = std::min(ptime, min_maxptime);
					//	ptime = std::max(ptime, max_minptime);
					//	AddAttributeLine(kCodecParamPTime, ptime, message);
					//}
				}
				else if (content.media_description()->type() == cricket::MEDIA_TYPE_DATA) 
				{
					for (const cricket::DataCodec& codec : media_desc->as_data()->codecs()) {
						// RFC 4566
						// a=rtpmap:<payload type> <encoding name>/<clock rate>
						// [/<encodingparameters>]
						Json::Value codec_value;
						if (codec.id != -1)
						{
							codec_value["payload"] = codec.id;
							codec_value["codec"] = codec.name;
							codec_value["rate"] = codec.clockrate;

						}
						media_info["rtp"].append(codec_value);
						/*InitAttrLine(kAttributeRtpmap, &os);
						os << kSdpDelimiterColon << codec.id << " " << codec.name << "/"
							<< codec.clockrate;
						AddLine(os.str(), message);*/
					}
				}

				media_info["ssrcGroups"] = Json::arrayValue;
				media_info["ssrcs"] = Json::arrayValue;
				for (const cricket::StreamParams& track : media_desc->streams()) 
				{
					
					// Build the ssrc-group lines.
					for (const cricket::SsrcGroup& ssrc_group : track.ssrc_groups) 
					{
						
						// RFC 5576
						// a=ssrc-group:<semantics> <ssrc-id> ...
						Json::Value cssrc_group;
						if (ssrc_group.ssrcs.empty()) 
						{
							continue;
						}
						cssrc_group["semantics"] = ssrc_group.semantics;
						std::ostringstream os;
						for (uint32_t cssrc_i = 0; cssrc_i < ssrc_group.ssrcs.size(); ++cssrc_i)
						{
							if (cssrc_i > 0)
							{
								os << " ";
							}
							os << rtc::ToString(ssrc_group.ssrcs[cssrc_i]);
						}
						cssrc_group["ssrcs"] = os.str();
						media_info["ssrcGroups"].append(cssrc_group);
					}
					// Build the ssrc lines for each ssrc.
					for (uint32_t ssrc : track.ssrcs) 
					{
						// RFC 5576
						// a=ssrc:<ssrc-id> cname:<value> 
						{
							Json::Value cssrc_name;
							cssrc_name["attribute"] = "cname";
							cssrc_name["id"] = ssrc;
							cssrc_name["value"] = track.cname;
							media_info["ssrcs"].append(cssrc_name);
						}

						if (desc->msid_signaling() & cricket::kMsidSignalingSsrcAttribute) {
							// draft-alvestrand-mmusic-msid-00
							// a=ssrc:<ssrc-id> msid:identifier [appdata]
							// The appdata consists of the "id" attribute of a MediaStreamTrack,
							// which corresponds to the "id" attribute of StreamParams.
							// Since a=ssrc msid signaling is used in Plan B SDP semantics, and
							// multiple stream ids are not supported for Plan B, we are only adding
							// a line for the first media stream id here.
							const std::string& track_stream_id = track.first_stream_id();
							// We use a special msid-id value of "-" to represent no streams,
							// for Unified Plan compatibility. Plan B will always have a
							// track_stream_id.
							const std::string& stream_id =
								track_stream_id.empty() ? "-" : track_stream_id;
							/*InitAttrLine(kAttributeSsrc, &os);
							os << kSdpDelimiterColon << ssrc << kSdpDelimiterSpace
								<< kSsrcAttributeMsid << kSdpDelimiterColon << stream_id
								<< kSdpDelimiterSpace << track.id;
							AddLine(os.str(), message);*/
							{
								Json::Value cssrc_name;
								cssrc_name["attribute"] = "msid";
								cssrc_name["id"] = ssrc;
								cssrc_name["value"] = stream_id + " " + track.id;
								media_info["ssrcs"].append(cssrc_name);
							}

							// TODO(ronghuawu): Remove below code which is for backward
							// compatibility.
							// draft-alvestrand-rtcweb-mid-01
							// a=ssrc:<ssrc-id> mslabel:<value>
							// The label isn't yet defined.
							// a=ssrc:<ssrc-id> label:<value>
							{
								Json::Value cssrc_name;
								cssrc_name["attribute"] = "mslabel";
								cssrc_name["id"] = ssrc;
								cssrc_name["value"] = stream_id  ;
								media_info["ssrcs"].append(cssrc_name);
							}
							{
								Json::Value cssrc_name;
								cssrc_name["attribute"] = "label";
								cssrc_name["id"] = ssrc;
								cssrc_name["value"] = track.id;
								media_info["ssrcs"].append(cssrc_name);
							}
							//AddSsrcLine(ssrc, kSsrcAttributeMslabel, stream_id, message);
							//AddSsrcLine(ssrc, kSSrcAttributeLabel, track.id, message);
						}
					}

					// Build the rid lines for each layer of the track
					//for (const cricket::RidDescription& rid_description : track.rids()) {
					//	/*InitAttrLine(kAttributeRid, &os);
					//	os << kSdpDelimiterColon
					//		<< serializer.SerializeRidDescription(rid_description);
					//	AddLine(os.str(), message);*/
					//}
				}

			}


			meessage["media"].append( media_info);
		}


		return meessage;
	}
}