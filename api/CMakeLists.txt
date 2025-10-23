project(api)
 
cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")

include_directories(

    .
)

FILE(GLOB   api_source

	#scoped_refptr.h
	array_view.h
	function_view.h
	media_types.cc
	media_types.h
	priority.h
	ref_counted_base.h
	rtp_headers.cc
	rtp_headers.h
	rtp_packet_info.cc
	rtp_packet_info.h
	#rtp_packet_infos (2).h
	rtp_packet_infos.h
	rtp_packet_infos.cc
	rtp_parameters.cc
	rtp_parameters.h
	rtp_transceiver_direction.h
	scoped_refptr.h
	sequence_checker.h
	stats_types.cc
	stats_types.h
	audio/audio_frame.cc
	audio/audio_frame.h
	audio/audio_frame_processor.h
	audio/audio_mixer.h
	audio/channel_layout.cc
	audio/channel_layout.h
	audio/echo_canceller3_config.cc
	audio/echo_canceller3_config.h
	audio/echo_canceller3_config_json.cc
	audio/echo_canceller3_config_json.h
	audio/echo_canceller3_factory.cc
	audio/echo_canceller3_factory.h
	audio/echo_control.h
	audio/echo_detector_creator.cc
	audio/echo_detector_creator.h
	audio_codecs/audio_format.cc
	audio_codecs/audio_format.h
	crypto/crypto_options.cc
	crypto/crypto_options.h
	#api/task_queue/default_task_queue_factory.h
	#api/task_queue/default_task_queue_factory_stdlib.cc
	#api/task_queue/default_task_queue_factory_win.cc
	# api/task_queue/queued_task.h
	# api/task_queue/task_queue_base.cc
	# api/task_queue/task_queue_base.h
	# api/task_queue/task_queue_factory.h
	transport/network_types.cc
	transport/network_types.h
	transport/rtp/dependency_descriptor.cc
	transport/rtp/dependency_descriptor.h
	transport/stun.cc
	transport/stun.h
	transport/webrtc_key_value_config.h
	units/data_rate.cc
	units/data_rate.h
	units/data_size.cc
	units/data_size.h
	units/frequency.cc
	units/frequency.h
	units/time_delta.cc
	units/time_delta.h
	units/timestamp.cc
	units/timestamp.h
	# video/color_space.cc
	# video/color_space.h
	# video/hdr_metadata.cc
	# video/hdr_metadata.h
	# video/i420_buffer.cc
	# video/i420_buffer.h
	# video/nv12_buffer.cc
	# video/nv12_buffer.h
	# video/render_resolution.h
	# video/video_codec_type.h
	# video/video_content_type.cc
	# video/video_content_type.h
	# video/video_frame_buffer.cc
	# video/video_frame_buffer.h
	# video/video_frame.cc
	# video/video_frame.h
	# video/video_frame_type.h
	# video/video_layers_allocation.h
	# video/video_rotation.h
	# video/video_sink_interface.h
	# video/video_timing.cc
	# video/video_timing.h
	# video_codecs/bitstream_parser.h
	
)


 
FILE(GLOB  media_stream_interface_source 

    media_stream_interface.cc
    media_stream_interface.h
    media_stream_track.h
    notifier.h
	
)


FILE(GLOB  audio_options_api_source


    audio_options.cc
    audio_options.h
)


FILE(GLOB  ice_transport_factory_source


	ice_transport_factory.h 
	ice_transport_factory.cc 
)


FILE(GLOB  packet_socket_factory_source


	packet_socket_factory.h 
	packet_socket_factory.cc 
)


FILE(GLOB libjingle_peerconnection_api_source

	candidate.cc
    candidate.h
    crypto_params.h
    data_channel_interface.cc
    data_channel_interface.h
    dtls_transport_interface.cc
    dtls_transport_interface.h
    dtmf_sender_interface.h
    ice_transport_interface.h
    jsep.cc
    jsep.h
    jsep_ice_candidate.cc
    jsep_ice_candidate.h
    jsep_session_description.h
    peer_connection_interface.cc
    peer_connection_interface.h
    rtp_receiver_interface.cc
    rtp_receiver_interface.h
    rtp_sender_interface.cc
    rtp_sender_interface.h
    rtp_transceiver_interface.cc
    rtp_transceiver_interface.h
    sctp_transport_interface.cc
    sctp_transport_interface.h
    set_local_description_observer_interface.h
    set_remote_description_observer_interface.h
    stats_types.cc
    stats_types.h
    turn_customizer.h
    uma_metrics.h
    video_track_source_proxy_factory.h

)


