project(logging)
 
cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")

FILE(GLOB  rtc_event_log_api_source

		rtc_event_log/encoder/rtc_event_log_encoder.h
)

FILE(GLOB rtc_event_field_source

    rtc_event_log/events/fixed_length_encoding_parameters_v3.cc
    rtc_event_log/events/fixed_length_encoding_parameters_v3.h
    rtc_event_log/events/rtc_event_field_encoding.cc
    rtc_event_log/events/rtc_event_field_encoding.h
    rtc_event_log/events/rtc_event_field_encoding_parser.cc
    rtc_event_log/events/rtc_event_field_encoding_parser.h
    rtc_event_log/events/rtc_event_field_extraction.cc
    rtc_event_log/events/rtc_event_field_extraction.h
)

FILE(GLOB  rtc_stream_config_source

    rtc_event_log/rtc_stream_config.cc
    rtc_event_log/rtc_stream_config.h

)

FILE(GLOB  rtc_event_pacing_source

    rtc_event_log/events/rtc_event_alr_state.cc
    rtc_event_log/events/rtc_event_alr_state.h
)

FILE(GLOB  rtc_event_audio_source

    rtc_event_log/events/rtc_event_audio_network_adaptation.cc
    rtc_event_log/events/rtc_event_audio_network_adaptation.h
    rtc_event_log/events/rtc_event_audio_playout.cc
    rtc_event_log/events/rtc_event_audio_playout.h
    rtc_event_log/events/rtc_event_audio_receive_stream_config.cc
    rtc_event_log/events/rtc_event_audio_receive_stream_config.h
    rtc_event_log/events/rtc_event_audio_send_stream_config.cc
    rtc_event_log/events/rtc_event_audio_send_stream_config.h

)

FILE(GLOB rtc_event_bwe_source

    rtc_event_log/events/rtc_event_bwe_update_delay_based.cc
    rtc_event_log/events/rtc_event_bwe_update_delay_based.h
    rtc_event_log/events/rtc_event_bwe_update_loss_based.cc
    rtc_event_log/events/rtc_event_bwe_update_loss_based.h
    rtc_event_log/events/rtc_event_probe_cluster_created.cc
    rtc_event_log/events/rtc_event_probe_cluster_created.h
    rtc_event_log/events/rtc_event_probe_result_failure.cc
    rtc_event_log/events/rtc_event_probe_result_failure.h
    rtc_event_log/events/rtc_event_probe_result_success.cc
    rtc_event_log/events/rtc_event_probe_result_success.h
    rtc_event_log/events/rtc_event_remote_estimate.h
    rtc_event_log/events/rtc_event_route_change.cc
    rtc_event_log/events/rtc_event_route_change.h

)

FILE(GLOB rtc_event_frame_events_source

    rtc_event_log/events/rtc_event_frame_decoded.cc
    rtc_event_log/events/rtc_event_frame_decoded.h
)



FILE(GLOB  rtc_event_generic_packet_events_source
    rtc_event_log/events/rtc_event_generic_ack_received.cc
    rtc_event_log/events/rtc_event_generic_ack_received.h
    rtc_event_log/events/rtc_event_generic_packet_received.cc
    rtc_event_log/events/rtc_event_generic_packet_received.h
    rtc_event_log/events/rtc_event_generic_packet_sent.cc
    rtc_event_log/events/rtc_event_generic_packet_sent.h

)

FILE(GLOB  rtc_event_rtp_rtcp_source 
    rtc_event_log/events/rtc_event_rtcp_packet_incoming.cc
    rtc_event_log/events/rtc_event_rtcp_packet_incoming.h
    rtc_event_log/events/rtc_event_rtcp_packet_outgoing.cc
    rtc_event_log/events/rtc_event_rtcp_packet_outgoing.h
    rtc_event_log/events/rtc_event_rtp_packet_incoming.cc
    rtc_event_log/events/rtc_event_rtp_packet_incoming.h
    rtc_event_log/events/rtc_event_rtp_packet_outgoing.cc
    rtc_event_log/events/rtc_event_rtp_packet_outgoing.h

)

FILE(GLOB rtc_event_video_source

    rtc_event_log/events/rtc_event_video_receive_stream_config.cc
    rtc_event_log/events/rtc_event_video_receive_stream_config.h
    rtc_event_log/events/rtc_event_video_send_stream_config.cc
    rtc_event_log/events/rtc_event_video_send_stream_config.h
)


