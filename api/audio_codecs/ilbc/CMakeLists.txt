project(ilbc)

cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")


FILE(GLOB audio_encoder_ilbc_source
    audio_encoder_ilbc.cc
    audio_encoder_ilbc.h
	audio_encoder_ilbc_config.h
)

FILE(GLOB  audio_decoder_ilbc_source


	audio_decoder_ilbc.h 
	audio_decoder_ilbc.cc 
	audio_encoder_ilbc_config.h
	
)
 

add_library(audio_encoder_ilbc  STATIC  ${audio_encoder_ilbc_source})
add_library(audio_decoder_ilbc  STATIC  ${audio_decoder_ilbc_source})
 
 


set(AllFile

#${desktop_capture_mock_source}
${audio_encoder_ilbc_source} 
${audio_decoder_ilbc_source}
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


set_property(TARGET  audio_encoder_ilbc 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/audio_codecs/${PROJECT_NAME})
 set_property(TARGET  audio_decoder_ilbc 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/audio_codecs/${PROJECT_NAME})
 
