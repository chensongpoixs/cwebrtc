project(synchronization)
cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")


FILE(GLOB  yield_source

	yield.h
	yield.cc
	)
	
	
FILE(GLOB  mutex_source

	mutex.cc
    mutex.h
    mutex_critical_section.h
    mutex_pthread.h
	mutex_abseil.h
)

FILE(GLOB  sequence_checker_internal_source

	sequence_checker_internal.h
	sequence_checker_internal.cc
)

FILE(GLOB yield_policy_source

	yield_policy.h
	yield_policy.cc
)


add_library(yield                                  STATIC  ${yield_source}                          ) 
add_library(mutex               				   STATIC  ${mutex_source}                           ) 
add_library(sequence_checker_internal 				   STATIC  ${sequence_checker_internal_source}                  ) 
add_library(yield_policy      				   STATIC  ${yield_policy_source}                       )  


set_target_properties(yield                                                   PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(mutex               		            					PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(sequence_checker_internal 	      					PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(yield_policy      			      					PROPERTIES LINKER_LANGUAGE CXX) 

set(AllFile 

          
		${yield_source}                             
		${mutex_source}                    
		${sequence_checker_internal_source}
		${yield_policy_source}             
		
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


 
set_property(TARGET yield                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME})
set_property(TARGET mutex               		                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME})
set_property(TARGET sequence_checker_internal 	                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME})
set_property(TARGET yield_policy      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 


