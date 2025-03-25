/*
 *  Copyright (c) 2012 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_RTP_RTCP_SOURCE_ULPFEC_GENERATOR_H_
#define MODULES_RTP_RTCP_SOURCE_ULPFEC_GENERATOR_H_

#include <stddef.h>
#include <stdint.h>
#include <list>
#include <memory>
#include <vector>

#include "modules/include/module_fec_types.h"
#include "modules/rtp_rtcp/source/forward_error_correction.h"

namespace webrtc {

class FlexfecSender;
/*

20250324 TOD@chensong  FEC原理和参数理解

以下是基于 ‌C++ 的 FEC（前向纠错）关键帧保护核心代码实现示例‌，采用
‌Reed-Solomon 算法‌ 实现冗余数据生成与恢复：

‌一、关键帧 FEC 实现步骤‌

‌数据分块‌：将关键帧数据分割为多个数据块（如 4个原始块）。

‌冗余生成‌：通过 Reed-Solomon 算法生成冗余块（如 2个冗余块）。 ‌

封装传输‌：发送原始块 +冗余块，允许接收端在部分丢包时恢复数据。

‌接收恢复‌：若丢失块数 ≤ 冗余块数，通过解码恢复原始数据。


#include <cstring>
#include <vector>
#include "reed_solomon.h"  // 使用开源库如 OpenFEC

// 关键帧数据结构（示例）
struct VideoFrame {
    int frame_type;    // 关键帧标记（如 0=非关键帧，1=关键帧）
    int data_size;
    uint8_t* data;     // 帧数据
};

// ------------------- 发送端：生成冗余数据 -------------------
void encode_fec(VideoFrame& frame, int k, int m) {
    // k=原始块数，m=冗余块数（总块数 n=k+m）
    std::vector<uint8_t*> data_blocks(k + m);
    

    // 1. 分块处理（示例分块逻辑）
    int block_size = frame.data_size / k;
    for (int i = 0; i < k; i++) {
        data_blocks[i] = new uint8_t[block_size];
        memcpy(data_blocks[i], frame.data + i * block_size, block_size);
    }
    

    // 2. 初始化 Reed-Solomon 编码器
    reed_solomon* rs = reed_solomon_new(k, m);
    

    // 3. 生成冗余块
    reed_solomon_encode(rs, data_blocks.data(), k + m, block_size);
    

    // 4. 将冗余块追加到发送缓冲区（模拟网络传输）
    for (int i = k; i < k + m; i++) {
        send_packet(data_blocks[i], block_size); // 模拟发送函数
    }
    

    // 释放资源
    reed_solomon_release(rs);
    for (auto& block : data_blocks) delete[] block;
}

// ------------------- 接收端：数据恢复 -------------------
void decode_fec(std::vector<uint8_t*>& received_blocks,
                const std::vector<bool>& lost_flags,
                int k, int m, int block_size) {
    // lost_flags 标记哪些块丢失（如 [0,1,0,1,0] 表示第1、3块丢失）
    

    // 1. 检查是否需要恢复（丢失块数 ≤ m）
    int lost_count = std::count(lost_flags.begin(), lost_flags.end(), true);
    if (lost_count > m) return; // 无法恢复
    

    // 2. 初始化 Reed-Solomon 解码器
    reed_solomon* rs = reed_solomon_new(k, m);
    

    // 3. 恢复丢失块
    reed_solomon_reconstruct(rs, received_blocks.data(),
                            lost_flags.data(), k + m, block_size);
    

    // 4. 重组原始关键帧数据
    uint8_t* restored_data = new uint8_t[k * block_size];
    for (int i = 0; i < k; i++) {
        memcpy(restored_data + i * block_size, received_blocks[i], block_size);
    }
    

    // 5. 提交给解码器（示例）
    submit_to_decoder(restored_data, k * block_size);
    

    // 释放资源
    reed_solomon_release(rs);
    delete[] restored_data;
}

‌三、关键参数与优化‌

‌分块策略‌：

cpp
Copy Code
// 示例：4 原始块 + 2 冗余块（可容忍 2 个丢包）
int k = 4, m = 2;
// 冗余比例 = m/(k+m) = 33%，需权衡带宽与抗丢包能力
‌性能优化‌：

‌动态调整冗余量‌：根据网络丢包率动态调整 m 值（如高丢包时增大
m）。
‌分块大小对齐‌：确保 block_size 是内存对齐单位（如 64
字节），加速编解码运算。 ‌硬件加速‌：使用 SIMD 指令（如
SSE/AVX）优化矩阵运算。 ‌与传输协议结合‌：

plaintext
Copy Code
数据包格式示例：
+------------+------------+------------+
| 块ID (0~5) | 数据长度   | 块数据     |
+------------+------------+------------+
‌四、对比不同 FEC 算法‌
算法	适用场景	复杂度	恢复能力
XOR（异或）	单冗余块（丢1补1）	低	仅恢复1个丢包
Reed-Solomon	多冗余块（通用场景）	中	恢复任意 m 个丢包
LDPC	高带宽长延迟网络	高	接近香农极限
‌五、实际应用注意事项‌
‌关键帧标记‌：在 RTP/RTCP 协议中需通过 frame_type
字段标识关键帧。
‌分片兼容性‌：若关键帧超过 MTU 需分片发送，需在分片头部增加 FEC
块标识。 ‌跨平台库推荐‌： ‌OpenFEC‌（开源 C
库，支持多种算法） ‌Zfec‌（Python 实现，适合快速原型开发）
以上代码需结合实际网络传输模块（如 WebRTC、FFmpeg）集成，重点关注
‌冗余比例动态调整‌ 和 ‌编解码性能优化‌。
*/
class RedPacket {
 public:
  explicit RedPacket(size_t length);
  ~RedPacket();

