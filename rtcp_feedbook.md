# recv rtcp data


接受数据堆栈信息

```
-- 1、io 线程读取数据 
AllocationSequence::OnReadPacket(rtc::AsyncPacketSocket* socket,  const char* data, size_t size, const rtc::SocketAddress& remote_addr, const int64_t& packet_time_us)
UDPPort::HandleIncomingPacket(rtc::AsyncPacketSocket* socket, const char* data, size_t size, const rtc::SocketAddress& remote_addr, int64_t packet_time_us)
UDPPort::OnReadPacket(rtc::AsyncPacketSocket* socket, const char* data, size_t size, const rtc::SocketAddress& remote_addr, const int64_t& packet_time_us)
onnection::OnReadPacket(const char* data, size_t size, int64_t packet_time_us)
P2PTransportChannel::OnReadPacket(Connection* connection, const char* data, size_t len, int64_t packet_time_us)
DtlsTransport::OnReadPacket(rtc::PacketTransportInternal* transport, const char* data, size_t size, const int64_t& packet_time_us, int flags)
RtpTransport::OnReadPacket(rtc::PacketTransportInternal* transport, const char* data, size_t len, const int64_t& packet_time_us, int flags)
SrtpTransport::OnRtpPacketReceived(rtc::CopyOnWriteBuffer packet, int64_t packet_time_us)
RtpTransport::DemuxPacket(rtc::CopyOnWriteBuffer packet, int64_t packet_time_us)										
RtpDemuxer::OnRtpPacket(const RtpPacketReceived& packet)
BaseChannel::OnRtpPacket(const webrtc::RtpPacketReceived& parsed_packet)
BaseChannel::OnPacketReceived(bool rtcp, const rtc::CopyOnWriteBuffer& packet, int64_t packet_time_us) 


[
--> 2、 线程切换的代码
invoker_.AsyncInvoke<void>(
      RTC_FROM_HERE, worker_thread_,
      Bind(&BaseChannel::ProcessPacket, this, rtcp, packet, packet_time_us));
]

// received 

BaseChannel::ProcessPacket(bool rtcp, const rtc::CopyOnWriteBuffer& packet, int64_t packet_time_us)
WebRtcVideoChannel::OnRtcpReceived
Call::DeliverPacket
Call::DeliverRtcp
VideoSendStream::DeliverRtcp 
VideoSendStreamImpl::DeliverRtcp 
RtpVideoSender::DeliverRtcp 
ModuleRtpRtcpImpl::IncomingRtcpPacket(const uint8_t* rtcp_packet, const size_t length)
RTCPReceiver::IncomingPacket(const uint8_t* packet, size_t packet_size)  --> RTCPReceiver模块接受数据并读取数据格式
RTCPReceiver::TriggerCallbacksFromRtcpPacket(const PacketInformation& packet_information)
RtpTransportControllerSend::OnTransportFeedback(const rtcp::TransportFeedback& feedback)

--> 3、 线程切换 gcc
 
GoogCcNetworkController::OnTransportPacketsFeedback(TransportPacketsFeedback report)
```