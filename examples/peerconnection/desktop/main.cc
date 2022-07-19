/*
 *  Copyright 2012 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "examples/peerconnection/desktop/conductor.h"
#include "examples/peerconnection/desktop/flag_defs.h"
#include "examples/peerconnection/desktop/main_wnd.h"
#include "examples/peerconnection/desktop/peer_connection_client.h"
#include "rtc_base/checks.h"
#include "rtc_base/ssl_adapter.h"
#include "rtc_base/win32_socket_init.h"
#include "rtc_base/win32_socket_server.h"
#include "system_wrappers/include/field_trial.h"
#include "test/field_trial.h"

#include <iostream>
#include <thread>
#include <chrono>
//webrtc::VoiceEngine* ptrVoEngine_;  //核心引擎类，下面的四个类的都是基于引擎创建的
//webrtc::VoEBase* ptrVoEBase_;
//webrtc::VoEVolumeControl* ptrVoEVolumeControl_;//声音控制类，设置麦克风与声卡的声音等
//webrtc::VoEFile* ptrVoEFile_;//音频文件管理，播放文件，保存文件等
//webrtc::VoEHardware* ptrVoEHardware_;//设备相关，可以获取设备，打开设备，播放等

void test()
{
	//webrtc::VoiceEngine::Create();
}


int Pnum = 0, Cnum;//父窗口数量，每一级父窗口的子窗口数量

				   //---------------------------------------------------------
				   //EnumChildWindows回调函数，hwnd为指定的父窗口
				   //---------------------------------------------------------
BOOL CALLBACK EnumChildWindowsProc(HWND hWnd, LPARAM lParam)
{
	wchar_t WindowTitle[100] = { 0 };
	Cnum++;
	::GetWindowText(hWnd, WindowTitle, 100);

	return true;
}
//---------------------------------------------------------
//EnumWindows回调函数，hwnd为发现的顶层窗口
//---------------------------------------------------------
BOOL CALLBACK EnumWindowsProc(HWND hWnd, LPARAM lParam)
{
	if (GetParent(hWnd) == NULL && IsWindowVisible(hWnd))  //判断是否顶层窗口并且可见
	{
		Pnum++;
		Cnum = 0;
		wchar_t WindowTitle[100] = { 0 };
		::GetWindowText(hWnd, WindowTitle, 100);

		EnumChildWindows(hWnd, EnumChildWindowsProc, NULL); //获取父窗口的所有子窗口
	}
	return true;
}
//---------------------------------------------------------
//main函数
//---------------------------------------------------------

//获取屏幕上所有的顶层窗口,每发现一个窗口就调用回调函数一次


struct handle_data {
	unsigned long process_id;
	HWND best_handle;
};

BOOL IsMainWindow(HWND handle)
{
	return GetWindow(handle, GW_OWNER) == (HWND)0 && IsWindowVisible(handle);
}
BOOL CALLBACK EnumWindowsCallback(HWND handle, LPARAM lParam)
{
	handle_data& data = *(handle_data*)lParam;
	unsigned long process_id = 0;
	GetWindowThreadProcessId(handle, &process_id);
	printf("process_id = %lu\n", process_id);
	if (data.process_id != process_id || !IsMainWindow(handle)) {
		return TRUE;
	}
	data.best_handle = handle;
	return FALSE;
}

HWND FindMainWindow()
{
	handle_data data;
	data.process_id = ::GetCurrentProcessId();
	data.best_handle = 0;
	EnumWindows(EnumWindowsCallback, (LPARAM)&data);
	return data.best_handle;
}

#include <dinput.h>
#include <dinputd.h>
#include <iostream>
//using namespace std;
//#pragma comment(lib, "dinput8.lib")
//#pragma comment(lib, "DXGuid.lib")  // unresolved external symbol for guid
//
////#define DIRECTINPUT_VERSION 0x0700
//#include <dinput.h>
//#define DINPUT_BUFFERSIZE 16
//LPDIRECTINPUT8 lpDirectInput;  // DirectInput object
//LPDIRECTINPUTDEVICE8 lpMouse;  // DirectInput device
//
//#pragma comment(lib, "dxguid.lib")
//#pragma comment(lib, "dinput.lib")
//
//
//  BOOL InitDInput(HWND hWnd) {
//  HRESULT hr;
//
//  // 创建一个 DIRECTINPUT 对象
//  hr = DirectInput8Create(GetModuleHandle(NULL), DIRECTINPUT_VERSION,
//                          IID_IDirectInput8, (LPVOID*)&lpDirectInput, NULL);
//  if
//    FAILED(hr) return FALSE;
//
//  // 创建一个 DIRECTINPUTDEVICE 界面
//  hr = lpDirectInput->CreateDevice(GUID_SysMouse, &lpMouse, NULL);
//  if
//    FAILED(hr) return FALSE;
//
//  // 设定查询鼠标状态的返回数据格式
//  hr = lpMouse->SetDataFormat(&c_dfDIMouse);
//  if
//    FAILED(hr) return FALSE;
//
//  // 设定协作模式
//  hr = lpMouse->SetCooperativeLevel(hWnd, DISCL_EXCLUSIVE | DISCL_FOREGROUND);
//  if
//    FAILED(hr) return FALSE;
//
//  // 设定缓冲区大小(不设定，缓冲区大小默认值为
//  // 0，程序就只能按立即模式工作;如果要用缓冲模式工作，必须使缓冲区大小超过0)
//  DIPROPDWORD property;
//  property.diph.dwSize = sizeof(DIPROPDWORD);
//  property.diph.dwHeaderSize = sizeof(DIPROPHEADER);
//  property.diph.dwObj = 0;
//  property.diph.dwHow = DIPH_DEVICE;
//  property.dwData = DINPUT_BUFFERSIZE;
//  hr = lpMouse->SetProperty(DIPROP_BUFFERSIZE, &property.diph);
//  if
//    FAILED(hr) return FALSE;
//
//  //获取使用权
//  hr = lpMouse->Acquire();
//  // lpMouse->SendDeviceData();
//  if
//    FAILED(hr) return FALSE;
//
//  return TRUE;
//}
//
//HRESULT UpdateInputState(void) {
//  DWORD i;
//  printf("[%s][%s][%d]\n", __FILE__, __FUNCTION__, __LINE__);
//  if (lpMouse != NULL) {
//    DIDEVICEOBJECTDATA didod;  // Receives buffered data
//    DWORD dwElements;
//    HRESULT hr;
//
//    while (TRUE) {
//      dwElements = 1;  // 每次从缓冲区中读一个数据
//      hr = lpMouse->GetDeviceData(sizeof(DIDEVICEOBJECTDATA), &didod,
//                                  &dwElements, 0);
//      printf("[%s][%s][%d]\n", __FILE__, __FUNCTION__, __LINE__);
//      if
//        FAILED(hr) {
//          // 发生了一个错误
//          if (hr == DIERR_INPUTLOST) {
//            hr = lpMouse->Acquire();  // 试图重新取回设备
//            if
//              FAILED(hr)
//
//            return S_FALSE;  // 失败
//          }
//        }
//      else if (dwElements == 1) {
//        switch (didod.dwOfs) {
//          case DIMOFS_X:  // X 轴偏移量
//            // didod.dwData 里是具体偏移相对值，单位为像素
//            break;
//          case DIMOFS_Y:  // Y 轴偏移量
//            // didod.dwData 里是具体偏移相对值，单位为像素
//            break;
//          case DIMOFS_BUTTON0:  // 0 号键（左键）状态
//            // didod.dwData 里是具体状态值
//            // 低字节最高位为 1 则表示按下
//            // 低字节最高位为 0 表示未按下
//            break;
//          case DIMOFS_BUTTON1:  // 1 号键（右键）状态
//            // 同上
//            break;
//          case DIMOFS_BUTTON2:  // 2 号键（中键）状态
//            // 同上
//            break;
//          case DIMOFS_BUTTON3:  // 3 号键状态
//            // 同上
//            break;
//        }
//      } else if (dwElements == 0)
//        break;  // 缓冲区读空
//    }
//  }
//  printf("[%s][%s][%d]\n", __FILE__, __FUNCTION__, __LINE__);
//  return S_OK;
//}
//
//void ReleaseDInput(void) {
//  if (lpDirectInput) {
//    if (lpMouse) {
//      // Always unacquire the device before calling Release().
//      lpMouse->Unacquire();
//      lpMouse->Release();
//      lpMouse = NULL;
//    }
//    lpDirectInput->Release();
//    lpDirectInput = NULL;
//  }
//}





int PASCAL wWinMain(HINSTANCE instance,
                    HINSTANCE prev_instance,
                    wchar_t* cmd_line,
                    int cmd_show) {
  rtc::WinsockInitializer winsock_init;
  rtc::Win32SocketServer w32_ss;
  rtc::Win32Thread w32_thread(&w32_ss);
  rtc::ThreadManager::Instance()->SetCurrentThread(&w32_thread);

  rtc::WindowsCommandLineArguments win_args;
  int argc = win_args.argc();
  char** argv = win_args.argv();

  rtc::FlagList::SetFlagsFromCommandLine(&argc, argv, true);
  if (FLAG_help) {
    rtc::FlagList::Print(NULL, false);
    return 0;
  }

  webrtc::test::ValidateFieldTrialsStringOrDie(FLAG_force_fieldtrials);
  // InitFieldTrialsFromString stores the char*, so the char array must outlive
  // the application.
  webrtc::field_trial::InitFieldTrialsFromString(FLAG_force_fieldtrials);

  // Abort if the user specifies a port that is outside the allowed
  // range [1, 65535].
  if ((FLAG_port < 1) || (FLAG_port > 65535)) {
    printf("Error: %i is not a valid port.\n", FLAG_port);
    return -1;
  }

  MainWnd wnd(FLAG_server, FLAG_port, FLAG_autoconnect, FLAG_autocall);
  if (!wnd.Create()) {
    RTC_NOTREACHED();
    return -1;
  }

  rtc::InitializeSSL();
  PeerConnectionClient client;
  rtc::scoped_refptr<Conductor> conductor(
      new rtc::RefCountedObject<Conductor>(&client, &wnd));



  //InitDInput(wnd.handle());
  //std::thread([]() 
  //{ 
	//  UpdateInputState(); 
  //}).detach();
  // Main loop.
  MSG msg;

 
   
  BOOL gm;
  FILE* out_file_ptr = ::fopen("chensong_mouse.log", "wb+");
  while ((gm = ::GetMessage(&msg, NULL, 0, 0)) != 0 && gm != -1) 
  {
	 
	  // std::cout << "msg.hand = " << msg.hwnd << ", msg.message" << msg.message << ", msg.wParam = " << msg.wParam << ", msg.LParam = " << msg.lParam << ", time = " << msg.time << ", pt  x = " << msg.pt.x << ", y = " << msg.pt.y;;
    if (!wnd.PreTranslateMessage(&msg)) 
	{
     
		/*
		 HWND        hwnd;
    UINT        message;
    WPARAM      wParam;
    LPARAM      lParam;
    DWORD       time;
    POINT       pt;
		
		*/
     static  std::chrono::steady_clock::time_point pre_time =
          std::chrono::steady_clock::now();
                std::chrono::steady_clock::time_point cur_time_ms =
                    std::chrono::steady_clock::now();
   
		 std::string string_pt =
                    std::to_string(msg.pt.x) + " " + std::to_string(msg.pt.y);
          ::fprintf( out_file_ptr, "[^_^]hwnd  = %p, message = %u, cur_time = %s,   time = %lu , pt = %s, ms = %s , pre_time = %s, rparam = %s, lparam = %s\n",
                     msg.hwnd, msg.message, std::to_string(::time(NULL)).c_str(),
                     msg.time, string_pt.c_str(),
                           std::to_string(cur_time_ms.time_since_epoch().count()).c_str(),
                     std::to_string(pre_time.time_since_epoch().count())
                         .c_str(),
                     std::to_string(msg.wParam).c_str(), std::to_string(msg.lParam).c_str());

		  ::fflush(out_file_ptr);
      ::TranslateMessage(&msg);
             
	 /* string_pt = std::to_string(msg.pt.x) + " " + std::to_string(msg.pt.y);
      ::fprintf(out_file_ptr,
                "[^_^]hwnd  = %p, message = %u,  time = %lu , pt = %s, ms = %s "
                ", pre_time = %s\n",
                msg.hwnd, msg.message, msg.time, string_pt.c_str(),
                std::to_string(cur_time_ms.time_since_epoch().count()).c_str(),
                std::to_string(pre_time.time_since_epoch().count()).c_str());
          ::fflush(out_file_ptr);*/
      ::DispatchMessage(&msg);
    }
  }

  if (conductor->connection_active() || client.is_connected()) {
    while ((conductor->connection_active() || client.is_connected()) &&
           (gm = ::GetMessage(&msg, NULL, 0, 0)) != 0 && gm != -1) {
      if (!wnd.PreTranslateMessage(&msg)) {
        ::TranslateMessage(&msg);
        ::DispatchMessage(&msg);
      }
    }
  }

  rtc::CleanupSSL();
  return 0;
}
