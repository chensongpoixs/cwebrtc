project(api)



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

add_library(${PROJECT_NAME} STATIC  ${api_source})
add_library(media_stream_interface  STATIC ${media_stream_interface_source})

add_library(audio_options_api  STATIC ${audio_options_api_source})

add_library(ice_transport_factory  STATIC ${ice_transport_factory_source})
add_library(libjingle_peerconnection_api  STATIC ${libjingle_peerconnection_api_source})
add_library(packet_socket_factory  STATIC ${packet_socket_factory_source})


add_library(async_dns_resolver  STATIC ${async_dns_resolver_source})


add_library(wrapping_async_dns_resolver  STATIC ${wrapping_async_dns_resolver_source})


add_library(scoped_refptr  STATIC  ${scoped_refptr_source})
add_subdirectory(task_queue)


add_subdirectory(video)


set_target_properties(async_dns_resolver                               PROPERTIES LINKER_LANGUAGE CXX)


set_target_properties(scoped_refptr                               PROPERTIES LINKER_LANGUAGE CXX)


# packet_socket_factory

set_target_properties(packet_socket_factory                               PROPERTIES LINKER_LANGUAGE CXX)


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
set_property(TARGET media_stream_interface  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})

set_property(TARGET audio_options_api  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})


set_property(TARGET ice_transport_factory  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})


set_property(TARGET libjingle_peerconnection_api  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
set_property(TARGET packet_socket_factory  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})

set_property(TARGET async_dns_resolver  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})


set_property(TARGET wrapping_async_dns_resolver  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})


set_property(TARGET scoped_refptr  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})


#set_property(TARGET scoped_refptr  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})








