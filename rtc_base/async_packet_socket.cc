/*
 *  Copyright 2015 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "rtc_base/async_packet_socket.h"
#include "rtc_base/net_helper.h"

namespace rtc {

PacketTimeUpdateParams::PacketTimeUpdateParams() = default;

PacketTimeUpdateParams::PacketTimeUpdateParams(
    const PacketTimeUpdateParams& other) = default;

PacketTimeUpdateParams::~PacketTimeUpdateParams() = default;

PacketOptions::PacketOptions() = default;
PacketOptions::PacketOptions(DiffServCodePoint dscp) : dscp(dscp) {}
PacketOptions::PacketOptions(const PacketOptions& other) = default;
PacketOptions::~PacketOptions() = default;

AsyncPacketSocket::AsyncPacketSocket() = default;

AsyncPacketSocket::~AsyncPacketSocket() = default;

void CopySocketInformationToPacketInfo(size_t packet_size_bytes,
                                       const AsyncPacketSocket& socket_from,
                                       bool is_connectionless,
                                       rtc::PacketInfo* info) {
  info->packet_size_bytes = packet_size_bytes;
  // TODO(srte): Make sure that the family of the local socket is always set
  // in the VirtualSocket implementation and remove this check.
  int family = socket_from.GetLocalAddress().family();
  if (family != 0) {
    info->ip_overhead_bytes = cricket::GetIpOverhead(family);
  }
}

}  // namespace rtc

namespace webrtc {

/*
enum DiffServCodePoint {
DSCP_NO_CHANGE = -1,
DSCP_DEFAULT = 0,  // Same as DSCP_CS0
DSCP_CS0 = 0,      // The default
DSCP_CS1 = 8,      // Bulk/background traffic
DSCP_AF11 = 10,
DSCP_AF12 = 12,
DSCP_AF13 = 14,
DSCP_CS2 = 16,
DSCP_AF21 = 18,
DSCP_AF22 = 20,
DSCP_AF23 = 22,
DSCP_CS3 = 24,
DSCP_AF31 = 26,
DSCP_AF32 = 28,
DSCP_AF33 = 30,
DSCP_CS4 = 32,
DSCP_AF41 = 34,  // Video
DSCP_AF42 = 36,  // Video
DSCP_AF43 = 38,  // Video
DSCP_CS5 = 40,   // Video
DSCP_EF = 46,    // Voice
DSCP_CS6 = 48,   // Voice
DSCP_CS7 = 56,   // Control messages
};
*/

const char* ToDiffServCodePoint(rtc::DiffServCodePoint type) {
  switch (type) {
    case rtc::DiffServCodePoint::DSCP_DEFAULT: {
      return "DSCP_DEFAULT";
      break;
    }
      /* case rtc::DiffServCodePoint::DSCP_CS0:
              {
                        return "DSCP_CS0";
                        break;
              }*/
    case rtc::DiffServCodePoint::DSCP_CS1: {
      return "DSCP_CS1";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_AF11: {
      return "DSCP_AF11";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_AF12: {
      return "DSCP_AF12";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_AF13: {
      return "DSCP_AF13";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_CS2: {
      return "DSCP_CS2";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_AF21: {
      return "DSCP_AF21";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_AF22: {
      return "DSCP_AF22";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_AF23: {
      return "DSCP_AF23";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_CS3: {
      return "DSCP_CS3";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_AF31: {
      return "DSCP_AF31";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_AF32: {
      return "DSCP_AF32";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_AF33: {
      return "DSCP_AF33";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_CS4: {
      return "DSCP_CS4";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_AF41: {
      return "DSCP_AF41";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_AF42: {
      return "DSCP_AF42";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_AF43: {
      return "DSCP_AF43";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_CS5: {
      return "DSCP_CS5";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_EF: {
      return "DSCP_EF";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_CS6: {
      return "DSCP_CS6";
      break;
    }
    case rtc::DiffServCodePoint::DSCP_CS7: {
      return "DSCP_CS7";
      break;
    }
    default: {
      return "DSCP_NO_CHANGE";
      break;
    }
  }

  return "DSCP_NO_CHANGE";
}

std::string ToString(const rtc::PacketTimeUpdateParams& packet) 
{
  char buffer[1024 * 5] = {0};
  /*
  int rtp_sendtime_extension_id = -1;  // extension header id present in packet.
  std::vector<char> srtp_auth_key;     // Authentication key.
  int srtp_auth_tag_len = -1;          // Authentication tag length.
  int64_t srtp_packet_index = -1;  // Required for Rtp Packet authentication.
  */
  std::string vec_srtp_auth_key;

  for (size_t i = 0; i < packet.srtp_auth_key.size(); ++i)
  {
    vec_srtp_auth_key += packet.srtp_auth_key[i];
  }

  ::sprintf(buffer,
            "\n[rtp_sendtime_extension_id = %d]\n[srtp_auth_key = "
            "%s]\n[srtp_auth_tag_len= %d]\n[srtp_packet_index = %llu]",
            packet.rtp_sendtime_extension_id, vec_srtp_auth_key.c_str(),
            packet.srtp_auth_tag_len, packet.srtp_packet_index);

  return buffer;
}

std::string ToString(const rtc::PacketOptions& packet) {
  char buffer[1024 * 10] = {0};
  /*
  DiffServCodePoint dscp = DSCP_NO_CHANGE;
  // When used with RTP packets (for example, webrtc::PacketOptions), the value
  // should be 16 bits. A value of -1 represents "not set".
  int64_t packet_id = -1;
  PacketTimeUpdateParams packet_time_params;
  // PacketInfo is passed to SentPacket when signaling this packet is sent.
  PacketInfo info_signaled_after_sent;
  */
  ::sprintf(
      buffer, "\n[dscp = %s]\n[packet_id = %llu]\n[packet_time_params = %s]\n[info_signaled_after_sent = %s]\n",
            ToDiffServCodePoint(packet.dscp), packet.packet_id,
            webrtc::ToString(packet.packet_time_params).c_str(),
            webrtc::ToString(packet.info_signaled_after_sent).c_str());
  return buffer;
}
}  // namespace webrtc
