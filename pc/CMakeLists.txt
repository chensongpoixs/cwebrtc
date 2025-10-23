project(pc)
 
cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")
#include_directories(
 #   .
#)






FILE(GLOB  proxy_source

    proxy.cc
    proxy.h
)



FILE(GLOB  peerconnection_source




	
    data_channel_controller.cc
    data_channel_controller.h
    data_channel_utils.cc
    data_channel_utils.h
    ice_server_parsing.cc
    ice_server_parsing.h
    jsep_ice_candidate.cc
    jsep_session_description.cc
    local_audio_source.cc
    local_audio_source.h
    media_stream_observer.cc
    media_stream_observer.h
    peer_connection.cc
    peer_connection.h
    peer_connection_factory.cc
    peer_connection_factory.h
    peer_connection_internal.h
    rtc_stats_collector.cc
    rtc_stats_collector.h
    rtc_stats_traversal.cc
    rtc_stats_traversal.h
    sctp_data_channel.cc
    sctp_data_channel.h
    sdp_offer_answer.cc  # TODO: Make separate target when not circular
    sdp_offer_answer.h  # dependent on peerconnection.h
    sdp_serializer.cc
    sdp_serializer.h
    sdp_utils.cc
    sdp_utils.h
    stats_collector.cc
    stats_collector.h
    stream_collection.h
    track_media_info_map.cc
    track_media_info_map.h
    webrtc_sdp.cc
    webrtc_sdp.h
    webrtc_session_description_factory.cc
    webrtc_session_description_factory.h


	

)


  


FILE(GLOB   rtc_pc_base_source


	channel.cc
    channel.h
    channel_interface.h
    channel_manager.cc
    channel_manager.h
    dtls_srtp_transport.cc
    dtls_srtp_transport.h
    dtls_transport.cc
    dtls_transport.h
    external_hmac.cc
    external_hmac.h
    ice_transport.cc
    ice_transport.h
    jsep_transport.cc
    jsep_transport.h
    jsep_transport_collection.cc
    jsep_transport_collection.h
    jsep_transport_controller.cc
    jsep_transport_controller.h
    media_session.cc
    media_session.h
    media_stream_proxy.h
    media_stream_track_proxy.h
    peer_connection_factory_proxy.h
    peer_connection_proxy.h
    rtcp_mux_filter.cc
    rtcp_mux_filter.h
    rtp_media_utils.cc
    rtp_media_utils.h
    rtp_receiver_proxy.h
    rtp_sender_proxy.h
    rtp_transport.cc
    rtp_transport.h
    rtp_transport_internal.h
    sctp_data_channel_transport.cc
    sctp_data_channel_transport.h
    sctp_transport.cc
    sctp_transport.h
    sctp_utils.cc
    sctp_utils.h
    srtp_filter.cc
    srtp_filter.h
    srtp_session.cc
    srtp_session.h
    srtp_transport.cc
    srtp_transport.h
    transport_stats.cc
    transport_stats.h
    used_ids.h
    video_track_source_proxy.cc
    video_track_source_proxy.h
)

FILE(GLOB  session_description_source

	session_description.h 
	session_description.cc 
)

FILE(GLOB simulcast_description_source

	simulcast_description.h 
	simulcast_description.cc 
)

FILE(GLOB  media_protocol_names_source

	media_protocol_names.h 
	media_protocol_names.cc 
)

FILE(GLOB connection_context_source

	connection_context.h 
	connection_context.cc 
)

FILE(GLOB peer_connection_message_handler_source

	peer_connection_message_handler.h 
	peer_connection_message_handler.cc 
)

FILE(GLOB  usage_pattern_source

	usage_pattern.h 
	usage_pattern.cc 
)
FILE(GLOB rtp_transceiver_source
    rtp_transceiver.cc
    rtp_transceiver.h
)
FILE(GLOB rtp_transmission_manager_source

	rtp_transmission_manager.h
	rtp_transmission_manager.cc 
)
FILE(GLOB transceiver_list_source

	transceiver_list.h 
	transceiver_list.cc 
)

FILE(GLOB  audio_rtp_receiver_source

	audio_rtp_receiver.h 
	audio_rtp_receiver.cc 
)

FILE(GLOB video_rtp_receiver_source

	video_rtp_receiver.h 
	video_rtp_receiver.cc 
)
FILE(GLOB video_rtp_track_source_source

	video_rtp_track_source.h 
	video_rtp_track_source.cc 
)
FILE(GLOB  audio_track_source

	audio_track.h
	audio_track.cc 
)

