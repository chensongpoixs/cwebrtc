project(audio_device)

cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")


FILE(GLOB  audio_device_api_source

    include/audio_device.h
    include/audio_device_defines.h
)


FILE(GLOB  audio_device_buffer_source


    audio_device_buffer.cc
    audio_device_buffer.h
    audio_device_config.h
    fine_audio_buffer.cc
    fine_audio_buffer.h
)

FILE(GLOB  audio_device_generic_source

    audio_device_generic.cc
    audio_device_generic.h
)


FILE(GLOB audio_device_name_source

    audio_device_name.cc
    audio_device_name.h
)
 
FILE(GLOB windows_core_audio_utility_source

      win/core_audio_utility_win.cc
      win/core_audio_utility_win.h
)

FILE(GLOB  audio_device_module_from_input_and_output_source
      include/audio_device_factory.cc
      include/audio_device_factory.h
	  win/audio_device_module_win.cc
      win/audio_device_module_win.h
      win/core_audio_base_win.cc
      win/core_audio_base_win.h
      win/core_audio_input_win.cc
      win/core_audio_input_win.h
      win/core_audio_output_win.cc
      win/core_audio_output_win.h
)


FILE(GLOB  audio_device_impl_source

    dummy/audio_device_dummy.cc
    dummy/audio_device_dummy.h
    dummy/file_audio_device.cc
    dummy/file_audio_device.h
    include/fake_audio_device.h
    include/test_audio_device.cc
    include/test_audio_device.h
  audio_device_data_observer.cc
  audio_device_impl.cc
  audio_device_impl.h
  include/audio_device_data_observer.h


          win/audio_device_core_win.cc
          win/audio_device_core_win.h  
		  
		  
		  #          "dmoguids.lib",
         # "wmcodecdspuuid.lib",
         # "amstrmid.lib",
         ## "msdmo.lib",
         # "oleaut32.lib",
)



add_library(audio_device_api 							STATIC ${audio_device_api_source})
add_library(audio_device_buffer 							STATIC ${audio_device_buffer_source})
add_library(audio_device_generic						STATIC ${audio_device_generic_source})
add_library(audio_device_name_source 							STATIC ${audio_device_name_source})
add_library(windows_core_audio_utility 					STATIC ${windows_core_audio_utility_source})
add_library(audio_device_module_from_input_and_output 	STATIC ${audio_device_module_from_input_and_output_source})
add_library(audio_device_impl 							STATIC ${audio_device_impl_source})
#add_library(desktop_capture_mock STATIC ${audio_device_api_source})

 set_target_properties(audio_device_api      			      					PROPERTIES LINKER_LANGUAGE CXX)  
#add_library(desktop_capture_differ_sse2 STATIC  ${desktop_capture_differ_sse2_source})

#add_library(screen_drawer  STATIC  ${screen_drawer_source})

set(AllFile



${audio_device_api_source} 						
${audio_device_buffer_source}					
${audio_device_generic_source}					
${audio_device_name_source} 						
${windows_core_audio_utility_source} 				
${audio_device_module_from_input_and_output_source}
${audio_device_impl_source} 						

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


#set_property(TARGET audio_device_api  				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME}) 
set_property(TARGET       audio_device_api                                                              PROPERTY FOLDER  ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET       audio_device_buffer                                                               PROPERTY FOLDER  ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET       audio_device_generic                                                              PROPERTY FOLDER  ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET       audio_device_name_source                                                              PROPERTY FOLDER  ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET       windows_core_audio_utility                                                              PROPERTY FOLDER  ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET       audio_device_module_from_input_and_output                                                              PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET       audio_device_impl                                                              PROPERTY FOLDER  ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})



#set_property(TARGET  desktop_capture_differ_sse2   PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})

#set_property(TARGET  screen_drawer    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
