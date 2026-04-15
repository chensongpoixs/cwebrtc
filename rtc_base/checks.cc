/*
 *  Copyright 2006 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

// Most of this was borrowed (with minor modifications) from V8's and Chromium's
// src/base/logging.cc.

#include <cstdarg>
#include <cstdio>
#include <cstdlib>

#if defined(WEBRTC_ANDROID)
#define RTC_LOG_TAG_ANDROID "rtc"
#include <android/log.h>  // NOLINT
#endif

#if defined(WEBRTC_WIN)
#include <windows.h>
#endif

#if defined(WEBRTC_WIN)
#define LAST_SYSTEM_ERROR (::GetLastError())
#elif defined(__native_client__) && __native_client__
#define LAST_SYSTEM_ERROR (0)
#elif defined(WEBRTC_POSIX)
#include <errno.h>
#define LAST_SYSTEM_ERROR (errno)
#endif  // WEBRTC_WIN

#include "rtc_base/checks.h"
#include "rtc_base/time_utils.h"
#include <ctime>
#include <string>
#include <sstream>
#include <iomanip> 
#include "rtc_base/time_utils.h"

namespace {


// 获取当前北京时间字符串，格式：YYYYMMDDHHMMSS
    std::string GetBeijingTimeString() {
        // 1. 获取 UTC 毫秒时间戳（WebRTC API）
        int64_t utc_ms = rtc::TimeMillis();      // 等价于 rtc::SystemTimeMillis()

        // 2. 转换为 time_t（秒级）
        time_t utc_sec = static_cast<time_t>(utc_ms / 1000);

        // 3. 加上 8 小时偏移（北京时间 = UTC+8）
        time_t beijing_sec = utc_sec + 8 * 3600;

        // 4. 转换为本地时间结构（gmtime 对 UTC+8 后的时间戳即得到北京时间）
        struct tm* tm_beijing = gmtime(&beijing_sec);

        // 5. 格式化为 YYYYMMDDHHMMSS
        std::ostringstream oss;
        oss << std::put_time(tm_beijing, "%Y%m%d%H%M%S");
        return oss.str();
    } 

RTC_NORETURN void WriteFatalLogAndAbort(const std::string& output) {
  const char* output_c = output.c_str();
#if defined(WEBRTC_ANDROID)
  __android_log_print(ANDROID_LOG_ERROR, RTC_LOG_TAG_ANDROID, "%s\n", output_c);
#endif
  fflush(stdout);
  fprintf(stderr, "%s", output_c);
  fflush(stderr);

  std::string out_fatal_log_name = GetBeijingTimeString() + "_libcrtc" + ".log";
  FILE* out_file_write_fatal_log_abort_log_ptr = ::fopen(out_fatal_log_name.c_str(), "wb+");
  if (out_file_write_fatal_log_abort_log_ptr)
  {
      ::fprintf(out_file_write_fatal_log_abort_log_ptr, "%s\n", output_c);
      ::fflush(out_file_write_fatal_log_abort_log_ptr);
      ::fclose(out_file_write_fatal_log_abort_log_ptr);
      out_file_write_fatal_log_abort_log_ptr = NULL;
  }


#if defined(WEBRTC_WIN)
  DebugBreak();
#endif
  abort();
}

#if defined(__GNUC__)
__attribute__((__format__(__printf__, 2, 3)))
#endif
void AppendFormat(std::string* s, const char* fmt, ...) {
  va_list args, copy;
  va_start(args, fmt);
  va_copy(copy, args);
  const int predicted_length = std::vsnprintf(nullptr, 0, fmt, copy);
  va_end(copy);

  if (predicted_length > 0) {
    const size_t size = s->size();
    s->resize(size + predicted_length);
    // Pass "+ 1" to vsnprintf to include space for the '\0'.
    std::vsnprintf(&((*s)[size]), predicted_length + 1, fmt, args);
  }
  va_end(args);
}
}  // namespace

namespace rtc {
namespace webrtc_checks_impl {

#if RTC_CHECK_MSG_ENABLED
// Reads one argument from args, appends it to s and advances fmt.
// Returns true iff an argument was sucessfully parsed.
bool ParseArg(va_list* args, const CheckArgType** fmt, std::string* s) {
  if (**fmt == CheckArgType::kEnd)
    return false;

  switch (**fmt) {
    case CheckArgType::kInt:
      AppendFormat(s, "%d", va_arg(*args, int));
      break;
    case CheckArgType::kLong:
      AppendFormat(s, "%ld", va_arg(*args, long));
      break;
    case CheckArgType::kLongLong:
      AppendFormat(s, "%lld", va_arg(*args, long long));
      break;
    case CheckArgType::kUInt:
      AppendFormat(s, "%u", va_arg(*args, unsigned));
      break;
    case CheckArgType::kULong:
      AppendFormat(s, "%lu", va_arg(*args, unsigned long));
      break;
    case CheckArgType::kULongLong:
      AppendFormat(s, "%llu", va_arg(*args, unsigned long long));
      break;
    case CheckArgType::kDouble:
      AppendFormat(s, "%g", va_arg(*args, double));
      break;
    case CheckArgType::kLongDouble:
      AppendFormat(s, "%Lg", va_arg(*args, long double));
      break;
    case CheckArgType::kCharP:
      s->append(va_arg(*args, const char*));
      break;
    case CheckArgType::kStdString:
      s->append(*va_arg(*args, const std::string*));
      break;
    case CheckArgType::kStringView: {
      const absl::string_view sv = *va_arg(*args, const absl::string_view*);
      s->append(sv.data(), sv.size());
      break;
    }
    case CheckArgType::kVoidP:
      AppendFormat(s, "%p", va_arg(*args, const void*));
      break;
    default:
      s->append("[Invalid CheckArgType]");
      return false;
  }
  (*fmt)++;
  return true;
}

RTC_NORETURN void FatalLog(const char* file,
                           int line,
                           const char* message,
                           const CheckArgType* fmt,
                           ...) {
  va_list args;
  va_start(args, fmt);

  std::string s;
  AppendFormat(&s,
               "\n\n"
               "#\n"
               "# Fatal error in: %s, line %d\n"
               "# last system error: %u\n"
               "# Check failed: %s",
               file, line, LAST_SYSTEM_ERROR, message);

  if (*fmt == CheckArgType::kCheckOp) {
    // This log message was generated by RTC_CHECK_OP, so we have to complete
    // the error message using the operands that have been passed as the first
    // two arguments.
    fmt++;

    std::string s1, s2;
    if (ParseArg(&args, &fmt, &s1) && ParseArg(&args, &fmt, &s2))
      AppendFormat(&s, " (%s vs. %s)\n# ", s1.c_str(), s2.c_str());
  } else {
    s.append("\n# ");
  }

  // Append all the user-supplied arguments to the message.
  while (ParseArg(&args, &fmt, &s))
    ;

  va_end(args);

  WriteFatalLogAndAbort(s);
}
#else  // RTC_CHECK_MSG_ENABLED
RTC_NORETURN void FatalLog(const char* file, int line) {
  std::string s;
  AppendFormat(&s,
               "\n\n"
               "#\n"
               "# Fatal error in: %s, line %d\n"
               "# last system error: %u\n"
               "# Check failed.\n"
               "# ",
               file, line, LAST_SYSTEM_ERROR);
  WriteFatalLogAndAbort(s);
}
#endif  // RTC_CHECK_MSG_ENABLED

#if RTC_DCHECK_IS_ON

RTC_NORETURN void UnreachableCodeReached(const char* file, int line) {
  std::string s;
  AppendFormat(&s,
               "\n\n"
               "#\n"
               "# Unreachable code reached: %s, line %d\n"
               "# last system error: %u\n"
               "# ",
               file, line, LAST_SYSTEM_ERROR);
  WriteFatalLogAndAbort(s);
}

#else  // !RTC_DCHECK_IS_ON

RTC_NORETURN void UnreachableCodeReached() {
  std::string s;
  AppendFormat(&s,
               "\n\n"
               "#\n"
               "# Unreachable code reached (file and line unknown)\n"
               "# last system error: %u\n"
               "# ",
               LAST_SYSTEM_ERROR);
  WriteFatalLogAndAbort(s);
}

#endif  // !RTC_DCHECK_IS_ON

}  // namespace webrtc_checks_impl
}  // namespace rtc

// Function to call from the C version of the RTC_CHECK and RTC_DCHECK macros.
RTC_NORETURN void rtc_FatalMessage(const char* file,
                                   int line,
                                   const char* msg) {
#if RTC_CHECK_MSG_ENABLED
  static constexpr rtc::webrtc_checks_impl::CheckArgType t[] = {
      rtc::webrtc_checks_impl::CheckArgType::kEnd};
  rtc::webrtc_checks_impl::FatalLog(file, line, msg, t);
#else
  rtc::webrtc_checks_impl::FatalLog(file, line);
#endif
}
