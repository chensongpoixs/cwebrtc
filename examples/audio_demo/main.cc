#include "examples/desktop_capture/desktop_capture.h"
#include "test/video_renderer.h"
#include "rtc_base/logging.h"

#include <thread>
#include "system_wrappers/include/field_trial.h"
#include "test/field_trial.h"
#include  <Windows.h>
#include <iostream>

#include "modules/audio_device/include/audio_device.h"
#include "api/audio/audio_mixer.h"
#include "api/audio_codecs/audio_decoder_factory.h"
#include "api/audio_codecs/audio_encoder_factory.h"
#include "api/audio_codecs/builtin_audio_decoder_factory.h"
#include "api/audio_codecs/builtin_audio_encoder_factory.h"
#include "modules/audio_device/include/audio_device.h"
#include "common_audio/resampler/include/resampler.h"
#include "modules/audio_processing/aec/echo_cancellation.h"
#include "modules/audio_processing/include/audio_processing.h"
#include "common_audio/vad/include/webrtc_vad.h"
#include "audio/remix_resample.h"

#include "api/audio/audio_frame.h"
#include "audio/utility/audio_frame_operations.h"
#include "common_audio/resampler/include/push_resampler.h"
#include "rtc_base/checks.h"
#include <inttypes.h>

#include <common_audio/resampler/include/push_resampler.h>
#include <api/audio/audio_frame.h>
#include "p2p/base/stun_server.h"
#include "rtc_base/async_tcp_socket.h"
#include "rtc_base/socket_address.h"
#include "rtc_base/socket_server.h"
#include "rtc_base/thread.h"
#include "rtc_base/checks.h"
#include "rtc_base/logging.h"
#include "rtc_base/net_helpers.h"
#include <iostream>
#include <thread>
#ifdef WIN32
#include "rtc_base/win32_socket_server.h"
#endif

#include "rtc_base/physical_socket_server.h"

constexpr int RECORD_MODE = 1;
constexpr int PLAYOUT_MODE = 2;

#define SAMPLE_RATE			32000
#define SAMPLES_PER_10MS	(SAMPLE_RATE/100)

FILE *record_file = NULL;
int g_bytes = 0;




#include "api/audio/audio_frame.h"
#include "audio/utility/audio_frame_operations.h"
#include <assert.h>
//#include "./audio/utility/audio_frame_operations.h"
namespace hskdmo {
	void RemixAndResample(const int16_t* src_data,
		size_t samples_per_channel,
		size_t num_channels,
		int sample_rate_hz,
		webrtc::PushResampler<int16_t>* resampler,
		webrtc::AudioFrame* dst_frame)
	{
		const int16_t* audio_ptr = src_data;
		size_t audio_ptr_num_channels = num_channels;
		int16_t mono_audio[webrtc::AudioFrame::kMaxDataSizeSamples];

		// Downmix before resampling.
		if (num_channels == 2 && dst_frame->num_channels_ == 1) {
#if 0
			webrtc::AudioFrameOperations::StereoToMono(src_data,
				samples_per_channel,
				mono_audio);
#else 
			webrtc::AudioFrameOperations::StereoToMono(dst_frame);
#endif 
			audio_ptr = mono_audio;
			audio_ptr_num_channels = 1;
		}

		if (resampler->InitializeIfNeeded(sample_rate_hz, dst_frame->sample_rate_hz_,
			audio_ptr_num_channels) == -1) {			
			assert(false);
		}

		const size_t src_length = samples_per_channel * audio_ptr_num_channels;
		int out_length = resampler->Resample(audio_ptr,
			src_length,
			dst_frame->mutable_data(),
			webrtc::AudioFrame::kMaxDataSizeSamples);
		if (out_length == -1) {		
			assert(false);
		}
		dst_frame->samples_per_channel_ = out_length / audio_ptr_num_channels;

		// Upmix after resampling.
		if (num_channels == 1 && dst_frame->num_channels_ == 2) {
			// The audio in dst_frame really is mono at this point; MonoToStereo will
			// set this back to stereo.
			dst_frame->num_channels_ = 1;
			webrtc::AudioFrameOperations::MonoToStereo(dst_frame);
		}
	}

}




