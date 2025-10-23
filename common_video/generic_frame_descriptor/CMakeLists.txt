project(generic_frame_descriptor)



FILE(GLOB  generic_frame_descriptor_source

  generic_frame_info.cc
     generic_frame_info.h

)

add_library(generic_frame_descriptor  STATIC ${generic_frame_descriptor_source})

set(AllFile 

          
		${generic_frame_descriptor_source}
      
		
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



#set_property(TARGET  ${PROJECT_NAME}   PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/common_video/${PROJECT_NAME})



