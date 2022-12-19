/*
 *  Copyright (c) 2018 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "modules/rtp_rtcp/source/rtp_video_header.h"

namespace webrtc {

RTPVideoHeader::RTPVideoHeader() : video_timing() {}
RTPVideoHeader::RTPVideoHeader(const RTPVideoHeader& other) = default;
RTPVideoHeader::~RTPVideoHeader() = default;

RTPVideoHeader::GenericDescriptorInfo::GenericDescriptorInfo() = default;
RTPVideoHeader::GenericDescriptorInfo::GenericDescriptorInfo(
    const GenericDescriptorInfo& other) = default;
RTPVideoHeader::GenericDescriptorInfo::~GenericDescriptorInfo() = default;

std::string ToString(
    const webrtc::RTPVideoHeader::GenericDescriptorInfo& desc_info) {
  char buffer[1024 * 100] = {0};
  
  std::string vec_dependencies;

  for (size_t i = 0; i < desc_info.dependencies.size(); ++i) 
  {
    if (0 != i) 
	{
      vec_dependencies += "\n";
	}

	vec_dependencies += "dependencies["
                            + std::to_string(i) +
                            "] =" + std::to_string(desc_info.dependencies[i]);
  }

  std::string vec_higher_spatial_layers;

  for (size_t i = 0; i < desc_info.higher_spatial_layers.size(); ++i)
  {
    if (0 != i) {
      vec_higher_spatial_layers += "\n";
    }

    vec_higher_spatial_layers +=
        "higher_spatial_layers[" + std::to_string(i) +
        "] =" + std::to_string(desc_info.higher_spatial_layers[i]);
  }


  /*
  int64_t frame_id = 0;
    int spatial_index = 0;
    int temporal_index = 0;
    absl::InlinedVector<int64_t, 5> dependencies;
    absl::InlinedVector<int, 5> higher_spatial_layers;
    bool discardable = false;
  */
  ::sprintf(&buffer[0], "[frame_id = %llu][spatial_index = %d][temporal_index = %d][dependencies = %s][higher_spatial_layers = %s][discardable = %s]", 
            desc_info.frame_id, desc_info.spatial_index,
            desc_info.temporal_index, vec_dependencies.c_str(), vec_higher_spatial_layers.c_str(),
      (desc_info.discardable == true ? "true" : "false"));

  return buffer;
}

std::string ToString(const webrtc::RTPVideoHeader& rtpheader) {
  char buffer[1024 * 600] = {0};



  /*
  uint16_t width = 0;
  uint16_t height = 0;
  VideoRotation rotation = VideoRotation::kVideoRotation_0;
  VideoContentType content_type = VideoContentType::UNSPECIFIED;
  bool is_first_packet_in_frame = false;
  bool is_last_packet_in_frame = false;
  uint8_t simulcastIdx = 0;
  VideoCodecType codec = VideoCodecType::kVideoCodecGeneric;

  PlayoutDelay playout_delay = {-1, -1};
  VideoSendTiming video_timing;
  FrameMarking frame_marking = {false, false, false, false, false, 0xFF, 0, 0};
  absl::optional<ColorSpace> color_space;
  RTPVideoTypeHeader video_type_header;
  */
  std::string frame_mask;
  /*
  bool start_of_frame;
  bool end_of_frame;
  bool independent_frame;
  bool discardable_frame;
  bool base_layer_sync;
  uint8_t temporal_id;
  uint8_t layer_id;
  uint8_t tl0_pic_idx;
  */

  frame_mask +=
      "[start_of_frame = " + std::to_string(rtpheader.frame_marking.start_of_frame )  + "]";
  frame_mask += "[end_of_frame = " + std::to_string(rtpheader.frame_marking.end_of_frame ) + "]";                       
  frame_mask +=
      "[independent_frame = " +
      std::to_string(rtpheader.frame_marking.independent_frame) + "]";  
  frame_mask +=
      "[discardable_frame = " +
      std::to_string(rtpheader.frame_marking.discardable_frame ) + "]";  
  frame_mask +=
      "[base_layer_sync = " +
      std::to_string(rtpheader.frame_marking.base_layer_sync ) + "]"; 
  frame_mask +=
      "[temporal_id = " + std::to_string(rtpheader.frame_marking.temporal_id) + "]" ;


  frame_mask +=
      "[layer_id = " + std::to_string(rtpheader.frame_marking.layer_id) +
      "]" ;

  frame_mask +=
      "[tl0_pic_idx = " + std::to_string(rtpheader.frame_marking.tl0_pic_idx) +
      "]" ;

  ::sprintf(&buffer[0],
            "[generic = %s][width = %hu][height = %hu][rotation = "
            "%d][content_type = %s]\n[is_first_packet_in_frame = %s][is_last_packet_in_frame = %s][simulcastIdx = %hhu]\n[codec = %s][playout_delay = (min = %d, max = %d)][video_timing = %s][frame_marking = %s]\n[color_space = %s]",
      (rtpheader.generic? webrtc::ToString(rtpheader.generic.value()).c_str() : "false"),
            rtpheader.width, rtpheader.height, rtpheader.rotation,
            webrtc::videocontenttypehelpers::ToString(rtpheader.content_type),
            (rtpheader.is_first_packet_in_frame ? "true" : "false"),
            (rtpheader.is_last_packet_in_frame ? "true" : "false"),
      rtpheader.simulcastIdx,
      (rtpheader.codec == VideoCodecType::kVideoCodecH264 ? "VideoCodecH264"
                                                          : "VideoCodecVP8"),
      rtpheader.playout_delay.min_ms, rtpheader.playout_delay.max_ms,
      webrtc::ToString(rtpheader.video_timing).c_str(), frame_mask.c_str(),
      (rtpheader.color_space ? "true" : "false"));

  return buffer;
}
}  // namespace webrtc
