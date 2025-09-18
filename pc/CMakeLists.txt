project(pc)

include_directories(
    .
)






FILE(GLOB  proxy_source

    proxy.cc
    proxy.h
)



FILE(GLOB  peerconnection_source




	
	audio_rtp_receiver.cc
    audio_rtp_receiver.h
    audio_track.cc
    audio_track.h
    data_channel.cc
    data_channel.h
    dtmf_sender.cc
    dtmf_sender.h
    ice_server_parsing.cc
    ice_server_parsing.h
    jsep_ice_candidate.cc
    jsep_session_description.cc
    local_audio_source.cc
    local_audio_source.h
    media_stream.cc
    media_stream.h
    media_stream_observer.cc
    media_stream_observer.h
    media_stream_track.h
    peer_connection.cc
    peer_connection.h
    peer_connection_factory.cc
    peer_connection_factory.h
    peer_connection_internal.h
    playout_latency.cc
    playout_latency.h
    playout_latency_interface.h
    playout_latency_proxy.h
    remote_audio_source.cc
    remote_audio_source.h
    rtc_stats_collector.cc
    rtc_stats_collector.h
    rtc_stats_traversal.cc
    rtc_stats_traversal.h
    rtp_parameters_conversion.cc
    rtp_parameters_conversion.h
    rtp_receiver.cc
    rtp_receiver.h
    rtp_sender.cc
    rtp_sender.h
    rtp_transceiver.cc
    rtp_transceiver.h
    sctp_utils.cc
    sctp_utils.h
    sdp_serializer.cc
    sdp_serializer.h
    sdp_utils.cc
    sdp_utils.h
    stats_collector.cc
    stats_collector.h
    stream_collection.h
    track_media_info_map.cc
    track_media_info_map.h
    video_rtp_receiver.cc
    video_rtp_receiver.h
    video_track.cc
    video_track.h
    video_track_source.cc
    video_track_source.h
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
    jsep_transport_controller.cc
    jsep_transport_controller.h
    media_session.cc
    media_session.h
    rtcp_mux_filter.cc
    rtcp_mux_filter.h
    rtp_media_utils.cc
    rtp_media_utils.h
    rtp_transport.cc
    rtp_transport.h
    rtp_transport_internal.h
    sctp_transport.cc
    sctp_transport.h
    session_description.cc
    session_description.h
    simulcast_description.cc
    simulcast_description.h
    srtp_filter.cc
    srtp_filter.h
    srtp_session.cc
    srtp_session.h
    srtp_transport.cc
    srtp_transport.h
    transport_stats.cc
    transport_stats.h
)



add_library(proxy STATIC ${proxy_source})

add_library(peerconnection STATIC  ${peerconnection_source})


add_library(rtc_pc_base STATIC  ${rtc_pc_base_source})

set(AllFile 

        ${proxy_source}
		

        ${peerconnection_source}
        ${rtc_pc_base_source}
		
)

foreach(fileItem ${AllFile})       
    # Get the directory of the source file
    get_filename_component(PARENT_DIR "${fileItem}" DIRECTORY)
	
    # Remove common directory prefix to make the group
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}" "" GROUP "${PARENT_DIR}")
	message(status    "==================>>>>${CMAKE_CURRENT_SOURCE_DIR} = ${GROUP} ====== ${PARENT_DIR}")
	#message(status   "---> fileItem = ${fileItem}     GROUP ---->  ${GROUP}")
    # Make sure we are using windows slashes
    string(REPLACE / \\ GROUP "${GROUP}")

	#string(REPLACE "/.." "\\" GROUP "${GROUP}")
	#string(REPLACE \. \\   GROUP ${GROUP})
	
    # Group into "Source Files" and "Header Files"
    set(GROUP "${GROUP}")
    source_group("${GROUP}" FILES "${fileItem}")
endforeach()


set_property(TARGET proxy  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
set_property(TARGET peerconnection  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
set_property(TARGET rtc_pc_base  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})


