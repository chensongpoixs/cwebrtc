project(api)



include_directories(

    .
)

FILE(GLOB   api_source

	scoped_refptr.h
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
	video/color_space.cc
	video/color_space.h
	video/hdr_metadata.cc
	video/hdr_metadata.h
	video/i420_buffer.cc
	video/i420_buffer.h
	video/nv12_buffer.cc
	video/nv12_buffer.h
	video/render_resolution.h
	video/video_codec_type.h
	video/video_content_type.cc
	video/video_content_type.h
	video/video_frame_buffer.cc
	video/video_frame_buffer.h
	video/video_frame.cc
	video/video_frame.h
	video/video_frame_type.h
	video/video_layers_allocation.h
	video/video_rotation.h
	video/video_sink_interface.h
	video/video_timing.cc
	video/video_timing.h
	video_codecs/bitstream_parser.h
	
)


 



add_library(${PROJECT_NAME} STATIC  ${api_source})


add_subdirectory(task_queue)



set(AllFile 

          
		

        ${task_queue}
    
		
)

foreach(fileItem ${AllFile})       
    # Get the directory of the source file
    get_filename_component(PARENT_DIR ${fileItem} DIRECTORY)
	
    # Remove common directory prefix to make the group
     string(REPLACE ${CMAKE_CURRENT_SOURCE_DIR} "" GROUP ${PARENT_DIR})
    # Make sure we are using windows slashes
     string(REPLACE / \\  GROUP ${GROUP})
     string(REPLACE "/.."  "\\" GROUP ${GROUP})
	#message(status   ---> fileItem = ${fileItem}     GROUP ---->  ${GROUP})
    # Group into Source Files and Header Files
     set(GROUP ${GROUP})
     source_group(${GROUP} FILES ${fileItem})
endforeach()



set_property(TARGET ${PROJECT_NAME}  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})





