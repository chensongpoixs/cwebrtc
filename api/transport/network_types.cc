/*
 *  Copyright (c) 2018 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "api/transport/network_types.h"

namespace webrtc {

// TODO(srte): Revert to using default after removing union member.
StreamsConfig::StreamsConfig() {}
StreamsConfig::StreamsConfig(const StreamsConfig&) = default;
StreamsConfig::~StreamsConfig() = default;

TargetRateConstraints::TargetRateConstraints() = default;
TargetRateConstraints::TargetRateConstraints(const TargetRateConstraints&) =
    default;
TargetRateConstraints::~TargetRateConstraints() = default;

NetworkRouteChange::NetworkRouteChange() = default;
NetworkRouteChange::NetworkRouteChange(const NetworkRouteChange&) = default;
NetworkRouteChange::~NetworkRouteChange() = default;

PacketResult::PacketResult() = default;
PacketResult::PacketResult(const PacketResult& other) = default;
PacketResult::~PacketResult() = default;

TransportPacketsFeedback::TransportPacketsFeedback() = default;
TransportPacketsFeedback::TransportPacketsFeedback(
    const TransportPacketsFeedback& other) = default;
TransportPacketsFeedback::~TransportPacketsFeedback() = default;

std::vector<PacketResult> TransportPacketsFeedback::ReceivedWithSendInfo() const 
{
  std::vector<PacketResult> res;
  for (const PacketResult& fb : packet_feedbacks)
  {
    if (fb.receive_time.IsFinite()) 
	{
      res.push_back(fb);
    }
  }
  return res;
}

std::vector<PacketResult> TransportPacketsFeedback::LostWithSendInfo() const {
  std::vector<PacketResult> res;
  for (const PacketResult& fb : packet_feedbacks) {
    if (fb.receive_time.IsPlusInfinity()) {
      res.push_back(fb);
    }
  }
  return res;
}

std::vector<PacketResult> TransportPacketsFeedback::PacketsWithFeedback()
    const {
  return packet_feedbacks;
}

NetworkControlUpdate::NetworkControlUpdate() = default;
NetworkControlUpdate::NetworkControlUpdate(const NetworkControlUpdate&) =
    default;
NetworkControlUpdate::~NetworkControlUpdate() = default;

PacedPacketInfo::PacedPacketInfo() = default;

PacedPacketInfo::PacedPacketInfo(int probe_cluster_id,
                                 int probe_cluster_min_probes,
                                 int probe_cluster_min_bytes)
    : probe_cluster_id(probe_cluster_id),
      probe_cluster_min_probes(probe_cluster_min_probes),
      probe_cluster_min_bytes(probe_cluster_min_bytes) {}

bool PacedPacketInfo::operator==(const PacedPacketInfo& rhs) const {
  return send_bitrate_bps == rhs.send_bitrate_bps &&
         probe_cluster_id == rhs.probe_cluster_id &&
         probe_cluster_min_probes == rhs.probe_cluster_min_probes &&
         probe_cluster_min_bytes == rhs.probe_cluster_min_bytes;
}

ProcessInterval::ProcessInterval() = default;
ProcessInterval::ProcessInterval(const ProcessInterval&) = default;
ProcessInterval::~ProcessInterval() = default;









/////////////////////////



std::string ToString(const PacedPacketInfo& packetinfo) {
  char buffer[1024] = {0};
  ::sprintf(buffer,
            "\n[send_bitrate_bps = %d]\n[probe_cluster_id = "
            "%d]\n[probe_cluster_min_probes = %d]\n[probe_cluster_min_bytes = %d]\n",
            packetinfo.send_bitrate_bps, packetinfo.probe_cluster_id,
            packetinfo.probe_cluster_min_probes,
            packetinfo.probe_cluster_min_bytes);
  return buffer;
}

std::string ToString(const SentPacket& sendpacket) {
  char buffer[1024 * 50] = {0};
  sprintf(buffer,
          "\n[send_time = %s]\n[size = %s]\n[prior_unacked_data = %s]\n[pacing_info "
          "= %s]\n[sequence_number = %llu]\n[data_in_flight = %s]\n",
          webrtc::ToString(sendpacket.send_time).c_str(),
          webrtc::ToString(sendpacket.size).c_str(),
          webrtc::ToString(sendpacket.prior_unacked_data).c_str(),
          webrtc::ToString(sendpacket.pacing_info).c_str(),
          sendpacket.sequence_number,
          webrtc::ToString(sendpacket.data_in_flight).c_str());

  return buffer;
}

std::string ToString(const PacketResult& packet) {
  char buffer[1024 * 5] = {0};
  sprintf(buffer, "\n[sent_packet = %s]\n[receive_time = %s]\n",
          webrtc::ToString(packet.sent_packet).c_str(),
          webrtc::ToString(packet.receive_time).c_str());
  return buffer;
}

std::string ToString(const TransportPacketsFeedback& transportpacket) {
  char buffer[1024 * 100] = {0};

  // char ver_packet_feedbacks[1024 * 10];
  std::string ver_packet_feedbacks =
      VecToString(transportpacket.packet_feedbacks);
  std::string vec_sendless_arrival_times =
      VecToString(transportpacket.sendless_arrival_times);
  ;

  sprintf(buffer,
          "\n[feedback_time = %s]\n[first_unacked_send_time = %s]\n[data_in_flight "
          "= %s]\n[prior_in_flight = %s]\n[packet_feedbacks = "
          "%s]\n[sendless_arrival_times = %s]\n",
          webrtc::ToString(transportpacket.feedback_time).c_str(),
          webrtc::ToString(transportpacket.first_unacked_send_time).c_str(),
          webrtc::ToString(transportpacket.data_in_flight).c_str(),
          webrtc::ToString(transportpacket.prior_in_flight).c_str(),
          ver_packet_feedbacks.c_str(), vec_sendless_arrival_times.c_str());
  return buffer;
}
}  // namespace webrtc