class AudioTransportImpl : public webrtc::AudioTransport
{
private:
	webrtc::PushResampler<int16_t> resampler_;
	webrtc::Resampler *resampler_out;
	//void *aec;
	VadInst *vad;
	webrtc::AudioFrame dst_frame_;

	webrtc::AudioProcessing *audioproc_ = NULL;

public:
	AudioTransportImpl(webrtc::AudioDeviceModule* audio) {		
		resampler_out = new webrtc::Resampler(SAMPLE_RATE, 48000, 2);
		int ret;
		/*
		aec = WebRtcAec_Create();
		assert(aec);
		ret = WebRtcAec_Init(aec, SAMPLE_RATE, SAMPLE_RATE);
		assert(ret == 0);
		*/
		vad = WebRtcVad_Create();
		assert(vad);
		ret = WebRtcVad_Init(vad);
		assert(ret == 0);

		audioproc_ = webrtc::AudioProcessingBuilder().Create();
	}

	~AudioTransportImpl() {
		delete resampler_out;

		//WebRtcAec_Free(aec);
		WebRtcVad_Free(vad);
	}


	virtual int32_t RecordedDataIsAvailable(
		const void* audioSamples,
		const size_t nSamples,
		const size_t nBytesPerSample,
		const size_t nChannels,
		const uint32_t samplesPerSec,
		const uint32_t totalDelayMS,
		const int32_t clockDrift,
		const uint32_t currentMicLevel,
		const bool keyPressed,
		uint32_t& newMicLevel) override
	{
		//	printf("RecordedDataIsAvailable line %d \n",__LINE__);
		//RecordedDataIsAvailable parameter: 441 2 1 44100 33 0 0 false
		printf("RecordedDataIsAvailable parameter: %zu %zu %zu %u %u %d %u %s\n", nSamples,
			nBytesPerSample, nChannels,
			samplesPerSec, totalDelayMS,
			clockDrift, currentMicLevel, keyPressed?"true":"false");

		printf("RecordedDataIsAvailable samples:");

		// 2 channels, 4bytes per sample
		const uint32_t *pSample = (const uint32_t*)audioSamples;
		for (uint32_t i = 0; i < nSamples; ++i) {
			printf(" %08x", pSample[i]);
		}
		printf("\n");


		// Convert sample rate from 48k to 16k, the channels from 2 to 1。
		dst_frame_.sample_rate_hz_ = 16000;
		dst_frame_.num_channels_ = 1;

#if 1 //linker error to comment it ;
		hskdmo::RemixAndResample((const int16_t*)audioSamples,
			nSamples,
			nChannels,
			samplesPerSec,
			&resampler_,
			&dst_frame_);
#endif 
		// save 48k sample
		fwrite((int8_t*)audioSamples, 2, nSamples, record_file); 

		// save 16k sample after resample

		size_t rc = fwrite((int8_t*)dst_frame_.data(), 2, dst_frame_.samples_per_channel_, record_file);
		if (rc < dst_frame_.samples_per_channel_) {
			printf("writes item: %zu\n", dst_frame_.samples_per_channel_);
		}
		else {
			g_bytes += 2 * dst_frame_.samples_per_channel_;
		}   



		if (audioproc_->set_stream_delay_ms(totalDelayMS) != 0) {
			// Silently ignore this failure to avoid flooding the logs.
		}

		webrtc::GainControl* agc = audioproc_->gain_control();
		if (agc->set_stream_analog_level(currentMicLevel) != 0) {
			assert(false);
		}
#if 0
		webrtc::EchoCancellation* aec = audioproc_->echo_cancellation();
		if (aec->is_drift_compensation_enabled()) {
			aec->set_stream_drift_samples(clockDrift);
		}
#endif
		audioproc_->set_stream_key_pressed(keyPressed);

		int err = audioproc_->ProcessStream(&dst_frame_);
		if (err != 0) {
			assert(false);
		}
		/*
		int rc = fwrite((int8_t*)dst_frame_.data(), 2, dst_frame_.samples_per_channel_, record_file);
		if (rc < dst_frame_.samples_per_channel_) {
		printf("writes item: %d\n", dst_frame_.samples_per_channel_);
		}
		else {
		g_bytes += 2 * dst_frame_.samples_per_channel_;
		}
		*/
		//fwrite((int8_t*)dst_frame_.data(), 2, dst_frame_.samples_per_channel_, record_file);
		/*
		int ret;
		ret = WebRtcVad_Process(vad, samplesPerSec,
		(int16_t*)audioSamples, nSamples);
		if (ret == 0) {
		return 0;
		}
		printf("");
		int16_t *samples = (int16_t *)buffer->push();
		if (samples == NULL) {
		printf("drop oldest recorded frame");
		buffer->pop();
		samples = (int16_t *)buffer->push();
		assert(samples);
		}
		int maxLen = SAMPLES_PER_10MS;
		size_t outLen = 0;
		resampler_in->Push((const int16_t*)audioSamples,
		nSamples,
		samples,
		maxLen, outLen);
		ret = WebRtcAec_Process(aec,
		samples,
		NULL,
		samples,
		NULL,
		SAMPLES_PER_10MS,
		totalDelayMS,
		0);
		assert(ret != -1);
		if(ret == -1){
		printf("%d %d", ret, WebRtcAec_get_error_code(aec));
		}
		int status = 0;
		int err = WebRtcAec_get_echo_status(aec, &status);
		if(status == 1){
		}
		*/

		return 0;
	}

