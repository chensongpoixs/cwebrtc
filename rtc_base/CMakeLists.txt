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
	
	#synchronization/mutex.cc
	#synchronization/mutex_critical_section.h
	#synchronization/mutex.h
	#synchronization/mutex_pthread.h
	#synchronization/sequence_checker.cc
	#synchronization/sequence_checker.h
	#synchronization/sequence_checker_internal.cc
	#synchronization/sequence_checker_internal.h
	#synchronization/yield.cc
	#synchronization/yield.h
	#synchronization/yield_policy.cc
	#synchronization/yield_policy.h



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


FILE(GLOB   logging_source


		logging.cc
      logging.h
)

FILE(GLOB  ip_address_source


		ip_address.cc 
	ip_address.h
)

FILE(GLOB socket_address_source

	socket_address.h 
	socket_address.cc
)

FILE(GLOB  network_constants_source

	network_constants.h 
	network_constants.cc 
)

FILE(GLOB async_resolver_interface_source

	async_resolver_interface.h 
	async_resolver_interface.cc 
)
FILE(GLOB  async_socket_source


	async_socket.h 
	async_socket.cc 
	)
	
	
FILE(GLOB  null_socket_server_source


	null_socket_server.h
	null_socket_server.cc 
	)
	
FILE(GLOB  threading_source


	async_resolver.cc
    async_resolver.h
    internal/default_socket_server.cc
    internal/default_socket_server.h
    message_handler.cc
    message_handler.h
    network_monitor.cc
    network_monitor.h
    network_monitor_factory.cc
    network_monitor_factory.h
    physical_socket_server.cc
    physical_socket_server.h
    thread.cc
    thread.h
    thread_message.h

)

FILE(GLOB  socket_source

	socket.h 
	socket.cc 
)

FILE(GLOB  stringutils_source

	string_encode.cc
    string_encode.h
    string_to_number.cc
    string_to_number.h
    string_utils.cc
    string_utils.h
    strings/string_builder.cc
    strings/string_builder.h
    strings/string_format.cc
    strings/string_format.h

)

FILE(GLOB  timeutils_source
    system_time.cc
    system_time.h
    time_utils.cc
    time_utils.h

)
FILE(GLOB  platform_thread_types_source

	platform_thread_types.h 
	platform_thread_types.cc 
)


FILE(GLOB  platform_thread_source
	platform_thread.cc 
	platform_thread.h

)

FILE(GLOB net_helpers_source

	net_helpers.h 
	net_helpers.cc 
)

FILE(GLOB  rtc_event_source

	event.h 
	event.cc 
)

FILE(GLOB win32_source
      win32.cc
      win32.h
      win32_window.cc
      win32_window.h

)

FILE(GLOB  weak_ptr_source

	weak_ptr.h 
	weak_ptr.cc 
)

FILE(GLOB callback_list_source

	callback_list.h 
	callback_list.cc 
)

FILE(GLOB  rtc_numerics_source

    numerics/event_based_exponential_moving_average.cc
    numerics/event_based_exponential_moving_average.h
    numerics/exp_filter.cc
    numerics/exp_filter.h
    numerics/math_utils.h
    numerics/moving_average.cc
    numerics/moving_average.h
    numerics/moving_median_filter.h
    numerics/percentile_filter.h
    numerics/running_statistics.h
    numerics/sequence_number_util.h
)

FILE(GLOB  rtc_base_tests_utils_source

    cpu_time.cc
    cpu_time.h
    fake_clock.cc
    fake_clock.h
    fake_mdns_responder.h
    fake_network.h
    fake_ssl_identity.cc
    fake_ssl_identity.h
    firewall_socket_server.cc
    firewall_socket_server.h
    memory_stream.cc
    memory_stream.h
    memory_usage.cc
    memory_usage.h
    nat_server.cc
    nat_server.h
    nat_socket_factory.cc
    nat_socket_factory.h
    nat_types.cc
    nat_types.h
    proxy_server.cc
    proxy_server.h
    server_socket_adapters.cc
    server_socket_adapters.h
    sigslot_tester.h
    socket_stream.cc
    socket_stream.h
    test_base64.h
    test_certificate_verifier.h
    test_echo_server.cc
    test_echo_server.h
    test_utils.cc
    test_utils.h
    virtual_socket_server.cc
    virtual_socket_server.h
)

