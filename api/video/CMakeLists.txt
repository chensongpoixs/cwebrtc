project(video)



FILE(GLOB   video_rtp_headers_source 

		color_space.cc
		color_space.h
		hdr_metadata.cc
		hdr_metadata.h
		video_content_type.cc
		video_content_type.h
		video_rotation.h
		video_timing.cc
		video_timing.h


)


FILE(GLOB  video_frame_source 


		i420_buffer.cc
		i420_buffer.h
		nv12_buffer.cc
		nv12_buffer.h
		video_codec_type.h
		video_frame.cc
		video_frame.h
		video_frame_buffer.cc
		video_frame_buffer.h
		video_sink_interface.h
		video_source_interface.cc
		video_source_interface.h
)


FILE(GLOB  video_frame_i010_source


	i010_buffer.cc
    i010_buffer.h
)




FILE(GLOB  recordable_encoded_frame_source


		recordable_encoded_frame.h
		
		
)

FILE(GLOB video_frame_type_source


	video_frame_type.h 
	
	)
	
	
FILE(GLOB  render_resolution_source 

	render_resolution.h 
	
	)
	
FILE(GLOB encoded_image_source 

	encoded_image.h 
	encoded_image.cc 

)

FILE(GLOB encoded_frame_source

	encoded_frame.h 
	encoded_frame.cc
)

FILE(GLOB  rtp_video_frame_assembler_source 


	rtp_video_frame_assembler.h 
	rtp_video_frame_assembler.cc 
	
	
	
	)
	
	
	
FILE(GLOB video_codec_constants_source

	video_codec_constants.h 
)

FILE(GLOB  video_bitrate_allocation_source

	video_bitrate_allocation.h 
	video_bitrate_allocation.cc 
)


FILE(GLOB  video_layers_allocation_source 


video_layers_allocation.h 
)


FILE(GLOB  video_bitrate_allocator_source

	video_bitrate_allocator.h 
	video_bitrate_allocator.cc 

)

FILE(GLOB video_bitrate_allocator_factory_source

	video_bitrate_allocator_factory.h 
)

FILE(GLOB video_stream_decoder_source 


	video_stream_decoder.h

)


FILE(GLOB  video_stream_decoder_create_source


	video_stream_decoder_create.h 
	video_stream_decoder_create.cc 
	)
	
FILE(GLOB  video_adaptation_source 

	video_adaptation_counters.cc
    video_adaptation_counters.h
    video_adaptation_reason.h


)

FILE(GLOB video_stream_encoder_source


    video_stream_encoder_interface.h
    video_stream_encoder_observer.h
    video_stream_encoder_settings.h
)

FILE(GLOB video_frame_metadata_source

	video_frame_metadata.h 
	video_frame_metadata.cc 
)


FILE(GLOB builtin_video_bitrate_allocator_factory_source


	builtin_video_bitrate_allocator_factory.h 
	builtin_video_bitrate_allocator_factory.cc 
)



add_library(video_rtp_headers 								STATIC  						${video_rtp_headers_source})
add_library(video_frame 									STATIC 							${video_frame_source})
add_library(video_frame_i010    							STATIC 						${video_frame_i010_source})
add_library(recordable_encoded_frame 						STATIC 				${recordable_encoded_frame_source})
add_library(video_frame_type  								STATIC  						${video_frame_type_source})
add_library(render_resolution 								STATIC  						${render_resolution_source})
add_library(encoded_image 									STATIC  							${encoded_image_source})
add_library(encoded_frame 									STATIC 							${encoded_frame_source})
add_library(rtp_video_frame_assembler 						STATIC 				${rtp_video_frame_assembler_source})
add_library(video_codec_constants  						    STATIC 					${video_codec_constants_source})
add_library(video_bitrate_allocation 						STATIC 				${video_bitrate_allocation_source})
add_library(video_layers_allocation 						STATIC 					${video_layers_allocation_source})
add_library(video_bitrate_allocator 						STATIC 					${video_bitrate_allocator_source})
add_library(video_bitrate_allocator_factory 				STATIC 			${video_bitrate_allocator_factory_source})
add_library(video_stream_decoder 							STATIC 					${video_stream_decoder_source})
add_library(video_stream_decoder_create 					STATIC 				${video_stream_decoder_create_source})
add_library(video_adaptation 								STATIC 						${video_adaptation_source})
add_library(video_stream_encoder 							STATIC 					${video_stream_encoder_source})
add_library(video_frame_metadata 							STATIC 					${video_frame_metadata_source})
add_library(builtin_video_bitrate_allocator_factory 		STATIC 	${builtin_video_bitrate_allocator_factory_source})




# CMake Error: CMake can not determine linker language for target: render_resolution
# CMake Error: CMake can not determine linker language for target: video_codec_constants
# CMake Error: CMake can not determine linker language for target: recordable_encoded_frame
# CMake Error: CMake can not determine linker language for target: video_frame_type
# CMake Error: CMake can not determine linker language for target: video_stream_decoder
# CMake Error: CMake can not determine linker language for target: video_stream_encoder
# CMake Error: CMake can not determine linker language for target: video_layers_allocation
#CMake Error: CMake can not determine linker language for target:  video_bitrate_allocator_factory
# 指定编译 CXX语言
set_target_properties(render_resolution                               PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(video_codec_constants                               PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(recordable_encoded_frame                               PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(video_frame_type                               PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(video_stream_decoder                               PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(video_stream_encoder                               PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(video_layers_allocation                               PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(video_bitrate_allocator_factory                               PROPERTIES LINKER_LANGUAGE CXX)
 




set(AllFile
${video_rtp_headers_source}
${video_frame_source}
${video_frame_i010_source}
${recordable_encoded_frame_source}
${video_frame_type_source}
${render_resolution_source}
${encoded_image_source}
${encoded_frame_source}
${rtp_video_frame_assembler_source}
${video_codec_constants_source}
${video_bitrate_allocation_source}
${video_layers_allocation_source}
${video_bitrate_allocator_source}
${video_bitrate_allocator_factory_source}
${video_stream_decoder_source}
${video_stream_decoder_create_source}
${video_adaptation_source}
${video_stream_encoder_source}
${video_frame_metadata_source}
${builtin_video_bitrate_allocator_factory}


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
set_property(TARGET  video_rtp_headers 								      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  video_frame 									      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  video_frame_i010    							      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  recordable_encoded_frame 						      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  video_frame_type  								      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  render_resolution 								      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  encoded_image 									      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  encoded_frame 									      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  rtp_video_frame_assembler 						      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  video_codec_constants  						      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  video_bitrate_allocation 						      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  video_layers_allocation 						      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  video_bitrate_allocator 						      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  video_bitrate_allocator_factory 				      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  video_stream_decoder 							      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  video_stream_decoder_create 					      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  video_adaptation 								      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  video_stream_encoder 							      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  video_frame_metadata 							      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET  builtin_video_bitrate_allocator_factory 		      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})