project(common_video)


FILE(GLOB  common_video_source

	bitrate_adjuster.cc
    frame_rate_estimator.cc
    frame_rate_estimator.h
    framerate_controller.cc
    framerate_controller.h
    h264/h264_bitstream_parser.cc
    h264/h264_bitstream_parser.h
    h264/h264_common.cc
    h264/h264_common.h
    h264/pps_parser.cc
    h264/pps_parser.h
    h264/sps_parser.cc
    h264/sps_parser.h
    h264/sps_vui_rewriter.cc
    h264/sps_vui_rewriter.h
    include/bitrate_adjuster.h
    include/incoming_video_stream.h
    include/quality_limitation_reason.h
    include/video_frame_buffer.h
    include/video_frame_buffer_pool.h
    incoming_video_stream.cc
    libyuv/include/webrtc_libyuv.h
    libyuv/webrtc_libyuv.cc
    video_frame_buffer.cc
    video_frame_buffer_pool.cc
    video_render_frames.cc
    video_render_frames.h

)


FILE(GLOB  frame_counts_source


	frame_counts.h 
	
)



add_library(common_video                          STATIC   ${common_video_source})
add_library(frame_counts                          STATIC   ${frame_counts_source})

set_target_properties(frame_counts                               PROPERTIES LINKER_LANGUAGE CXX)


add_subdirectory(generic_frame_descriptor)


set(AllFile 

          
		${common_video_source}
        ${frame_counts_source}
		
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



set_property(TARGET  common_video   PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
set_property(TARGET  frame_counts   PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
