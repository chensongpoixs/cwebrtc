/*
 *  Copyright 2012 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "examples/peerconnection/desktop/main_wnd.h"

#include <math.h>

#include "api/video/i420_buffer.h"
#include "common_video/libyuv/include/webrtc_libyuv.h"
#include "examples/peerconnection/desktop/defaults.h"
#include "rtc_base/arraysize.h"
#include "rtc_base/checks.h"
#include "rtc_base/logging.h"
#include "third_party/libyuv/include/libyuv/convert_argb.h"
#include "third_party/libyuv/include/libyuv.h"
ATOM MainWnd::wnd_class_ = 0;
const wchar_t MainWnd::kClassName[] = L"WebRTC_MainWnd";

namespace {

// const char kConnecting[] = "Connecting... ";
// const char kNoVideoStreams[] = "(no video streams either way)";
// const char kNoIncomingStream[] = "(no incoming video)";
static const unsigned char table[] = {

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /*" ",0*/

    0x00, 0x00, 0x00, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10,
    0x10, 0x00, 0x00, 0x18, 0x18, 0x00, 0x00, /*"!",1*/

    0x00, 0x12, 0x36, 0x24, 0x48, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /*""",2*/

    0x00, 0x00, 0x00, 0x24, 0x24, 0x24, 0xFE, 0x48, 0x48,
    0x48, 0xFE, 0x48, 0x48, 0x48, 0x00, 0x00, /*"#",3*/

    0x00, 0x00, 0x10, 0x38, 0x54, 0x54, 0x50, 0x30, 0x18,
    0x14, 0x14, 0x54, 0x54, 0x38, 0x10, 0x10, /*"$",4*/

    0x00, 0x00, 0x00, 0x44, 0xA4, 0xA8, 0xA8, 0xA8, 0x54,
    0x1A, 0x2A, 0x2A, 0x2A, 0x44, 0x00, 0x00, /*"%",5*/

    0x00, 0x00, 0x00, 0x30, 0x48, 0x48, 0x48, 0x50, 0x6E,
    0xA4, 0x94, 0x88, 0x89, 0x76, 0x00, 0x00, /*"&",6*/

    0x00, 0x60, 0x60, 0x20, 0xC0, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /*"'",7*/

    0x00, 0x02, 0x04, 0x08, 0x08, 0x10, 0x10, 0x10, 0x10,
    0x10, 0x10, 0x08, 0x08, 0x04, 0x02, 0x00, /*"(",8*/

    0x00, 0x40, 0x20, 0x10, 0x10, 0x08, 0x08, 0x08, 0x08,
    0x08, 0x08, 0x10, 0x10, 0x20, 0x40, 0x00, /*")",9*/

    0x00, 0x00, 0x00, 0x00, 0x10, 0x10, 0xD6, 0x38, 0x38,
    0xD6, 0x10, 0x10, 0x00, 0x00, 0x00, 0x00, /*"*",10*/

    0x00, 0x00, 0x00, 0x00, 0x10, 0x10, 0x10, 0x10, 0xFE,
    0x10, 0x10, 0x10, 0x10, 0x00, 0x00, 0x00, /*"+",11*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x60, 0x60, 0x20, 0xC0, /*",",12*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7F,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /*"-",13*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x60, 0x60, 0x00, 0x00, /*".",14*/

    0x00, 0x00, 0x01, 0x02, 0x02, 0x04, 0x04, 0x08, 0x08,
    0x10, 0x10, 0x20, 0x20, 0x40, 0x40, 0x00, /*"/",15*/

    0x00, 0x00, 0x00, 0x18, 0x24, 0x42, 0x42, 0x42, 0x42,
    0x42, 0x42, 0x42, 0x24, 0x18, 0x00, 0x00, /*"0",16*/

    0x00, 0x00, 0x00, 0x10, 0x70, 0x10, 0x10, 0x10, 0x10,
    0x10, 0x10, 0x10, 0x10, 0x7C, 0x00, 0x00, /*"1",17*/

    0x00, 0x00, 0x00, 0x3C, 0x42, 0x42, 0x42, 0x04, 0x04,
    0x08, 0x10, 0x20, 0x42, 0x7E, 0x00, 0x00, /*"2",18*/

    0x00, 0x00, 0x00, 0x3C, 0x42, 0x42, 0x04, 0x18, 0x04,
    0x02, 0x02, 0x42, 0x44, 0x38, 0x00, 0x00, /*"3",19*/

    0x00, 0x00, 0x00, 0x04, 0x0C, 0x14, 0x24, 0x24, 0x44,
    0x44, 0x7E, 0x04, 0x04, 0x1E, 0x00, 0x00, /*"4",20*/

    0x00, 0x00, 0x00, 0x7E, 0x40, 0x40, 0x40, 0x58, 0x64,
    0x02, 0x02, 0x42, 0x44, 0x38, 0x00, 0x00, /*"5",21*/

    0x00, 0x00, 0x00, 0x1C, 0x24, 0x40, 0x40, 0x58, 0x64,
    0x42, 0x42, 0x42, 0x24, 0x18, 0x00, 0x00, /*"6",22*/

    0x00, 0x00, 0x00, 0x7E, 0x44, 0x44, 0x08, 0x08, 0x10,
    0x10, 0x10, 0x10, 0x10, 0x10, 0x00, 0x00, /*"7",23*/

    0x00, 0x00, 0x00, 0x3C, 0x42, 0x42, 0x42, 0x24, 0x18,
    0x24, 0x42, 0x42, 0x42, 0x3C, 0x00, 0x00, /*"8",24*/

    0x00, 0x00, 0x00, 0x18, 0x24, 0x42, 0x42, 0x42, 0x26,
    0x1A, 0x02, 0x02, 0x24, 0x38, 0x00, 0x00, /*"9",25*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x00,
    0x00, 0x00, 0x00, 0x18, 0x18, 0x00, 0x00, /*":",26*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x10, 0x10, 0x20, /*";",27*/

    0x00, 0x00, 0x00, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40,
    0x20, 0x10, 0x08, 0x04, 0x02, 0x00, 0x00, /*"<",28*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFE, 0x00, 0x00,
    0x00, 0xFE, 0x00, 0x00, 0x00, 0x00, 0x00, /*"=",29*/

    0x00, 0x00, 0x00, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02,
    0x04, 0x08, 0x10, 0x20, 0x40, 0x00, 0x00, /*">",30*/

    0x00, 0x00, 0x00, 0x3C, 0x42, 0x42, 0x62, 0x02, 0x04,
    0x08, 0x08, 0x00, 0x18, 0x18, 0x00, 0x00, /*"?",31*/

    0x00, 0x00, 0x00, 0x38, 0x44, 0x5A, 0xAA, 0xAA, 0xAA,
    0xAA, 0xB4, 0x42, 0x44, 0x38, 0x00, 0x00, /*"@",32*/

    0x00, 0x00, 0x00, 0x10, 0x10, 0x18, 0x28, 0x28, 0x24,
    0x3C, 0x44, 0x42, 0x42, 0xE7, 0x00, 0x00, /*"A",33*/

    0x00, 0x00, 0x00, 0xF8, 0x44, 0x44, 0x44, 0x78, 0x44,
    0x42, 0x42, 0x42, 0x44, 0xF8, 0x00, 0x00, /*"B",34*/

    0x00, 0x00, 0x00, 0x3E, 0x42, 0x42, 0x80, 0x80, 0x80,
    0x80, 0x80, 0x42, 0x44, 0x38, 0x00, 0x00, /*"C",35*/

    0x00, 0x00, 0x00, 0xF8, 0x44, 0x42, 0x42, 0x42, 0x42,
    0x42, 0x42, 0x42, 0x44, 0xF8, 0x00, 0x00, /*"D",36*/

    0x00, 0x00, 0x00, 0xFC, 0x42, 0x48, 0x48, 0x78, 0x48,
    0x48, 0x40, 0x42, 0x42, 0xFC, 0x00, 0x00, /*"E",37*/

    0x00, 0x00, 0x00, 0xFC, 0x42, 0x48, 0x48, 0x78, 0x48,
    0x48, 0x40, 0x40, 0x40, 0xE0, 0x00, 0x00, /*"F",38*/

    0x00, 0x00, 0x00, 0x3C, 0x44, 0x44, 0x80, 0x80, 0x80,
    0x8E, 0x84, 0x44, 0x44, 0x38, 0x00, 0x00, /*"G",39*/

    0x00, 0x00, 0x00, 0xE7, 0x42, 0x42, 0x42, 0x42, 0x7E,
    0x42, 0x42, 0x42, 0x42, 0xE7, 0x00, 0x00, /*"H",40*/

    0x00, 0x00, 0x00, 0x7C, 0x10, 0x10, 0x10, 0x10, 0x10,
    0x10, 0x10, 0x10, 0x10, 0x7C, 0x00, 0x00, /*"I",41*/

    0x00, 0x00, 0x00, 0x3E, 0x08, 0x08, 0x08, 0x08, 0x08,
    0x08, 0x08, 0x08, 0x08, 0x08, 0x88, 0xF0, /*"J",42*/

    0x00, 0x00, 0x00, 0xEE, 0x44, 0x48, 0x50, 0x70, 0x50,
    0x48, 0x48, 0x44, 0x44, 0xEE, 0x00, 0x00, /*"K",43*/

    0x00, 0x00, 0x00, 0xE0, 0x40, 0x40, 0x40, 0x40, 0x40,
    0x40, 0x40, 0x40, 0x42, 0xFE, 0x00, 0x00, /*"L",44*/

    0x00, 0x00, 0x00, 0xEE, 0x6C, 0x6C, 0x6C, 0x6C, 0x54,
    0x54, 0x54, 0x54, 0x54, 0xD6, 0x00, 0x00, /*"M",45*/

    0x00, 0x00, 0x00, 0xC7, 0x62, 0x62, 0x52, 0x52, 0x4A,
    0x4A, 0x4A, 0x46, 0x46, 0xE2, 0x00, 0x00, /*"N",46*/

    0x00, 0x00, 0x00, 0x38, 0x44, 0x82, 0x82, 0x82, 0x82,
    0x82, 0x82, 0x82, 0x44, 0x38, 0x00, 0x00, /*"O",47*/

    0x00, 0x00, 0x00, 0xFC, 0x42, 0x42, 0x42, 0x42, 0x7C,
    0x40, 0x40, 0x40, 0x40, 0xE0, 0x00, 0x00, /*"P",48*/

    0x00, 0x00, 0x00, 0x38, 0x44, 0x82, 0x82, 0x82, 0x82,
    0x82, 0xB2, 0xCA, 0x4C, 0x38, 0x06, 0x00, /*"Q",49*/

    0x00, 0x00, 0x00, 0xFC, 0x42, 0x42, 0x42, 0x7C, 0x48,
    0x48, 0x44, 0x44, 0x42, 0xE3, 0x00, 0x00, /*"R",50*/

    0x00, 0x00, 0x00, 0x3E, 0x42, 0x42, 0x40, 0x20, 0x18,
    0x04, 0x02, 0x42, 0x42, 0x7C, 0x00, 0x00, /*"S",51*/

    0x00, 0x00, 0x00, 0xFE, 0x92, 0x10, 0x10, 0x10, 0x10,
    0x10, 0x10, 0x10, 0x10, 0x38, 0x00, 0x00, /*"T",52*/

    0x00, 0x00, 0x00, 0xE7, 0x42, 0x42, 0x42, 0x42, 0x42,
    0x42, 0x42, 0x42, 0x42, 0x3C, 0x00, 0x00, /*"U",53*/

    0x00, 0x00, 0x00, 0xE7, 0x42, 0x42, 0x44, 0x24, 0x24,
    0x28, 0x28, 0x18, 0x10, 0x10, 0x00, 0x00, /*"V",54*/

    0x00, 0x00, 0x00, 0xD6, 0x92, 0x92, 0x92, 0x92, 0xAA,
    0xAA, 0x6C, 0x44, 0x44, 0x44, 0x00, 0x00, /*"W",55*/

    0x00, 0x00, 0x00, 0xE7, 0x42, 0x24, 0x24, 0x18, 0x18,
    0x18, 0x24, 0x24, 0x42, 0xE7, 0x00, 0x00, /*"X",56*/

    0x00, 0x00, 0x00, 0xEE, 0x44, 0x44, 0x28, 0x28, 0x10,
    0x10, 0x10, 0x10, 0x10, 0x38, 0x00, 0x00, /*"Y",57*/

    0x00, 0x00, 0x00, 0x7E, 0x84, 0x04, 0x08, 0x08, 0x10,
    0x20, 0x20, 0x42, 0x42, 0xFC, 0x00, 0x00, /*"Z",58*/

    0x00, 0x1E, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10,
    0x10, 0x10, 0x10, 0x10, 0x10, 0x1E, 0x00, /*"[",59*/

    0x00, 0x00, 0x40, 0x40, 0x20, 0x20, 0x10, 0x10, 0x10,
    0x08, 0x08, 0x04, 0x04, 0x04, 0x02, 0x02, /*"\",60*/

    0x00, 0x78, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
    0x08, 0x08, 0x08, 0x08, 0x08, 0x78, 0x00, /*"]",61*/

    0x00, 0x1C, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /*"^",62*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, /*"_",63*/

    0x00, 0x60, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /*"`",64*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x42,
    0x1E, 0x22, 0x42, 0x42, 0x3F, 0x00, 0x00, /*"a",65*/

    0x00, 0x00, 0x00, 0xC0, 0x40, 0x40, 0x40, 0x58, 0x64,
    0x42, 0x42, 0x42, 0x64, 0x58, 0x00, 0x00, /*"b",66*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x22,
    0x40, 0x40, 0x40, 0x22, 0x1C, 0x00, 0x00, /*"c",67*/

    0x00, 0x00, 0x00, 0x06, 0x02, 0x02, 0x02, 0x1E, 0x22,
    0x42, 0x42, 0x42, 0x26, 0x1B, 0x00, 0x00, /*"d",68*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x42,
    0x7E, 0x40, 0x40, 0x42, 0x3C, 0x00, 0x00, /*"e",69*/

    0x00, 0x00, 0x00, 0x0F, 0x11, 0x10, 0x10, 0x7E, 0x10,
    0x10, 0x10, 0x10, 0x10, 0x7C, 0x00, 0x00, /*"f",70*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0x44,
    0x44, 0x38, 0x40, 0x3C, 0x42, 0x42, 0x3C, /*"g",71*/

    0x00, 0x00, 0x00, 0xC0, 0x40, 0x40, 0x40, 0x5C, 0x62,
    0x42, 0x42, 0x42, 0x42, 0xE7, 0x00, 0x00, /*"h",72*/

    0x00, 0x00, 0x00, 0x30, 0x30, 0x00, 0x00, 0x70, 0x10,
    0x10, 0x10, 0x10, 0x10, 0x7C, 0x00, 0x00, /*"i",73*/

    0x00, 0x00, 0x00, 0x0C, 0x0C, 0x00, 0x00, 0x1C, 0x04,
    0x04, 0x04, 0x04, 0x04, 0x04, 0x44, 0x78, /*"j",74*/

    0x00, 0x00, 0x00, 0xC0, 0x40, 0x40, 0x40, 0x4E, 0x48,
    0x50, 0x68, 0x48, 0x44, 0xEE, 0x00, 0x00, /*"k",75*/

    0x00, 0x00, 0x00, 0x70, 0x10, 0x10, 0x10, 0x10, 0x10,
    0x10, 0x10, 0x10, 0x10, 0x7C, 0x00, 0x00, /*"l",76*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFE, 0x49,
    0x49, 0x49, 0x49, 0x49, 0xED, 0x00, 0x00, /*"m",77*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xDC, 0x62,
    0x42, 0x42, 0x42, 0x42, 0xE7, 0x00, 0x00, /*"n",78*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x42,
    0x42, 0x42, 0x42, 0x42, 0x3C, 0x00, 0x00, /*"o",79*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD8, 0x64,
    0x42, 0x42, 0x42, 0x44, 0x78, 0x40, 0xE0, /*"p",80*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1E, 0x22,
    0x42, 0x42, 0x42, 0x22, 0x1E, 0x02, 0x07, /*"q",81*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEE, 0x32,
    0x20, 0x20, 0x20, 0x20, 0xF8, 0x00, 0x00, /*"r",82*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0x42,
    0x40, 0x3C, 0x02, 0x42, 0x7C, 0x00, 0x00, /*"s",83*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x10, 0x7C, 0x10,
    0x10, 0x10, 0x10, 0x10, 0x0C, 0x00, 0x00, /*"t",84*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC6, 0x42,
    0x42, 0x42, 0x42, 0x46, 0x3B, 0x00, 0x00, /*"u",85*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE7, 0x42,
    0x24, 0x24, 0x28, 0x10, 0x10, 0x00, 0x00, /*"v",86*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD7, 0x92,
    0x92, 0xAA, 0xAA, 0x44, 0x44, 0x00, 0x00, /*"w",87*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x6E, 0x24,
    0x18, 0x18, 0x18, 0x24, 0x76, 0x00, 0x00, /*"x",88*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE7, 0x42,
    0x24, 0x24, 0x28, 0x18, 0x10, 0x10, 0xE0, /*"y",89*/

    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7E, 0x44,
    0x08, 0x10, 0x10, 0x22, 0x7E, 0x00, 0x00, /*"z",90*/

    0x00, 0x03, 0x04, 0x04, 0x04, 0x04, 0x04, 0x08, 0x04,
    0x04, 0x04, 0x04, 0x04, 0x04, 0x03, 0x00, /*"{
                                                                                                                              ",91*/

    0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
    0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, /*"|",92*/

    0x00, 0x60, 0x10, 0x10, 0x10, 0x10, 0x10, 0x08, 0x10,
    0x10, 0x10, 0x10, 0x10, 0x10, 0x60, 0x00

};

