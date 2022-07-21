/*
 *  Copyright (c) 2014 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "modules/desktop_capture/win/screen_capturer_win_gdi.h"

#include <utility>

#include "modules/desktop_capture/desktop_capture_options.h"
#include "modules/desktop_capture/desktop_frame.h"
#include "modules/desktop_capture/desktop_frame_win.h"
#include "modules/desktop_capture/desktop_region.h"
#include "modules/desktop_capture/mouse_cursor.h"
#include "modules/desktop_capture/win/cursor.h"
#include "modules/desktop_capture/win/desktop.h"
#include "modules/desktop_capture/win/screen_capture_utils.h"
#include "rtc_base/checks.h"
#include "rtc_base/logging.h"
#include "rtc_base/time_utils.h"
#include "rtc_base/trace_event.h"

namespace webrtc {

namespace {

// Constants from dwmapi.h.
const UINT DWM_EC_DISABLECOMPOSITION = 0;
const UINT DWM_EC_ENABLECOMPOSITION = 1;

const wchar_t kDwmapiLibraryName[] = L"dwmapi.dll";

}  // namespace

ScreenCapturerWinGdi::ScreenCapturerWinGdi(
    const DesktopCaptureOptions& options) {
  if (options.disable_effects()) {
    // Load dwmapi.dll dynamically since it is not available on XP.
    if (!dwmapi_library_)
      dwmapi_library_ = LoadLibraryW(kDwmapiLibraryName);

    if (dwmapi_library_) {
      composition_func_ = reinterpret_cast<DwmEnableCompositionFunc>(
          GetProcAddress(dwmapi_library_, "DwmEnableComposition"));
    }
  }
}
//static FILE* out_file_app_capture_ptr = NULL;
//namespace chen {
//
//int Pnum = 0, Cnum;  //父窗口数量，每一级父窗口的子窗口数量
//
////---------------------------------------------------------
//// EnumChildWindows回调函数，hwnd为指定的父窗口
////---------------------------------------------------------
//BOOL CALLBACK EnumChildWindowsProc(HWND hWnd, LPARAM lParam) {
//  wchar_t WindowTitle[100] = {0};
//  Cnum++;
//  ::GetWindowText(hWnd, WindowTitle, 100);
//
//  return true;
//}
////---------------------------------------------------------
//// EnumWindows回调函数，hwnd为发现的顶层窗口
////---------------------------------------------------------
//BOOL CALLBACK EnumWindowsProc(HWND hWnd, LPARAM lParam) {
//  if (GetParent(hWnd) == NULL &&
//      IsWindowVisible(hWnd))  //判断是否顶层窗口并且可见
//  {
//    Pnum++;
//    Cnum = 0;
//    wchar_t WindowTitle[100] = {0};
//    ::GetWindowText(hWnd, WindowTitle, 100);
//
//    EnumChildWindows(hWnd, EnumChildWindowsProc,
//                     NULL);  //获取父窗口的所有子窗口
//  }
//  return true;
//}
////---------------------------------------------------------
//// main函数
////---------------------------------------------------------
//
////获取屏幕上所有的顶层窗口,每发现一个窗口就调用回调函数一次
//
//struct handle_data {
//  unsigned long process_id;
//  HWND best_handle;
//};
//
//BOOL IsMainWindow(HWND handle) {
//  return GetWindow(handle, GW_OWNER) == (HWND)0 && IsWindowVisible(handle);
//}
//BOOL CALLBACK EnumWindowsCallback(HWND handle, LPARAM lParam) {
//  handle_data& data = *(handle_data*)lParam;
//  unsigned long process_id = 0;
//  GetWindowThreadProcessId(handle, &process_id);
//  // printf("process_id = %lu\n", process_id);
//  if (data.process_id != process_id || !IsMainWindow(handle)) 
//  {
//    if (out_file_app_capture_ptr) {
//      fprintf(out_file_app_capture_ptr, "[warr][process_id = %lu][window_id = %lu]\n", data.process_id, process_id);
//      fflush(out_file_app_capture_ptr);
//    }
//    return TRUE;
//  }
//  if (out_file_app_capture_ptr) {
//    fprintf(out_file_app_capture_ptr,
//            "[info][process_id = %lu][window_id = %lu]\n", data.process_id,
//            process_id);
//    fflush(out_file_app_capture_ptr);
//  }
//  data.best_handle = handle;
//  return FALSE;
//}
//
//HWND FindMainWindow() 
//{
//  if (!out_file_app_capture_ptr) 
//  {
//    out_file_app_capture_ptr = ::fopen("app_gui_capture.log", "wb+");
//  }
//  handle_data data;
//  data.process_id = ::GetCurrentProcessId();
//  if (out_file_app_capture_ptr) 
//  {
//    fprintf(out_file_app_capture_ptr, "[process_id = %lu]\n", data.process_id);
//    fflush(out_file_app_capture_ptr);
//  }
//  data.best_handle = 0;
//  EnumWindows(EnumWindowsCallback, (LPARAM)&data);
//  return data.best_handle;
//}
//
//}  // namespace chen

//static HDC GetAppCgiCapture() 
//{
//	return  GetDC(NULL);
//  HWND wnd = chen::FindMainWindow();  
//  if (!out_file_app_capture_ptr) {
//    out_file_app_capture_ptr = ::fopen("app_gui_capture.log", "wb+");
//  }
//  if (out_file_app_capture_ptr) {
//    ::fprintf(out_file_app_capture_ptr, "app_gui_capture ptr = %p\n", wnd);
//    ::fflush(out_file_app_capture_ptr);
//  }
//  return GetDC(wnd);
//}

ScreenCapturerWinGdi::~ScreenCapturerWinGdi() {
  if (desktop_dc_)
    ReleaseDC(NULL, desktop_dc_);
  if (memory_dc_)
    DeleteDC(memory_dc_);

  // Restore Aero.
  if (composition_func_)
    (*composition_func_)(DWM_EC_ENABLECOMPOSITION);

  if (dwmapi_library_)
    FreeLibrary(dwmapi_library_);
}

void ScreenCapturerWinGdi::SetSharedMemoryFactory(
    std::unique_ptr<SharedMemoryFactory> shared_memory_factory) {
  shared_memory_factory_ = std::move(shared_memory_factory);
}

void ScreenCapturerWinGdi::CaptureFrame() {
  TRACE_EVENT0("webrtc", "ScreenCapturerWinGdi::CaptureFrame");
  int64_t capture_start_time_nanos = rtc::TimeNanos();

  queue_.MoveToNextFrame();
  RTC_DCHECK(!queue_.current_frame() || !queue_.current_frame()->IsShared());

  // Make sure the GDI capture resources are up-to-date.
  PrepareCaptureResources();

  if (!CaptureImage()) {
    RTC_LOG(WARNING) << "Failed to capture screen by GDI.";
    callback_->OnCaptureResult(Result::ERROR_TEMPORARY, nullptr);
    return;
  }

  // Emit the current frame.
  std::unique_ptr<DesktopFrame> frame = queue_.current_frame()->Share();
  frame->set_dpi(DesktopVector(GetDeviceCaps(desktop_dc_, LOGPIXELSX),
                               GetDeviceCaps(desktop_dc_, LOGPIXELSY)));
  frame->mutable_updated_region()->SetRect(
      DesktopRect::MakeSize(frame->size()));
  frame->set_capture_time_ms((rtc::TimeNanos() - capture_start_time_nanos) /
                             rtc::kNumNanosecsPerMillisec);
  frame->set_capturer_id(DesktopCapturerId::kScreenCapturerWinGdi);
  callback_->OnCaptureResult(Result::SUCCESS, std::move(frame));
}

bool ScreenCapturerWinGdi::GetSourceList(SourceList* sources) {
  return webrtc::GetScreenList(sources);
}

bool ScreenCapturerWinGdi::SelectSource(SourceId id) {
  bool valid = IsScreenValid(id, &current_device_key_);
  if (valid)
    current_screen_id_ = id;
  return valid;
}

void ScreenCapturerWinGdi::Start(Callback* callback) {
  RTC_DCHECK(!callback_);
  RTC_DCHECK(callback);

  callback_ = callback;

  // Vote to disable Aero composited desktop effects while capturing. Windows
  // will restore Aero automatically if the process exits. This has no effect
  // under Windows 8 or higher.  See crbug.com/124018.
  if (composition_func_)
    (*composition_func_)(DWM_EC_DISABLECOMPOSITION);
}

void ScreenCapturerWinGdi::PrepareCaptureResources() {
  // Switch to the desktop receiving user input if different from the current
  // one.
  std::unique_ptr<Desktop> input_desktop(Desktop::GetInputDesktop());
  if (input_desktop && !desktop_.IsSame(*input_desktop)) {
    // Release GDI resources otherwise SetThreadDesktop will fail.
    if (desktop_dc_) {
      ReleaseDC(NULL, desktop_dc_);
      desktop_dc_ = nullptr;
    }

    if (memory_dc_) {
      DeleteDC(memory_dc_);
      memory_dc_ = nullptr;
    }

    // If SetThreadDesktop() fails, the thread is still assigned a desktop.
    // So we can continue capture screen bits, just from the wrong desktop.
    desktop_.SetThreadDesktop(input_desktop.release());

    // Re-assert our vote to disable Aero.
    // See crbug.com/124018 and crbug.com/129906.
    if (composition_func_) {
      (*composition_func_)(DWM_EC_DISABLECOMPOSITION);
    }
  }

  // If the display configurations have changed then recreate GDI resources.
  if (display_configuration_monitor_.IsChanged()) {
    if (desktop_dc_) {
      ReleaseDC(NULL, desktop_dc_);
      desktop_dc_ = nullptr;
    }
    if (memory_dc_) {
      DeleteDC(memory_dc_);
      memory_dc_ = nullptr;
    }
  }

  if (!desktop_dc_) {
    RTC_DCHECK(!memory_dc_);

    // Create GDI device contexts to capture from the desktop into memory.
     HWND deskHW = GetDesktopWindow();
    // GetWindowRect(deskHW, &deskRC);
    // deskDC = GetWindowDC(deskHW);
    desktop_dc_ = /*GetAppCgiCapture();*/    GetDC(deskHW);
    RTC_CHECK(desktop_dc_);
    memory_dc_ = CreateCompatibleDC(desktop_dc_);
    RTC_CHECK(memory_dc_);

    // Make sure the frame buffers will be reallocated.
    queue_.Reset();
  }
}


