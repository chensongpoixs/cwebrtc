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
#include "rtc_base/physical_socket_server.h"



 


 









#define CHEN_LOG_SHOW std::cout << "[info]" << __FUNCTION__ << "[" << __LINE__ << "] thread_id = " << std::this_thread::get_id() << std::endl;



#define CHEN_LOG_SHOW_END std::cout << "[info]" << __FUNCTION__ << "[" << __LINE__ << "] end thread_id = " << std::this_thread::get_id() << std::endl;

enum ESESSION_TYPE
{
	ESession_None = 0,
	ESession_Init,
	ESession_Connnecting,
	ESession_Handshake,
	ESession_Connnectd,
	ESession_Close,
	
};
 
class cTestClient : public sigslot::has_slots<>  
{
private:
	typedef rtc::AsyncSocket			csocket;
	typedef rtc::SocketAddress			caddress;
	typedef rtc::PhysicalSocketServer	cwork;
	typedef std::thread					cthread;

	// http://tools.ietf.org/html/rfc6455#section-5.2  Base Framing Protocol
	//
	//  0                   1                   2                   3
	//  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
	// +-+-+-+-+-------+-+-------------+-------------------------------+
	// |F|R|R|R| opcode|M| Payload len |    Extended payload length    |
	// |I|S|S|S|  (4)  |A|     (7)     |             (16/64)           |
	// |N|V|V|V|       |S|             |   (if payload len==126/127)   |
	// | |1|2|3|       |K|             |                               |
	// +-+-+-+-+-------+-+-------------+ - - - - - - - - - - - - - - - +
	// |     Extended payload length continued, if payload len == 127  |
	// + - - - - - - - - - - - - - - - +-------------------------------+
	// |                               |Masking-key, if MASK set to 1  |
	// +-------------------------------+-------------------------------+
	// | Masking-key (continued)       |          Payload Data         |
	// +-------------------------------- - - - - - - - - - - - - - - - +
	// :                     Payload Data continued ...                :
	// + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
	// |                     Payload Data continued ...                |
	// +---------------------------------------------------------------+
	struct wsheader_type {
		unsigned header_size;
		bool fin;
		bool mask;
		enum opcode_type {
			CONTINUATION = 0x0,
			TEXT_FRAME = 0x1,
			BINARY_FRAME = 0x2,
			CLOSE = 8,
			PING = 9,
			PONG = 0xa,
		} opcode;
		int N0;
		uint64_t N;
		uint8_t masking_key[4];
	};
public:
	cTestClient( ) 
		: m_address()
		, m_socket()
		, m_status(ESession_None)  //后期
		, m_io_work()
		, control_data_()

	{	 onconnect_data_;
		WSADATA wsaData;
		WORD wVersionRequested = MAKEWORD(1, 0);
		WSAStartup(wVersionRequested, &wsaData);
	}
	~cTestClient() {}
public:
 
	bool init(const char * host, uint16_t port)
	{
		CHEN_LOG_SHOW
		m_address.SetIP(host);
		m_address.SetPort(port);



		m_socket = m_io_work.CreateAsyncSocket(m_address.ipaddr().family(), SOCK_STREAM);
		if (!m_socket)
		{
			std::cout << "create async socket failed !!!" << std::endl;
			return false;
		}
		 
		m_socket->SignalCloseEvent.connect(this, &cTestClient:: OnClose); 
		m_socket->SignalConnectEvent.connect(this, &cTestClient::OnConnect);
		m_socket->SignalWriteEvent.connect(this, &cTestClient::OnWrite);
		m_socket->SignalReadEvent.connect(this, &cTestClient::OnRead);
		m_status = ESession_Init;
		return true;
	}


	bool connect_to()
	{
		CHEN_LOG_SHOW
		if (!m_socket)
		{
			return false;
		}
		onconnect_data_.clear();
		char line[1024] = {0};

		snprintf(line, 1024, "GET /%s HTTP/1.1\r\n", "/?roomId=chensong&peerId=xiqhlyrn"); 
		onconnect_data_ = line;
		snprintf(line, 1024, "Host: %s:%d\r\n", m_address.hostname().c_str(), m_address.ip()); 
		onconnect_data_ += line;


		static const char * user_agent = "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36\r\n";

		onconnect_data_ += user_agent;

		snprintf(line, 1024, "Upgrade: websocket\r\n"); 
		onconnect_data_ += line;

		snprintf(line, 1024, "Connection: Upgrade\r\n");
		onconnect_data_ += line;

		snprintf(line, 1024, "Origin: http://%s:%u\r\n", m_address.hostname().c_str(), m_address.ip()); 
		onconnect_data_ += line;
		snprintf(line, 1024, "Sec-WebSocket-Key: x3JJHMbDL1EzLkh9GBhXDw==\r\n");
		onconnect_data_ += line;
		snprintf(line, 1024, "Sec-WebSocket-Version: 13\r\n"); 
		onconnect_data_ += line;

		static const char * websocketproto = "Sec-WebSocket-Protocol: protoo\r\n";
		onconnect_data_ += websocketproto;
		onconnect_data_ += "\r\n";
		m_socket->Connect(m_address);
		m_status = ESession_Connnecting;
		// async connect
		return true;
	}


