

project(memory)
cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")

#add_definitions(
				#	-DWIN32
				#	-D_DEBUG
				##	-D_WINDOWS
				#	-D_UNICODE
				#	-DUNICODE
				#	-D_AFXDLL
#)

 


#

file(GLOB aligned_malloc_source 
	 
	aligned_malloc.h
	aligned_malloc.cc 
	 
) 


FILE(GLOB fifo_buffer_source

    fifo_buffer.cc
    fifo_buffer.h
)


 
add_library(aligned_malloc  STATIC  ${aligned_malloc_source})
add_library(fifo_buffer      STATIC  ${fifo_buffer_source})

 


#set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "/SUBSYSTEM:WINDOWS /SAFESEH:NO")


set(AllFile ${aligned_malloc_source} ${fifo_buffer_source})
foreach(fileItem ${AllFile})       
    # Get the directory of the source file
    get_filename_component(PARENT_DIR "${fileItem}" DIRECTORY)
	
    # Remove common directory prefix to make the group
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}" "" GROUP "${PARENT_DIR}")
    # Make sure we are using windows slashes
    string(REPLACE "/" "\\" GROUP "${GROUP}")
	#message(status   "---> fileItem = ${fileItem}     GROUP ---->  ${GROUP}")
    # Group into "Source Files" and "Header Files"
    set(GROUP "${GROUP}")
    source_group("${GROUP}" FILES "${fileItem}")
endforeach()



set_property(TARGET aligned_malloc  				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET fifo_buffer  				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
#file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/resources DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})