FILE(GLOB   async_dns_resolver_source


	async_dns_resolver.h 
)


FILE(GLOB  wrapping_async_dns_resolver_source

 wrapping_async_dns_resolver.cc
    wrapping_async_dns_resolver.h
)


FILE(GLOB  scoped_refptr_source


	scoped_refptr.h 
)

FILE(GLOB  rtc_error_source

	rtc_error.cc 
	rtc_error.h
)

FILE(GLOB  libjingle_logging_api_source

			rtc_event_log_output.h
)

 FILE(GLOB  numerics_source
    numerics/samples_stats_counter.cc
    numerics/samples_stats_counter.h

)


FILE(GLOB  task_queue_source 

    task_queue/queued_task.h
    task_queue/task_queue_base.h
    task_queue/task_queue_base.cc
    task_queue/task_queue_factory.h
  #deps = [
 #   "../../rtc_base:checks",
 #   "../../rtc_base:macromagic",
  #  "../../rtc_base/system:rtc_export",
 # ]

)

FILE(GLOB  default_task_queue_factory_source
    task_queue/default_task_queue_factory.h
    task_queue/default_task_queue_factory_win.cc
)



FILE(GLOB rtc_event_log_source


    rtc_event_log/rtc_event.cc
    rtc_event_log/rtc_event.h
    rtc_event_log/rtc_event_log.cc
    rtc_event_log/rtc_event_log.h
    rtc_event_log/rtc_event_log_factory_interface.h

)

FILE(GLOB   rtc_event_log_factory_source

	rtc_event_log/rtc_event_log_factory.h 
	rtc_event_log/rtc_event_log_factory.cc 
)



##############
FILE(GLOB  video_codecs_api_source
    video_codecs/h264_profile_level_id.cc
    video_codecs/h264_profile_level_id.h
    video_codecs/sdp_video_format.cc
    video_codecs/sdp_video_format.h
    video_codecs/spatial_layer.cc
    video_codecs/spatial_layer.h
    video_codecs/video_codec.cc
    video_codecs/video_codec.h
    video_codecs/video_decoder.cc
    video_codecs/video_decoder.h
    video_codecs/video_decoder_factory.h
    video_codecs/video_encoder.cc
    video_codecs/video_encoder.h
    video_codecs/video_encoder_config.cc
    video_codecs/video_encoder_config.h
    video_codecs/video_encoder_factory.h
    video_codecs/vp8_frame_buffer_controller.h
    video_codecs/vp8_frame_config.cc
    video_codecs/vp8_frame_config.h
    video_codecs/vp8_temporal_layers.cc
    video_codecs/vp8_temporal_layers.h
    video_codecs/vp9_profile.cc
    video_codecs/vp9_profile.h

)

FILE(GLOB  bitstream_parser_api_source
	video_codecs/bitstream_parser.h

)

FILE(GLOB builtin_video_decoder_factory_source
    video_codecs/builtin_video_decoder_factory.cc
    video_codecs/builtin_video_decoder_factory.h
)

FILE(GLOB builtin_video_encoder_factory_source 
	video_codecs/builtin_video_encoder_factory.h 
	video_codecs/builtin_video_encoder_factory.cc 
)

FILE(GLOB  vp8_temporal_layers_factory_source

	video_codecs/vp8_temporal_layers_factory.cc 
	video_codecs/vp8_temporal_layers_factory.h
)

FILE(GLOB  rtc_software_fallback_wrappers_source
    video_codecs/video_decoder_software_fallback_wrapper.cc
    video_codecs/video_decoder_software_fallback_wrapper.h
    video_codecs/video_encoder_software_fallback_wrapper.cc
    video_codecs/video_encoder_software_fallback_wrapper.h
)





######################################

FILE(GLOB   video_rtp_headers_source 

		video/color_space.cc
		video/color_space.h
		video/hdr_metadata.cc
		video/hdr_metadata.h
		video/video_content_type.cc
		video/video_content_type.h
		video/video_rotation.h
		video/video_timing.cc
		video/video_timing.h


)


