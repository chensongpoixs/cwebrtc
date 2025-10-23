project(video_capture)
cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")



FILE(GLOB  video_capture_module_source

	device_info_impl.cc
    device_info_impl.h
    video_capture.h
    video_capture_config.h
    video_capture_defines.h
    video_capture_factory.cc
    video_capture_factory.h
    video_capture_impl.cc
    video_capture_impl.h
)


FILE(GLOB  video_capture_internal_impl_source


        windows/device_info_ds.cc
        windows/device_info_ds.h
        windows/help_functions_ds.cc
        windows/help_functions_ds.h
        windows/sink_filter_ds.cc
        windows/sink_filter_ds.h
        windows/video_capture_ds.cc
        windows/video_capture_ds.h
        windows/video_capture_factory_windows.cc
)

 


# FILE(GLOB  desktop_capture_mock_source


# 		./mock_desktop_capturer_callback.cc
#       ./mock_desktop_capturer_callback.h
# )


#add_library(desktop_capture_mock STATIC ${desktop_capture_mock_source})


add_library(${PROJECT_NAME} STATIC ${video_capture_module_source} 
  ${video_capture_internal_impl_source}
  
  )
#add_library(desktop_capture_differ_sse2 STATIC  ${desktop_capture_differ_sse2_source})

#add_library(screen_drawer  STATIC  ${screen_drawer_source})

set(AllFile

#${desktop_capture_mock_source}
${video_capture_module_source}
${video_capture_internal_impl_source}
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