// ptr_frame为YUV420格式字符数组，str为叠加的字符串，startx、starty为要叠加的位置，length为叠加字符的长度
char* draw_font_func(unsigned char* ptr_frameY,
                     unsigned char* ptr_frameU,
                     unsigned char* ptr_frameV,
                     const char* str,
                     int startx,
                     int starty,
                     int color,
                     int length,
                     int wid,
                     int heig) {
  int tagY = 0, tagU = 0, tagV = 0;
  unsigned char *offsetY = NULL, *offsetU = NULL, *offsetV = NULL;
  unsigned short p16, mask16;  // for reading hzk16 dots

  // yuv 地址的设置
  offsetY = ptr_frameY;
  offsetU = ptr_frameU;  // + WIDTH * HEIGHT;
  offsetV = ptr_frameV;  // + WIDTH * HEIGHT/4;
  const char* p = str;

  switch (color) {
    case 0:  // Yellow
      tagY = 226;
      tagU = 0;
      tagV = 149;
      break;
    case 1:  // Red
      tagY = 76;
      tagU = 85;
      tagV = 255;
      break;
    case 2:  // Green
      tagY = 150;
      tagU = 44;
      tagV = 21;
      break;
    case 3:  // Blue
      tagY = 29;
      tagU = 255;
      tagV = 107;
      break;
    default:  // White
      tagY = 128;
      tagU = 128;
      tagV = 128;
  }

  int x = 0, y = 0, i = 1, j = 0, k = 0;
  for (i = 0; i < length; i++) {
    for (j = 0, y = starty; j < 16 && y < heig - 1; j++, y += 2) {
      p16 = (unsigned short)table[(*p - 32) * 16 + j];
      mask16 = 0x0080;  // 二进制 1000 0000
                        // for (k = 0, x = startx +i*32; k < 16 && x < WIDTH -
                        // 1; k++, x+=2)   // dots in a line
      for (k = 0, x = startx + i * 16; k < 8 && x < wid - 1; k++, x += 2) {
        if (p16 & mask16) {
          *(offsetY + y * wid + x) = *(offsetY + y * wid + x + 1) = tagY;
          *(offsetY + (y + 1) * wid + x) = *(offsetY + (y + 1) * wid + x + 1) =
              tagY;
          *(offsetU + y * wid / 4 + x / 2) = tagU;
          *(offsetV + y * wid / 4 + x / 2) = tagV;
        }
        mask16 = mask16 >> 1;  //循环移位取数据
        if (mask16 == 0)
          mask16 = 0x8000;
      }
    }
    p++;
  }
  return NULL;
}
void CalculateWindowSizeForText(HWND wnd,
                                const wchar_t* text,
                                size_t* width,
                                size_t* height) {
  HDC dc = ::GetDC(wnd);
  RECT text_rc = {0};
  ::DrawTextW(dc, text, -1, &text_rc, DT_CALCRECT | DT_SINGLELINE);
  ::ReleaseDC(wnd, dc);
  RECT client, window;
  ::GetClientRect(wnd, &client);
  ::GetWindowRect(wnd, &window);

  *width = text_rc.right - text_rc.left;
  *width += (window.right - window.left) - (client.right - client.left);
  *height = text_rc.bottom - text_rc.top;
  *height += (window.bottom - window.top) - (client.bottom - client.top);
}