FILE(GLOB  video_frame_source 


		video/i420_buffer.cc
		video/i420_buffer.h
		video/nv12_buffer.cc
		video/nv12_buffer.h
		video/video_codec_type.h
		video/video_frame.cc
		video/video_frame.h
		video/video_frame_buffer.cc
		video/video_frame_buffer.h
		video/video_sink_interface.h
		video/video_source_interface.cc
		video/video_source_interface.h
)


FILE(GLOB  video_frame_i010_source


	video/i010_buffer.cc
    video/i010_buffer.h
)




FILE(GLOB  recordable_encoded_frame_source


		video/recordable_encoded_frame.h
		
		
)

FILE(GLOB video_frame_type_source


	video/video_frame_type.h 
	
	)
	
	
FILE(GLOB  render_resolution_source 

	video/render_resolution.h 
	
	)
	
FILE(GLOB encoded_image_source 

	video/encoded_image.h 
	video/encoded_image.cc 

)

FILE(GLOB encoded_frame_source

	video/encoded_frame.h 
	video/encoded_frame.cc
)

FILE(GLOB  rtp_video_frame_assembler_source 


	video/rtp_video_frame_assembler.h 
	video/rtp_video_frame_assembler.cc 
	
	
	
	)
	
	
	
FILE(GLOB video_codec_constants_source

	video/video_codec_constants.h 
)

FILE(GLOB  video_bitrate_allocation_source

	video/video_bitrate_allocation.h 
	video/video_bitrate_allocation.cc 
)


FILE(GLOB  video_layers_allocation_source 


	video/video_layers_allocation.h 
)


FILE(GLOB  video_bitrate_allocator_source

	video/video_bitrate_allocator.h 
	video/video_bitrate_allocator.cc 

)

FILE(GLOB video_bitrate_allocator_factory_source

	video/video_bitrate_allocator_factory.h 
)

FILE(GLOB video_stream_decoder_source 


	video/video_stream_decoder.h

)


FILE(GLOB  video_stream_decoder_create_source


	video/video_stream_decoder_create.h 
	video/video_stream_decoder_create.cc 
	)
	
FILE(GLOB  video_adaptation_source 

	video/video_adaptation_counters.cc
    video/video_adaptation_counters.h
    video/video_adaptation_reason.h


)

FILE(GLOB video_stream_encoder_source


    video/video_stream_encoder_interface.h
    video/video_stream_encoder_observer.h
    video/video_stream_encoder_settings.h
)

FILE(GLOB video_frame_metadata_source

	video/video_frame_metadata.h 
	video/video_frame_metadata.cc 
)


FILE(GLOB builtin_video_bitrate_allocator_factory_source


	video/builtin_video_bitrate_allocator_factory.h 
	video/builtin_video_bitrate_allocator_factory.cc 
)

#################################################################################




FILE(GLOB audio_codecs_api_source
   audio_codecs/audio_codec_pair_id.cc
   audio_codecs/audio_codec_pair_id.h
   audio_codecs/audio_decoder.cc
   audio_codecs/audio_decoder.h
   audio_codecs/audio_decoder_factory.h
   audio_codecs/audio_decoder_factory_template.h
   audio_codecs/audio_encoder.cc
   audio_codecs/audio_encoder.h
   audio_codecs/audio_encoder_factory.h
   audio_codecs/audio_encoder_factory_template.h
   audio_codecs/audio_format.cc
   audio_codecs/audio_format.h
)

FILE(GLOB  builtin_audio_decoder_factory_source 
    audio_codecs/builtin_audio_decoder_factory.cc
    audio_codecs/builtin_audio_decoder_factory.h
)


FILE(GLOB  builtin_audio_encoder_factory_source

    audio_codecs/builtin_audio_encoder_factory.cc
    audio_codecs/builtin_audio_encoder_factory.h
)


FILE(GLOB  opus_audio_decoder_factory_source

    audio_codecs/opus_audio_decoder_factory.cc
    audio_codecs/opus_audio_decoder_factory.h
)

FILE(GLOB  opus_audio_encoder_factory_source
    audio_codecs/opus_audio_encoder_factory.cc
    audio_codecs/opus_audio_encoder_factory.h
)


