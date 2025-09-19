project(rtc_event_log)
cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")




FILE(GLOB rtc_event_log_source


    rtc_event.cc
    rtc_event.h
    rtc_event_log.cc
    rtc_event_log.h
    rtc_event_log_factory_interface.h

)

FILE(GLOB   rtc_event_log_factory_source

	rtc_event_log_factory.h 
	rtc_event_log_factory.cc 
)

add_library(rtc_event_log             		   					STATIC  ${rtc_event_log_source}                         ) 
add_library(rtc_event_log_factory             		   					STATIC  ${rtc_event_log_factory_source}                         ) 
 




set_target_properties(rtc_event_log      			      					PROPERTIES LINKER_LANGUAGE CXX)  

set(AllFile 

          
		${rtc_event_log_source}  
		${rtc_event_log_factory_source} 
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


 
set_property(TARGET rtc_event_log                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME}) 
set_property(TARGET rtc_event_log_factory                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME}) 
