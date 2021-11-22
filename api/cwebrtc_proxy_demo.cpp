/**
*
*	Copyright (C) 2010 FastTime
*  Description: webrtc proxy demo 
*	Author: chensong
*	Date:	2021.11.22
*/

#include <iostream>
#include <cstdlib>
#include <cstdio>
#include <type_traits>
// webrtc proxy test demo 
namespace chen
{
	template <typename R>
	class ReturnType {
	public:
		template <typename C, typename M>
		void Invoke(C* c, M m) {
			r_ = (c->*m)();
		}
		template <typename C, typename M, typename T1>
		void Invoke(C* c, M m, T1 a1) {
			r_ = (c->*m)(std::move(a1));
		}
		template <typename C, typename M, typename T1, typename T2>
		void Invoke(C* c, M m, T1 a1, T2 a2) {
			r_ = (c->*m)(std::move(a1), std::move(a2));
		}
		template <typename C, typename M, typename T1, typename T2, typename T3>
		void Invoke(C* c, M m, T1 a1, T2 a2, T3 a3) {
			r_ = (c->*m)(std::move(a1), std::move(a2), std::move(a3));
		}
		template <typename C,
			typename M,
			typename T1,
			typename T2,
			typename T3,
			typename T4>
			void Invoke(C* c, M m, T1 a1, T2 a2, T3 a3, T4 a4) {
			r_ = (c->*m)(std::move(a1), std::move(a2), std::move(a3), std::move(a4));
		}
		template <typename C,
			typename M,
			typename T1,
			typename T2,
			typename T3,
			typename T4,
			typename T5>
			void Invoke(C* c, M m, T1 a1, T2 a2, T3 a3, T4 a4, T5 a5) {
			r_ = (c->*m)(std::move(a1), std::move(a2), std::move(a3), std::move(a4),
				std::move(a5));
		}

		R moved_result() { return std::move(r_); }

	private:
		R r_;
	};

	template <>
	class ReturnType<void> {
	public:
		template <typename C, typename M>
		void Invoke(C* c, M m) {
			(c->*m)();
		}
		template <typename C, typename M, typename T1>
		void Invoke(C* c, M m, T1 a1) {
			(c->*m)(std::move(a1));
		}
		template <typename C, typename M, typename T1, typename T2>
		void Invoke(C* c, M m, T1 a1, T2 a2) {
			(c->*m)(std::move(a1), std::move(a2));
		}
		template <typename C, typename M, typename T1, typename T2, typename T3>
		void Invoke(C* c, M m, T1 a1, T2 a2, T3 a3) {
			(c->*m)(std::move(a1), std::move(a2), std::move(a3));
		}

		void moved_result() {}
	};


	/////////////////////////////////////////////////////////

	class MessageHandler {
	public:
		virtual ~MessageHandler() {};
		virtual void OnMessage(/*Message* msg*/) = 0;

	protected:
		MessageHandler() {}

	private:
		MessageHandler(const MessageHandler&) = delete; 
		MessageHandler& operator=(const MessageHandler&) = delete;
		//RTC_DISALLOW_COPY_AND_ASSIGN(MessageHandler);
	};
	//////////////////////////////////////////////////////////

	class SynchronousMethodCall : public MessageHandler  {
	public:
		explicit SynchronousMethodCall( MessageHandler* proxy);
		~SynchronousMethodCall() override;

		void Invoke();

	private:
		void OnMessage() override;

		MessageHandler* proxy_;
	};
	SynchronousMethodCall::SynchronousMethodCall( MessageHandler* proxy )
		: proxy_(proxy){}
	SynchronousMethodCall::~SynchronousMethodCall() = default;
	void SynchronousMethodCall::Invoke() {
		
		proxy_->OnMessage();
	}
	void SynchronousMethodCall::OnMessage(/*rtc::Message**/) {
		
	}
	////////////////////////////////////////////////////////////////////////////

	template <typename C, typename R>
	class MethodCall0 : public MessageHandler{
	public:
		typedef R (C::*Method)();
		MethodCall0(C* c, Method m) : c_(c), m_(m) {}

		R Marshal() {
			SynchronousMethodCall(this).Invoke();
			return r_.moved_result();
		}

	private:
		void OnMessage() { r_.Invoke(c_, m_); }

		C* c_;
		Method m_;
		ReturnType<R> r_;
	};




}


class webrtcCall
{
public:
	void start()
	{
		printf("webrtc proxy call  start ^_^ !!!\n");
	}
};

class webrtcProxyCall
{
public:

	webrtcProxyCall() 
	{
		ptr = new webrtcCall();
	}
	~webrtcProxyCall() {}

	void test()
	{
		chen::MethodCall0<webrtcCall, void> call(ptr, &webrtcCall::start);
		return call.Marshal();
	}
private:
	webrtcCall * ptr;

};


int main(int argc, char * argv[])
{
	//printf("hello world !!!\n");
	webrtcProxyCall p;
	p.test();
	//system("pause");
	
	return EXIT_SUCCESS;
}





