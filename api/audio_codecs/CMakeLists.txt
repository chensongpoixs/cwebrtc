project(audio_codecs)

cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")


FILE(GLOB audio_codecs_api_source
   audio_codec_pair_id.cc
   audio_codec_pair_id.h
   audio_decoder.cc
   audio_decoder.h
   audio_decoder_factory.h
   audio_decoder_factory_template.h
   audio_encoder.cc
   audio_encoder.h
   audio_encoder_factory.h
   audio_encoder_factory_template.h
   audio_format.cc
   audio_format.h
)

FILE(GLOB  builtin_audio_decoder_factory_source 
    builtin_audio_decoder_factory.cc
    builtin_audio_decoder_factory.h
)


FILE(GLOB  builtin_audio_encoder_factory_source

    builtin_audio_encoder_factory.cc
    builtin_audio_encoder_factory.h
)


FILE(GLOB  opus_audio_decoder_factory_source

    opus_audio_decoder_factory.cc
    opus_audio_decoder_factory.h
)

FILE(GLOB  opus_audio_encoder_factory_source
    opus_audio_encoder_factory.cc
    opus_audio_encoder_factory.h
)

add_library(audio_codecs_api  STATIC  ${audio_codecs_api_source})
add_library(builtin_audio_decoder_factory  STATIC  ${builtin_audio_decoder_factory_source})
add_library(builtin_audio_encoder_factory  STATIC  ${builtin_audio_encoder_factory_source})
add_library(opus_audio_decoder_factory  STATIC  ${opus_audio_decoder_factory_source})
add_library(opus_audio_encoder_factory  STATIC  ${opus_audio_encoder_factory_source})
#add_library(audio_codecs_api  STATIC  ${audio_codecs_api_source})




add_subdirectory(L16)
add_subdirectory(g711)
add_subdirectory(g722)
add_subdirectory(isac)
add_subdirectory(opus)
add_subdirectory(ilbc)

set(AllFile

#${desktop_capture_mock_source}
${audio_codecs_api_source} 
${builtin_audio_decoder_factory_source}
${builtin_audio_encoder_factory_source}
${opus_audio_decoder_factory_source}
${opus_audio_encoder_factory_source}
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


set_property(TARGET  audio_codecs_api 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
#set_property(TARGET  rtc_sdp_video_format_utils 				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  builtin_audio_decoder_factory 				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  builtin_audio_encoder_factory 				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  opus_audio_decoder_factory 				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  opus_audio_encoder_factory 				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
#set_property(TARGET  rtc_sdp_video_format_utils 				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
#set_property(TARGET  rtc_sdp_video_format_utils 				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
#set_property(TARGET  rtc_sdp_video_format_utils 				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