FILE(GLOB rtc_event_number_encodings_source

    rtc_event_log/encoder/bit_writer.cc
    rtc_event_log/encoder/bit_writer.h
    rtc_event_log/encoder/rtc_event_log_encoder_common.cc
    rtc_event_log/encoder/rtc_event_log_encoder_common.h
    rtc_event_log/encoder/var_int.cc
    rtc_event_log/encoder/var_int.h
)

FILE(GLOB rtc_event_log_impl_encoder_source

    rtc_event_log/encoder/blob_encoding.cc
    rtc_event_log/encoder/blob_encoding.h
    rtc_event_log/encoder/delta_encoding.cc
    rtc_event_log/encoder/delta_encoding.h
)

FILE(GLOB  rtc_event_log_impl_output_source

	rtc_event_log/output/rtc_event_log_output_file.h
)

FILE(GLOB  fake_rtc_event_log_source
    rtc_event_log/fake_rtc_event_log.cc
    rtc_event_log/fake_rtc_event_log.h
    rtc_event_log/fake_rtc_event_log_factory.cc
    rtc_event_log/fake_rtc_event_log_factory.h
)

FILE(GLOB  ice_log_source
    rtc_event_log/events/rtc_event_dtls_transport_state.cc
    rtc_event_log/events/rtc_event_dtls_transport_state.h
    rtc_event_log/events/rtc_event_dtls_writable_state.cc
    rtc_event_log/events/rtc_event_dtls_writable_state.h
    rtc_event_log/events/rtc_event_ice_candidate_pair.cc
    rtc_event_log/events/rtc_event_ice_candidate_pair.h
    rtc_event_log/events/rtc_event_ice_candidate_pair_config.cc
    rtc_event_log/events/rtc_event_ice_candidate_pair_config.h
    rtc_event_log/ice_logger.cc
    rtc_event_log/ice_logger.h
)

add_library(${PROJECT_NAME}  		   					STATIC  ${rtc_event_log_api_source}                       
 			   ${rtc_event_field_source}   					 
 			   ${rtc_stream_config_source}   					 
 			   ${rtc_event_pacing_source}   					 
 			   ${rtc_event_audio_source}   					 
 		   ${rtc_event_bwe_source}   					 	 
    					   ${rtc_event_frame_events_source}   				 
  		   					   ${rtc_event_generic_packet_events_source}    
 				   ${rtc_event_rtp_rtcp_source}   	 
 				   ${rtc_event_video_source}   	 
 	   					   ${rtc_event_number_encodings_source}    
 	   					   ${rtc_event_log_impl_encoder_source}    
    					   ${rtc_event_log_impl_output_source}   	 
 				   ${fake_rtc_event_log_source}    
 			   ${ice_log_source}   	
			
			)

#set_target_properties(rtc_event_log_api      			      					PROPERTIES LINKER_LANGUAGE CXX) 


#set_target_properties(rtc_event_log_impl_output      			      					PROPERTIES LINKER_LANGUAGE CXX) 

set(AllFile 

          
		${rtc_event_log_api_source}      
		${rtc_event_field_source}
		${rtc_stream_config_source}
		${rtc_event_pacing_source}
		${rtc_event_audio_source}
		${rtc_event_bwe_source}
		${rtc_event_frame_events_source}
		${rtc_event_generic_packet_events_source}
		${rtc_event_rtp_rtcp_source}
		${rtc_event_video_source}
		${rtc_event_number_encodings_source}
		${rtc_event_log_impl_encoder_source}
		${rtc_event_log_impl_output_source}
		${fake_rtc_event_log_source}
		${ice_log_source}
		
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
#set_property(TARGET rtc_event_field               		                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET rtc_stream_config     	                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET rtc_event_pacing      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET rtc_event_audio      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#
#
#set_property(TARGET rtc_event_bwe      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET rtc_event_frame_events      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET rtc_event_generic_packet_events      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET rtc_event_rtp_rtcp      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET rtc_event_video      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET rtc_event_number_encodings      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET rtc_event_log_impl_encoder      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET rtc_event_log_impl_output      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET fake_rtc_event_log      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET ice_log      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET rtc_event_number_encodings      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET rtc_event_number_encodings      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 
#set_property(TARGET rtc_event_number_encodings      			                     PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME}) 