	bool startup()
	{
		m_thread = std::thread(&cTestClient::_work_thread, this);
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
		onconnect_data_.clear();
		m_status = ESession_Handshake;
	}
	void OnWrite(rtc::AsyncSocket* socket )
	{
		CHEN_LOG_SHOW
	}
	void OnRead(rtc::AsyncSocket* socket )
	{
		CHEN_LOG_SHOW

		if (_read_into_buffer(socket, control_data_))
		{
			if (m_status == ESession_Handshake)
			{
				int status = 0;
				// 判断服务器校验是否成功
				if (sscanf(control_data_.c_str(), "HTTP/1.1 %d", &status) != 1 || status != 101)
				{
					m_status = ESession_Close;
					RTC_LOG(INFO) << "websocket protoo handshake  failed !!! message = " << control_data_;
				}
				else
				{
					m_status = ESession_Connnectd; // 连接成功哈
					RTC_LOG(INFO) << "websocket protoo handshake sucesss !!!";
				}
			}
			else if (m_status == ESession_Connnectd)
			{
				for (const char &value : control_data_)
				{
					m_recv_data.push_back(value);
				}
				wsheader_type ws;
				if (m_recv_data.size() < 2) { return; /* Need at least 2 */ }
				const uint8_t * data = (uint8_t *) &m_recv_data[0]; // peek, but don't consume
				ws.fin = (data[0] & 0x80) == 0x80;
				ws.opcode = (wsheader_type::opcode_type) (data[0] & 0x0f);
				ws.mask = (data[1] & 0x80) == 0x80;
				ws.N0 = (data[1] & 0x7f);
				ws.header_size = 2 + (ws.N0 == 126? 2 : 0) + (ws.N0 == 127? 8 : 0) + (ws.mask? 4 : 0);
				if (m_recv_data.size() < ws.header_size) 
				{ 
					return; /* Need: ws.header_size - rxbuf.size() */ 
				}
				int i = 0;
				if (ws.N0 < 126) {
					ws.N = ws.N0;
					i = 2;
				}
				else if (ws.N0 == 126) {
					ws.N = 0;
					ws.N |= ((uint64_t) data[2]) << 8;
					ws.N |= ((uint64_t) data[3]) << 0;
					i = 4;
				}
				else if (ws.N0 == 127) {
					ws.N = 0;
					ws.N |= ((uint64_t) data[2]) << 56;
					ws.N |= ((uint64_t) data[3]) << 48;
					ws.N |= ((uint64_t) data[4]) << 40;
					ws.N |= ((uint64_t) data[5]) << 32;
					ws.N |= ((uint64_t) data[6]) << 24;
					ws.N |= ((uint64_t) data[7]) << 16;
					ws.N |= ((uint64_t) data[8]) << 8;
					ws.N |= ((uint64_t) data[9]) << 0;
					i = 10;
				}
				if (ws.mask) {
					ws.masking_key[0] = ((uint8_t) data[i+0]) << 0;
					ws.masking_key[1] = ((uint8_t) data[i+1]) << 0;
					ws.masking_key[2] = ((uint8_t) data[i+2]) << 0;
					ws.masking_key[3] = ((uint8_t) data[i+3]) << 0;
				}
				else {
					ws.masking_key[0] = 0;
					ws.masking_key[1] = 0;
					ws.masking_key[2] = 0;
					ws.masking_key[3] = 0;
				}
				if (m_recv_data.size() < ws.header_size+ws.N) 
				{
					return; /* Need: ws.header_size+ws.N - rxbuf.size() */ 
				}

				// We got a whole message, now do something with it:
				if (
					ws.opcode == wsheader_type::TEXT_FRAME 
					|| ws.opcode == wsheader_type::BINARY_FRAME
					|| ws.opcode == wsheader_type::CONTINUATION
					) {
					if (ws.mask) 
					{
						for (size_t i = 0; i != ws.N; ++i)
						{
							m_recv_data[i+ws.header_size] ^= ws.masking_key[i&0x3]; 
						}
					}
					receivedData.insert(receivedData.end(), m_recv_data.begin()+ws.header_size, m_recv_data.begin()+ws.header_size+(size_t)ws.N);// just feed
					if (ws.fin) 
					{

						if (ws.opcode == wsheader_type::TEXT_FRAME)
						{
							std::string stringMessage(receivedData.begin(), receivedData.end());
							//callable.OnMessage(stringMessage);
							RTC_LOG(INFO) << "[INFO] recv stringMessage = " <<stringMessage;
						}
						else
						{
							RTC_LOG(INFO) << "[INFO] recv receivedData = " <<receivedData.data();
							// callable.OnMessage(receivedData);
						}
						receivedData.erase(receivedData.begin(), receivedData.end());
						std::vector<uint8_t> ().swap(receivedData);// free memory
					}
				}
				else if (ws.opcode == wsheader_type::PING)
				{
					if (ws.mask) 
					{
						for (size_t i = 0; i != ws.N; ++i) 
						{
							m_recv_data[i+ws.header_size] ^= ws.masking_key[i&0x3]; 
						}
					}
					std::string data(m_recv_data.begin()+ws.header_size, m_recv_data.begin()+ws.header_size+(size_t)ws.N);
					_send_frame(wsheader_type::PONG,(uint8_t*)data.c_str(),data.length());
				}
				else if (ws.opcode == wsheader_type::PONG) 
				{
				}
				else if (ws.opcode == wsheader_type::CLOSE)
				{
					//  close(); 
				}
				else 
				{
					fprintf(stderr, "ERROR: Got unexpected WebSocket message.\n");
					// close(); 
				}

				m_recv_data.erase(m_recv_data.begin(), m_recv_data.begin() + ws.header_size+(size_t)ws.N);
			}
		}
		control_data_.clear();
	}


private:
	void	_work_thread()
	{
		while (true)
		{
			m_io_work.Wait(100, true); 
		}
		// exit info  try 
	}

