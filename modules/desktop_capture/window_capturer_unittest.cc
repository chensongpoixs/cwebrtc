/*
 *  Copyright (c) 2013 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include <memory>
#include <string>
#include <utility>

#include "modules/desktop_capture/desktop_capture_options.h"
#include "modules/desktop_capture/desktop_capturer.h"
#include "modules/desktop_capture/desktop_frame.h"
#include "modules/desktop_capture/desktop_geometry.h"
#include "rtc_base/checks.h"
#include "test/gtest.h"
#include "third_party/libyuv/include/libyuv/convert_argb.h"
#include "third_party/libyuv/include/libyuv.h"
#include "api/video/i420_buffer.h"
#include "api/video/video_frame.h"
#include "common_video/libyuv/include/webrtc_libyuv.h"



namespace chen {

#define max(x, y) (x > y ? x : y)
#define min(x, y) (x < y ? x : y)
#define y(r, g, b) (((66 * r + 129 * g + 25 * b + 128) >> 8) + 16)
#define u(r, g, b) (((-38 * r - 74 * g + 112 * b + 128) >> 8) + 128)
#define v(r, g, b) (((112 * r - 94 * g - 18 * b + 128) >> 8) + 128)
#define color(x) ((unsigned char)((x < 0) ? 0 : ((x > 255) ? 255 : x)))

#define RGBA_YUV420SP 0x00004012
#define BGRA_YUV420SP 0x00004210
#define RGBA_YUV420P 0x00014012
#define BGRA_YUV420P 0x00014210
#define RGB_YUV420SP 0x00003012
#define RGB_YUV420P 0x00013012
#define BGR_YUV420SP 0x00003210
#define BGR_YUV420P 0x00013210

/**
 *   type 0-3位表示b的偏移量
 *        4-7位表示g的偏移量
 *        8-11位表示r的偏移量
 *        12-15位表示rgba一个像素所占的byte
 *        16-19位表示yuv的类型，0为420sp，1为420p
 */

void rgbaToYuv(int width,
               int height,
               unsigned char* rgb,
               unsigned char* yuv,
               int type) {
  const int frameSize = width * height;
  const int yuvType = (type & 0x10000) >> 16;
  const int byteRgba = (type & 0x0F000) >> 12;
  const int rShift = (type & 0x00F00) >> 8;
  const int gShift = (type & 0x000F0) >> 4;
  const int bShift = (type & 0x0000F);
  const int uIndex = 0;
  const int vIndex = yuvType;  // yuvType为1表示YUV420p,为0表示420sp

  int yIndex = 0;
  int uvIndex[2] = {frameSize, frameSize + frameSize / 4};

  unsigned char R, G, B, Y, U, V;
  unsigned int index = 0;
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      index = j * width + i;

      R = rgb[index * byteRgba + rShift] & 0xFF;
      G = rgb[index * byteRgba + gShift] & 0xFF;
      B = rgb[index * byteRgba + bShift] & 0xFF;

      Y = y(R, G, B);
      U = u(R, G, B);
      V = v(R, G, B);

      yuv[yIndex++] = color(Y);
      if (j % 2 == 0 && index % 2 == 0) {
        yuv[uvIndex[uIndex]++] = color(U);
        yuv[uvIndex[vIndex]++] = color(V);
      }
    }
  }
}
void Java_com_aiya_jni_DataConvert_rgbaToYuv(uint8_t* rgbaBuffer,
                                             int width,
                                             int height,
                                             uint8_t* yuv,
                                             int type) {
  unsigned char* cRgba = (unsigned char*)rgbaBuffer;

  unsigned char* cYuv = (unsigned char*)yuv;
  rgbaToYuv(width, height, cRgba, cYuv, type);
}

}


namespace webrtc {

	void Calc16ByteAlignedStride(int width, int* stride_y, int* stride_uv) {
  *stride_y = 16 * ((width + 15) / 16);
  *stride_uv = 16 * ((width + 31) / 32);
}

class WindowCapturerTest : public ::testing::Test,
                           public DesktopCapturer::Callback {
 public:
  void SetUp() override {
    capturer_ = DesktopCapturer::CreateWindowCapturer(
        DesktopCaptureOptions::CreateDefault());
    RTC_DCHECK(capturer_);
  }

  void TearDown() override {}

  // DesktopCapturer::Callback interface
  void OnCaptureResult(DesktopCapturer::Result result,
                       std::unique_ptr<DesktopFrame> frame) override {
    frame_ = std::move(frame);



	
      
    

  }

 protected:
  std::unique_ptr<DesktopCapturer> capturer_;
  std::unique_ptr<DesktopFrame> frame_;
};

// Verify that we can enumerate windows.
TEST_F(WindowCapturerTest, Enumerate) {
  DesktopCapturer::SourceList sources;
  EXPECT_TRUE(capturer_->GetSourceList(&sources));

  // Verify that window titles are set.
  for (auto it = sources.begin(); it != sources.end(); ++it) {
    EXPECT_FALSE(it->title.empty());
  }
}

// Flaky on Linux. See: crbug.com/webrtc/7830
#if defined(WEBRTC_LINUX)
#define MAYBE_Capture DISABLED_Capture
#else
#define MAYBE_Capture Capture
#endif
// Verify we can capture a window.
//
// TODO(sergeyu): Currently this test just looks at the windows that already
// exist. Ideally it should create a test window and capture from it, but there
// is no easy cross-platform way to create new windows (potentially we could
// have a python script showing Tk dialog, but launching code will differ
// between platforms).
TEST_F(WindowCapturerTest, MAYBE_Capture) {
  DesktopCapturer::SourceList sources;
  capturer_->Start(this);
  EXPECT_TRUE(capturer_->GetSourceList(&sources));

  // Verify that we can select and capture each window.
  for (auto it = sources.begin(); it != sources.end(); ++it) {
    frame_.reset();
    if (capturer_->SelectSource(it->id)) {
      capturer_->CaptureFrame();
    }

    // If we failed to capture a window make sure it no longer exists.
    if (!frame_.get()) {
      DesktopCapturer::SourceList new_list;
      EXPECT_TRUE(capturer_->GetSourceList(&new_list));
      for (auto new_list_it = new_list.begin(); new_list_it != new_list.end();
           ++new_list_it) {
        EXPECT_FALSE(it->id == new_list_it->id);
      }
      continue;
    }

    EXPECT_GT(frame_->size().width(), 0);
    EXPECT_GT(frame_->size().height(), 0);
  }
}

}  // namespace webrtc