HFONT GetDefaultFont() {
  static HFONT font = reinterpret_cast<HFONT>(GetStockObject(DEFAULT_GUI_FONT));
  return font;
}

std::string GetWindowText(HWND wnd) {
  char text[MAX_PATH] = {0};
  ::GetWindowTextA(wnd, &text[0], ARRAYSIZE(text));
  return text;
}

void AddListBoxItem(HWND listbox, const std::string& str, LPARAM item_data) {
  LRESULT index = ::SendMessageA(listbox, LB_ADDSTRING, 0,
                                 reinterpret_cast<LPARAM>(str.c_str()));
  ::SendMessageA(listbox, LB_SETITEMDATA, index, item_data);
}

}  // namespace

MainWnd::MainWnd(const char* server,
                 int port,
                 bool auto_connect,
                 bool auto_call)
    : ui_(CONNECT_TO_SERVER),
      wnd_(NULL),
      edit1_(NULL),
      edit2_(NULL),
      edit3_(NULL),
      edit4_(NULL),
      edit5_(NULL),
      label1_(NULL),
      label2_(NULL),
      label3_(NULL),
      label4_(NULL),
      label5_(NULL),
      button_(NULL),
      listbox_(NULL),
      destroyed_(false),
      nested_msg_(NULL),
      callback_(NULL),
      server_(server),
      turn_url_("turn:192.168.1.6:23333?transport=udp"),
      user_name_("chensong"),
      pass_word_("0123456789"),
      auto_connect_(auto_connect),
      auto_call_(auto_call) {
  char buffer[10];
  snprintf(buffer, sizeof(buffer), "%i", port);
  port_ = buffer;
}

