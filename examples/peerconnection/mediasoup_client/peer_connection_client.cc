/*
 *  Copyright 2012 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "examples/peerconnection/mediasoup_client/peer_connection_client.h"

#include "examples/peerconnection/mediasoup_client/defaults.h"
#include "rtc_base/checks.h"
#include "rtc_base/logging.h"
#include "rtc_base/net_helpers.h"
#include <iostream>
#include <thread>
#ifdef WIN32
#include "rtc_base/win32_socket_server.h"
#endif
#include "rtc_base/strings/json.h"
namespace {

// This is our magical hangup signal.
const char kByeMessage[] = "BYE";
// Delay between server connection retries, in milliseconds
const int kReconnectDelay = 2000;

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

}  // namespace

PeerConnectionClient::PeerConnectionClient()
    : callback_(NULL), resolver_(NULL), state_(NOT_CONNECTED), my_id_(-1),m_websocket_protoo_id(7583332) {}

PeerConnectionClient::~PeerConnectionClient() {}

void PeerConnectionClient::InitSocketSignals() {
  RTC_DCHECK(control_socket_.get() != NULL);
 // RTC_DCHECK(hanging_get_.get() != NULL);
  control_socket_->SignalCloseEvent.connect(this,
                                            &PeerConnectionClient::OnClose);
 // hanging_get_->SignalCloseEvent.connect(this, &PeerConnectionClient::OnClose);
  control_socket_->SignalConnectEvent.connect(this,
                                              &PeerConnectionClient::OnConnect);
  control_socket_->SignalWriteEvent.connect(this, &PeerConnectionClient::OnWrite);
 // hanging_get_->SignalConnectEvent.connect(
 //     this, &PeerConnectionClient::OnHangingGetConnect);
  control_socket_->SignalReadEvent.connect(this, &PeerConnectionClient::OnRead);
 // hanging_get_->SignalReadEvent.connect(
 //     this, &PeerConnectionClient::OnHangingGetRead);
}

int PeerConnectionClient::id() const {
  return my_id_;
}

bool PeerConnectionClient::is_connected() const {
  return my_id_ != -1;
}

const Peers& PeerConnectionClient::peers() const {
  return peers_;
}

void PeerConnectionClient::RegisterObserver(
    PeerConnectionClientObserver* callback) {
  RTC_DCHECK(!callback_);
  callback_ = callback;
}

void PeerConnectionClient::Connect(const std::string& server,
                                   int port,
                                   const std::string& client_name) {
  RTC_DCHECK(!server.empty());
  RTC_DCHECK(!client_name.empty());

  if (state_ != NOT_CONNECTED) {
    RTC_LOG(WARNING)
        << "The client must not be connected before you can call Connect()";
    callback_->OnServerConnectionFailure();
    return;
  }

  if (server.empty() || client_name.empty()) {
    callback_->OnServerConnectionFailure();
    return;
  }

  if (port <= 0)
    port = kDefaultServerPort;

  server_address_.SetIP(server);
  server_address_.SetPort(port);
  client_name_ = client_name;

  /*
  if (server_address_.IsUnresolvedIP()) {
    state_ = RESOLVING;
    resolver_ = new rtc::AsyncResolver();
    resolver_->SignalDone.connect(this, &PeerConnectionClient::OnResolveResult);
    resolver_->Start(server_address_);
  } else*/
  {
    DoConnect();
  }
}

void PeerConnectionClient::OnResolveResult(
    rtc::AsyncResolverInterface* resolver) {
  if (resolver_->GetError() != 0) {
    callback_->OnServerConnectionFailure();
    resolver_->Destroy(false);
    resolver_ = NULL;
    state_ = NOT_CONNECTED;
  } else {
    server_address_ = resolver_->address();
    DoConnect();
  }
}

