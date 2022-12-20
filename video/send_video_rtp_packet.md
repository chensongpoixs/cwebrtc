# 一、发送H264的包的rtp的分组的流程和发送流程 堆栈信息

```

VideoStreamEncoder::OnEncodedImage
VideoSendStreamImpl::OnEncodedImage
RtpVideoSender::OnEncodedImage
RTPSenderVideo::SendVideo
RTPSenderVideo::SendVideoPacket
RTPSenderVideo::LogAndSendToNetwork
RTPSender::SendToNetwork
PacedSender::InsertPacket -->放到rtp的包packets_队列中去 在PacedSender::Process定时线程5ms发送一次
```



# 二、接受H264的包rtp解析和组包的流程


```
BaseChannel::ProcessPacket 接受网络层数据
WebRtcVideoChannel::OnPacketReceived ->切换到RTP包的解析中去
Call::DeliverPacket
Call::DeliverRtp -> 开始解析rtp包的信息 ----->NotifyBweOfReceivedPacket
RtpStreamReceiverController::OnRtpPacket --> 视频数据rtp包逻辑
RtpDemuxer::OnRtpPacket  --> 查找src源
RtpVideoStreamReceiver::OnRtpPacket
RtpVideoStreamReceiver::ReceivePacket --> 解析rtp头部信息和rtp扩展信息
RtpVideoStreamReceiver::OnReceivedPayloadData --》 进入nack模块      ========> NackModule::OnReceivedPacket -->  [rtt statistics] 对于掉包处理模块nack重新发送
PacketBuffer::InsertPacket --> 接受rtp包插入接受队列中去


```



 

