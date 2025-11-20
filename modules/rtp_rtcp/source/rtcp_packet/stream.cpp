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


#include "modules/rtp_rtcp/source/rtcp_packet/stream.h"

#include <cstdint>
#include <cstring>
#include <string>
#include <utility>
#include <vector>

#include "absl/strings/string_view.h"
#include "modules/rtp_rtcp/source/byte_io.h"
#include "modules/rtp_rtcp/source/rtcp_packet/common_header.h"
#include "rtc_base/checks.h"
#include "rtc_base/logging.h"
 
#include <string.h>

#include <cstdint>
#include <utility>
     
#include "rtc_base/checks.h"
#include "rtc_base/logging.h"

namespace webrtc {
    namespace rtcp {
        constexpr uint8_t Stream::kPacketType;
        // Stream packet (BYE) (RFC 3550).
        //
        //        0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
        //       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
        //       |V=2|P|    SC   |   PT=BYE=211  |             length            |
        //       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
        //       |                           SSRC/CSRC                           |
        //       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
        //       :                              ...                              :
        //       +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
        // (opt) |     length      | status                                      |
        //       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
        Stream::Stream() = default;

        Stream::~Stream() = default;

        bool Stream::Parse(const CommonHeader& packet) {
            RTC_DCHECK_EQ(packet.type(), kPacketType);

            const uint8_t src_count = packet.count();
            // Validate packet.
            if (packet.payload_size_bytes() < 4u * src_count) {
                RTC_LOG(LS_WARNING)
                    << "Packet is too small to contain CSRCs it promise to have.";
                return false;
            }
            const uint8_t* const payload = packet.payload();
            bool has_status = packet.payload_size_bytes() > 4u * src_count;
            uint8_t status_length = 0;
            if (has_status) {
                status_length = payload[4u * src_count];
                if (packet.payload_size_bytes() - 4u * src_count < 1u + status_length) {
                    RTC_LOG(LS_WARNING) << "Invalid status length: " << status_length;
                    return false;
                }
            }
            // Once sure packet is valid, copy values.
            if (src_count == 0) {  // A count value of zero is valid, but useless.
                SetSenderSsrc(0);
                csrcs_.clear();
            }
            else {
                SetSenderSsrc(ByteReader<uint32_t>::ReadBigEndian(payload));
                csrcs_.resize(src_count - 1);
                for (size_t i = 1; i < src_count; ++i)
                    csrcs_[i - 1] = ByteReader<uint32_t>::ReadBigEndian(&payload[4 * i]);
            }

            if (has_status) {
                std::string   status_data;
                status_data.assign(reinterpret_cast<const char*>(&payload[4u * src_count + 1]),
                    status_length);

                status_ = atoi(status_data.c_str());
            }
            else {
                status_ = false;
            }

            return true;
        }

        bool Stream::Create(uint8_t* packet,
            size_t* index,
            size_t max_length,
            PacketReadyCallback callback) const {
            while (*index + BlockLength() > max_length) {
                if (!OnBufferFull(packet, index, callback))
                    return false;
            }
            const size_t index_end = *index + BlockLength();

            CreateHeader(1 + csrcs_.size(), kPacketType, HeaderLength(), packet, index);
            // Store srcs of the leaving clients.
            ByteWriter<uint32_t>::WriteBigEndian(&packet[*index], sender_ssrc());
            *index += sizeof(uint32_t);
            for (uint32_t csrc : csrcs_) {
                ByteWriter<uint32_t>::WriteBigEndian(&packet[*index], csrc);
                *index += sizeof(uint32_t);
            }
            // Store the reason to leave.

            std::string status_data = std::to_string(status_);
            if (!status_data.empty())
            {
                uint8_t status_length = static_cast<uint8_t>(status_data.size());
                packet[(*index)++] = status_length;
                memcpy(&packet[*index], status_data.data(), status_length);
                *index += status_length;
                // Add padding bytes if needed.
                size_t bytes_to_pad = index_end - *index;
                RTC_DCHECK_LE(bytes_to_pad, 3);
                if (bytes_to_pad > 0) {
                    memset(&packet[*index], 0, bytes_to_pad);
                    *index += bytes_to_pad;
                }
            }
            RTC_DCHECK_EQ(index_end, *index);
            return true;
        }

        bool Stream::SetCsrcs(std::vector<uint32_t> csrcs) {
            if (csrcs.size() > kMaxNumberOfCsrcs) {
                RTC_LOG(LS_WARNING) << "Too many CSRCs for Bye packet.";
                return false;
            }
            csrcs_ = std::move(csrcs);
            return true;
        }

        void Stream::SetStatus(bool status) 
        { 
            status_ = status ? 1 : 0;
        }

        size_t Stream::BlockLength() const {
            size_t src_count = (1 + csrcs_.size());
            std::string stream_status = std::to_string(status_);
            size_t reason_size_in_32bits = stream_status.empty() ? 0 : (stream_status.size() / 4 + 1);
            return kHeaderLength + 4 * (src_count + reason_size_in_32bits);
        }

    }  // namespace rtcp
}  // namespace webrtc