void PeerConnectionClient::DoConnect() {
  control_socket_.reset(CreateClientSocket(server_address_.ipaddr().family()));
 // hanging_get_.reset(CreateClientSocket(server_address_.ipaddr().family()));
  InitSocketSignals();
  //char buffer[1024] = {0};
  //sprintf(buffer, "[%s]", std::to_string(std::this_thread::get_id()));
 // RTC_LOG(INFO) << __FUNCTION__ << " start , thread_id = " << buffer;
  RTC_LOG(INFO) << "connect websocket id = " << std::this_thread::get_id();
  RTC_LOG(INFO)<< "[INFO]" << __FUNCTION__ << ", start thread_id = " << std::this_thread::get_id();
  /*
  GET /?roomId=chensong&peerId=xiqhlyrn HTTP/1.1
  Host: 127.0.0.1:9000
  Connection: Upgrade
  Pragma: no-cache
  Cache-Control: no-cache
  User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36 Edg/95.0.1020.44
  Upgrade: websocket
  Origin: https://169.254.119.31:3000
  Sec-WebSocket-Version: 13
  Accept-Encoding: gzip, deflate, br
  Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6
  Sec-WebSocket-Key: sloDVaAu6/ye7AgZlX1BJw==
  Sec-WebSocket-Extensions: permessage-deflate; client_max_window_bits
  Sec-WebSocket-Protocol: protoo

  */


  /* char buffer[1024];
  snprintf(buffer, sizeof(buffer), "GET /sign_in?%s HTTP/1.0\r\n\r\n",
  client_name_.c_str());*/

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
  bool ret = ConnectControlSocket();
 // RTC_LOG(INFO) << __FUNCTION__ << " connect end !@!! , thread_id = " << buffer;
  RTC_LOG(INFO) << "[INFO]" << __FUNCTION__ << ", end thread_id = " << std::this_thread::get_id();
  if (ret)
  {
	  state_ = SIGNING_IN;
  }
  if (!ret) {
    callback_->OnServerConnectionFailure();
  }
}

bool PeerConnectionClient::SendToPeer(int peer_id, const std::string& message) {
  if (state_ != CONNECTED)
    return false;

  RTC_DCHECK(is_connected());
  RTC_DCHECK(control_socket_->GetState() == rtc::Socket::CS_CLOSED);
  if (!is_connected() || peer_id == -1)
    return false;

  char headers[1024];
  snprintf(headers, sizeof(headers),
           "POST /message?peer_id=%i&to=%i HTTP/1.0\r\n"
           "Content-Length: %zu\r\n"
           "Content-Type: text/plain\r\n"
           "\r\n",
           my_id_, peer_id, message.length());
  onconnect_data_ = headers;
  onconnect_data_ += message;
  return ConnectControlSocket();
}

bool PeerConnectionClient::SendHangUp(int peer_id) {
  return SendToPeer(peer_id, kByeMessage);
}

bool PeerConnectionClient::IsSendingMessage() {
  return state_ == CONNECTED &&
         control_socket_->GetState() != rtc::Socket::CS_CLOSED;
}

bool PeerConnectionClient::SignOut() {
  if (state_ == NOT_CONNECTED || state_ == SIGNING_OUT)
    return true;

  /*if (hanging_get_->GetState() != rtc::Socket::CS_CLOSED)
    hanging_get_->Close();*/

  if (control_socket_->GetState() == rtc::Socket::CS_CLOSED) {
    state_ = SIGNING_OUT;

    if (my_id_ != -1) {
      char buffer[1024];
      snprintf(buffer, sizeof(buffer),
               "GET /sign_out?peer_id=%i HTTP/1.0\r\n\r\n", my_id_);
      onconnect_data_ = buffer;
      return ConnectControlSocket();
    } else {
      // Can occur if the app is closed before we finish connecting.
      return true;
    }
  } else {
    state_ = SIGNING_OUT_WAITING;
  }

  return true;
}

void PeerConnectionClient::Close() 
{

  control_socket_->Close();
 // hanging_get_->Close();
  onconnect_data_.clear();
  peers_.clear();
  if (resolver_ != NULL) {
    resolver_->Destroy(false);
    resolver_ = NULL;
  }
  my_id_ = -1;
  state_ = NOT_CONNECTED;
}

bool PeerConnectionClient::ConnectControlSocket() {
  RTC_DCHECK(control_socket_->GetState() == rtc::Socket::CS_CLOSED);
  int err = control_socket_->Connect(server_address_);
  if (err == SOCKET_ERROR) {
    Close();
    return false;
  }
  return true;
}

