project(isac)

cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")


FILE(GLOB audio_encoder_isac_source
    audio_encoder_isac.h
   # audio_encoder_g722.h
	#audio_encoder_g722_config.h
)

FILE(GLOB  audio_decoder_isac_source


	audio_decoder_isac.h 
	#audio_decoder_g722.cc 
	#audio_encoder_g722_config.h
	
)

FILE(GLOB  audio_encoder_isac_float_source

	audio_encoder_isac_float.h 
	audio_encoder_isac_float.cc 
)

FILE(GLOB  audio_decoder_isac_float_source

	audio_decoder_isac_float.h 
	audio_decoder_isac_float.cc 
)
 

add_library(audio_encoder_isac  STATIC  ${audio_encoder_isac_source})
add_library(audio_decoder_isac  STATIC  ${audio_decoder_isac_source})
add_library(audio_encoder_isac_float  STATIC  ${audio_encoder_isac_float_source})
 add_library(audio_decoder_isac_float  STATIC  ${audio_decoder_isac_float_source})
 
 

set_target_properties(audio_encoder_isac                               PROPERTIES LINKER_LANGUAGE CXX) 
set_target_properties(audio_decoder_isac                               PROPERTIES LINKER_LANGUAGE CXX) 
set(AllFile

#${desktop_capture_mock_source}
${audio_encoder_isac_source} 
${audio_decoder_isac_source}
${audio_encoder_isac_float_source}
${audio_decoder_isac_float_source}
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


set_property(TARGET  audio_encoder_isac 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/audio_codecs/${PROJECT_NAME})
 set_property(TARGET  audio_decoder_isac 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/audio_codecs/${PROJECT_NAME})
 set_property(TARGET  audio_encoder_isac_float 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/audio_codecs/${PROJECT_NAME})
 
 set_property(TARGET  audio_decoder_isac_float 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/audio_codecs/${PROJECT_NAME})
 