MainWnd::~MainWnd() {
  RTC_DCHECK(!IsWindow());
}

bool MainWnd::Create() {
  RTC_DCHECK(wnd_ == NULL);
  if (!RegisterWindowClass())
    return false;

  ui_thread_id_ = ::GetCurrentThreadId();
  wnd_ =
      ::CreateWindowExW(WS_EX_OVERLAPPEDWINDOW, kClassName, L"TURN_ClientB",
                        WS_OVERLAPPEDWINDOW | WS_VISIBLE | WS_CLIPCHILDREN,
                        CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
                        CW_USEDEFAULT, NULL, NULL, GetModuleHandle(NULL), this);
  /*
  wnd_ =
      ::CreateWindowExW(WS_EX_OVERLAPPEDWINDOW, kClassName, L"WebRTC_DESKTOP",
                        WS_OVERLAPPEDWINDOW | WS_VISIBLE | WS_CLIPCHILDREN,
                  -1920,200,
                   CW_USEDEFAULT, CW_USEDEFAULT,  800,
          800, NULL, NULL, GetModuleHandle(NULL), this);
  */
  ::SendMessage(wnd_, WM_SETFONT, reinterpret_cast<WPARAM>(GetDefaultFont()),
                TRUE);

  CreateChildWindows();
  SwitchToConnectUI();

  return wnd_ != NULL;
}

bool MainWnd::Destroy() {
  BOOL ret = FALSE;
  if (IsWindow()) {
    ret = ::DestroyWindow(wnd_);
  }

  return ret != FALSE;
}

void MainWnd::RegisterObserver(MainWndCallback* callback) {
  callback_ = callback;
}

bool MainWnd::IsWindow() {
  return wnd_ && ::IsWindow(wnd_) != FALSE;
}

bool MainWnd::PreTranslateMessage(MSG* msg) {
  bool ret = false;
  if (msg->message == WM_CHAR) {
    if (msg->wParam == VK_TAB) {
      HandleTabbing();
      ret = true;
    } else if (msg->wParam == VK_RETURN) {
      OnDefaultAction();
      ret = true;
    } else if (msg->wParam == VK_ESCAPE) {
      if (callback_) {
        if (ui_ == STREAMING) {
          callback_->DisconnectFromCurrentPeer();
        } else {
          callback_->DisconnectFromServer();
        }
      }
    }
  } else if (msg->hwnd == NULL && msg->message == UI_THREAD_CALLBACK) {
    callback_->UIThreadCallback(static_cast<int>(msg->wParam),
                                reinterpret_cast<void*>(msg->lParam));
    ret = true;
  }
  return ret;
}

void MainWnd::SwitchToConnectUI() {
  RTC_DCHECK(IsWindow());
  LayoutPeerListUI(false);
  ui_ = CONNECT_TO_SERVER;
  LayoutConnectUI(true);
  ::SetFocus(edit1_);

  if (auto_connect_)
    ::PostMessage(button_, BM_CLICK, 0, 0);
}

void MainWnd::SwitchToPeerList(const Peers& peers) {
  LayoutConnectUI(false);

  ::SendMessage(listbox_, LB_RESETCONTENT, 0, 0);

  AddListBoxItem(listbox_, "List of currently connected peers:", -1);
  Peers::const_iterator i = peers.begin();
  for (; i != peers.end(); ++i)
    AddListBoxItem(listbox_, i->second.c_str(), i->first);

  ui_ = LIST_PEERS;
  LayoutPeerListUI(true);
  ::SetFocus(listbox_);

  if (auto_call_ && peers.begin() != peers.end()) {
    // Get the number of items in the list
    LRESULT count = ::SendMessage(listbox_, LB_GETCOUNT, 0, 0);
    if (count != LB_ERR) {
      // Select the last item in the list
      LRESULT selection = ::SendMessage(listbox_, LB_SETCURSEL, count - 1, 0);
      if (selection != LB_ERR)
        ::PostMessage(wnd_, WM_COMMAND,
                      MAKEWPARAM(GetDlgCtrlID(listbox_), LBN_DBLCLK),
                      reinterpret_cast<LPARAM>(listbox_));
    }
  }
}

void MainWnd::SwitchToStreamingUI() {
  LayoutConnectUI(false);
  LayoutPeerListUI(false);
  ui_ = STREAMING;
}

void MainWnd::MessageBox(const char* caption, const char* text, bool is_error) {
  DWORD flags = MB_OK;
  if (is_error)
    flags |= MB_ICONERROR;

  ::MessageBoxA(handle(), text, caption, flags);
}

void MainWnd::StartLocalRenderer(webrtc::VideoTrackInterface* local_video) {
  local_renderer_.reset(new VideoRenderer(handle(), 1, 1, local_video, false));
}

void MainWnd::StopLocalRenderer() {
  local_renderer_.reset();
}

void MainWnd::StartRemoteRenderer(webrtc::VideoTrackInterface* remote_video) {
  remote_renderer_.reset(new VideoRenderer(handle(), 1, 1, remote_video));
}

void MainWnd::StopRemoteRenderer() {
  remote_renderer_.reset();
}

void MainWnd::QueueUIThreadCallback(int msg_id, void* data) {
  ::PostThreadMessage(ui_thread_id_, UI_THREAD_CALLBACK,
                      static_cast<WPARAM>(msg_id),
                      reinterpret_cast<LPARAM>(data));
}