	virtual int32_t NeedMorePlayData(
		const size_t nSamples,
		const size_t nBytesPerSample,
		const size_t nChannels,
		const uint32_t samplesPerSec,
		void* audioSamples,
		size_t& nSamplesOut,
		int64_t* elapsed_time_ms,
		int64_t* ntp_time_ms) override
	{
		/*
		printf("NeedMorePlayData %d %d %d %d\n", nSamples,
		nBytesPerSample,
		nChannels,
		samplesPerSec);
		*/
		int old_samples_per_channel = 160;
		int old_channels = 1;
		int16_t old_samples[161] = { 0 };
		fread(old_samples, 2, old_samples_per_channel, record_file);
		//nSamplesOut = nSamples;

		/*

		int ret = 0;
		//ret = WebRtcAec_BufferFarend(aec, samples, SAMPLES_PER_10MS);
		//assert(ret == 0);
		*/

		dst_frame_.sample_rate_hz_ = samplesPerSec;
		dst_frame_.num_channels_ = nChannels;
#if 1 // comment it for linker error ;
		hskdmo::RemixAndResample(old_samples,
			old_samples_per_channel,
			old_channels,
			16000,
			&resampler_,
			&dst_frame_);
#endif
		nSamplesOut = dst_frame_.samples_per_channel_;
		memcpy(audioSamples, dst_frame_.data(), nBytesPerSample * nSamplesOut);
		*elapsed_time_ms = dst_frame_.elapsed_time_ms_;
		*ntp_time_ms = dst_frame_.ntp_time_ms_;

		return 0;
	}

	virtual void PullRenderData(int bits_per_sample,
		int sample_rate,
		size_t number_of_channels,
		size_t number_of_frames,
		void* audio_data,
		int64_t* elapsed_time_ms,
		int64_t* ntp_time_ms) override
	{

	}
};











#define CHEN_LOG_SHOW std::cout << "[info]" << __FUNCTION__ << "[" << __LINE__ << "] thread_id = " << std::this_thread::get_id() << std::endl;



#define CHEN_LOG_SHOW_END std::cout << "[info]" << __FUNCTION__ << "[" << __LINE__ << "] end thread_id = " << std::this_thread::get_id() << std::endl;


















































