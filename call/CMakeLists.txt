
project(call)
 
cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")


FILE(GLOB  version_source


	version.cc 
	version.h 
	)
FILE(GLOB  call_interfaces_source

    audio_receive_stream.cc
    audio_receive_stream.h
    audio_send_stream.h
    audio_state.cc
    audio_state.h
    call.h
    call_config.cc
    call_config.h
    flexfec_receive_stream.cc
    flexfec_receive_stream.h
    packet_receiver.h
    syncable.cc
    syncable.h
)
FILE(GLOB audio_sender_interface_source

		audio_sender.h
)

FILE(GLOB  rtp_interfaces_source

    rtp_config.cc
    rtp_config.h
    rtp_packet_sink_interface.h
    rtp_stream_receiver_controller_interface.h
    rtp_transport_config.h
    rtp_transport_controller_send_factory_interface.h
    rtp_transport_controller_send_interface.h
)

FILE(GLOB  rtp_receiver_source
    rtp_demuxer.cc
    rtp_demuxer.h
    rtp_stream_receiver_controller.cc
    rtp_stream_receiver_controller.h
    rtx_receive_stream.cc
    rtx_receive_stream.h

)
FILE(GLOB  rtp_sender_source
    rtp_payload_params.cc
    rtp_payload_params.h
    rtp_transport_controller_send.cc
    rtp_transport_controller_send.h
    rtp_transport_controller_send_factory.h
    rtp_video_sender.cc
    rtp_video_sender.h
    rtp_video_sender_interface.h

)
FILE(GLOB  bitrate_configurator_source

    rtp_bitrate_configurator.cc
    rtp_bitrate_configurator.h
)
FILE(GLOB  bitrate_allocator_source
	bitrate_allocator.h 
	bitrate_allocator.cc 
)

FILE(GLOB  call_source
    call.cc
    call_factory.cc
    call_factory.h
    degraded_call.cc
    degraded_call.h
    flexfec_receive_stream_impl.cc
    flexfec_receive_stream_impl.h
    receive_time_calculator.cc
    receive_time_calculator.h
)

FILE(GLOB  receive_stream_interface_source

	receive_stream.h
)

FILE(GLOB video_stream_api_source

    video_receive_stream.cc
    video_receive_stream.h
    video_send_stream.cc
    video_send_stream.h
)

FILE(GLOB  simulated_network_source
    simulated_network.cc
    simulated_network.h

)

FILE(GLOB fake_network_source


    fake_network_pipe.cc
    fake_network_pipe.h
)
	

add_library(${PROJECT_NAME}  		   					STATIC  ${version_source}                      
 				   ${call_interfaces_source}                 
 	   					   ${audio_sender_interface_source}  
 				   ${rtp_interfaces_source}                  
 				   ${rtp_receiver_source}                    
 				   ${rtp_sender_source}                      
    					   ${bitrate_configurator_source}    
 				   ${bitrate_allocator_source}               
 	   ${call_source}                          
 	   					   ${receive_stream_interface_source}
 				   ${video_stream_api_source}                
 				   ${simulated_network_source}               
 			   ${fake_network_source}                        
			   
			   ) 


#set_target_properties(audio_sender_interface      			      					PROPERTIES LINKER_LANGUAGE CXX)  
#set_target_properties(receive_stream_interface      			      					PROPERTIES LINKER_LANGUAGE CXX)  

set(AllFile 

          
		${version_source}
		${call_interfaces_source}
		${audio_sender_interface_source}
		${rtp_interfaces_source}
		${rtp_receiver_source}
		${rtp_sender_source}
		${bitrate_configurator_source}
		${bitrate_allocator_source}
		${call_source}
		${receive_stream_interface_source}
		${video_stream_api_source}
		${simulated_network_source}
		${fake_network_source}
		
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


 
set_property(TARGET ${PROJECT_NAME}                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}) 
#set_property(TARGET call_interfaces                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET audio_sender_interface                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET rtp_interfaces                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET call_rtp_receiver                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET call_rtp_sender                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET bitrate_configurator                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET bitrate_allocator                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET call                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET receive_stream_interface                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET video_stream_api                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET simulated_network                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET fake_network                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