void MainWnd::OnPaint() {
  PAINTSTRUCT ps;
  ::BeginPaint(handle(), &ps);

  RECT rc;
  ::GetClientRect(handle(), &rc);
  ::EndPaint(handle(), &ps);
  return;

  // VideoRenderer* local_renderer = local_renderer_.get();
  // VideoRenderer* remote_renderer = remote_renderer_.get();
  // if (ui_ == STREAMING && remote_renderer && local_renderer) {
  //  AutoLock<VideoRenderer> local_lock(local_renderer);
  //  AutoLock<VideoRenderer> remote_lock(remote_renderer);

  //  //const BITMAPINFO& bmi = remote_renderer->bmi();
  //  int height = remote_renderer->getHeight();
  //   //abs(bmi.bmiHeader.biHeight);
  //  int width = remote_renderer->getWidth();  //// bmi.bmiHeader.biWidth;

  //  const uint8_t* image = remote_renderer->image();
  //  if (image != NULL) {
  //    HDC dc_mem = ::CreateCompatibleDC(ps.hdc);
  //    ::SetStretchBltMode(dc_mem, HALFTONE);

  //    // Set the map mode so that the ratio will be maintained for us.
  //    HDC all_dc[] = {ps.hdc, dc_mem};
  //    for (size_t i = 0; i < arraysize(all_dc); ++i) {
  //      SetMapMode(all_dc[i], MM_ISOTROPIC);
  //      SetWindowExtEx(all_dc[i], width, height, NULL);
  //      SetViewportExtEx(all_dc[i], rc.right, rc.bottom, NULL);
  //    }

  //    HBITMAP bmp_mem = ::CreateCompatibleBitmap(ps.hdc, rc.right, rc.bottom);
  //    HGDIOBJ bmp_old = ::SelectObject(dc_mem, bmp_mem);

  //    POINT logical_area = {rc.right, rc.bottom};
  //    DPtoLP(ps.hdc, &logical_area, 1);

  //    HBRUSH brush = ::CreateSolidBrush(RGB(0, 0, 0));
  //    RECT logical_rect = {0, 0, logical_area.x, logical_area.y};
  //    ::FillRect(dc_mem, &logical_rect, brush);
  //    ::DeleteObject(brush);

  //    int x = (logical_area.x / 2) - (width / 2);
  //    int y = (logical_area.y / 2) - (height / 2);

  //    StretchDIBits(dc_mem, x, y, width, height, 0, 0, width, height, image,
  //                  &bmi, DIB_RGB_COLORS, SRCCOPY);

  //    if ((rc.right - rc.left) > 200 && (rc.bottom - rc.top) > 200) {
  //      const BITMAPINFO& bmi = local_renderer->bmi();
  //      image = local_renderer->image();
  //      int thumb_width = bmi.bmiHeader.biWidth / 4;
  //      int thumb_height = abs(bmi.bmiHeader.biHeight) / 4;
  //      StretchDIBits(dc_mem, logical_area.x - thumb_width - 10,
  //                    logical_area.y - thumb_height - 10, thumb_width,
  //                    thumb_height, 0, 0, bmi.bmiHeader.biWidth,
  //                    -bmi.bmiHeader.biHeight, image, &bmi, DIB_RGB_COLORS,
  //                    SRCCOPY);
  //    }

  //    BitBlt(ps.hdc, 0, 0, logical_area.x, logical_area.y, dc_mem, 0, 0,
  //           SRCCOPY);

  //    // Cleanup.
  //    ::SelectObject(dc_mem, bmp_old);
  //    ::DeleteObject(bmp_mem);
  //    ::DeleteDC(dc_mem);
  //  } else {
  //    // We're still waiting for the video stream to be initialized.
  //    HBRUSH brush = ::CreateSolidBrush(RGB(0, 0, 0));
  //    ::FillRect(ps.hdc, &rc, brush);
  //    ::DeleteObject(brush);

  //    HGDIOBJ old_font = ::SelectObject(ps.hdc, GetDefaultFont());
  //    ::SetTextColor(ps.hdc, RGB(0xff, 0xff, 0xff));
  //    ::SetBkMode(ps.hdc, TRANSPARENT);

  //    std::string text(kConnecting);
  //    if (!local_renderer->image()) {
  //      text += kNoVideoStreams;
  //    } else {
  //      text += kNoIncomingStream;
  //    }
  //    ::DrawTextA(ps.hdc, text.c_str(), -1, &rc,
  //                DT_SINGLELINE | DT_CENTER | DT_VCENTER);
  //    ::SelectObject(ps.hdc, old_font);
  //  }
  //} else {
  //  HBRUSH brush = ::CreateSolidBrush(::GetSysColor(COLOR_WINDOW));
  //  ::FillRect(ps.hdc, &rc, brush);
  //  ::DeleteObject(brush);
  //}

  ::EndPaint(handle(), &ps);
}

void MainWnd::OnDestroyed() {
  PostQuitMessage(0);
}

void MainWnd::OnDefaultAction() {
  if (!callback_)
    return;
  if (ui_ == CONNECT_TO_SERVER) {
    std::string server(GetWindowText(edit1_));
    std::string port_str(GetWindowText(edit2_));
    std::string turn_url(GetWindowText(edit3_));
    std::string user_name(GetWindowText(edit4_));
    std::string pass_word(GetWindowText(edit5_));
    int port = port_str.length() ? atoi(port_str.c_str()) : 0;
    callback_->StartLogin(server, port, turn_url, user_name, pass_word);
  } else if (ui_ == LIST_PEERS) {
    LRESULT sel = ::SendMessage(listbox_, LB_GETCURSEL, 0, 0);
    if (sel != LB_ERR) {
      LRESULT peer_id = ::SendMessage(listbox_, LB_GETITEMDATA, sel, 0);
      if (peer_id != -1 && callback_) {
        // Á¬½Ó¶Ô·½->peer
        callback_->ConnectToPeer(peer_id);
      }
    }
  } else {
    ::MessageBoxA(wnd_, "OK!", "Yeah", MB_OK);
  }
}

bool MainWnd::OnMessage(UINT msg, WPARAM wp, LPARAM lp, LRESULT* result) {
  switch (msg) {
    case WM_ERASEBKGND:
      *result = TRUE;
      return true;

    case WM_PAINT:
      OnPaint();
      return true;

    case WM_SETFOCUS:
      if (ui_ == CONNECT_TO_SERVER) {
        SetFocus(edit1_);
      } else if (ui_ == LIST_PEERS) {
        SetFocus(listbox_);
      }
      return true;

    case WM_SIZE:
      if (ui_ == CONNECT_TO_SERVER) {
        LayoutConnectUI(true);
      } else if (ui_ == LIST_PEERS) {
        LayoutPeerListUI(true);
      }
      break;

    case WM_CTLCOLORSTATIC:
      *result = reinterpret_cast<LRESULT>(GetSysColorBrush(COLOR_WINDOW));
      return true;

    case WM_COMMAND:
      if (button_ == reinterpret_cast<HWND>(lp)) {
        if (BN_CLICKED == HIWORD(wp))
          OnDefaultAction();
      } else if (listbox_ == reinterpret_cast<HWND>(lp)) {
        if (LBN_DBLCLK == HIWORD(wp)) {
          OnDefaultAction();
        }
      }
      return true;

    case WM_CLOSE:
      if (callback_)
        callback_->Close();
      break;
  }
  return false;
}

// static
LRESULT CALLBACK MainWnd::WndProc(HWND hwnd, UINT msg, WPARAM wp, LPARAM lp) {
  //	WM_LBUTTONDOWN

  //#define WM_LBUTTONDOWN                  0x0201
  //#define WM_LBUTTONUP                    0x0202
  //#define WM_LBUTTONDBLCLK                0x0203

  // static FILE * out_file_ptr = fopen("./test.log", "wb+");
  // if (out_file_ptr)
  //{
  //	if (WM_LBUTTONDOWN == msg)
  //	{
  //		fprintf(out_file_ptr, "[msg = %u][WM_LBUTTONDOWN][]\n", msg);
  //	}
  //	else if (WM_LBUTTONUP == msg)
  //	{
  //		fprintf(out_file_ptr, "[msg = %u][WM_LBUTTONUP][]\n", msg);
  //	}
  //	else if (WM_LBUTTONDBLCLK == msg)
  //	{
  //		fprintf(out_file_ptr, "[msg = %u][WM_LBUTTONDBLCLK][]\n", msg);
  //	}
  //	else
  //	{
  //		fprintf(out_file_ptr, "[msg = %u][][]\n", msg);
  //	}
  //	fflush(out_file_ptr);
  //}

  // RTC_LOG(LS_INFO) << "msg = " << msg << ", wp " << wp << ", lp = " << lp;
  MainWnd* me =
      reinterpret_cast<MainWnd*>(::GetWindowLongPtr(hwnd, GWLP_USERDATA));
  if (!me && WM_CREATE == msg) {
    CREATESTRUCT* cs = reinterpret_cast<CREATESTRUCT*>(lp);
    me = reinterpret_cast<MainWnd*>(cs->lpCreateParams);
    me->wnd_ = hwnd;
    ::SetWindowLongPtr(hwnd, GWLP_USERDATA, reinterpret_cast<LONG_PTR>(me));
  }

  LRESULT result = 0;
  if (me) {
    void* prev_nested_msg = me->nested_msg_;
    me->nested_msg_ = &msg;

    bool handled = me->OnMessage(msg, wp, lp, &result);
    if (WM_NCDESTROY == msg) {
      me->destroyed_ = true;
    } else if (!handled) {
      result = ::DefWindowProc(hwnd, msg, wp, lp);
    }

    if (me->destroyed_ && prev_nested_msg == NULL) {
      me->OnDestroyed();
      me->wnd_ = NULL;
      me->destroyed_ = false;
    }

    me->nested_msg_ = prev_nested_msg;
  } else {
    result = ::DefWindowProc(hwnd, msg, wp, lp);
  }

  return result;
}