//static DesktopRect GetGUIRect()
//{ 
//	HWND wnd = chen::FindMainWindow(); 
//	if (!wnd)
//	{
//          return DesktopRect();
//	}
//        RECT rect;
//    
//		/*
//		
//		 LONG    left;
//    LONG    top;
//    LONG    right;
//    LONG    bottom;
//		*/
//	if (!GetWindowRect(wnd, &rect))
//	{
//          return DesktopRect(); 
//	}
//
//	return DesktopRect::MakeXYWH(rect.left, rect.top, rect.right, rect.bottom);
//}

bool ScreenCapturerWinGdi::CaptureImage() {
  DesktopRect screen_rect = /*GetGUIRect();*/ GetScreenRect(current_screen_id_, current_device_key_);
  if (screen_rect.is_empty()) {
    RTC_LOG(LS_WARNING) << "Failed to get screen rect.";
    return false;
  }

  DesktopSize size = screen_rect.size();
  // If the current buffer is from an older generation then allocate a new one.
  // Note that we can't reallocate other buffers at this point, since the caller
  // may still be reading from them.
  if (!queue_.current_frame() ||
      !queue_.current_frame()->size().equals(screen_rect.size())) {
    RTC_DCHECK(desktop_dc_);
    RTC_DCHECK(memory_dc_);

    std::unique_ptr<DesktopFrame> buffer = DesktopFrameWin::Create(
        size, shared_memory_factory_.get(), desktop_dc_);
    if (!buffer) {
      RTC_LOG(LS_WARNING) << "Failed to create frame buffer.";
      return false;
    }
    queue_.ReplaceCurrentFrame(SharedDesktopFrame::Wrap(std::move(buffer)));
  }
  queue_.current_frame()->set_top_left(
      screen_rect.top_left().subtract(GetFullscreenRect().top_left()));

  // Select the target bitmap into the memory dc and copy the rect from desktop
  // to memory.
  DesktopFrameWin* current = static_cast<DesktopFrameWin*>(
      queue_.current_frame()->GetUnderlyingFrame());
  HGDIOBJ previous_object = SelectObject(memory_dc_, current->bitmap());
  if (!previous_object || previous_object == HGDI_ERROR) {
    RTC_LOG(LS_WARNING) << "Failed to select current bitmap into memery dc.";
    return false;
  }

  bool result = (BitBlt(memory_dc_, 0, 0, screen_rect.width(),
                        screen_rect.height(), desktop_dc_, screen_rect.left(),
                        screen_rect.top(), SRCCOPY | CAPTUREBLT) != FALSE);
  if (!result) {
    RTC_LOG_GLE(LS_WARNING) << "BitBlt failed";
  }

  // Select back the previously selected object to that the device contect
  // could be destroyed independently of the bitmap if needed.
  SelectObject(memory_dc_, previous_object);

  return result;
}

}  // namespace webrtc
