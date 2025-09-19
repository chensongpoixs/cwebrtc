PROJECT(rtc_base)

cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")


FILE(GLOB  checks_source

    checks.h
    checks.cc

)





FILE(GLOB  rtc_base_source

    async_invoker.cc
    async_invoker.h
    async_invoker_inl.h
    async_packet_socket.cc
    async_packet_socket.h
    async_tcp_socket.cc
    async_tcp_socket.h
    async_udp_socket.cc
    async_udp_socket.h
    crc32.cc
    crc32.h
    crypt_string.cc
    crypt_string.h
    data_rate_limiter.cc
    data_rate_limiter.h
    dscp.h
    file_rotating_stream.cc
    file_rotating_stream.h
    helpers.cc
    helpers.h
    http_common.cc
    http_common.h
    mdns_responder_interface.h
    message_digest.cc
    message_digest.h
    net_helper.cc
    net_helper.h
    network.cc
    network.h
    network_route.cc
    network_route.h
    openssl.h
    openssl_adapter.cc
    openssl_adapter.h
    openssl_digest.cc
    openssl_digest.h
    openssl_key_pair.cc
    openssl_key_pair.h
    openssl_session_cache.cc
    openssl_session_cache.h
    openssl_stream_adapter.cc
    openssl_stream_adapter.h
    openssl_utility.cc
    openssl_utility.h
    proxy_info.cc
    proxy_info.h
    rtc_certificate.cc
    rtc_certificate.h
    rtc_certificate_generator.cc
    rtc_certificate_generator.h
    sigslot_repeater.h
    socket_adapters.cc
    socket_adapters.h
    socket_address_pair.cc
    socket_address_pair.h
    ssl_adapter.cc
    ssl_adapter.h
    ssl_certificate.cc
    ssl_certificate.h
    ssl_fingerprint.cc
    ssl_fingerprint.h
    ssl_identity.cc
    ssl_identity.h
    ssl_stream_adapter.cc
    ssl_stream_adapter.h
    stream.cc
    stream.h
    unique_id_generator.cc
    unique_id_generator.h
    async_invoker.cc
    async_invoker.h
    async_invoker_inl.h
    async_packet_socket.cc
    async_packet_socket.h
    async_tcp_socket.cc
    async_tcp_socket.h
    async_udp_socket.cc
    async_udp_socket.h
    crc32.cc
    crc32.h
    crypt_string.cc
    crypt_string.h
    data_rate_limiter.cc
    data_rate_limiter.h
    dscp.h
    file_rotating_stream.cc
    file_rotating_stream.h
    helpers.cc
    helpers.h
    http_common.cc
    http_common.h
    mdns_responder_interface.h
    message_digest.cc
    message_digest.h
    net_helper.cc
    net_helper.h
    network.cc
    network.h
    network_route.cc
    network_route.h
    openssl.h
    openssl_adapter.cc
    openssl_adapter.h
    openssl_digest.cc
    openssl_digest.h
    openssl_key_pair.cc
    openssl_key_pair.h
    openssl_session_cache.cc
    openssl_session_cache.h
    openssl_stream_adapter.cc
    openssl_stream_adapter.h
    openssl_utility.cc
    openssl_utility.h
    proxy_info.cc
    proxy_info.h
    rtc_certificate.cc
    rtc_certificate.h
    rtc_certificate_generator.cc
    rtc_certificate_generator.h
    sigslot_repeater.h
    socket_adapters.cc
    socket_adapters.h
    socket_address_pair.cc
    socket_address_pair.h
    ssl_adapter.cc
    ssl_adapter.h
    ssl_certificate.cc
    ssl_certificate.h
    ssl_fingerprint.cc
    ssl_fingerprint.h
    ssl_identity.cc
    ssl_identity.h
    ssl_stream_adapter.cc
    ssl_stream_adapter.h
    stream.cc
    stream.h
    unique_id_generator.cc
    unique_id_generator.h
    async_invoker.cc
    async_invoker.h
    async_invoker_inl.h
    async_packet_socket.cc
    async_packet_socket.h
    async_tcp_socket.cc
    async_tcp_socket.h
    async_udp_socket.cc
    async_udp_socket.h
    crc32.cc
    crc32.h
    crypt_string.cc
    crypt_string.h
    data_rate_limiter.cc
    data_rate_limiter.h
    dscp.h
    file_rotating_stream.cc
    file_rotating_stream.h
    helpers.cc
    helpers.h
    http_common.cc
    http_common.h
    mdns_responder_interface.h
    message_digest.cc
    message_digest.h
    net_helper.cc
    net_helper.h
    network.cc
    network.h
    network_route.cc
    network_route.h
    openssl.h
    openssl_adapter.cc
    openssl_adapter.h
    openssl_digest.cc
    openssl_digest.h
    openssl_key_pair.cc
    openssl_key_pair.h
    openssl_session_cache.cc
    openssl_session_cache.h
    openssl_stream_adapter.cc
    openssl_stream_adapter.h
    openssl_utility.cc
    openssl_utility.h
    proxy_info.cc
    proxy_info.h
    rtc_certificate.cc
    rtc_certificate.h
    rtc_certificate_generator.cc
    rtc_certificate_generator.h
    sigslot_repeater.h
    socket_adapters.cc
    socket_adapters.h
    socket_address_pair.cc
    socket_address_pair.h
    ssl_adapter.cc
    ssl_adapter.h
    ssl_certificate.cc
    ssl_certificate.h
    ssl_fingerprint.cc
    ssl_fingerprint.h
    ssl_identity.cc
    ssl_identity.h
    ssl_stream_adapter.cc
    ssl_stream_adapter.h
    stream.cc
    stream.h
    unique_id_generator.cc
    unique_id_generator.h
    async_invoker.cc
    async_invoker.h
    async_invoker_inl.h
    async_packet_socket.cc
    async_packet_socket.h
    async_tcp_socket.cc
    async_tcp_socket.h
    async_udp_socket.cc
    async_udp_socket.h
    crc32.cc
    crc32.h
    crypt_string.cc
    crypt_string.h
    data_rate_limiter.cc
    data_rate_limiter.h
    dscp.h
    file_rotating_stream.cc
    file_rotating_stream.h
    helpers.cc
    helpers.h
    http_common.cc
    http_common.h
    mdns_responder_interface.h
    message_digest.cc
    message_digest.h
    net_helper.cc
    net_helper.h
    network.cc
    network.h
    network_route.cc
    network_route.h
    openssl.h
    openssl_adapter.cc
    openssl_adapter.h
    openssl_digest.cc
    openssl_digest.h
    openssl_key_pair.cc
    openssl_key_pair.h
    openssl_session_cache.cc
    openssl_session_cache.h
    openssl_stream_adapter.cc
    openssl_stream_adapter.h
    openssl_utility.cc
    openssl_utility.h
    proxy_info.cc
    proxy_info.h
    rtc_certificate.cc
    rtc_certificate.h
    rtc_certificate_generator.cc
    rtc_certificate_generator.h
    sigslot_repeater.h
    socket_adapters.cc
    socket_adapters.h
    socket_address_pair.cc
    socket_address_pair.h
    ssl_adapter.cc
    ssl_adapter.h
    ssl_certificate.cc
    ssl_certificate.h
    ssl_fingerprint.cc
    ssl_fingerprint.h
    ssl_identity.cc
    ssl_identity.h
    ssl_stream_adapter.cc
    ssl_stream_adapter.h
    stream.cc
    stream.h
    unique_id_generator.cc
    unique_id_generator.h
    async_invoker.cc
    async_invoker.h
    async_invoker_inl.h
    async_packet_socket.cc
    async_packet_socket.h
    async_tcp_socket.cc
    async_tcp_socket.h
    async_udp_socket.cc
    async_udp_socket.h
    crc32.cc
    crc32.h
    crypt_string.cc
    crypt_string.h
    data_rate_limiter.cc
    data_rate_limiter.h
    dscp.h
    file_rotating_stream.cc
    file_rotating_stream.h
    helpers.cc
    helpers.h
    http_common.cc
    http_common.h
    mdns_responder_interface.h
    message_digest.cc
    message_digest.h
    net_helper.cc
    net_helper.h
    network.cc
    network.h
    network_route.cc
    network_route.h
    openssl.h
    openssl_adapter.cc
    openssl_adapter.h
    openssl_digest.cc
    openssl_digest.h
    openssl_key_pair.cc
    openssl_key_pair.h
    openssl_session_cache.cc
    openssl_session_cache.h
    openssl_stream_adapter.cc
    openssl_stream_adapter.h
    openssl_utility.cc
    openssl_utility.h
    proxy_info.cc
    proxy_info.h
    rtc_certificate.cc
    rtc_certificate.h
    rtc_certificate_generator.cc
    rtc_certificate_generator.h
    sigslot_repeater.h
    socket_adapters.cc
    socket_adapters.h
    socket_address_pair.cc
    socket_address_pair.h
    ssl_adapter.cc
    ssl_adapter.h
    ssl_certificate.cc
    ssl_certificate.h
    ssl_fingerprint.cc
    ssl_fingerprint.h
    ssl_identity.cc
    ssl_identity.h
    ssl_stream_adapter.cc
    ssl_stream_adapter.h
    stream.cc
    stream.h
    unique_id_generator.cc
    unique_id_generator.h
    async_invoker.cc
    async_invoker.h
    async_invoker_inl.h
    async_packet_socket.cc
    async_packet_socket.h
    async_tcp_socket.cc
    async_tcp_socket.h
    async_udp_socket.cc
    async_udp_socket.h
    crc32.cc
    crc32.h
    crypt_string.cc
    crypt_string.h
    data_rate_limiter.cc
    data_rate_limiter.h
    dscp.h
    file_rotating_stream.cc
    file_rotating_stream.h
    helpers.cc
    helpers.h
    http_common.cc
    http_common.h
    mdns_responder_interface.h
    message_digest.cc
    message_digest.h
    net_helper.cc
    net_helper.h
    network.cc
    network.h
    network_route.cc
    network_route.h
    openssl.h
    openssl_adapter.cc
    openssl_adapter.h
    openssl_digest.cc
    openssl_digest.h
    openssl_key_pair.cc
    openssl_key_pair.h
    openssl_session_cache.cc
    openssl_session_cache.h
    openssl_stream_adapter.cc
    openssl_stream_adapter.h
    openssl_utility.cc
    openssl_utility.h
    proxy_info.cc
    proxy_info.h
    rtc_certificate.cc
    rtc_certificate.h
    rtc_certificate_generator.cc
    rtc_certificate_generator.h
    sigslot_repeater.h
    socket_adapters.cc
    socket_adapters.h
    socket_address_pair.cc
    socket_address_pair.h
    ssl_adapter.cc
    ssl_adapter.h
    ssl_certificate.cc
    ssl_certificate.h
    ssl_fingerprint.cc
    ssl_fingerprint.h
    ssl_identity.cc
    ssl_identity.h
    ssl_stream_adapter.cc
    ssl_stream_adapter.h
    stream.cc
    stream.h
    unique_id_generator.cc
    unique_id_generator.h
    async_invoker.cc
    async_invoker.h
    async_invoker_inl.h
    async_packet_socket.cc
    async_packet_socket.h
    async_tcp_socket.cc
    async_tcp_socket.h
    async_udp_socket.cc
    async_udp_socket.h
    crc32.cc
    crc32.h
    crypt_string.cc
    crypt_string.h
    data_rate_limiter.cc
    data_rate_limiter.h
    dscp.h
    file_rotating_stream.cc
    file_rotating_stream.h
    helpers.cc
    helpers.h
    http_common.cc
    http_common.h
    mdns_responder_interface.h
    message_digest.cc
    message_digest.h
    net_helper.cc
    net_helper.h
    network.cc
    network.h
    network_route.cc
    network_route.h
    openssl.h
    openssl_adapter.cc
    openssl_adapter.h
    openssl_digest.cc
    openssl_digest.h
    openssl_key_pair.cc
    openssl_key_pair.h
    openssl_session_cache.cc
    openssl_session_cache.h
    openssl_stream_adapter.cc
    openssl_stream_adapter.h
    openssl_utility.cc
    openssl_utility.h
    proxy_info.cc
    proxy_info.h
    rtc_certificate.cc
    rtc_certificate.h
    rtc_certificate_generator.cc
    rtc_certificate_generator.h
    sigslot_repeater.h
    socket_adapters.cc
    socket_adapters.h
    socket_address_pair.cc
    socket_address_pair.h
    ssl_adapter.cc
    ssl_adapter.h
    ssl_certificate.cc
    ssl_certificate.h
    ssl_fingerprint.cc
    ssl_fingerprint.h
    ssl_identity.cc
    ssl_identity.h
    ssl_stream_adapter.cc
    ssl_stream_adapter.h
    stream.cc
    stream.h
    unique_id_generator.cc
    unique_id_generator.h
    async_invoker.cc
    async_invoker.h
    async_invoker_inl.h
    async_packet_socket.cc
    async_packet_socket.h
    async_tcp_socket.cc
    async_tcp_socket.h
    async_udp_socket.cc
    async_udp_socket.h
    crc32.cc
    crc32.h
    crypt_string.cc
    crypt_string.h
    data_rate_limiter.cc
    data_rate_limiter.h
    dscp.h
    file_rotating_stream.cc
    file_rotating_stream.h
    helpers.cc
    helpers.h
    http_common.cc
    http_common.h
    mdns_responder_interface.h
    message_digest.cc
    message_digest.h
    net_helper.cc
    net_helper.h
    network.cc
    network.h
    network_route.cc
    network_route.h
    openssl.h
    openssl_adapter.cc
    openssl_adapter.h
    openssl_digest.cc
    openssl_digest.h
    openssl_key_pair.cc
    openssl_key_pair.h
    openssl_session_cache.cc
    openssl_session_cache.h
    openssl_stream_adapter.cc
    openssl_stream_adapter.h
    openssl_utility.cc
    openssl_utility.h
    proxy_info.cc
    proxy_info.h
    rtc_certificate.cc
    rtc_certificate.h
    rtc_certificate_generator.cc
    rtc_certificate_generator.h
    sigslot_repeater.h
    socket_adapters.cc
    socket_adapters.h
    socket_address_pair.cc
    socket_address_pair.h
    ssl_adapter.cc
    ssl_adapter.h
    ssl_certificate.cc
    ssl_certificate.h
    ssl_fingerprint.cc
    ssl_fingerprint.h
    ssl_identity.cc
    ssl_identity.h
    ssl_stream_adapter.cc
    ssl_stream_adapter.h
    stream.cc
    stream.h
    unique_id_generator.cc
    unique_id_generator.h
    async_invoker.cc
    async_invoker.h
    async_invoker_inl.h
    async_packet_socket.cc
    async_packet_socket.h
    async_tcp_socket.cc
    async_tcp_socket.h
    async_udp_socket.cc
    async_udp_socket.h
    crc32.cc
    crc32.h
    crypt_string.cc
    crypt_string.h
    data_rate_limiter.cc
    data_rate_limiter.h
    dscp.h
    file_rotating_stream.cc
    file_rotating_stream.h
    helpers.cc
    helpers.h
    http_common.cc
    http_common.h
    mdns_responder_interface.h
    message_digest.cc
    message_digest.h
    net_helper.cc
    net_helper.h
    network.cc
    network.h
    network_route.cc
    network_route.h
    openssl.h
    openssl_adapter.cc
    openssl_adapter.h
    openssl_digest.cc
    openssl_digest.h
    openssl_key_pair.cc
    openssl_key_pair.h
    openssl_session_cache.cc
    openssl_session_cache.h
    openssl_stream_adapter.cc
    openssl_stream_adapter.h
    openssl_utility.cc
    openssl_utility.h
    proxy_info.cc
    proxy_info.h
    rtc_certificate.cc
    rtc_certificate.h
    rtc_certificate_generator.cc
    rtc_certificate_generator.h
    sigslot_repeater.h
    socket_adapters.cc
    socket_adapters.h
    socket_address_pair.cc
    socket_address_pair.h
    ssl_adapter.cc
    ssl_adapter.h
    ssl_certificate.cc
    ssl_certificate.h
    ssl_fingerprint.cc
    ssl_fingerprint.h
    ssl_identity.cc
    ssl_identity.h
    ssl_stream_adapter.cc
    ssl_stream_adapter.h
    stream.cc
    stream.h
    unique_id_generator.cc
    unique_id_generator.h
    async_invoker.cc
    async_invoker.h
    async_invoker_inl.h
    async_packet_socket.cc
    async_packet_socket.h
    async_tcp_socket.cc
    async_tcp_socket.h
    async_udp_socket.cc
    async_udp_socket.h
    crc32.cc
    crc32.h
    crypt_string.cc
    crypt_string.h
    data_rate_limiter.cc
    data_rate_limiter.h
    dscp.h
    file_rotating_stream.cc
    file_rotating_stream.h
    helpers.cc
    helpers.h
    http_common.cc
    http_common.h
    mdns_responder_interface.h
    message_digest.cc
    message_digest.h
    net_helper.cc
    net_helper.h
    network.cc
    network.h
    network_route.cc
    network_route.h
    openssl.h
    openssl_adapter.cc
    openssl_adapter.h
    openssl_digest.cc
    openssl_digest.h
    openssl_key_pair.cc
    openssl_key_pair.h
    openssl_session_cache.cc
    openssl_session_cache.h
    openssl_stream_adapter.cc
    openssl_stream_adapter.h
    openssl_utility.cc
    openssl_utility.h
    proxy_info.cc
    proxy_info.h
    rtc_certificate.cc
    rtc_certificate.h
    rtc_certificate_generator.cc
    rtc_certificate_generator.h
    sigslot_repeater.h
    socket_adapters.cc
    socket_adapters.h
    socket_address_pair.cc
    socket_address_pair.h
    ssl_adapter.cc
    ssl_adapter.h
    ssl_certificate.cc
    ssl_certificate.h
    ssl_fingerprint.cc
    ssl_fingerprint.h
    ssl_identity.cc
    ssl_identity.h
    ssl_stream_adapter.cc
    ssl_stream_adapter.h
    stream.cc
    stream.h
    unique_id_generator.cc
    unique_id_generator.h
    async_invoker.cc
    async_invoker.h
    async_invoker_inl.h
    async_packet_socket.cc
    async_packet_socket.h
    async_tcp_socket.cc
    async_tcp_socket.h
    async_udp_socket.cc
    async_udp_socket.h
    crc32.cc
    crc32.h
    crypt_string.cc
    crypt_string.h
    data_rate_limiter.cc
    data_rate_limiter.h
    dscp.h
    file_rotating_stream.cc
    file_rotating_stream.h
    helpers.cc
    helpers.h
    http_common.cc
    http_common.h
    mdns_responder_interface.h
    message_digest.cc
    message_digest.h
    net_helper.cc
    net_helper.h
    network.cc
    network.h
    network_route.cc
    network_route.h
    openssl.h
    openssl_adapter.cc
    openssl_adapter.h
    openssl_digest.cc
    openssl_digest.h
    openssl_key_pair.cc
    openssl_key_pair.h
    openssl_session_cache.cc
    openssl_session_cache.h
    openssl_stream_adapter.cc
    openssl_stream_adapter.h
    openssl_utility.cc
    openssl_utility.h
    proxy_info.cc
    proxy_info.h
    rtc_certificate.cc
    rtc_certificate.h
    rtc_certificate_generator.cc
    rtc_certificate_generator.h
    sigslot_repeater.h
    socket_adapters.cc
    socket_adapters.h
    socket_address_pair.cc
    socket_address_pair.h
    ssl_adapter.cc
    ssl_adapter.h
    ssl_certificate.cc
    ssl_certificate.h
    ssl_fingerprint.cc
    ssl_fingerprint.h
    ssl_identity.cc
    ssl_identity.h
    ssl_stream_adapter.cc
    ssl_stream_adapter.h
    stream.cc
    stream.h
    unique_id_generator.cc
    unique_id_generator.h
    async_invoker.cc
    async_invoker.h
    async_invoker_inl.h
    async_packet_socket.cc
    async_packet_socket.h
    async_tcp_socket.cc
    async_tcp_socket.h
    async_udp_socket.cc
    async_udp_socket.h
    crc32.cc
    crc32.h
    crypt_string.cc
    crypt_string.h
    data_rate_limiter.cc
    data_rate_limiter.h
    dscp.h
    file_rotating_stream.cc
    file_rotating_stream.h
    helpers.cc
    helpers.h
    http_common.cc
    http_common.h
    mdns_responder_interface.h
    message_digest.cc
    message_digest.h
    net_helper.cc
    net_helper.h
    network.cc
    network.h
    network_route.cc
    network_route.h
    openssl.h
    openssl_adapter.cc
    openssl_adapter.h
    openssl_digest.cc
    openssl_digest.h
    openssl_key_pair.cc
    openssl_key_pair.h
    openssl_session_cache.cc
    openssl_session_cache.h
    openssl_stream_adapter.cc
    openssl_stream_adapter.h
    openssl_utility.cc
    openssl_utility.h
    proxy_info.cc
    proxy_info.h
    rtc_certificate.cc
    rtc_certificate.h
    rtc_certificate_generator.cc
    rtc_certificate_generator.h
    sigslot_repeater.h
    socket_adapters.cc
    socket_adapters.h
    socket_address_pair.cc
    socket_address_pair.h
    ssl_adapter.cc
    ssl_adapter.h
    ssl_certificate.cc
    ssl_certificate.h
    ssl_fingerprint.cc
    ssl_fingerprint.h
    ssl_identity.cc
    ssl_identity.h
    ssl_stream_adapter.cc
    ssl_stream_adapter.h
    stream.cc
    stream.h
    unique_id_generator.cc
    unique_id_generator.h
    async_invoker.cc
    async_invoker.h
    async_invoker_inl.h
    async_packet_socket.cc
    async_packet_socket.h
    async_tcp_socket.cc
    async_tcp_socket.h
    async_udp_socket.cc
    async_udp_socket.h
    crc32.cc
    crc32.h
    crypt_string.cc
    crypt_string.h
    data_rate_limiter.cc
    data_rate_limiter.h
    dscp.h
    file_rotating_stream.cc
    file_rotating_stream.h
    helpers.cc
    helpers.h
    http_common.cc
    http_common.h
    mdns_responder_interface.h
    message_digest.cc
    message_digest.h
    net_helper.cc
    net_helper.h
    network.cc
    network.h
    network_route.cc
    network_route.h
    openssl.h
    openssl_adapter.cc
    openssl_adapter.h
    openssl_digest.cc
    openssl_digest.h
    openssl_key_pair.cc
    openssl_key_pair.h
    openssl_session_cache.cc
    openssl_session_cache.h
    openssl_stream_adapter.cc
    openssl_stream_adapter.h
    openssl_utility.cc
    openssl_utility.h
    proxy_info.cc
    proxy_info.h
    rtc_certificate.cc
    rtc_certificate.h
    rtc_certificate_generator.cc
    rtc_certificate_generator.h
    sigslot_repeater.h
    socket_adapters.cc
    socket_adapters.h
    socket_address_pair.cc
    socket_address_pair.h
    ssl_adapter.cc
    ssl_adapter.h
    ssl_certificate.cc
    ssl_certificate.h
    ssl_fingerprint.cc
    ssl_fingerprint.h
    ssl_identity.cc
    ssl_identity.h
    ssl_stream_adapter.cc
    ssl_stream_adapter.h
    stream.cc
    stream.h
    unique_id_generator.cc
    unique_id_generator.h
          
      openssl_certificate.cc
      openssl_certificate.h
      openssl_identity.cc
      openssl_identity.h
          
          
      log_sinks.cc
      log_sinks.h
      rolling_accumulator.h
      ssl_roots.h 
          
      win32_socket_server.cc
      win32_socket_server.h
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
			 
	strings/json.cc
	strings/json.h
	strings/string_builder.cc
	strings/string_builder.h			 
	
	synchronization/mutex.cc
	synchronization/mutex_critical_section.h
	synchronization/mutex.h
	synchronization/mutex_pthread.h
	synchronization/sequence_checker.cc
	synchronization/sequence_checker.h
	synchronization/sequence_checker_internal.cc
	synchronization/sequence_checker_internal.h
	synchronization/yield.cc
	synchronization/yield.h
	synchronization/yield_policy.cc
	synchronization/yield_policy.h



	deprecated/recursive_critical_section.cc
	deprecated/recursive_critical_section.h
	
	
	internal/default_socket_server.cc
	internal/default_socket_server.h
	
	
	network/sent_packet.h
	network/sent_packet.cc 
	
	
	
	task_utils/pending_task_safety_flag.cc
	task_utils/pending_task_safety_flag.h
	task_utils/repeating_task.cc
	task_utils/repeating_task.h
	task_utils/to_queued_task.h
	
	
	
	memory/aligned_malloc.cc
	memory/aligned_malloc.h
	memory/fifo_buffer.cc
	memory/fifo_buffer.h
	
	
	
	containers/as_const.h
	containers/flat_map.h
	containers/flat_tree.cc
	containers/flat_tree.h
	containers/invoke.h
	containers/not_fn.h
	containers/void_t.h
	
	
	
	experiments/field_trial_parser.cc  
	experiments/field_trial_parser.h
	
	
	#system/arch.h
	#system/file_wrapper.cc
	#system/file_wrapper.h
	#system/ignore_warnings.h
	#system/inline.h
	#system/no_unique_address.h
	#system/rtc_export.h
	#system/unused.h
	#system/warn_current_thread_is_deadlocked.cc
	#system/warn_current_thread_is_deadlocked.h



	#third_party/sigslot/*.h
	#third_party/base64/*.h
	
	
	#	third_party/sigslot/*.cc
		
	#third_party/base64/*.cc


)