// static
bool MainWnd::RegisterWindowClass() {
  if (wnd_class_)
    return true;

  WNDCLASSEXW wcex = {sizeof(WNDCLASSEX)};
  wcex.style = CS_DBLCLKS;
  wcex.hInstance = GetModuleHandle(NULL);
  wcex.hbrBackground = reinterpret_cast<HBRUSH>(COLOR_WINDOW + 1);
  wcex.hCursor = ::LoadCursor(NULL, IDC_ARROW);
  wcex.lpfnWndProc = &WndProc;
  wcex.lpszClassName = kClassName;
  wnd_class_ = ::RegisterClassExW(&wcex);
  RTC_DCHECK(wnd_class_ != 0);
  return wnd_class_ != 0;
}

void MainWnd::CreateChildWindow(HWND* wnd,
                                MainWnd::ChildWindowID id,
                                const wchar_t* class_name,
                                DWORD control_style,
                                DWORD ex_style) {
  if (::IsWindow(*wnd))
    return;

  // Child windows are invisible at first, and shown after being resized.
  DWORD style = WS_CHILD | control_style;
  *wnd = ::CreateWindowExW(ex_style, class_name, L"", style, 100, 100, 100, 100,
                           wnd_, reinterpret_cast<HMENU>(id),
                           GetModuleHandle(NULL), NULL);
  RTC_DCHECK(::IsWindow(*wnd) != FALSE);
  ::SendMessage(*wnd, WM_SETFONT, reinterpret_cast<WPARAM>(GetDefaultFont()),
                TRUE);
}

void MainWnd::CreateChildWindows() {
  // Create the child windows in tab order.
  CreateChildWindow(&label1_, LABEL1_ID, L"Static", ES_CENTER | ES_READONLY, 0);
  CreateChildWindow(&edit1_, EDIT_ID, L"Edit",
                    ES_LEFT | ES_NOHIDESEL | WS_TABSTOP, WS_EX_CLIENTEDGE);
  CreateChildWindow(&label2_, LABEL2_ID, L"Static", ES_CENTER | ES_READONLY, 0);
  CreateChildWindow(&edit2_, EDIT_ID, L"Edit",
                    ES_LEFT | ES_NOHIDESEL | WS_TABSTOP, WS_EX_CLIENTEDGE);
  CreateChildWindow(&button_, BUTTON_ID, L"Button", BS_CENTER | WS_TABSTOP, 0);

  CreateChildWindow(&listbox_, LISTBOX_ID, L"ListBox",
                    LBS_HASSTRINGS | LBS_NOTIFY, WS_EX_CLIENTEDGE);

  CreateChildWindow(&label3_, LABEL3_ID, L"Static", ES_CENTER | ES_READONLY, 0);
  CreateChildWindow(&edit3_, EDIT_ID, L"Edit",
                    ES_LEFT | ES_NOHIDESEL | WS_TABSTOP, WS_EX_CLIENTEDGE);
  CreateChildWindow(&label4_, LABEL4_ID, L"Static", ES_CENTER | ES_READONLY, 0);
  CreateChildWindow(&edit4_, EDIT_ID, L"Edit",
                    ES_LEFT | ES_NOHIDESEL | WS_TABSTOP, WS_EX_CLIENTEDGE);
  CreateChildWindow(&label5_, LABEL5_ID, L"Static", ES_CENTER | ES_READONLY, 0);
  CreateChildWindow(&edit5_, EDIT_ID, L"Edit",
                    ES_LEFT | ES_NOHIDESEL | WS_TABSTOP, WS_EX_CLIENTEDGE);

  ::SetWindowTextA(edit1_, server_.c_str());
  ::SetWindowTextA(edit2_, port_.c_str());
  ::SetWindowTextA(edit3_, turn_url_.c_str());   // turn_url
  ::SetWindowTextA(edit4_, user_name_.c_str());  // username;
  ::SetWindowTextA(edit5_, pass_word_.c_str());  // password
}

void MainWnd::LayoutConnectUI(bool show) {
  struct Windows {
    HWND wnd;
    const wchar_t* text;
    size_t width;
    size_t height;
  } windows[] = {
      {label1_, L"Server"},  {edit1_, L"XXXyyyYYYgggXXXyyyYYYggg"},
      {label2_, L":"},       {edit2_, L"XyXyX"},
      {button_, L"Connect"},
  };

  Windows turn_windows[] = {
      {label1_, L"Server"},
      {edit1_, L"XXXyyyYYYgggXXXyyyYYYggg"},
      {label3_, L"TurnUrl:"},
      {edit3_, L"XXXyyyYYYgggXXXyyyYYYgggXXXyyyYYYgggXXXyyyYYYggg"},
      {label4_, L"UserName:"},
      {edit4_, L"XXXyyyYYYgggXXXyyyYYYggg"},
      {label5_, L"PassWord:"},
      {edit5_, L"XXXyyyYYYgggXXXyyyYYYggg"},
  };

  if (show) {
    const size_t kSeparator = 5;
    size_t total_width = (ARRAYSIZE(windows) - 1) * kSeparator;

    for (size_t i = 0; i < ARRAYSIZE(windows); ++i) {
      CalculateWindowSizeForText(windows[i].wnd, windows[i].text,
                                 &windows[i].width, &windows[i].height);
      total_width += windows[i].width;
    }
    for (size_t i = 2; i < ARRAYSIZE(turn_windows); ++i) {
      CalculateWindowSizeForText(turn_windows[i].wnd, turn_windows[i].text,
                                 &turn_windows[i].width,
                                 &turn_windows[i].height);
      // total_width += windows[i].width;
    }
    RECT rc;
    ::GetClientRect(wnd_, &rc);
    size_t x = (rc.right / 2) - (total_width / 2);
    size_t y = rc.bottom / 2;
    size_t w_h = ARRAYSIZE(turn_windows) / 2;
    for (size_t i = 0; i < ARRAYSIZE(windows); ++i) {
      size_t top = y - (windows[i].height * w_h / 2);
      ::MoveWindow(windows[i].wnd, static_cast<int>(x), static_cast<int>(top),
                   static_cast<int>(windows[i].width),
                   static_cast<int>(windows[i].height), TRUE);
      x += kSeparator + windows[i].width;
      if (windows[i].text[0] != 'X') {
        ::SetWindowTextW(windows[i].wnd, windows[i].text);
      }
      ::ShowWindow(windows[i].wnd, SW_SHOWNA);
    }
    size_t top = y - (turn_windows[0].height * w_h);
    for (size_t i = 1; i < w_h; ++i) {
      top += turn_windows[(i * 2)].height;
      x = (rc.right / 2) - (total_width / 2);

      ::MoveWindow(turn_windows[(i * 2)].wnd, static_cast<int>(x),
                   static_cast<int>(top),
                   static_cast<int>(turn_windows[(i * 2)].width),
                   static_cast<int>(turn_windows[(i * 2)].height), TRUE);
      x += kSeparator + turn_windows[(i * 2)].width;
      ::MoveWindow(turn_windows[(i * 2) + 1].wnd, static_cast<int>(x),
                   static_cast<int>(top),
                   static_cast<int>(turn_windows[(i * 2) + 1].width),
                   static_cast<int>(turn_windows[(i * 2) + 1].height), TRUE);
      if (turn_windows[(i * 2)].text[0] != 'X') {
        ::SetWindowTextW(turn_windows[(i * 2)].wnd, turn_windows[(i * 2)].text);
      }
      ::ShowWindow(turn_windows[(i * 2)].wnd, SW_SHOWNA);
      ::ShowWindow(turn_windows[(i * 2) + 1].wnd, SW_SHOWNA);
    }
  } else {
    for (size_t i = 0; i < ARRAYSIZE(windows); ++i) {
      ::ShowWindow(windows[i].wnd, SW_HIDE);
    }
    for (size_t i = 1; i < ARRAYSIZE(turn_windows); ++i) {
      ::ShowWindow(turn_windows[i].wnd, SW_HIDE);
    }
  }
}

