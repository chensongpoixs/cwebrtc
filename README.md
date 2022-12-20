**WebRTC is a free, open software project** that provides browsers and mobile
applications with Real-Time Communications (RTC) capabilities via simple APIs.
The WebRTC components have been optimized to best serve this purpose.

**Our mission:** To enable rich, high-quality RTC applications to be
developed for the browser, mobile platforms, and IoT devices, and allow them
all to communicate via a common set of protocols.

The WebRTC initiative is a project supported by Google, Mozilla and Opera,
amongst others.

### Development

See http://www.webrtc.org/native-code/development for instructions on how to get
started developing with the native code.

[Authoritative list](native-api.md) of directories that contain the
native API header files.

### More info

 * Official web site: http://www.webrtc.org
 * Master source code repo: https://webrtc.googlesource.com/src
 * Samples and reference apps: https://github.com/webrtc
 * Mailing list: http://groups.google.com/group/discuss-webrtc
 * Continuous build: http://build.chromium.org/p/client.webrtc
 * [Coding style guide](style-guide.md)
 * [Code of conduct](CODE_OF_CONDUCT.md)





# 一、 WebRTC中调整参数的列表

[WebRTC中调整参数的列表](webrtc_argv_list.md)





# 二、正文


![](https://github.com/chensongpoixs/cwebrtc/blob/chensong/img/video_send_encoder.jpg?raw=true)


RtpStreamSender有三个成员变量:rtp_rtcp(rtp\rtcp 打包、接收、发送), sender_video(pacer 发送), fec_generator(fec)，



congestion_controller: 拥塞控制


## 1、整体框架

[H264的数据包分组发送与接受H264数据包组包的流程](video/send_video_rtp_packet.md)


WebRTC中有得部分码控结构如下图所示，从socket层接收到数据后，到transport解析rtcp包处理得到feedback，通过call将feedback转发到对应sendstream上的rtcp处理模块，最终通过RtpTransportControllerSend将feedback转发到GoogCcNetworkContoller解析码率预估后，把预估的码率（target bitrate），探测策略（probe config），congestion  windows给pacer，pacer转发给pacingContrller去使用进行发送码率控制


![webrtc_transport_cc_framework](img/webrtc_transport_cc_framework.jpg)


其中以GoogCcNetworkController作为整个码率预估及调整的核心，涉及的类和流程如下图所示，红框中的类在GoogCcNetworkController下

![webrtc_googccnetwork_controller](img/webrtc_googccnetwork_controller.jpg)

1. ProbeBitrateEstimator：根据feedbak计算探测码率，PacingController中会将报按照cluster进行划分，transport-CC报文能得到报所属的cluster以及发送和接受信息，通过发送和接收的数据大小比判断是否到达链路上限从而进行宽带探测。

2. AcknowledgedBBitrateEstimator: 估算当前的吞吐量

3. BitrateEstimator: 使用滑动窗口 + <font color='red'>卡尔曼滤波计算当前发送吞吐量</font>

4. DelayBaseBBwe: 基于延迟预估码率

5. TrendlineEstimator：使用线性回归技术当前网络拥堵情况

6. AimdRateControl：通过TrendLine预测出来的网络整体对码率进行aimd方式调整

7. SendSideBandwidthEstimation：基于丢包计算预估码率，结合延迟预估码率，得到最终的目标码率

8. ProbeController：探测控制器，通过目前码率判断下次是否探测，探测码率大小

9. CongestionWindowPushbackController： 基于当前的rtt设置一个时间窗口，同时基于当前码率设置当前时间窗口下的数据量，通过判断当前窗口的使用量，如果使用量过大的时候，降低编码时使用的目标码率，加速窗口消退，减少延迟

10. AlrDetector：应用（码率）受限检测， 检查当前的发送码率是否和目标码率由于编码器等原因相差过大受限了， 受限情况下会触发带宽预测过程的特殊处理

11. NetworkSateEstimator、NetworkStateProdictor：此两者属于待开发类，只是在代码中有，但是还没开发完，没用上。