FILE(GLOB audio_g711_source
    audio_codecs/g711/audio_encoder_g711.cc
    audio_codecs/g711/audio_encoder_g711.h 
	audio_codecs/g711/audio_decoder_g711.h 
	audio_codecs/g711/audio_decoder_g711.cc 
	
)
FILE(GLOB audio_g722_source
    audio_codecs/g722/audio_encoder_g722.cc
    audio_codecs/g722/audio_encoder_g722.h
	audio_codecs/g722/audio_encoder_g722_config.h 
	audio_codecs/g722/audio_decoder_g722.h 
	audio_codecs/g722/audio_decoder_g722.cc 
	audio_codecs/g722/audio_encoder_g722_config.h
	
)
FILE(GLOB audio_ilbc_source
    audio_codecs/ilbc/audio_encoder_ilbc.cc
    audio_codecs/ilbc/audio_encoder_ilbc.h
	audio_codecs/ilbc/audio_encoder_ilbc_config.h  
	audio_codecs/ilbc/audio_decoder_ilbc.h 
	audio_codecs/ilbc/audio_decoder_ilbc.cc 
	audio_codecs/ilbc/audio_encoder_ilbc_config.h
	
)
 FILE(GLOB audio_isac_source
    audio_codecs/isac/audio_encoder_isac.h
   # audio_encoder_g722.h
	#audio_encoder_g722_config.h 
	audio_codecs/isac/audio_decoder_isac.h 
	#audio_decoder_g722.cc 
	#audio_encoder_g722_config.h 
	audio_codecs/isac/audio_encoder_isac_float.h 
	audio_codecs/isac/audio_encoder_isac_float.cc  
	audio_codecs/isac/audio_decoder_isac_float.h 
	audio_codecs/isac/audio_decoder_isac_float.cc 
)
 FILE(GLOB audio_L16_source
    audio_codecs/L16/audio_encoder_L16.cc
    audio_codecs/L16/audio_encoder_L16.h 
	audio_codecs/L16/audio_decoder_L16.h 
	audio_codecs/L16/audio_decoder_L16.cc 
	
)
 
 ############
 FILE(GLOB audio_opus_config_source
    audio_codecs/opus/audio_encoder_multi_channel_opus_config.cc 
    audio_codecs/opus/audio_encoder_multi_channel_opus_config.h 
    audio_codecs/opus/audio_encoder_opus_config.cc 
    audio_codecs/opus/audio_encoder_opus_config.h  
	audio_codecs/opus/audio_decoder_multi_channel_opus_config.h 
	audio_codecs/opus/audio_encoder_opus.h 
	audio_codecs/opus/audio_encoder_opus.cc  
	audio_codecs/opus/audio_decoder_opus.h 
	audio_codecs/opus/audio_decoder_opus.cc  
	audio_codecs/opus/audio_encoder_multi_channel_opus.h
	audio_codecs/opus/audio_encoder_multi_channel_opus.cc 
    audio_codecs/opus/audio_decoder_multi_channel_opus.cc
    audio_codecs/opus/audio_decoder_multi_channel_opus.h
)
 
#add_subdirectory(audio_codecs/L16)
#add_subdirectory(audio_codecs/g711)
#add_subdirectory(audio_codecs/g722)
#add_subdirectory(audio_codecs/isac)
#add_subdirectory(audio_codecs/opus)
#add_subdirectory(audio_codecs/ilbc)

add_library(${PROJECT_NAME} STATIC  ${api_source}
                        ${media_stream_interface_source} 
 ${audio_options_api_source}  
 ${ice_transport_factory_source} 
  ${libjingle_peerconnection_api_source} 
    ${packet_socket_factory_source}  
 ${async_dns_resolver_source}  
  ${wrapping_async_dns_resolver_source}  
  ${scoped_refptr_source}  
  ${rtc_error_source}  
  ${libjingle_logging_api_source}
  ${numerics_source}
  ${task_queue_source}
  ${default_task_queue_factory_source}

  ${rtc_event_log_source}
  ${rtc_event_log_factory_source}


  ${video_codecs_api_source}
  ${bitstream_parser_api_source}
  ${builtin_video_decoder_factory_source}
  ${builtin_video_encoder_factory_source}
  ${vp8_temporal_layers_factory_source}
  ${rtc_software_fallback_wrappers_source}

  ##


  ${video_rtp_headers_source}
  ${video_frame_source}
  ${video_frame_i010_source}
  ${recordable_encoded_frame_source}
  ${video_frame_type_source}
  ${render_resolution_source}
  ${encoded_image_source}
  ${encoded_frame_source}
  ${rtp_video_frame_assembler_source}
  ${video_codec_constants_source}
  ${video_bitrate_allocation_source}
  ${video_layers_allocation_source}
  ${video_bitrate_allocator_source}
  ${video_bitrate_allocator_factory_source}
  ${video_stream_decoder_source}
  ${video_stream_decoder_create_source}
  ${video_adaptation_source}
  ${video_stream_encoder_source}
  ${video_frame_metadata_source}
  ${builtin_video_bitrate_allocator_factory_source}

  ########


  ${audio_codecs_api_source}
  ${builtin_audio_decoder_factory_source}
  ${builtin_audio_encoder_factory_source}
  ${opus_audio_decoder_factory_source}
  ${opus_audio_encoder_factory_source}
  ${audio_g711_source}

  ${audio_g722_source}
  ${audio_ilbc_source}
  ${audio_isac_source}
  ${audio_L16_source}
  ${audio_opus_config_source}
  )