  void CreateHeader(const uint8_t* rtp_header,
                    size_t header_length,
                    int red_payload_type,
                    int payload_type);
  void SetSeqNum(int seq_num);
  void AssignPayload(const uint8_t* payload, size_t length);
  void ClearMarkerBit();
  uint8_t* data() const;
  size_t length() const;

 private:
  std::unique_ptr<uint8_t[]> data_;
  size_t length_;
  size_t header_length_;
};

class UlpfecGenerator {
  friend class FlexfecSender;

 public:
  UlpfecGenerator();
  ~UlpfecGenerator();

  void SetFecParameters(const FecProtectionParams& params);

  // Adds a media packet to the internal buffer. When enough media packets
  // have been added, the FEC packets are generated and stored internally.
  // These FEC packets are then obtained by calling GetFecPacketsAsRed().
  int AddRtpPacketAndGenerateFec(const uint8_t* data_buffer,
                                 size_t payload_length,
                                 size_t rtp_header_length);

  // Returns true if there are generated FEC packets available.
  bool FecAvailable() const;

  size_t NumAvailableFecPackets() const;

  // Returns the overhead, per packet, for FEC (and possibly RED).
  size_t MaxPacketOverhead() const;

  // Returns generated FEC packets with RED headers added.
  std::vector<std::unique_ptr<RedPacket>> GetUlpfecPacketsAsRed(
      int red_payload_type,
      int ulpfec_payload_type,
      uint16_t first_seq_num);

 private:
  explicit UlpfecGenerator(std::unique_ptr<ForwardErrorCorrection> fec);

  // Overhead is defined as relative to the number of media packets, and not
  // relative to total number of packets. This definition is inherited from the
  // protection factor produced by video_coding module and how the FEC
  // generation is implemented.
  int Overhead() const;

  // Returns true if the excess overhead (actual - target) for the FEC is below
  // the amount |kMaxExcessOverhead|. This effects the lower protection level
  // cases and low number of media packets/frame. The target overhead is given
  // by |params_.fec_rate|, and is only achievable in the limit of large number
  // of media packets.
  bool ExcessOverheadBelowMax() const;

  // Returns true if the number of added media packets is at least
  // |min_num_media_packets_|. This condition tries to capture the effect
  // that, for the same amount of protection/overhead, longer codes
  // (e.g. (2k,2m) vs (k,m)) are generally more effective at recovering losses.
  bool MinimumMediaPacketsReached() const;

  void ResetState();

  std::unique_ptr<ForwardErrorCorrection> fec_;
  ForwardErrorCorrection::PacketList media_packets_;
  size_t last_media_packet_rtp_header_length_;
  std::list<ForwardErrorCorrection::Packet*> generated_fec_packets_;
  int num_protected_frames_;
  int min_num_media_packets_;
  FecProtectionParams params_;
  FecProtectionParams new_params_;
};

}  // namespace webrtc

#endif  // MODULES_RTP_RTCP_SOURCE_ULPFEC_GENERATOR_H_