	bool _read_into_buffer(rtc::AsyncSocket * socket, std::string& data)
	{
		 char buffer[0Xffff];
		do 
		{
			int bytes = socket->Recv(buffer, sizeof(buffer), nullptr);
			if (bytes <= 0)
			{
				break;
			}
			data.append(buffer, bytes);
		} while (true);
		return data.length() > 0 ? true : false;
			
	}
	// 后期放到session中成员变量 
	void _send_frame(wsheader_type::opcode_type type,const uint8_t* message_begin, size_t message_len)
	{
		// TODO:
		// Masking key should (must) be derived from a high quality random
		// number generator, to mitigate attacks on non-WebSocket friendly
		// middleware:

		std::vector<uint8_t> txbuf;
		const uint8_t masking_key[4] = { 0x12, 0x34, 0x56, 0x78 };



		// TODO: consider acquiring a lock on txbuf...

		std::vector<uint8_t> header;
		header.assign(2 + (message_len >= 126 ? 2 : 0) + (message_len >= 65536 ? 6 : 0) + (true ? 4 : 0), 0);
		header[0] = 0x80 | type;
		if (false) {}
		else if (message_len < 126) {
			header[1] = (message_len & 0xff) | (true ? 0x80 : 0);
			if (true) 
			{
				header[2] = masking_key[0];
				header[3] = masking_key[1];
				header[4] = masking_key[2];
				header[5] = masking_key[3];
			}
		}
		else if (message_len < 65536) {
			header[1] = 126 | (true ? 0x80 : 0);
			header[2] = (message_len >> 8) & 0xff;
			header[3] = (message_len >> 0) & 0xff;
			if (true) {
				header[4] = masking_key[0];
				header[5] = masking_key[1];
				header[6] = masking_key[2];
				header[7] = masking_key[3];
			}
		}
		else { // TODO: run coverage testing here
			header[1] = 127 | (true ? 0x80 : 0);
			header[2] = (message_len >> 56) & 0xff;
			header[3] = (message_len >> 48) & 0xff;
			header[4] = (message_len >> 40) & 0xff;
			header[5] = (message_len >> 32) & 0xff;
			header[6] = (message_len >> 24) & 0xff;
			header[7] = (message_len >> 16) & 0xff;
			header[8] = (message_len >> 8) & 0xff;
			header[9] = (message_len >> 0) & 0xff;
			if (true) {
				header[10] = masking_key[0];
				header[11] = masking_key[1];
				header[12] = masking_key[2];
				header[13] = masking_key[3];
			}
		}
		// N.B. - txbuf will keep growing until it can be transmitted over the socket:
		txbuf.insert(txbuf.end(), header.begin(), header.end());

		//write data
		size_t offset = txbuf.size();
		txbuf.resize(offset+message_len);
		for (size_t i = 0; i< message_len; ++i)
		{
			txbuf[offset+i] = message_begin[i];
		}

		if (true) {
			size_t message_offset = txbuf.size() - message_len;
			for (size_t i = 0; i != message_len; ++i) {
				txbuf[message_offset + i] ^= masking_key[i & 0x3];
			}
		}


		if (txbuf.size())
		{
			m_socket->Send(&txbuf[0], txbuf.size());
		}

	}
public:
	caddress					m_address;
	csocket*					m_socket; // 目前是客户端的唯一socket
	ESESSION_TYPE				m_status;  //后期单独封装到session中去  socket 
	cwork						m_io_work;
	cthread						m_thread;
	std::string					control_data_;
	std::string					onconnect_data_;
	std::vector<uint8_t>		m_recv_data;
	std::vector<uint8_t>		receivedData;
	
};
 
 


int main(int argc, char *argv[])
{
	
	cTestClient client;
	client.init("127.0.0.1", 8888);
	client.connect_to();
	client.startup();

	while (true)
	{
		std::this_thread::sleep_for(std::chrono::microseconds(1000));
	}
	 

	return 0;
}