#add_subdirectory(task_queue)
#add_subdirectory(rtc_event_log)
#add_subdirectory(audio_codecs)
#add_subdirectory(video_codecs)
#add_subdirectory(numerics)
#add_subdirectory(video)


#set_target_properties(async_dns_resolver                               PROPERTIES LINKER_LANGUAGE CXX)


#set_target_properties(scoped_refptr                               PROPERTIES LINKER_LANGUAGE CXX)


# packet_socket_factory

#set_target_properties(packet_socket_factory                               PROPERTIES LINKER_LANGUAGE CXX)
#set_target_properties(libjingle_logging_api                               PROPERTIES LINKER_LANGUAGE CXX)

set(AllFile 

          
		${api_source}
		${media_stream_interface_source}
		${audio_options_api_source}
        ${ice_transport_factory_source}
		${libjingle_peerconnection_api_source}
		${wrapping_async_dns_resolver_source}
		${async_dns_resolver_source}
		${packet_socket_factory_source}
		${scoped_refptr_source}
		${rtc_error_source}
		${libjingle_logging_api_source}
		${numerics_source}
  ${task_queue_source}
  ${default_task_queue_factory_source}
		 ${rtc_event_log_source}
  ${rtc_event_log_factory_source}


    ${video_codecs_api_source}
  ${bitstream_parser_api_source}
  ${builtin_video_decoder_factory_source}
  ${builtin_video_encoder_factory_source}
  ${vp8_temporal_layers_factory_source}
  ${rtc_software_fallback_wrappers_source}
    ${video_rtp_headers_source}
  ${video_frame_source}
  ${video_frame_i010_source}
  ${recordable_encoded_frame_source}
  ${video_frame_type_source}
  ${render_resolution_source}
  ${encoded_image_source}
  ${encoded_frame_source}
  ${rtp_video_frame_assembler_source}
  ${video_codec_constants_source}
  ${video_bitrate_allocation_source}
  ${video_layers_allocation_source}
  ${video_bitrate_allocator_source}
  ${video_bitrate_allocator_factory_source}
  ${video_stream_decoder_source}
  ${video_stream_decoder_create_source}
  ${video_adaptation_source}
  ${video_stream_encoder_source}
  ${video_frame_metadata_source}
  ${builtin_video_bitrate_allocator_factory_source}

  #
    ${audio_codecs_api_source}
  ${builtin_audio_decoder_factory_source}
  ${builtin_audio_encoder_factory_source}
  ${opus_audio_decoder_factory_source}
  ${opus_audio_encoder_factory_source}
  ${audio_g711_source}
  ${audio_g722_source}
  ${audio_ilbc_source}
  ${audio_isac_source}
  ${audio_L16_source}
  ${audio_opus_config_source}
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



set_property(TARGET ${PROJECT_NAME}  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET media_stream_interface  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#
#set_property(TARGET audio_options_api  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#
#
#set_property(TARGET ice_transport_factory  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#
#
#set_property(TARGET libjingle_peerconnection_api  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET packet_socket_factory  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#
#set_property(TARGET async_dns_resolver  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#
#
#set_property(TARGET wrapping_async_dns_resolver  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#
#
#set_property(TARGET scoped_refptr  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#
#
#set_property(TARGET rtc_error  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET libjingle_logging_api  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})







