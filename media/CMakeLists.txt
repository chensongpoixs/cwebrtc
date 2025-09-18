project(media)




FILE(GLOB  rtc_media_base_source



     base/media_config.h

	base/adapted_video_track_source.cc
    base/adapted_video_track_source.h
    base/audio_source.h
    base/codec.cc
    base/codec.h
    base/delayable.h
    base/media_channel.cc
    base/media_channel.h
    base/media_constants.cc
    base/media_constants.h
    base/media_engine.cc
    base/media_engine.h
    base/rid_description.cc
    base/rid_description.h
    base/rtp_utils.cc
    base/rtp_utils.h
    base/stream_params.cc
    base/stream_params.h
    base/turn_utils.cc
    base/turn_utils.h
    base/video_adapter.cc
    base/video_adapter.h
    base/video_broadcaster.cc
    base/video_broadcaster.h
    base/video_common.cc
    base/video_common.h
    base/video_source_base.cc
    base/video_source_base.h

)


add_library(rtc_media_base  STATIC  ${rtc_media_base_source})



set(AllFile

#${desktop_capture_mock_source}
${rtc_media_base_source}

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


set_property(TARGET  rtc_media_base PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
