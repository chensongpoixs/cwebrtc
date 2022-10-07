/*
 *  Copyright 2012 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef P2P_BASE_TRANSPORT_DESCRIPTION_H_
#define P2P_BASE_TRANSPORT_DESCRIPTION_H_

#include <memory>
#include <string>
#include <vector>

#include "absl/algorithm/container.h"
#include "p2p/base/p2p_constants.h"
#include "rtc_base/ssl_fingerprint.h"

namespace cricket {

// SEC_ENABLED and SEC_REQUIRED should only be used if the session
// was negotiated over TLS, to protect the inline crypto material
// exchange.
// SEC_DISABLED: No crypto in outgoing offer, ignore any supplied crypto.
// SEC_ENABLED:  Crypto in outgoing offer and answer (if supplied in offer).
// SEC_REQUIRED: Crypto in outgoing offer and answer. Fail any offer with absent
//               or unsupported crypto.
// TODO(deadbeef): Remove this or rename it to something more appropriate, like
// SdesPolicy.
//TODO@chensong 2022-10-06 只有在会话
//通过TLS进行协商，以保护内联加密材料
//交换。
//SEC_DISABLED：传出报价中没有加密，忽略提供的任何加密。
//SEC_ENABLED：发出报价和应答中的加密（如果报价中提供）。
//SEC_REQUIRED：发出要约和回复时加密。因缺席而未通过任何提议
//或不受支持的加密。
//TODO（死牛肉）：删除此项或将其重命名为更合适的名称，如
//SdesPolicy公司。
enum SecurePolicy { SEC_DISABLED, SEC_ENABLED, SEC_REQUIRED };

// Whether our side of the call is driving the negotiation, or the other side.
enum IceRole { ICEROLE_CONTROLLING = 0, ICEROLE_CONTROLLED, ICEROLE_UNKNOWN };

// ICE RFC 5245 implementation type.
enum IceMode {
  ICEMODE_FULL,  // As defined in http://tools.ietf.org/html/rfc5245#section-4.1
  ICEMODE_LITE   // As defined in http://tools.ietf.org/html/rfc5245#section-4.2
};

// RFC 4145 - http://tools.ietf.org/html/rfc4145#section-4
// 'active':  The endpoint will initiate an outgoing connection.
// 'passive': The endpoint will accept an incoming connection.
// 'actpass': The endpoint is willing to accept an incoming
//            connection or to initiate an outgoing connection.
/*a = setup 主要是表示dtls的协商过程中角色的问题，谁是客户端，谁是服务器
a = setup:actpass 既可以是客户端，也可以是服务器
a = setup : active 客户端
a = setup : passive 服务器
由客户端先发起client hello*/
enum ConnectionRole {
  CONNECTIONROLE_NONE = 0,
  CONNECTIONROLE_ACTIVE,
  CONNECTIONROLE_PASSIVE,
  CONNECTIONROLE_ACTPASS,
  CONNECTIONROLE_HOLDCONN,
};

struct IceParameters {
  // TODO(honghaiz): Include ICE mode in this structure to match the ORTC
  // struct:
  // http://ortc.org/wp-content/uploads/2016/03/ortc.html#idl-def-RTCIceParameters
  std::string ufrag;
  std::string pwd;
  bool renomination = false;
  IceParameters() = default;
  IceParameters(const std::string& ice_ufrag,
                const std::string& ice_pwd,
                bool ice_renomination)
      : ufrag(ice_ufrag), pwd(ice_pwd), renomination(ice_renomination) {}

  bool operator==(const IceParameters& other) const {
    return ufrag == other.ufrag && pwd == other.pwd &&
           renomination == other.renomination;
  }
  bool operator!=(const IceParameters& other) const {
    return !(*this == other);
  }
};

extern const char CONNECTIONROLE_ACTIVE_STR[];
extern const char CONNECTIONROLE_PASSIVE_STR[];
extern const char CONNECTIONROLE_ACTPASS_STR[];
extern const char CONNECTIONROLE_HOLDCONN_STR[];



////////////////////////////////////////TODO@chensong 20220906 ICE-options 连接的属性////////////////////////////////////////////////////////////////////////
// a=ice-options 用于描述 ICE 连接的属性信息，ice-options 的定义有很多种，WebRTC
// 中常见的有： 
///  1. a=ice-options:trickle client 一边收集 candidate 一边发送给对端并开始连通性检查，可以缩短 ICE 建立连接的时间。
// 
//   2. a=ice-options:renomination 允许 ICE controlling 一方动态重新提名新的
// candidate ，默认情况 Offer 一方为controlling 角色，answer 一方为 controlled
// 角色；同时 Lite 一方只能为 controlled 角色。
///////////////////////////////////////////////////////////////////////////////////////////////////////
constexpr auto* ICE_OPTION_TRICKLE = "trickle";
constexpr auto* ICE_OPTION_RENOMINATION = "renomination";

bool StringToConnectionRole(const std::string& role_str, ConnectionRole* role);
bool ConnectionRoleToString(const ConnectionRole& role, std::string* role_str);
//// 网络安全和ICE策略
struct TransportDescription {
  TransportDescription();
  TransportDescription(const std::vector<std::string>& transport_options,
                       const std::string& ice_ufrag,
                       const std::string& ice_pwd,
                       IceMode ice_mode,
                       ConnectionRole role,
                       const rtc::SSLFingerprint* identity_fingerprint);
  TransportDescription(const std::string& ice_ufrag,
                       const std::string& ice_pwd);
  TransportDescription(const TransportDescription& from);
  ~TransportDescription();

  TransportDescription& operator=(const TransportDescription& from);

  // TODO(deadbeef): Rename to HasIceOption, etc.
  bool HasOption(const std::string& option) const {
    return absl::c_linear_search(transport_options, option);
  }
  void AddOption(const std::string& option) {
    transport_options.push_back(option);
  }
  bool secure() const { return identity_fingerprint != nullptr; }

  IceParameters GetIceParameters() {
    return IceParameters(ice_ufrag, ice_pwd,
                         HasOption(ICE_OPTION_RENOMINATION));
  }

  static rtc::SSLFingerprint* CopyFingerprint(const rtc::SSLFingerprint* from) {
    if (!from)
      return NULL;

    return new rtc::SSLFingerprint(*from);
  }

  // These are actually ICE options (appearing in the ice-options attribute in
  // SDP).
  // TODO(deadbeef): Rename to ice_options.
  //a=ice-options 用于描述 ICE 连接的属性信息，ice-options 的定义有很多种，WebRTC 中常见的有：
  //a=ice-options:trickle client 一边收集 candidate 一边发送给对端并开始连通性检查，可以缩短 ICE 建立连接的时间。
  //a=ice-options:renomination 允许 ICE controlling 一方动态重新提名新的 candidate ，默认情况 Offer 一方为controlling 角色，answer 一方为 controlled 角色；同时 Lite 一方只能为 controlled 角色。

  std::vector<std::string> transport_options;
  std::string ice_ufrag; // 用户名
  std::string ice_pwd; // 密码
  IceMode ice_mode;  // 连接服务器时服务器是否进行校验 ， 是否双方都要进行校验
  ConnectionRole connection_role; // 是服务器、客户端， 还是即可以是服务器又可以客户端

  std::unique_ptr<rtc::SSLFingerprint> identity_fingerprint;
};

}  // namespace cricket

#endif  // P2P_BASE_TRANSPORT_DESCRIPTION_H_