void PeerConnectionClient::OnConnect(rtc::AsyncSocket* socket) 
{
	/*char buffer[1024] = {0};
	sprintf(buffer, "%p", std::this_thread::get_id());
	RTC_LOG(INFO) << __FUNCTION__ << ", thread_id = " << buffer; */

	RTC_LOG(INFO) << "[INFO]" << __FUNCTION__ << ", start thread_id = " << std::this_thread::get_id();

	RTC_LOG(INFO) << __FUNCTION__ << ",  start !!! thread_id = " << std::this_thread::get_id();
  RTC_DCHECK(!onconnect_data_.empty());
  state_ = CONNECT_HANDSHAKE;
  size_t sent = socket->Send(onconnect_data_.c_str(), onconnect_data_.length());
  RTC_DCHECK(sent == onconnect_data_.length());
  onconnect_data_.clear();
  RTC_LOG(INFO) << __FUNCTION__ << ",  end !!!";
}
void PeerConnectionClient::OnWrite(rtc::AsyncSocket* socket)
{
	RTC_LOG(INFO)<< "[INFO]" << __FUNCTION__ << ", start thread_id = " << std::this_thread::get_id();

	//char buffer[1024] = {0};
	//sprintf(buffer, "%p", std::this_thread::get_id());
	//RTC_LOG(INFO) << __FUNCTION__ << ", thread_id = " << buffer;
	RTC_LOG(INFO) << __FUNCTION__ << ",  start !!! thread_id = " << std::this_thread::get_id();
	RTC_LOG(INFO) << "write data  ^_^ !!!";
	//control_socket_->SignalWriteEvent.connect(this, &PeerConnectionClient::OnWrite);
}
void PeerConnectionClient::OnHangingGetConnect(rtc::AsyncSocket* socket) {
  char buffer[1024];
  snprintf(buffer, sizeof(buffer), "GET /wait?peer_id=%i HTTP/1.0\r\n\r\n",
           my_id_);
  int len = static_cast<int>(strlen(buffer));
  int sent = socket->Send(buffer, len);
  RTC_DCHECK(sent == len);
}

void PeerConnectionClient::OnMessageFromPeer(int peer_id,
                                             const std::string& message) {
  if (message.length() == (sizeof(kByeMessage) - 1) &&
      message.compare(kByeMessage) == 0) {
    callback_->OnPeerDisconnected(peer_id);
  } else {
    callback_->OnMessageFromPeer(peer_id, message);
  }
}

bool PeerConnectionClient::GetHeaderValue(const std::string& data,
                                          size_t eoh,
                                          const char* header_pattern,
                                          size_t* value) {
  RTC_DCHECK(value != NULL);
  size_t found = data.find(header_pattern);
  if (found != std::string::npos && found < eoh) {
    *value = atoi(&data[found + strlen(header_pattern)]);
    return true;
  }
  return false;
}

bool PeerConnectionClient::GetHeaderValue(const std::string& data,
                                          size_t eoh,
                                          const char* header_pattern,
                                          std::string* value) {
  RTC_DCHECK(value != NULL);
  size_t found = data.find(header_pattern);
  if (found != std::string::npos && found < eoh) {
    size_t begin = found + strlen(header_pattern);
    size_t end = data.find("\r\n", begin);
    if (end == std::string::npos)
      end = eoh;
    value->assign(data.substr(begin, end - begin));
    return true;
  }
  return false;
}

bool PeerConnectionClient::ReadIntoBuffer(rtc::AsyncSocket* socket,
                                          std::string* data,
                                          size_t* content_length) {
  char buffer[0xffff];
  do {
    int bytes = socket->Recv(buffer, sizeof(buffer), nullptr);
    if (bytes <= 0)
      break;
    data->append(buffer, bytes);
  } while (true);
  return data->length() > 0 ? true : false;
  /////////////////////////////////////////////////////////////////////////////////////////
  bool ret = false;
  size_t i = data->find("\r\n\r\n");
  if (i != std::string::npos) {
    RTC_LOG(INFO) << "Headers received";
    if (GetHeaderValue(*data, i, "\r\nContent-Length: ", content_length)) {
      size_t total_response_size = (i + 4) + *content_length;
      if (data->length() >= total_response_size) {
        ret = true;
        std::string should_close;
        const char kConnection[] = "\r\nConnection: ";
        if (GetHeaderValue(*data, i, kConnection, &should_close) &&
            should_close.compare("close") == 0) {
          socket->Close();
          // Since we closed the socket, there was no notification delivered
          // to us.  Compensate by letting ourselves know.
          OnClose(socket, 0);
        }
      } else {
        // We haven't received everything.  Just continue to accept data.
      }
    } else {
      RTC_LOG(LS_ERROR) << "No content length field specified by the server.";
    }
  }
  return ret;
}

