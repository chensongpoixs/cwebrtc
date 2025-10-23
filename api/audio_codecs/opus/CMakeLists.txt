project(opus)

cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")


FILE(GLOB audio_encoder_opus_config_source
    audio_encoder_multi_channel_opus_config.cc 
    audio_encoder_multi_channel_opus_config.h 
    audio_encoder_opus_config.cc 
    audio_encoder_opus_config.h 
)

FILE(GLOB  audio_decoder_opus_config_source


		audio_decoder_multi_channel_opus_config.h
	
)

FILE(GLOB  audio_encoder_opus_source
	audio_encoder_opus.h 
	audio_encoder_opus.cc 
)

FILE(GLOB  audio_decoder_opus_source

	audio_decoder_opus.h 
	audio_decoder_opus.cc 
)

FILE(GLOB  audio_encoder_multiopus_source
	audio_encoder_multi_channel_opus.h
	audio_encoder_multi_channel_opus.cc
)

FILE(GLOB audio_decoder_multiopus_source
    audio_decoder_multi_channel_opus.cc
    audio_decoder_multi_channel_opus.h
)
 

add_library(audio_encoder_opus_config  STATIC  ${audio_encoder_opus_config_source})
add_library(audio_decoder_opus_config  STATIC  ${audio_decoder_opus_config_source})
add_library(audio_encoder_opus          STATIC  ${audio_encoder_opus_source})
add_library(audio_decoder_opus          STATIC  ${audio_decoder_opus_source})
add_library(audio_encoder_multiopus          STATIC  ${audio_encoder_multiopus_source})
add_library(audio_decoder_multiopus          STATIC  ${audio_decoder_multiopus_source})
#add_library(audio_encoder_opus          STATIC  ${audio_encoder_opus_source})
#add_library(audio_encoder_opus          STATIC  ${audio_encoder_opus_source})
  
 
set_target_properties(audio_decoder_opus_config                               PROPERTIES LINKER_LANGUAGE CXX) 

set(AllFile

#${desktop_capture_mock_source}
${audio_encoder_opus_config_source} 
${audio_decoder_opus_config_source}
${audio_encoder_opus_source}
${audio_decoder_opus_source}
${audio_encoder_multiopus_source}
${audio_decoder_multiopus_source}
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


set_property(TARGET  audio_encoder_opus_config 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/audio_codecs/${PROJECT_NAME})
set_property(TARGET  audio_decoder_opus_config 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/audio_codecs/${PROJECT_NAME})
set_property(TARGET  audio_encoder_opus 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/audio_codecs/${PROJECT_NAME})
set_property(TARGET  audio_decoder_opus 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/audio_codecs/${PROJECT_NAME})
set_property(TARGET  audio_encoder_multiopus 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/audio_codecs/${PROJECT_NAME})
set_property(TARGET  audio_decoder_multiopus 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/audio_codecs/${PROJECT_NAME})
#set_property(TARGET  audio_encoder_opus 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/audio_codecs/${PROJECT_NAME})
   