void MainWnd::LayoutPeerListUI(bool show) {
  if (show) {
    RECT rc;
    ::GetClientRect(wnd_, &rc);
    ::MoveWindow(listbox_, 0, 0, rc.right, rc.bottom, TRUE);
    ::ShowWindow(listbox_, SW_SHOWNA);
  } else {
    ::ShowWindow(listbox_, SW_HIDE);
    InvalidateRect(wnd_, NULL, TRUE);
  }
}

void MainWnd::HandleTabbing() {
  bool shift = ((::GetAsyncKeyState(VK_SHIFT) & 0x8000) != 0);
  UINT next_cmd = shift ? GW_HWNDPREV : GW_HWNDNEXT;
  UINT loop_around_cmd = shift ? GW_HWNDLAST : GW_HWNDFIRST;
  HWND focus = GetFocus(), next;
  do {
    next = ::GetWindow(focus, next_cmd);
    if (IsWindowVisible(next) &&
        (GetWindowLong(next, GWL_STYLE) & WS_TABSTOP)) {
      break;
    }

    if (!next) {
      next = ::GetWindow(focus, loop_around_cmd);
      if (IsWindowVisible(next) &&
          (GetWindowLong(next, GWL_STYLE) & WS_TABSTOP)) {
        break;
      }
    }
    focus = next;
  } while (true);
  ::SetFocus(next);
}

//
// MainWnd::VideoRenderer
//

#define D3DFVF_CUSTOMVERTEX (D3DFVF_XYZ | D3DFVF_TEX1)

struct D3dCustomVertex {
  float x, y, z;
  float u, v;
};

MainWnd::VideoRenderer::VideoRenderer(
    HWND wnd,
    int width,
    int height,
    webrtc::VideoTrackInterface* track_to_render,
    bool render)
    : wnd_(wnd),
      width_(width),
      height_(height),

      d3d_(NULL),
      d3d_device_(NULL),
      texture_(NULL),
      vertex_buffer_(NULL),
      rendered_track_(track_to_render),
      renderer_(render) {
  //::InitializeCriticalSection(&buffer_lock_);
  // ZeroMemory(&bmi_, sizeof(bmi_));
  // bmi_.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
  // bmi_.bmiHeader.biPlanes = 1;
  // bmi_.bmiHeader.biBitCount = 32;
  // bmi_.bmiHeader.biCompression = BI_RGB;
  // bmi_.bmiHeader.biWidth = width;
  // bmi_.bmiHeader.biHeight = -height;
  // bmi_.bmiHeader.biSizeImage =
  //    width * height * (bmi_.bmiHeader.biBitCount >> 3);
  d3d_ = Direct3DCreate9(D3D_SDK_VERSION);
  if (d3d_ == NULL) {
    // Destroy();
    return;
  }

  D3DPRESENT_PARAMETERS d3d_params = {};

  d3d_params.Windowed = TRUE;
  d3d_params.SwapEffect = D3DSWAPEFFECT_COPY;

  IDirect3DDevice9* d3d_device;
  if (d3d_->CreateDevice(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, wnd_,
                         D3DCREATE_SOFTWARE_VERTEXPROCESSING, &d3d_params,
                         &d3d_device) != D3D_OK) {
    // Destroy();
    return;
  }
  d3d_device_ = d3d_device;
  d3d_device->Release();

  IDirect3DVertexBuffer9* vertex_buffer;
  const int kRectVertices = 4;
  if (d3d_device_->CreateVertexBuffer(kRectVertices * sizeof(D3dCustomVertex),
                                      0, D3DFVF_CUSTOMVERTEX, D3DPOOL_MANAGED,
                                      &vertex_buffer, NULL) != D3D_OK) {
    // Destroy();
    return;
  }
  vertex_buffer_ = vertex_buffer;
  vertex_buffer->Release();

  d3d_device_->SetRenderState(D3DRS_CULLMODE, D3DCULL_NONE);
  d3d_device_->SetRenderState(D3DRS_LIGHTING, FALSE);
  SetSize(width_, height_);

  ShowWindow(wnd_, SW_SHOWNOACTIVATE);
  d3d_device_->Present(NULL, NULL, NULL, NULL);

  rendered_track_->AddOrUpdateSink(this, rtc::VideoSinkWants());
}

MainWnd::VideoRenderer::~VideoRenderer() {
  rendered_track_->RemoveSink(this);
  texture_ = NULL;
  vertex_buffer_ = NULL;
  d3d_device_ = NULL;
  d3d_ = NULL;
  
  // if (wnd_ != NULL) {
  //  DestroyWindow(wnd_);
  //  RTC_DCHECK(!IsWindow(wnd_));
  //  wnd_ = NULL;
  //}
  // ::DeleteCriticalSection(&buffer_lock_);
}

void MainWnd::VideoRenderer::SetSize(int width, int height) {
  /* AutoLock<VideoRenderer> lock(this);

   if (width == bmi_.bmiHeader.biWidth && height == bmi_.bmiHeader.biHeight) {
     return;
   }

   bmi_.bmiHeader.biWidth = width;
   bmi_.bmiHeader.biHeight = -height;
   bmi_.bmiHeader.biSizeImage =
       width * height * (bmi_.bmiHeader.biBitCount >> 3);
   image_.reset(new uint8_t[bmi_.bmiHeader.biSizeImage]);*/
  width_ = width;
  height_ = height;
  IDirect3DTexture9* texture;

  d3d_device_->CreateTexture(
      static_cast<UINT>(width_), static_cast<UINT>(height_), 1,
      D3DUSAGE_DYNAMIC, D3DFMT_A8R8G8B8 /*D3DFMT_A8R8G8B8*/,
      /*D3DPOOL_DEFAULT*/ D3DPOOL_DEFAULT, &texture, NULL);
  texture_ = texture;

  // 创建字体
  // ID3DXFont* pFont = nullptr;
  // D3DXFONT_DESC fontDesc = {
  //    24,         0, 0, FW_NORMAL, DEFAULT_CHARSET, FALSE, FALSE,
  //    DEFAULT_PITCH, L"微软雅黑"};
  // D3DXCreateFontIndirect(pDevice, &fontDesc, &pFont);

  // 绘制文字
  /*RECT rect = {0, 0, 512, 512};
  IDirect3DSurface9* pSurface = nullptr;
  pTexture->GetSurfaceLevel(0, &pSurface);  */

  texture->Release();

  // Vertices for the video frame to be rendered to.
  static const D3dCustomVertex rect[] = {
      {-1.0f, -1.0f, 0.0f, 0.0f, 1.0f},
      {-1.0f, 1.0f, 0.0f, 0.0f, 0.0f},
      {1.0f, -1.0f, 0.0f, 1.0f, 1.0f},
      {1.0f, 1.0f, 0.0f, 1.0f, 0.0f},
  };

  void* buf_data;
  if (vertex_buffer_->Lock(0, 0, &buf_data, 0) != D3D_OK)
    return;

  memcpy(buf_data, &rect, sizeof(rect));
  vertex_buffer_->Unlock();
}