void PeerConnectionClient::OnRead(rtc::AsyncSocket* socket) 
{
	RTC_LOG(INFO) << "[INFO]" << __FUNCTION__ << ", start thread_id = " << std::this_thread::get_id();


	/*char buffer[1024] = {0};
	sprintf(buffer, "%p", std::this_thread::get_id());
	RTC_LOG(INFO) << __FUNCTION__ << ", thread_id = " << buffer;*/
  size_t content_length = 0;
  if (ReadIntoBuffer(socket, &control_data_, &content_length)) 
  {
	// TODO@chensong 2021-12-31  websocket 连接进行handshake 交换
	  int status = 0;
	  if (state_ == CONNECT_HANDSHAKE)
	  {
		  // 判断服务器校验是否成功
		  if (sscanf(control_data_.c_str(), "HTTP/1.1 %d", &status) != 1 || status != 101)
		  {
			  state_ = SIGNING_OUT_WAITING;
			  RTC_LOG(INFO) << "websocket protoo handshake  failed !!! message = " << control_data_;
		  }
		  else
		  {
			  state_ = CONNECTED; // 连接成功哈
			  RTC_LOG(INFO) << "websocket protoo handshake sucesss !!!";
		  }

		  //json data = {
			 // "request":true,
			 // "id":7583332, //  
			 // "method":"getRouterRtpCapabilities", //方法
			 // "data":{

		  //}
		  //};


		  Json::StyledWriter writer;
		  Json::Value jmessage;
		   
		  jmessage["request"] = true;
		  jmessage["id"] = ++m_websocket_protoo_id; 
		  jmessage["method"] = "getRouterRtpCapabilities";
		  jmessage["data"] = Json::objectValue;
		  //SendMessage(writer.write(jmessage));
		  //
		  std::string message = writer.write(jmessage);
		  RTC_LOG(INFO) << "[INFO]" << "send message = " << message << "   !!!";
		  sendData(wsheader_type::TEXT_FRAME, (const uint8_t *)message.c_str(), message.length());
		  // socket->Send(message.c_str(), message.length());
		  control_data_.clear();
	  }
	  else  if (state_ == CONNECTED)
	  {
		  // 正常业务的处理 
		  RTC_LOG(INFO) << "[INFO]" << "recv message = " << control_data_ << "   !!!";
		 // m_recv_data.insert(m_recv_data.end(), (const uint8_t *)control_data_.c_str());
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
			  sendData(wsheader_type::PONG,(uint8_t*)data.c_str(),data.length());
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
	  else
	  {
		 
		  // warring  
	  }
	  control_data_.clear();
	  return;
////////////////////////////////////////////////////////////////////////////////////////////

    size_t peer_id = 0, eoh = 0;
    bool ok =
        ParseServerResponse(control_data_, content_length, &peer_id, &eoh);
    if (ok) {
      if (my_id_ == -1) {
        // First response.  Let's store our server assigned ID.
        RTC_DCHECK(state_ == SIGNING_IN);
        my_id_ = static_cast<int>(peer_id);
        RTC_DCHECK(my_id_ != -1);

        // The body of the response will be a list of already connected peers.
        if (content_length) {
          size_t pos = eoh + 4;
          while (pos < control_data_.size()) {
            size_t eol = control_data_.find('\n', pos);
            if (eol == std::string::npos)
              break;
            int id = 0;
            std::string name;
            bool connected;
            if (ParseEntry(control_data_.substr(pos, eol - pos), &name, &id,
                           &connected) &&
                id != my_id_) {
              peers_[id] = name;
              callback_->OnPeerConnected(id, name);
            }
            pos = eol + 1;
          }
        }
        RTC_DCHECK(is_connected());
        callback_->OnSignedIn();
      } else if (state_ == SIGNING_OUT) {
        Close();
        callback_->OnDisconnected();
      } else if (state_ == SIGNING_OUT_WAITING) {
        SignOut();
      }
    }

    control_data_.clear();

   /* if (state_ == SIGNING_IN) {
      RTC_DCHECK(hanging_get_->GetState() == rtc::Socket::CS_CLOSED);
      state_ = CONNECTED;
      hanging_get_->Connect(server_address_);
    }*/
  }
}



void PeerConnectionClient::sendData(wsheader_type::opcode_type type,const uint8_t* message_begin, size_t message_len)
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
		control_socket_->Send(&txbuf[0], txbuf.size());
	}

}
void PeerConnectionClient::OnHangingGetRead(rtc::AsyncSocket* socket) {
  RTC_LOG(INFO) << __FUNCTION__;
  size_t content_length = 0;
  if (ReadIntoBuffer(socket, &notification_data_, &content_length)) {
    size_t peer_id = 0, eoh = 0;
    bool ok =
        ParseServerResponse(notification_data_, content_length, &peer_id, &eoh);

    if (ok) {
      // Store the position where the body begins.
      size_t pos = eoh + 4;

      if (my_id_ == static_cast<int>(peer_id)) {
        // A notification about a new member or a member that just
        // disconnected.
        int id = 0;
        std::string name;
        bool connected = false;
        if (ParseEntry(notification_data_.substr(pos), &name, &id,
                       &connected)) {
          if (connected) {
            peers_[id] = name;
            callback_->OnPeerConnected(id, name);
          } else {
            peers_.erase(id);
            callback_->OnPeerDisconnected(id);
          }
        }
      } else {
        OnMessageFromPeer(static_cast<int>(peer_id),
                          notification_data_.substr(pos));
      }
    }

    notification_data_.clear();
  }

  //if (hanging_get_->GetState() == rtc::Socket::CS_CLOSED &&
  //    state_ == CONNECTED) {
  //  hanging_get_->Connect(server_address_);
  //}
}