rtc::AsyncSocket* CreateClientSocket(int family) {
#ifdef WIN32
	rtc::Win32Socket* sock = new rtc::Win32Socket();
	sock->CreateT(family, SOCK_STREAM);
	return sock;
#elif defined(WEBRTC_POSIX)
	rtc::Thread* thread = rtc::Thread::Current();
	RTC_DCHECK(thread != NULL);
	return thread->socketserver()->CreateAsyncSocket(family, SOCK_STREAM);
#else
#error Platform not supported.
#endif
}
class cTestClient : public sigslot::has_slots<> ,
	public rtc::MessageHandler
{
public:
	cTestClient(rtc::AsyncSocket * control_socket):control_socket_(control_socket) {}
	~cTestClient() {}
public:
	void OnMessage(rtc::Message* msg)
	{
		init();
	}
	bool init()
	{
		CHEN_LOG_SHOW


			control_socket_->SignalCloseEvent.connect(this, &cTestClient:: OnClose);
			// hanging_get_->SignalCloseEvent.connect(this, &PeerConnectionClient::OnClose);
			control_socket_->SignalConnectEvent.connect(this, &cTestClient::OnConnect);
			control_socket_->SignalWriteEvent.connect(this, &cTestClient::OnWrite);
			// hanging_get_->SignalConnectEvent.connect(
			//     this, &PeerConnectionClient::OnHangingGetConnect);
			control_socket_->SignalReadEvent.connect(this, &cTestClient::OnRead);

	/*		control_socket_->SignalConnect.connect(this, &cTestClient::OnConnect);
		control_socket_->SignalClose.connect(this, &cTestClient::OnClose);
		control_socket_->SignalReadPacket.connect(this, &cTestClient::OnRead);
		control_socket_->SignalSentPacket.connect(this, &cTestClient::OnWrite);*/
		onconnect_data_.clear();
		char line[1024] = {0};

		snprintf(line, 1024, "GET /%s HTTP/1.1\r\n", "/?roomId=chensong&peerId=xiqhlyrn"); 
		onconnect_data_ = line;
		snprintf(line, 1024, "Host: %s:%d\r\n", server_address_.hostname().c_str(), server_address_.ip()); 
		onconnect_data_ += line;


		static const char * user_agent = "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36\r\n";

		onconnect_data_ += user_agent;


		snprintf(line, 1024, "Upgrade: websocket\r\n"); 
		onconnect_data_ += line;

		snprintf(line, 1024, "Connection: Upgrade\r\n");
		onconnect_data_ += line;

		snprintf(line, 1024, "Origin: http://%s:%u\r\n", server_address_.hostname().c_str(), server_address_.ip()); 
		onconnect_data_ += line;
		snprintf(line, 1024, "Sec-WebSocket-Key: x3JJHMbDL1EzLkh9GBhXDw==\r\n");
		onconnect_data_ += line;
		snprintf(line, 1024, "Sec-WebSocket-Version: 13\r\n"); 
		onconnect_data_ += line;

		static const char * websocketproto = "Sec-WebSocket-Protocol: protoo\r\n";
		onconnect_data_ += websocketproto;
		onconnect_data_ += "\r\n";
		 

		//rtc::PacketOptions options;
		//// socket->Send(onconnect_data_.c_str(), onconnect_data_.length(), options); 
		//control_socket_->Send(onconnect_data_.c_str(), onconnect_data_.length() );
		//onconnect_data_.clear();
		
		return true;
	}
	void OnClose(rtc::AsyncSocket* socket, int error)
	{
		CHEN_LOG_SHOW
	}
	void OnConnect(rtc::AsyncSocket* socket)
	{
		CHEN_LOG_SHOW
			rtc::PacketOptions options;
		socket->Send(onconnect_data_.c_str(), onconnect_data_.length()); 
		//control_socket_->Send(onconnect_data_.c_str(), onconnect_data_.length(), options);
		onconnect_data_.clear();
	}
	void OnWrite(rtc::AsyncSocket* socket )
	{
		CHEN_LOG_SHOW
	}
	void OnRead(rtc::AsyncSocket* socket )
	{
		CHEN_LOG_SHOW

	}
public:
	rtc::AsyncSocket* control_socket_;
	std::string control_data_;
	std::string onconnect_data_;
	rtc::SocketAddress server_address_;
};

//rtc::AsyncSocket* CreateClientSocket(int family) {
//#ifdef WIN32
//	rtc::Win32Socket* sock = new rtc::Win32Socket();
//	sock->CreateT(family, SOCK_STREAM);
//	return sock;
//#elif defined(WEBRTC_POSIX)
//	rtc::Thread* thread = rtc::Thread::Current();
//	RTC_DCHECK(thread != NULL);
//	return thread->socketserver()->CreateAsyncSocket(family, SOCK_STREAM);
//#else
//#error Platform not supported.
//#endif
//}


class Async :  public sigslot::has_slots<> ,
	public rtc::MessageHandler
{
public:
	void OnMessage(rtc::Message* msg)
	{
		//init();
	}
	Async(rtc::AsyncTCPSocket* async_socket)
		:m_async_socket(async_socket)
	{
		m_async_socket->SignalConnect.connect(this, &Async::OnConnect);
	}
	void OnConnect(rtc::AsyncPacketSocket* socket)
	{
		CHEN_LOG_SHOW
	}


	rtc::AsyncTCPSocket* m_async_socket;
};