FILE(GLOB  rtc_base_approved_source

	bit_buffer.cc
    bit_buffer.h
    buffer.h
    buffer_queue.cc
    buffer_queue.h
    byte_buffer.cc
    byte_buffer.h
    byte_order.h
    copy_on_write_buffer.cc
    copy_on_write_buffer.h
    event_tracer.cc
    event_tracer.h
    location.cc
    location.h
    numerics/histogram_percentile_counter.cc
    numerics/histogram_percentile_counter.h
    numerics/mod_ops.h
    numerics/moving_max_counter.h
    numerics/sample_counter.cc
    numerics/sample_counter.h
    one_time_event.h
    race_checker.cc
    race_checker.h
    random.cc
    random.h
    rate_statistics.cc
    rate_statistics.h
    rate_tracker.cc
    rate_tracker.h
    strong_alias.h
    swap_queue.h
    timestamp_aligner.cc
    timestamp_aligner.h
    trace_event.h
    zero_memory.cc
    zero_memory.h

	#win
	 
)


if (CMAKE_SYSTEM_NAME MATCHES "Windows")
    file(GLOB rtc_base_win_source
        "win/windows_version.h"
		"win/windows_version.cc"
		 "win/scoped_com_initializer.h"
		"win/scoped_com_initializer.cc"
		 "win/get_activation_factory.cc" 
      "win/get_activation_factory.h"
      "win/hstring.cc"
      "win/hstring.h"
      "win/scoped_com_initializer.cc"
      "win/scoped_com_initializer.h"
      "win/windows_version.cc"
      "win/windows_version.h"
    )

	FILE(GLOB rtc_base_win_wgc_source
	 "win/create_direct3d_device.cc"
      "win/create_direct3d_device.h"
	)
	
endif()






add_library(checks  STATIC  ${checks_source})

add_library(rtc_base STATIC ${rtc_base_source}
		
		
			${rtc_base_win}
		)

add_library(rtc_base_approved STATIC ${rtc_base_approved_source})

add_library(rtc_base_win STATIC ${rtc_base_win_source})

add_library(rtc_base_win_wgc STATIC ${rtc_base_win_wgc_source})



add_subdirectory(third_party)
add_subdirectory(system)
        
set(AllFile  

    ${checks_source}
    ${rtc_base_source}
	${rtc_base_approved_source}
	${rtc_base_win_source}
	${rtc_base_win_wgc_source}
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



set_property(TARGET rtc_base  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})

set_property(TARGET rtc_base_win  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
set_property(TARGET rtc_base_approved  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
set_property(TARGET rtc_base_win_wgc  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})

set_property(TARGET checks  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})