// 在纹理表面绘制文本
void MainWnd::VideoRenderer::DrawTextToTexture(const std::wstring& text) {
  if (!texture_)
    return;

  // 获取纹理表面
  IDirect3DSurface9* pSurface = NULL;
  HRESULT hr = texture_->GetSurfaceLevel(0, &pSurface);
  if (FAILED(hr))
    return;

  // 获取 GDI 设备上下文（HDC）
  HDC hdc = NULL;
  hr = pSurface->GetDC(&hdc);
  if (FAILED(hr)) {
    pSurface->Release();
    return;
  }

  // 设置 GDI 绘图参数
  SetBkMode(hdc, TRANSPARENT);            // 透明背景
  SetTextColor(hdc, RGB(255, 255, 255));  // 白色文字

  // 创建字体
  HFONT hFont =
      CreateFont(48,                   // 字体高度
                 0, 0, 0,              // 宽度和倾斜角度
                 FW_BOLD,              // 字体粗细
                 FALSE, FALSE, FALSE,  // 斜体、下划线、删除线
                 DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                 DEFAULT_QUALITY, DEFAULT_PITCH | FF_DONTCARE,
                 L"Arial"  // 字体名称
      );

  // 选择字体到 HDC
  HGDIOBJ oldFont = SelectObject(hdc, hFont);

  // 定义绘制区域
  RECT rect = {0, 0, 400, 400};

  // 绘制文本（居中对齐）
  DrawText(hdc, text.c_str(), (int)text.length(), &rect,
            DT_CENTER | DT_VCENTER | DT_SINGLELINE);

  // 清理资源
  SelectObject(hdc, oldFont);
  DeleteObject(hFont);
  pSurface->ReleaseDC(hdc);
  pSurface->Release();
}


void MainWnd::VideoRenderer::OnFrame(const webrtc::VideoFrame& frame) {
  {
    if (!renderer_) {
      return;
    }

	

	if (!i420_buffer_.get() || i420_buffer_->width() * i420_buffer_->height() <
                                   frame.width() * frame.height()) {
      i420_buffer_ = webrtc::I420Buffer::Create(frame.width() , frame.height());
    }
      //  i420_buffer_ = frame.video_frame_buffer()->GetI420();
    libyuv::ConvertToI420(frame.video_frame_buffer()->GetI420()->DataY(), 0, i420_buffer_->MutableDataY(),
                          i420_buffer_->StrideY(), i420_buffer_->MutableDataU(),
                          i420_buffer_->StrideU(), i420_buffer_->MutableDataV(), i420_buffer_->StrideV(),
                          0, 0, frame.width(), frame.height(), frame.width(),
                          frame.height(), libyuv::kRotate0,
                          libyuv::FOURCC_I420);
    if (static_cast<size_t>(frame.width()) != width_ ||
        static_cast<size_t>(frame.height()) != height_) {
      SetSize(static_cast<size_t>(frame.width()),
              static_cast<size_t>(frame.height()));
    }
    cnt++;
    auto timestamp_curr =
        std::chrono::duration_cast<std::chrono::milliseconds>(
            std::chrono::system_clock::now().time_since_epoch())
            .count();
    if (timestamp_curr - timestamp_ > 1000) {
      // RTC_LOG(LS_INFO) << "FPS: " << cnt;
      
      timestamp_ = timestamp_curr;
      osd_ = "renderFPS: " + std::to_string(cnt) + "/s";
      // webrtc::I420Buffer* i420_buffer = /*static_cast <webrtc::I420Buffer*>*/
      // (
      //    webrtc::I420Buffer*)(frame.video_frame_buffer()->GetI420A());
      
      cnt = 0;
    }
    draw_font_func(i420_buffer_->MutableDataY(), i420_buffer_->MutableDataU(),
                   i420_buffer_->MutableDataV(), osd_.c_str(), 100, 100,3,
                   osd_.length(), frame.width(), frame.height());
    D3DLOCKED_RECT lock_rect;
	if (texture_->LockRect(0, &lock_rect, NULL, 0) != D3D_OK)
	{
      return;
	}
        libyuv::ConvertFromI420(i420_buffer_->DataY(), i420_buffer_->StrideY(),
                                i420_buffer_->DataU(), i420_buffer_->StrideU(),
                                i420_buffer_->DataV(), i420_buffer_->StrideV(),
                                static_cast<uint8_t*>(lock_rect.pBits),
                                0,
                                i420_buffer_->width(), i420_buffer_->height(),
                                ConvertVideoType(webrtc::VideoType::kARGB));
   /*  ConvertFromI420(frame, webrtc::VideoType::kARGB, 0,
                    static_cast<uint8_t*>(lock_rect.pBits)); */
       /* rtc::scoped_refptr<webrtc::I420BufferInterface> i420_buffer =
            frame.video_frame_buffer()->ToI420();
        memcpy(static_cast<uint8_t*>(lock_rect.pBits), i420_buffer->DataY(),
               i420_buffer->ChromaHeight() * i420_buffer->ChromaWidth())*/
        //lock_rect.pBits = (void*)frame.video_frame_buffer()->ToI420()->DataY();
    texture_->UnlockRect(0);

    d3d_device_->BeginScene();
    d3d_device_->SetFVF(D3DFVF_CUSTOMVERTEX);
    d3d_device_->SetStreamSource(0, vertex_buffer_, 0, sizeof(D3dCustomVertex));
    d3d_device_->SetTexture(0, texture_);
    d3d_device_->DrawPrimitive(D3DPT_TRIANGLESTRIP, 0, 2);
    d3d_device_->EndScene();

    d3d_device_->Present(NULL, NULL, NULL, NULL);
    //  AutoLock<VideoRenderer> lock(this);

    // rtc::scoped_refptr<webrtc::I420BufferInterface> buffer(
    //    video_frame.video_frame_buffer()->ToI420());
    // if (video_frame.rotation() != webrtc::kVideoRotation_0) {
    //  buffer = webrtc::I420Buffer::Rotate(*buffer, video_frame.rotation());
    //}

    // SetSize(buffer->width(), buffer->height());

    // RTC_LOG(INFO) << "++++++++++++++width = " << buffer->width() <<", height
    // = " << buffer->height();

    // static const std::string outfilefix = "./desktop/desktop_";
    // static uint64_t frames = 0;
    // std::string outfilename = outfilefix + std::to_string(buffer->width()) +
    //                          "_" + std::to_string(buffer->height()) + "_" +
    //                          std::to_string(++frames) + ".yuv";

    /*FILE *outfile = fopen(outfilename.c_str(), "wb+");
    if (outfile)
    {
            fwrite(buffer->DataY(), 1, buffer->width()* buffer->height(),
    outfile); fflush(outfile); fclose(outfile);
    }*/

    /* RTC_DCHECK(image_.get() != NULL);
     libyuv::I420ToARGB(buffer->DataY(), buffer->StrideY(), buffer->DataU(),
                        buffer->StrideU(), buffer->DataV(), buffer->StrideV(),
                        image_.get(),
                        bmi_.bmiHeader.biWidth * bmi_.bmiHeader.biBitCount / 8,
                        buffer->width(), buffer->height());*/
  }
  InvalidateRect(wnd_, NULL, TRUE);
}
