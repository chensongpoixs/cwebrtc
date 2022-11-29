/*
 *  Copyright 2018 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "rtc_base/network/sent_packet.h"

namespace rtc {

PacketInfo::PacketInfo() = default;
PacketInfo::PacketInfo(const PacketInfo& info) = default;
PacketInfo::~PacketInfo() = default;

SentPacket::SentPacket() = default;
SentPacket::SentPacket(int64_t packet_id, int64_t send_time_ms)
    : packet_id(packet_id), send_time_ms(send_time_ms) {}
SentPacket::SentPacket(int64_t packet_id,
                       int64_t send_time_ms,
                       const rtc::PacketInfo& info)
    : packet_id(packet_id), send_time_ms(send_time_ms), info(info) {}

}  // namespace rtc

namespace webrtc {

/*enum class PacketType {
kUnknown,
kData,
kIceConnectivityCheck,
kIceConnectivityCheckResponse,
kStunMessage,
kTurnMessage,
};*/

// enum class PacketInfoProtocolType {
//  kUnknown,
//  kUdp,
//  kTcp,
//  kSsltcp,
//  kTls,
//};

const char* ToPacketType(rtc::PacketType type) {
  switch (type) {
    case rtc::PacketType ::kData: {
      return "Data";
      break;
    }
    case rtc::PacketType ::kIceConnectivityCheck: {
      return "kIceConnectivityCheck";
      break;
    }
    case rtc::PacketType ::kIceConnectivityCheckResponse: {
      return "kIceConnectivityCheckResponse";
      break;
    }
    case rtc::PacketType ::kStunMessage: {
      return "kStunMessage";
      break;
    }
    case rtc::PacketType ::kTurnMessage: {
      return "kTurnMessage";
      break;
    }
    default: {
      return "kUnknown";
      break;
    }
  }
  return "kUnknown";
}

const char* ToPacketInfoProtocolType(rtc::PacketInfoProtocolType type) {
  switch (type) {
    case rtc::PacketInfoProtocolType::kUdp: {
      return "kUdp";
      break;
    }
    case rtc::PacketInfoProtocolType::kTcp: {
      return "kTcp";
      break;
    }
    case rtc::PacketInfoProtocolType::kSsltcp: {
      return "kSsltcp";
      break;
    }
    case rtc::PacketInfoProtocolType::kTls: {
      return "kTls";
      break;
    }
    default: {
      return "kUnknown";
      break;
    }
  }
  return "kUnknown";
}

std::string ToString(const rtc::PacketInfo& packetinfo) {
  char buffer[1024 * 5] = {0};
  /*
  
   bool included_in_feedback = false;
  bool included_in_allocation = false;
  PacketType packet_type = PacketType::kUnknown;
  PacketInfoProtocolType protocol = PacketInfoProtocolType::kUnknown;
  // A unique id assigned by the network manager, and absl::nullopt if not set.
  absl::optional<uint16_t> network_id;
  size_t packet_size_bytes = 0;
  size_t turn_overhead_bytes = 0;
  size_t ip_overhead_bytes = 0;
  */
  if (packetinfo.network_id) {
    sprintf(buffer,
            "\n[included_in_feedback  = %s]\n[included_in_allocation = "
            "%s]\n[packet_type = %s]\n[protocol = %s]\n[network_id = %u]\n[packet_size_bytes = "
            "%llu]\n[turn_overhead_bytes = "
            "%llu]\n[ip_overhead_bytes = %llu]\n",
            (packetinfo.included_in_feedback ? "true" : "false"),
            (packetinfo.included_in_allocation ? "true" : "false"),
            ToPacketType(packetinfo.packet_type),
            ToPacketInfoProtocolType(packetinfo.protocol),
            packetinfo.network_id.value(), packetinfo.packet_size_bytes,
            packetinfo.turn_overhead_bytes, packetinfo.ip_overhead_bytes);
  }
  else
  {
    sprintf(buffer,
            "\n[included_in_feedback  = %s]\n[included_in_allocation = "
            "%s]\n[packet_type = %s]\n[protocol = %s]\n[packet_size_bytes = "
            "%llu] \n[turn_overhead_bytes = "
            "%llu]\n[ip_overhead_bytes = %llu]\n",
            (packetinfo.included_in_feedback ? "true" : "false"),
            (packetinfo.included_in_allocation ? "true" : "false"),
            ToPacketType(packetinfo.packet_type),
            ToPacketInfoProtocolType(packetinfo.protocol),
              packetinfo.packet_size_bytes,
            packetinfo.turn_overhead_bytes, packetinfo.ip_overhead_bytes);
  }
  return buffer;
}
std::string ToString(const rtc::SentPacket& packet) 
{
  char buffer[1024 * 10] = {0};

  /*
   int64_t packet_id = -1;
  int64_t send_time_ms = -1;
  rtc::PacketInfo info;
  */
  sprintf(buffer, "\n[packet_id = %llu]\n[send_time_ms = %llu]\n [info = %s]\n", 
	  packet.packet_id, packet.send_time_ms, webrtc::ToString( packet.info).c_str());

	return buffer;
}
}  // namespace webrtc