bool PeerConnectionClient::ParseEntry(const std::string& entry,
                                      std::string* name,
                                      int* id,
                                      bool* connected) {
  RTC_DCHECK(name != NULL);
  RTC_DCHECK(id != NULL);
  RTC_DCHECK(connected != NULL);
  RTC_DCHECK(!entry.empty());

  *connected = false;
  size_t separator = entry.find(',');
  if (separator != std::string::npos) {
    *id = atoi(&entry[separator + 1]);
    name->assign(entry.substr(0, separator));
    separator = entry.find(',', separator + 1);
    if (separator != std::string::npos) {
      *connected = atoi(&entry[separator + 1]) ? true : false;
    }
  }
  return !name->empty();
}

int PeerConnectionClient::GetResponseStatus(const std::string& response) {
  int status = -1;
  size_t pos = response.find(' ');
  if (pos != std::string::npos)
    status = atoi(&response[pos + 1]);
  return status;
}

bool PeerConnectionClient::ParseServerResponse(const std::string& response,
                                               size_t content_length,
                                               size_t* peer_id,
                                               size_t* eoh) {
  int status = GetResponseStatus(response.c_str());
  if (status != 200) {
    RTC_LOG(LS_ERROR) << "Received error from server";
    Close();
    callback_->OnDisconnected();
    return false;
  }

  *eoh = response.find("\r\n\r\n");
  RTC_DCHECK(*eoh != std::string::npos);
  if (*eoh == std::string::npos)
    return false;

  *peer_id = -1;

  // See comment in peer_channel.cc for why we use the Pragma header and
  // not e.g. "X-Peer-Id".
  GetHeaderValue(response, *eoh, "\r\nPragma: ", peer_id);

  return true;
}

void PeerConnectionClient::OnClose(rtc::AsyncSocket* socket, int err) {
  RTC_LOG(INFO) << __FUNCTION__;

  socket->Close();

#ifdef WIN32
  if (err != WSAECONNREFUSED) {
#else
  if (err != ECONNREFUSED) {
#endif
    /*if (socket == hanging_get_.get()) {
      if (state_ == CONNECTED) {
        hanging_get_->Close();
        hanging_get_->Connect(server_address_);
      }
    } else*/ {
      callback_->OnMessageSent(err);
    }
  } else {
    if (socket == control_socket_.get()) {
      RTC_LOG(WARNING) << "Connection refused; retrying in 2 seconds";
      rtc::Thread::Current()->PostDelayed(RTC_FROM_HERE, kReconnectDelay, this,
                                          0);
    } else {
      Close();
      callback_->OnDisconnected();
    }
  }
}

void PeerConnectionClient::OnMessage(rtc::Message* msg) {
  // ignore msg; there is currently only one supported message ("retry")
  DoConnect();
}