FILE(GLOB  video_track__source
	video_track.h 
	video_track.cc 
)
FILE(GLOB sdp_state_provider_source

	sdp_state_provider.h 
)

FILE(GLOB jitter_buffer_delay_source

	jitter_buffer_delay.h 
	jitter_buffer_delay.cc 
)
FILE(GLOB remote_audio_source_source

	remote_audio_source.h 
	remote_audio_source.cc 
)

FILE(GLOB rtp_sender_source

	rtp_sender.h 
	rtp_sender.cc 
)

FILE(GLOB  rtp_parameters_conversion_source

	rtp_parameters_conversion.h 
	rtp_parameters_conversion.cc 
)
FILE(GLOB dtmf_sender_source

	dtmf_sender.h 
	dtmf_sender.cc 
	)
	
	FILE(GLOB  media_stream_source
	
	media_stream.h 
	media_stream.cc 
	)
	
FILE(GLOB  video_track_source_source

		video_track_source.h 
		video_track_source.cc 
		)
FILE(GLOB stats_collector_interface_source

	stats_collector_interface.h
	
	)
FILE(GLOB pc_rtp_receiver_source 
	rtp_receiver.h 
	rtp_receiver.cc 
)
add_library(${PROJECT_NAME} STATIC ${proxy_source} 
 						 ${peerconnection_source} 
 						 ${rtc_pc_base_source} 
 						 ${session_description_source} 
 						 ${simulcast_description_source} 
 						 ${media_protocol_names_source} 
 						 ${connection_context_source} 
 						 ${peer_connection_message_handler_source} 
 						 ${usage_pattern_source} 
 						 ${rtp_transceiver_source} 
 						    ${rtp_transmission_manager_source} 
 					   ${transceiver_list_source} 
 					   ${pc_rtp_receiver_source} 
 						   ${audio_rtp_receiver_source} 
 						   ${video_rtp_receiver_source} 
 							   ${video_rtp_track_source_source} 
 				   ${audio_track_source} 
 				   ${video_track__source} 
 						  ${sdp_state_provider_source} 
 						  ${jitter_buffer_delay_source} 
 						  ${remote_audio_source_source} 
 				   ${rtp_sender_source} 
 							   ${rtp_parameters_conversion_source} 
 				   ${dtmf_sender_source} 
 				   ${media_stream_source} 
 						   ${video_track_source_source} 
                           ${stats_collector_interface_source}
						   
						   
						   )



#set_target_properties(sdp_state_provider      			      					PROPERTIES LINKER_LANGUAGE CXX)  
#set_target_properties(stats_collector_interface      			      					PROPERTIES LINKER_LANGUAGE CXX)  

set(AllFile 

        ${proxy_source}
		

        ${peerconnection_source}
        ${rtc_pc_base_source}
		${session_description_source}
		${simulcast_description_source}
		${media_protocol_names_source}
		${connection_context_source}
		${peer_connection_message_handler_source}
		${usage_pattern_source}
		${rtp_transceiver_source}
		${rtp_transmission_manager_source}
		${transceiver_list_source}
		${pc_rtp_receiver_source}
		${audio_rtp_receiver_source}
		${video_rtp_receiver_source}
		${video_rtp_track_source_source}
		${audio_track_source}
		${video_track__source}
		${sdp_state_provider_source}
		${jitter_buffer_delay_source}
		${remote_audio_source_source}
		${rtp_sender_source}
		${rtp_parameters_conversion_source}
		${dtmf_sender_source}
		${media_stream_source}
		${video_track_source_source}
		${stats_collector_interface_source}
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



#set_property(TARGET proxy  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
set_property(TARGET ${PROJECT_NAME}  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER})
#set_property(TARGET rtc_pc_base  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET session_description  						PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET simulcast_description  						PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET media_protocol_names  						PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET connection_context  						PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET peer_connection_message_handler  				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET usage_pattern  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET rtp_transceiver  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET rtp_transmission_manager  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET transceiver_list  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET pc_rtp_receiver  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET audio_rtp_receiver  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET video_rtp_receiver  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET video_rtp_track_source  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET audio_track  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET video_track  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET sdp_state_provider  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET jitter_buffer_delay  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET remote_audio_source  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET pc_rtp_sender  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET rtp_parameters_conversion  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET dtmf_sender  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET media_stream  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET video_track_source  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET stats_collector_interface  								PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
 

