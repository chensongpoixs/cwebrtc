project(video_codecs)

cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")



FILE(GLOB  video_codecs_api_source
    h264_profile_level_id.cc
    h264_profile_level_id.h
    sdp_video_format.cc
    sdp_video_format.h
    spatial_layer.cc
    spatial_layer.h
    video_codec.cc
    video_codec.h
    video_decoder.cc
    video_decoder.h
    video_decoder_factory.h
    video_encoder.cc
    video_encoder.h
    video_encoder_config.cc
    video_encoder_config.h
    video_encoder_factory.h
    vp8_frame_buffer_controller.h
    vp8_frame_config.cc
    vp8_frame_config.h
    vp8_temporal_layers.cc
    vp8_temporal_layers.h
    vp9_profile.cc
    vp9_profile.h

)

FILE(GLOB  bitstream_parser_api_source
	bitstream_parser.h

)

FILE(GLOB builtin_video_decoder_factory_source
    builtin_video_decoder_factory.cc
    builtin_video_decoder_factory.h
)

FILE(GLOB builtin_video_encoder_factory_source 
	builtin_video_encoder_factory.h 
	builtin_video_encoder_factory.cc 
)

FILE(GLOB  vp8_temporal_layers_factory_source

	vp8_temporal_layers_factory.cc 
	vp8_temporal_layers_factory.h
)

FILE(GLOB  rtc_software_fallback_wrappers_source
    video_decoder_software_fallback_wrapper.cc
    video_decoder_software_fallback_wrapper.h
    video_encoder_software_fallback_wrapper.cc
    video_encoder_software_fallback_wrapper.h
)

add_library(video_codecs_api  STATIC  ${video_codecs_api_source}) 
add_library(bitstream_parser_api  STATIC  ${bitstream_parser_api_source}) 
add_library(builtin_video_decoder_factory  STATIC  ${builtin_video_decoder_factory_source}) 
add_library(builtin_video_encoder_factory  STATIC  ${builtin_video_encoder_factory_source}) 
add_library(vp8_temporal_layers_factory  STATIC  ${vp8_temporal_layers_factory_source}) 
add_library(rtc_software_fallback_wrappers  STATIC  ${rtc_software_fallback_wrappers_source}) 


# packet_socket_factory

set_target_properties(bitstream_parser_api                               PROPERTIES LINKER_LANGUAGE CXX) 

set(AllFile 

          
		${video_codecs_api_source} 
		${bitstream_parser_api_source}
		${builtin_video_decoder_factory_source}
		${builtin_video_encoder_factory_source}
		${vp8_temporal_layers_factory_source}
		${rtc_software_fallback_wrappers_source}
		
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



set_property(TARGET video_codecs_api  									PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET bitstream_parser_api  									PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET builtin_video_decoder_factory  									PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET builtin_video_encoder_factory  									PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET vp8_temporal_layers_factory  									PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET rtc_software_fallback_wrappers  									PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})