int main(int argc, char *argv[])
{
	WSADATA wsaData;
	WORD wVersionRequested = MAKEWORD(1, 0);
	WSAStartup(wVersionRequested, &wsaData);
	rtc::SocketAddress server_addr;
	server_addr.SetIP("127.0.0.1");
	server_addr.SetPort(8888);
	rtc::PhysicalSocketServer server;

	rtc::AsyncSocket *async_socket = server.CreateAsyncSocket(server_addr.ipaddr().family(), SOCK_STREAM);
	cTestClient client(async_socket);
	client.init();
	
	async_socket->Connect(server_addr);
	 
	while (true)
	{
		RTC_LOG(INFO) << "[INFO]" << "wiat 100 ...";;
		server.Wait(100, true);
		//std::this_thread::sleep_for(std::chrono::milliseconds(10));
	}


	
	 

	//delete server;





	return 0;
	/*cTestClient client;
	client.init();*/

	while (true)
	{
		std::this_thread::sleep_for(std::chrono::milliseconds(100));
	}
	return 0;

	/*if (argc < 2) {
		fprintf(stderr, "Need input the param recording(1) or playout(2).\n");
		return -1;
	}*/

	int mode = 1/*atoi(argv[1])*/;
	if (mode == PLAYOUT_MODE){
		record_file = fopen("recordingdata.pcm", "rb");
	}
	else {
		record_file = fopen("recordingdata.pcm", "wb+");
	}
	if (!record_file) {
		fprintf(stderr, "Open file failed!\n");
		return -1;
	}

	rtc::scoped_refptr<webrtc::AudioDeviceModule> adm = nullptr;
	adm = webrtc::AudioDeviceModule::Create(
		webrtc::AudioDeviceModule::kPlatformDefaultAudio);
	assert(adm);

	// Initialize audio device module
	adm->Init();

	int num{ 0 };
	int ret{ 0 };

	setlocale(LC_CTYPE, "");

	AudioTransportImpl callback(adm);
	ret = adm->RegisterAudioCallback(&callback);

	if (mode== PLAYOUT_MODE) {
		num = adm->PlayoutDevices();
		printf("Output devices: %d\n", num);
		for (int i = 0; i < num; i++) {
			char name[webrtc::kAdmMaxDeviceNameSize];
			char guid[webrtc::kAdmMaxGuidSize];
			int ret = adm->PlayoutDeviceName(i, name, guid);
			if (ret != -1) {
				printf("	%d %s %s\n", i, name, guid);
			}
		}

		ret = adm->SetPlayoutDevice(
			webrtc::AudioDeviceModule::WindowsDeviceType::kDefaultCommunicationDevice);		
		ret = adm->InitPlayout();
		printf("Start playout\n");
		ret = adm->StartPlayout();
	}
	else {
		num = adm->RecordingDevices();
		printf("Input devices: %d\n", num);
		for (int i = 0; i < num; i++) {
			char name[webrtc::kAdmMaxDeviceNameSize];
			char guid[webrtc::kAdmMaxGuidSize];
			int ret = adm->RecordingDeviceName(i, name, guid);
			if (ret != -1) {
				printf("###  %d %s %s\n", i, name, guid);
			}
		}
#if 0 //this is maybe for windows
		ret = adm->SetRecordingDevice(
			webrtc::AudioDeviceModule::WindowsDeviceType::kDefaultCommunicationDevice);
#else 
		//use kPlatformDefaultAudio,or callback will not be execute
		ret = adm->SetRecordingDevice(webrtc::AudioDeviceModule::AudioLayer::kPlatformDefaultAudio);
#endif 
		ret = adm->InitRecording();
		printf("Start recording\n");
		ret = adm->StartRecording();		
	}

	while (true)
	{
		printf("sleep 10000 ...\n");
		Sleep(1000);
	}
	

	printf("End play or recording\n");

	if (mode == RECORD_MODE) {
		adm->StopRecording();
	}
	else {
		adm->StopPlayout();
	}
	adm->Terminate();

	Sleep(2);

	fclose(record_file);
	record_file = NULL;

	printf("total bytes:%d\n", g_bytes);

	return 0;
}


