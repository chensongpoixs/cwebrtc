/******************************************************************************
 *  Copyright (c) 2025 The CRTC project authors . All Rights Reserved.
 *
 *  Please visit https://chensongpoixs.github.io for detail
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 ******************************************************************************/
 /*****************************************************************************
                   Author: chensong
                   date:  2025-09-21



 ******************************************************************************/


#ifndef _C_MODULES_RTP_RTCP_SOURCE_RTCP_PACKET_STREAM_H_
#define _C_MODULES_RTP_RTCP_SOURCE_RTCP_PACKET_STREAM_H_

#include <string>
#include <vector>
#include <cstddef>
#include <cstdint>
#include <string>
#include <vector>

#include "absl/strings/string_view.h"
#include "modules/rtp_rtcp/source/rtcp_packet.h"
 
namespace webrtc {
    namespace rtcp {
        class CommonHeader;

        class Stream : public RtcpPacket {
        public:
            static constexpr uint8_t kPacketType = 211;

            Stream();
            ~Stream() override;

            // Parse assumes header is already parsed and validated.
            bool Parse(const CommonHeader& packet);

            bool SetCsrcs(std::vector<uint32_t> csrcs);
            void SetStatus(bool status);

            const std::vector<uint32_t>& csrcs() const { return csrcs_; }
              bool Status() const { return status_; }

            size_t BlockLength() const override;

            bool Create(uint8_t* packet,
                size_t* index,
                size_t max_length,
                PacketReadyCallback callback) const override;

        private:
            static const int kMaxNumberOfCsrcs = 0x1f - 1;  // First item is sender SSRC.

            std::vector<uint32_t> csrcs_; 
            uint32_t        status_ = 1; 
        };

    }  // namespace rtcp
}  // namespace 
#endif  // MODULES_RTP_RTCP_SOURCE_RTCP_PACKET_BYE_H_
