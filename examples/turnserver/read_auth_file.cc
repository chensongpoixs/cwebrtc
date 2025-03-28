/*
 *  Copyright 2018 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "examples/turnserver/read_auth_file.h"

#include <stddef.h>
#include <iostream>
#include "rtc_base/string_encode.h"

namespace webrtc_examples {

std::map<std::string, std::string> ReadAuthFile(std::istream* s) {
  std::map<std::string, std::string> name_to_key;
  for (std::string line; std::getline(*s, line);) 
  {
    // File is stored as lines of <username>=<HA1>.
    // Generate HA1 via "echo -n "<username>:<realm>:<password>" | md5sum"
    const size_t sep = line.find('=');
    if (sep == std::string::npos)
      continue;
    char buf[32];
    size_t len = rtc::hex_decode(buf, sizeof(buf), line.data() + sep + 1,
                                 line.size() - sep - 1);
    if (len > 0) {
    //  name_to_key.emplace(line.substr(0, sep), std::string(buf, len));
    }
  }
  name_to_key.insert(std::make_pair("chensong", "0123456789"));
  std::cout << "[name_to_key size = " << name_to_key.size() << "]" << std::endl;
  for (const std::pair<const std::string,const std::string> & pi: name_to_key) 
  {
    std::cout << "[key = " << pi.first << "][value = " << pi.second
              << "]" << std::endl;
  }

   
  return name_to_key;
}

}  // namespace webrtc_examples