FILE(GLOB  rate_limiter_source
	rate_limiter.h 
	rate_limiter.cc 

)

FILE(GLOB  rtc_task_queue_source

	task_queue.cc
	task_queue.h
)


FILE(GLOB  rtc_task_queue_win_source
		task_queue_win.cc
      task_queue_win.h
)

FILE(GLOB  bitstream_reader_source

	bitstream_reader.cc 
	bitstream_reader.h 
)

###################
file(GLOB aligned_malloc_source 
	 
	memory/aligned_malloc.h
	memory/aligned_malloc.cc 
	 
) 


FILE(GLOB fifo_buffer_source

    memory/fifo_buffer.cc
    memory/fifo_buffer.h
)

#######################



FILE(GLOB  yield_source

	synchronization/yield.h
	synchronization/yield.cc
	)
	
	
FILE(GLOB  mutex_source

	synchronization/mutex.cc
    synchronization/mutex.h
    synchronization/mutex_critical_section.h
    synchronization/mutex_pthread.h
	synchronization/mutex_abseil.h
)

FILE(GLOB  sequence_checker_internal_source

	synchronization/sequence_checker_internal.h
	synchronization/sequence_checker_internal.cc
)

FILE(GLOB yield_policy_source

	synchronization/yield_policy.h
	synchronization/yield_policy.cc
)


FILE(GLOB  base64_source


	third_party/base64/base64.cc 
	third_party/base64/base64.h
	
	)

FILE(GLOB  sigslot_source


	third_party/sigslot/sigslot.cc 
	third_party/sigslot/sigslot.h
	
	)	






FILE(GLOB   warn_current_thread_is_deadlocked_source

	experiments/warn_current_thread_is_deadlocked.h 
	
	
	# linux  
	#warn_current_thread_is_deadlocked.cc

 
	experiments/no_unique_address.h

 

			experiments/arch.h
 

		experiments/asm_defines.h
 
	experiments/file_wrapper.h
	experiments/file_wrapper.cc 
 

	experiments/ignore_warnings.h
 
	experiments/inline.h
	 
	experiments/unused.h
	 
	experiments/assume.h
 
    experiments/rtc_export.h
    experiments/rtc_export_template.h
	 
	#thread_registry.cc 
	experiments/thread_registry.h
)




FILE(GLOB  system_alr_experiment_source

	system/alr_experiment.cc 
	system/alr_experiment.h 
    system/field_trial_list.cc
    system/field_trial_list.h
    system/field_trial_parser.cc
    system/field_trial_parser.h
    system/field_trial_units.cc
    system/field_trial_units.h
    system/struct_parameters_parser.cc
    system/struct_parameters_parser.h 
	system/quality_rampup_experiment.h 
	system/quality_rampup_experiment.cc  
	system/quality_scaler_settings.h 
	system/quality_scaler_settings.cc  
	system/bandwidth_quality_scaler_settings.cc
	system/bandwidth_quality_scaler_settings.h 
	system/quality_scaling_experiment.cc 
	system/quality_scaling_experiment.h 
	system/normalize_simulcast_size_experiment.h 
	system/normalize_simulcast_size_experiment.cc  
	system/balanced_degradation_settings.cc 
	system/balanced_degradation_settings.h  
	system/cpu_speed_experiment.h 
	system/cpu_speed_experiment.cc  
	system/encoder_info_settings.h 
	system/encoder_info_settings.cc  
	system/rtt_mult_experiment.h 
	system/rtt_mult_experiment.cc  
	system/jitter_upper_bound_experiment.h 
	system/jitter_upper_bound_experiment.cc  
	system/rate_control_settings.h
	system/rate_control_settings.cc  
	system/keyframe_interval_settings.h
	system/keyframe_interval_settings.cc  
	system/stable_target_rate_experiment.h 
	system/stable_target_rate_experiment.cc  
	system/min_video_bitrate_experiment.h 
	system/min_video_bitrate_experiment.cc 
)





