project(p2p)


cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")




FILE(GLOB  rtc_p2p_source


    base/async_stun_tcp_socket.cc
    base/async_stun_tcp_socket.h
    base/basic_async_resolver_factory.cc
    base/basic_async_resolver_factory.h
    base/basic_ice_controller.cc
    base/basic_ice_controller.h
    base/basic_packet_socket_factory.cc
    base/basic_packet_socket_factory.h
    base/candidate_pair_interface.h
    base/connection.cc
    base/connection.h
    base/connection_info.cc
    base/connection_info.h
    base/default_ice_transport_factory.cc
    base/default_ice_transport_factory.h
    base/dtls_transport.cc
    base/dtls_transport.h
    base/dtls_transport_factory.h
    base/dtls_transport_internal.cc
    base/dtls_transport_internal.h
    base/ice_controller_factory_interface.h
    base/ice_controller_interface.cc
    base/ice_controller_interface.h
    base/ice_credentials_iterator.cc
    base/ice_credentials_iterator.h
    base/ice_transport_internal.cc
    base/ice_transport_internal.h
    base/p2p_constants.cc
    base/p2p_constants.h
    base/p2p_transport_channel.cc
    base/p2p_transport_channel.h
    base/p2p_transport_channel_ice_field_trials.h
    base/packet_transport_internal.cc
    base/packet_transport_internal.h
    base/port.cc
    base/port.h
    base/port_allocator.cc
    base/port_allocator.h
    base/port_interface.cc
    base/port_interface.h
    base/pseudo_tcp.cc
    base/pseudo_tcp.h
    base/regathering_controller.cc
    base/regathering_controller.h
    base/stun_port.cc
    base/stun_port.h
    base/stun_request.cc
    base/stun_request.h
    base/tcp_port.cc
    base/tcp_port.h
    base/transport_description.cc
    base/transport_description.h
    base/transport_description_factory.cc
    base/transport_description_factory.h
    base/transport_info.h
    base/turn_port.cc
    base/turn_port.h
    base/udp_port.h
    client/basic_port_allocator.cc
    client/basic_port_allocator.h
    client/relay_port_factory_interface.h
    client/turn_port_factory.cc
    client/turn_port_factory.h
)

FILE(GLOB  p2p_server_utils_source

    base/stun_server.cc
    base/stun_server.h
    base/turn_server.cc
    base/turn_server.h
)


FILE(GLOB   libstunprober_source
    stunprober/stun_prober.cc
    stunprober/stun_prober.h

)

add_library(${PROJECT_NAME} 			STATIC  ${rtc_p2p_source} 
  ${p2p_server_utils_source} 
  ${libstunprober_source})


set(AllFile  

    ${rtc_p2p_source}
    ${p2p_server_utils_source}
	${libstunprober_source} 
)
# source_group("include" FILES ${AllFile})
foreach(fileItem ${AllFile})       
    # Get the directory of the source file
    get_filename_component(PARENT_DIR "${fileItem}" DIRECTORY)
	
    # Remove common directory prefix to make the group
    string(REGEX  REPLACE "${CMAKE_CURRENT_SOURCE_DIR}" "" GROUP "${PARENT_DIR}")
    # Make sure we are using windows slashes
    string(REPLACE "/" "\\" GROUP "${GROUP}")
	#message(status   "---> fileItem = ${fileItem}     GROUP ---->  ${GROUP}")
    # Group into "Source Files" and "Header Files"
    set(GROUP "${GROUP}")
    source_group("${GROUP}" FILES "${fileItem}")
endforeach()



set_property(TARGET ${PROJECT_NAME}  				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER})

#set_property(TARGET p2p_server_utils  			PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET libstunprober  		PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
