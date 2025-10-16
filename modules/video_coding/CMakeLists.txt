project(video_coding_lib)
cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")



FILE(GLOB  video_coding_source

    encoded_frame.cc
    encoded_frame.h 
	chain_diff_calculator.cc
    chain_diff_calculator.h
    frame_dependencies_calculator.cc
    frame_dependencies_calculator.h
    histogram.cc
    histogram.h
    nack_requester.cc
    nack_requester.h
    packet_buffer.cc
    packet_buffer.h
    h264_packet_buffer.cc
    h264_packet_buffer.h
    codec_timer.cc
    codec_timer.h
    decoder_database.cc
    decoder_database.h
    fec_controller_default.cc
    fec_controller_default.h
    fec_rate_table.h
    frame_buffer2.cc
    frame_buffer2.h
    frame_object.cc
    frame_object.h
    generic_decoder.cc
    generic_decoder.h
    h264_sprop_parameter_sets.cc
    h264_sprop_parameter_sets.h
    h264_sps_pps_tracker.cc
    h264_sps_pps_tracker.h
    include/video_codec_initializer.h
    inter_frame_delay.cc
    inter_frame_delay.h
    internal_defines.h
    jitter_estimator.cc
    jitter_estimator.h
    loss_notification_controller.cc
    loss_notification_controller.h
    media_opt_util.cc
    media_opt_util.h
    rtp_frame_id_only_ref_finder.cc
    rtp_frame_id_only_ref_finder.h
    rtp_frame_reference_finder.cc
    rtp_frame_reference_finder.h
    rtp_generic_ref_finder.cc
    rtp_generic_ref_finder.h
    rtp_seq_num_only_ref_finder.cc
    rtp_seq_num_only_ref_finder.h
    rtp_vp8_ref_finder.cc
    rtp_vp8_ref_finder.h
    rtp_vp9_ref_finder.cc
    rtp_vp9_ref_finder.h
    rtt_filter.cc
    rtt_filter.h
    timestamp_map.cc
    timestamp_map.h
    timing.cc
    timing.h
    unique_timestamp_counter.cc
    unique_timestamp_counter.h
    video_codec_initializer.cc
    video_receiver2.cc
    video_receiver2.h
    include/video_codec_interface.cc
    include/video_codec_interface.h
    include/video_coding_defines.h
    include/video_error_codes.h
    video_coding_defines.cc
    decoding_state.cc
    decoding_state.h
    event_wrapper.cc
    event_wrapper.h
    frame_buffer.cc
    frame_buffer.h
    include/video_coding.h
    jitter_buffer.cc
    jitter_buffer.h
    jitter_buffer_common.h
    packet.cc
    packet.h
    receiver.cc
    receiver.h
    session_info.cc
    session_info.h
    video_coding_impl.cc
    video_coding_impl.h
    video_receiver.cc
    codecs/h264/include/h264_globals.h
    codecs/interface/common_constants.h
    codecs/vp8/include/vp8_globals.h
    codecs/vp9/include/vp9_globals.h
    utility/bandwidth_quality_scaler.cc
    utility/bandwidth_quality_scaler.h
    utility/decoded_frames_history.cc
    utility/decoded_frames_history.h
    utility/frame_dropper.cc
    utility/frame_dropper.h
    utility/framerate_controller_deprecated.cc
    utility/framerate_controller_deprecated.h
    utility/ivf_file_reader.cc
    utility/ivf_file_reader.h
    utility/ivf_file_writer.cc
    utility/ivf_file_writer.h
    utility/qp_parser.cc
    utility/qp_parser.h
    utility/quality_scaler.cc
    utility/quality_scaler.h
    utility/simulcast_rate_allocator.cc
    utility/simulcast_rate_allocator.h
    utility/simulcast_utility.cc
    utility/simulcast_utility.h
    utility/vp8_header_parser.cc
    utility/vp8_header_parser.h
    utility/vp9_constants.h
    utility/vp9_uncompressed_header_parser.cc
    utility/vp9_uncompressed_header_parser.h
    codecs/h264/h264.cc
    codecs/h264/h264_color_space.cc
    codecs/h264/h264_color_space.h
    codecs/h264/h264_decoder_impl.cc
    codecs/h264/h264_decoder_impl.h
    codecs/h264/h264_encoder_impl.cc
    codecs/h264/h264_encoder_impl.h
    codecs/h264/include/h264.h	
 #  codecs/multiplex/augmented_video_frame_buffer.cc
 #  codecs/multiplex/include/augmented_video_frame_buffer.h
 #  codecs/multiplex/include/multiplex_decoder_adapter.h
 #  codecs/multiplex/include/multiplex_encoder_adapter.h
 #  codecs/multiplex/multiplex_decoder_adapter.cc
 #  codecs/multiplex/multiplex_encoded_image_packer.cc
 #  codecs/multiplex/multiplex_encoded_image_packer.h
 #  codecs/multiplex/multiplex_encoder_adapter.cc
   # codecs/interface/libvpx_interface.cc
   # codecs/interface/libvpx_interface.h
	#codecs/interface/mock_libvpx_interface.h
    codecs/vp8/include/vp8.h
    #codecs/vp8/libvpx_vp8_decoder.cc
    #codecs/vp8/libvpx_vp8_decoder.h
    #codecs/vp8/libvpx_vp8_encoder.cc
    #codecs/vp8/libvpx_vp8_encoder.h
    #codecs/vp8/default_temporal_layers.cc
   # codecs/vp8/default_temporal_layers.h
    codecs/vp8/include/temporal_layers_checker.h
    #codecs/vp8/screenshare_layers.cc
    #codecs/vp8/screenshare_layers.h
    #codecs/vp8/temporal_layers.h
    #codecs/vp8/temporal_layers_checker.cc
    codecs/vp9/svc_config.cc
    codecs/vp9/svc_config.h
    codecs/vp9/include/vp9.h
  #  codecs/vp9/libvpx_vp9_decoder.cc
  #  codecs/vp9/libvpx_vp9_decoder.h
  #  codecs/vp9/libvpx_vp9_encoder.cc
  #  codecs/vp9/libvpx_vp9_encoder.h
   # codecs/vp9/vp9.cc
   # codecs/vp9/vp9_frame_buffer_pool.cc
   # codecs/vp9/vp9_frame_buffer_pool.h
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
)


 
 