add_library(${PROJECT_NAME}  STATIC  ${checks_source}
   ${rtc_base_source} 
   ${rtc_base_win}  

  ${rtc_base_approved_source} 

  ${rtc_base_win_source} 

  ${rtc_base_win_wgc_source} 


${logging_source} 
 ${ip_address_source} 
  ${socket_address_source} 
  ${network_constants_source} 
  ${async_resolver_interface_source} 
  ${async_socket_source} 

 ${null_socket_server_source} 
  ${threading_source} 
  ${socket_source} 
  ${stringutils_source} 
  ${timeutils_source} 
  ${platform_thread_types_source} 
  ${platform_thread_source} 
  ${net_helpers_source} 
  ${rtc_task_queue_win_source} 

  ${rtc_event_source} 
  ${bitstream_reader_source}
  
  
 
#  "crypt32.lib
#      "iphlpapi.lib
#      "secur32.lib
 ${win32_source} 
   ${weak_ptr_source} 
  ${callback_list_source}
   ${rtc_numerics_source}
  ${rtc_base_tests_utils_source}
  ${rtc_task_queue_source}

 ${rate_limiter_source}
 

  ${aligned_malloc_source}
  ${fifo_buffer_source}



  #############
  ${yield_source}
  ${mutex_source}
  ${sequence_checker_internal_source}
  ${yield_policy_source}


  ${base64_source}
  ${sigslot_source}

  ${warn_current_thread_is_deadlocked_source}
  ${system_alr_experiment_source}
 )



 
















 
#add_library(${PROJECT_NAME}_lib  STATIC ${rtc_base_ALL_LIB})
#set_target_properties(${PROJECT_NAME}_lib      			      					PROPERTIES LINKER_LANGUAGE CXX) 
#target_link_libraries(${PROJECT_NAME}_lib  PUBLIC   ${rtc_base_ALL_LIB} )



#add_subdirectory(system)
#add_subdirectory(memory)
#add_subdirectory(synchronization)
#add_subdirectory(experiments)
# add_subdirectory(third_party)
 
 
 
set(AllFile  

    ${checks_source}
    ${rtc_base_source}
	${rtc_base_approved_source}
	${rtc_base_win_source}
	${rtc_base_win_wgc_source}
	${logging_source}
	${ip_address_source}
	${socket_address_source}
	${network_constants_source}
	${async_resolver_interface_source}
	${async_socket_source}
	${null_socket_server_source}
	${threading_source}
	${socket_source}
	${stringutils_source}
	${timeutils_source}
	${platform_thread_types_source}
	${platform_thread_source}
	${net_helpers_source}
	${rtc_event_source}
	${win32_source}
	${weak_ptr_source}
	${callback_list_source}
	${rtc_numerics_source}
	${rtc_base_tests_utils_source}
	${rate_limiter_source}
	${rtc_task_queue_source}
	${rtc_task_queue_win_source}
	${bitstream_reader_source}
	  ${aligned_malloc_source}
  ${fifo_buffer_source}

   #############
  ${yield_source}
  ${mutex_source}
  ${sequence_checker_internal_source}
  ${yield_policy_source}
  ${base64_source}
  ${sigslot_source}
  ${warn_current_thread_is_deadlocked_source}

  ${system_alr_experiment_source}

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



set_property(TARGET ${PROJECT_NAME}  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER} )

#set_property(TARGET rtc_base_win  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET rtc_base_approved  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET rtc_base_win_wgc  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET logging  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET checks  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#
#set_property(TARGET ip_address  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET socket_address  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#
#set_property(TARGET network_constants  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#
#
#
#set_property(TARGET async_resolver_interface  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET async_socket              PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET null_socket_server        PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET threading                 PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET socket                    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET stringutils                    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET timeutils                    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET platform_thread_types                    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET platform_thread                    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET net_helpers                    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET rtc_event                    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET win32                    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET weak_ptr                    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET callback_list                    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET rtc_numerics                    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET rtc_base_tests_utils                 PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#set_property(TARGET rate_limiter                 PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#
##rtc_task_queue_source
#set_property(TARGET rtc_task_queue                 PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#
#set_property(TARGET rtc_task_queue_win                 PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
##${bitstream_reader_source}
#set_property(TARGET bitstream_reader                 PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
#