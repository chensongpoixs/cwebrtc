/*
 *  Copyright 2012 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef EXAMPLES_PEERCONNECTION_CLIENT_MAIN_WND_H_
#define EXAMPLES_PEERCONNECTION_CLIENT_MAIN_WND_H_

#include <map>
#include <memory>
#include <string>
#include <chrono>
#include <thread>
#include "api/media_stream_interface.h"
#include "api/video/i420_buffer.h"
#include "api/video/video_frame.h"
#include "examples/peerconnection/desktop/peer_connection_client.h"
#include "media/base/media_channel.h"
#include "media/base/video_common.h"
#if defined(WEBRTC_WIN)
#include "rtc_base/win32.h"

#include <Windows.h>
#include <d3d9.h>
#include <d3d9caps.h>
#include <d3d9helper.h>
#include <d3d9types.h>
//#include <d3dx9.h>
#pragma comment(lib, "d3d9.lib")  // located in DirectX SDK
#endif                            // WEBRTC_WIN

class MainWndCallback {
 public:
  virtual void StartLogin(const std::string& server,
                          int port,
                          const std::string& turn_url,
                          const std::string& user_name,
                          const std::string& pass_word) = 0;
  virtual void DisconnectFromServer() = 0;
  virtual void ConnectToPeer(int peer_id) = 0;
  virtual void DisconnectFromCurrentPeer() = 0;
  virtual void UIThreadCallback(int msg_id, void* data) = 0;
  virtual void Close() = 0;

 protected:
  virtual ~MainWndCallback() {}
};

// Pure virtual interface for the main window.
class MainWindow {
 public:
  virtual ~MainWindow() {}

  enum UI {
    CONNECT_TO_SERVER,
    LIST_PEERS,
    STREAMING,
  };

  virtual void RegisterObserver(MainWndCallback* callback) = 0;

  virtual bool IsWindow() = 0;
  virtual void MessageBox(const char* caption,
                          const char* text,
                          bool is_error) = 0;

  virtual UI current_ui() = 0;

  virtual void SwitchToConnectUI() = 0;
  virtual void SwitchToPeerList(const Peers& peers) = 0;
  virtual void SwitchToStreamingUI() = 0;

  virtual void StartLocalRenderer(webrtc::VideoTrackInterface* local_video) = 0;
  virtual void StopLocalRenderer() = 0;
  virtual void StartRemoteRenderer(
      webrtc::VideoTrackInterface* remote_video) = 0;
  virtual void StopRemoteRenderer() = 0;

  virtual void QueueUIThreadCallback(int msg_id, void* data) = 0;
};

#ifdef WIN32

class MainWnd : public MainWindow {
 public:
  static const wchar_t kClassName[];

  enum WindowMessages {
    UI_THREAD_CALLBACK = WM_APP + 1,
  };

  MainWnd(const char* server, int port, bool auto_connect, bool auto_call);
  ~MainWnd();

  bool Create();
  bool Destroy();
  bool PreTranslateMessage(MSG* msg);

  virtual void RegisterObserver(MainWndCallback* callback);
  virtual bool IsWindow();
  virtual void SwitchToConnectUI();
  virtual void SwitchToPeerList(const Peers& peers);
  virtual void SwitchToStreamingUI();
  virtual void MessageBox(const char* caption, const char* text, bool is_error);
  virtual UI current_ui() { return ui_; }

  virtual void StartLocalRenderer(webrtc::VideoTrackInterface* local_video);
  virtual void StopLocalRenderer();
  virtual void StartRemoteRenderer(webrtc::VideoTrackInterface* remote_video);
  virtual void StopRemoteRenderer();

  virtual void QueueUIThreadCallback(int msg_id, void* data);

  HWND handle() const { return wnd_; }

  class VideoRenderer : public rtc::VideoSinkInterface<webrtc::VideoFrame> {
   public:
    VideoRenderer(HWND wnd,
                  int width,
                  int height,

                  webrtc::VideoTrackInterface* track_to_render,
                  bool render = true);
    virtual ~VideoRenderer();

    // void Lock() { ::EnterCriticalSection(&buffer_lock_); }

    // void Unlock() { ::LeaveCriticalSection(&buffer_lock_); }
    void DrawTextToTexture(const std::wstring& text);
    // VideoSinkInterface implementation
    void OnFrame(const webrtc::VideoFrame& frame) override;

    //   const BITMAPINFO& bmi() const { return bmi_; }
    //   const uint8_t* image() const { return image_.get(); }

    size_t getWidth() const { return width_; }
    size_t getHeight() const { return height_; }

   protected:
    void SetSize(int width, int height);

    enum {
      SET_SIZE,
      RENDER_FRAME,
    };

    HWND wnd_;
    // BITMAPINFO bmi_;
    // std::unique_ptr<uint8_t[]> image_;
    // CRITICAL_SECTION buffer_lock_;

    size_t width_, height_;
    rtc::scoped_refptr<IDirect3D9> d3d_;
    rtc::scoped_refptr<IDirect3DDevice9> d3d_device_;

    rtc::scoped_refptr<IDirect3DTexture9> texture_;
    rtc::scoped_refptr<IDirect3DVertexBuffer9> vertex_buffer_;
    rtc::scoped_refptr<webrtc::VideoTrackInterface> rendered_track_;
    rtc::scoped_refptr<webrtc::I420Buffer> i420_buffer_;
    bool renderer_;
    int64_t timestamp_{std::chrono::duration_cast<std::chrono::milliseconds>(
                            std::chrono::system_clock::now().time_since_epoch())
                            .count()};
    size_t cnt{0};
    std::string osd_{"renderFps:0/s"};
  };

  // A little helper class to make sure we always to proper locking and
  // unlocking when working with VideoRenderer buffers.
  template <typename T>
  class AutoLock {
   public:
    explicit AutoLock(T* obj) : obj_(obj) { obj_->Lock(); }
    ~AutoLock() { obj_->Unlock(); }

   protected:
    T* obj_;
  };

 protected:
  enum ChildWindowID {
    EDIT_ID = 1,
    BUTTON_ID,
    LABEL1_ID,
    LABEL2_ID,
    LABEL3_ID,
    LABEL4_ID,
    LABEL5_ID,
    LISTBOX_ID,
  };

  void OnPaint();
  void OnDestroyed();

  void OnDefaultAction();

  bool OnMessage(UINT msg, WPARAM wp, LPARAM lp, LRESULT* result);

  static LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wp, LPARAM lp);
  static bool RegisterWindowClass();

  void CreateChildWindow(HWND* wnd,
                         ChildWindowID id,
                         const wchar_t* class_name,
                         DWORD control_style,
                         DWORD ex_style);
  void CreateChildWindows();

  void LayoutConnectUI(bool show);
  void LayoutPeerListUI(bool show);

  void HandleTabbing();

 private:
  std::unique_ptr<VideoRenderer> local_renderer_;
  std::unique_ptr<VideoRenderer> remote_renderer_;
  UI ui_;
  HWND wnd_;
  DWORD ui_thread_id_;
  HWND edit1_;
  HWND edit2_;
  HWND edit3_;
  HWND edit4_;
  HWND edit5_;
  HWND label1_;
  HWND label2_;
  HWND label3_;  // turn
  HWND label4_;  // username;
  HWND label5_;  // password
  HWND button_;
  HWND listbox_;
  bool destroyed_;
  void* nested_msg_;
  MainWndCallback* callback_;
  static ATOM wnd_class_;
  std::string server_;
  std::string port_;
  std::string turn_url_;
  std::string user_name_;
  std::string pass_word_;
  bool auto_connect_;
  bool auto_call_;
};
#endif  // WIN32

#endif  // EXAMPLES_PEERCONNECTION_CLIENT_MAIN_WND_H_