# FILE(GLOB  desktop_capture_mock_source


# 		./mock_desktop_capturer_callback.cc
#       ./mock_desktop_capturer_callback.h
# )


#add_library(desktop_capture_mock STATIC ${desktop_capture_mock_source})


add_library(${PROJECT_NAME} STATIC ${video_coding_source}) 
#add_library(desktop_capture_differ_sse2 STATIC  ${desktop_capture_differ_sse2_source})

#add_library(screen_drawer  STATIC  ${screen_drawer_source})

set(AllFile

#${desktop_capture_mock_source}
${video_coding_source} 
#${desktop_capture_differ_sse2_source}
#${screen_drawer_source}

)
foreach(fileItem ${AllFile})       
    # Get the directory of the source file
    get_filename_component(PARENT_DIR "${fileItem}" DIRECTORY)
	
    # Remove common directory prefix to make the group
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}" "" GROUP "${PARENT_DIR}")
	#message(status    "==================>>>>${CMAKE_CURRENT_SOURCE_DIR} = ${GROUP} ====== ${PARENT_DIR}")
	#message(status   "---> fileItem = ${fileItem}     GROUP ---->  ${GROUP}")
    # Make sure we are using windows slashes
    string(REPLACE / \\ GROUP "${GROUP}")

	#string(REPLACE "/.." "\\" GROUP "${GROUP}")
	#string(REPLACE \. \\   GROUP ${GROUP})
	
    # Group into "Source Files" and "Header Files"
    set(GROUP "${GROUP}")
    source_group("${GROUP}" FILES "${fileItem}")
endforeach()



#set_property(TARGET  desktop_capture_mock PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})


set_property(TARGET  ${PROJECT_NAME} PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules)
#set_property(TARGET  video_capture_internal_impl   PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
#set_property(TARGET  desktop_capture_differ_sse2   PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})

#set_property(TARGET  screen_drawer    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
