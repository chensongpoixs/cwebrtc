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
#include "rtc_base/message_digest.h"

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
    char buf[32] = {0};
    size_t len = rtc::hex_decode(buf, sizeof(buf), line.data() + sep + 1,
                                 line.size() - sep - 1);
  /*  std::cout << "====" << line << "[" << rtc::hex_encode(std::string(buf, len))
              << "]" << len
              << buf << std::endl;*/
    if (len > 0) {
      name_to_key.emplace(line.substr(0, sep), std::string(buf, len));
    }
  }
  #if 0
  // MD5: D25E9FE4D6524B84A36966B5B2AAD94E
//SHA1:  F8EDCD8490D9BEE59946EA42A7A04EEEA13AFDFC

 /* const bool success = ComputeStunCredentialHash(credentials_.username, realm_,
                                                 credentials_.password, &hash_);*/
  {
    // http://tools.ietf.org/html/rfc5389#section-15.4
    // long-term credentials will be calculated using the key and key is
    // key = MD5(username ":" realm ":" SASLprep(password))
    std::string input = "chensong";
    input += ':';
    input += "realm";
    input += ':';
    input += "0123456789";

    char digest[32] = {0};
    size_t size = rtc::ComputeDigest(rtc::DIGEST_MD5, input.c_str(),
                                     input.size(), digest, sizeof(digest));
   /* if (size == 0) {
      return false;
    }*/
    std::cout << "[" << rtc::hex_encode(std::string(digest, size)) << "]"
              << size << digest
              << std::endl;
    
     // std::string(digest, size);
   // name_to_key.insert(std::make_pair(
   //     "chensong", std::string(digest, size) /* "chensong:realm:0123456789"*/));
  }
  name_to_key.insert(std::make_pair("chensong", "chensong:realm:0123456789"));
  name_to_key.insert(std::make_pair("chensongmd5", "162F5E6AA5D8AF47D9213EDBF3B278C5"));
  name_to_key.insert(std::make_pair("chensongsha1", "F1C3A820883154F290D048716A2710ED465C177D"));
#endif // #if TURN_LOG
  std::cout << "[name_to_key size = " << name_to_key.size() << "]" << std::endl;
  for (const std::pair<const std::string,const std::string> & pi: name_to_key) 
  {
    std::cout << "[key = " << pi.first << "][value = " << pi.second
              << "]" << std::endl;
  }

   
  return name_to_key;
}

}  // namespace webrtc_examples
