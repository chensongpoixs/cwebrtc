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

		 std::string string_pt =
                    std::to_string(msg.pt.x) + " " + std::to_string(msg.pt.y);
          ::fprintf( out_file_ptr, "[^_^]hwnd  = %p, message = %u,  time = %lu , pt = %s\n",
                    msg.hwnd, msg.message,  msg.time,
                    string_pt.c_str());

		  ::fflush(out_file_ptr);
      ::TranslateMessage(&msg);
               
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
