project(system)





FILE(GLOB   warn_current_thread_is_deadlocked_source

	warn_current_thread_is_deadlocked.h 
	
	
	# linux  
	#warn_current_thread_is_deadlocked.cc


)

FILE(GLOB  no_unique_address_source

	no_unique_address.h

)


FILE(GLOB  arch_source


			arch.h
)


FILE(GLOB  asm_defines_source


		asm_defines.h
)

FILE(GLOB  file_wrapper_source

	file_wrapper.h
	file_wrapper.cc 
	
)

FILE(GLOB ignore_warnings_source


	ignore_warnings.h
)

FILE(GLOB  inline_source

	inline.h
	
	)
	
	
FILE(GLOB  unused_source
	unused.h
	)
	
FILE(GLOB  assume_source

	assume.h
	
)
FILE(GLOB  rtc_export_source

    rtc_export.h
    rtc_export_template.h
	)


FILE(GLOB  thread_registry_source

	#thread_registry.cc 
	thread_registry.h
)

add_library(warn_current_thread_is_deadlocked  STATIC  ${warn_current_thread_is_deadlocked_source})
add_library(no_unique_address 				   STATIC  ${no_unique_address_source}                ) 
add_library(thread_registry 				   STATIC  ${thread_registry_source}                  ) 
add_library(rtc_export      				   STATIC  ${rtc_export_source}                       ) 
add_library(assume          				   STATIC  ${assume_source}                           ) 
add_library(unused          				   STATIC  ${unused_source}                           ) 
add_library(inline           				   STATIC  ${inline_source}                           ) 
add_library(ignore_warnings 				   STATIC  ${ignore_warnings_source}                  ) 
add_library(file_wrapper    				   STATIC  ${file_wrapper_source}                     ) 
add_library(asm_defines      				   STATIC  ${asm_defines_source}                      ) 
add_library(arch              				   STATIC  ${arch_source}                             ) 


set_target_properties(warn_current_thread_is_deadlocked                               PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(no_unique_address                               					PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(thread_registry 	                        					PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(rtc_export      	                        					PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(assume          	                        					PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(unused          	                        					PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(inline                                   					PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(ignore_warnings 	                        					PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(file_wrapper    	                        					PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(asm_defines                              					PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(arch                                      					PROPERTIES LINKER_LANGUAGE CXX) 

set(AllFile 

          
		${warn_current_thread_is_deadlocked_source}
		${no_unique_address_source}
		
		${thread_registry_source}   
		${rtc_export_source}        
		${assume_source}            
		${unused_source}            
		${inline_source}            
		${ignore_warnings_source}   
		${file_wrapper_source}      
		${asm_defines_source}       
		${arch_source}              
		
		
		
		
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



set_property(TARGET warn_current_thread_is_deadlocked  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME})

set_property(TARGET no_unique_address                  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME})
set_property(TARGET thread_registry 	                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME})
set_property(TARGET rtc_export      	                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME})
set_property(TARGET assume          	                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME})
set_property(TARGET unused          	                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME})
set_property(TARGET inline                                 PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME})
set_property(TARGET ignore_warnings 	                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME})
set_property(TARGET file_wrapper    	                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME})
set_property(TARGET asm_defines                            PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME})
set_property(TARGET arch                                   PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 