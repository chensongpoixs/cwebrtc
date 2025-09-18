PROJECT(rtc_base)




FILE(GLOB  checks_source

    checks.h
    checks.cc

)





FILE(GLOB  rtc_base_source

           arraysize.h
           async_packet_socket.cc
           async_packet_socket.h
           async_resolver.cc
           async_resolver.h
           async_resolver_interface.cc
           async_resolver_interface.h
           async_socket.cc
           async_socket.h
           async_udp_socket.cc
           async_udp_socket.h
           atomic_ops.h
           bit_buffer.cc
           bit_buffer.h
           bitstream_reader.cc
           bitstream_reader.h
           buffer.h
           buffer_queue.cc
           buffer_queue.h
           byte_buffer.cc
           byte_buffer.h
           byte_io.h
           byte_order.h
            #  rtc_base/checks.cc
            #  rtc_base/checks.h
              compile_assert_c.h
              constructor_magic.h
             #rtc_base/containers/
           copy_on_write_buffer.cc
           copy_on_write_buffer.h
           crc32.cc
           crc32.h
           deprecated/
           deprecation.h
           dscp.h
           event.cc
           event.h
           event_tracer.cc
           event_tracer.h
           experiments/
           fake_clock.cc
           fake_clock.h
           gtest_prod_util.h
           helpers.cc
           helpers.h
           ignore_wundef.h
           internal/
           ip_address.cc
           ip_address.h
           location.cc
           location.h
           logging.cc
           logging.h
           memory/
           message_digest.cc
           message_digest.h
           message_handler.cc
           message_handler.h
           net_helper.cc
           net_helper.h
           net_helpers.cc
           net_helpers.h
           network/
           network_constants.cc
           network_constants.h
           network_monitor.cc
           network_monitor.h
           null_socket_server.cc
           null_socket_server.h
           numerics/
           openssl_adapter.cc
           openssl_adapter.h
           openssl_certificate.cc
           openssl_certificate.h
           openssl_digest.cc
           openssl_digest.h
           openssl.h
           openssl_identity.cc
           openssl_identity.h
           openssl_key_pair.cc
           openssl_key_pair.h
           openssl_session_cache.cc
           openssl_session_cache.h
           openssl_stream_adapter.cc
           openssl_stream_adapter.h
           openssl_utility.cc
           openssl_utility.h
           physical_socket_server.cc
           physical_socket_server.h
           platform_thread.cc
           platform_thread.h
           platform_thread_types.cc
           platform_thread_types.h
           race_checker.cc
           race_checker.h
           random.cc
           random.h
           rate_limiter.cc
           rate_limiter.h
           rate_statistics.cc
           rate_statistics.h
           rate_tracker.cc
           rate_tracker.h
           ref_counted_object.h
           ref_counter.h
           ref_count.h
           rtc_certificate.cc
           rtc_certificate_generator.cc
           rtc_certificate_generator.h
           rtc_certificate.h
           sanitizer.h
           socket_address.cc
           socket_address.h
           socket.cc
           socket_factory.h
           socket.h
           socket_server.h
           ssl_adapter.cc
           ssl_adapter.h
           ssl_certificate.cc
           ssl_certificate.h
           ssl_fingerprint.cc
           ssl_fingerprint.h
           ssl_identity.cc
           ssl_identity.h
           ssl_roots.h
           ssl_stream_adapter.cc
           ssl_stream_adapter.h
           stream.cc
           stream.h
           string_encode.cc
           string_encode.h
           strings/
           string_to_number.cc
           string_to_number.h
           string_utils.cc
           string_utils.h
           swap_queue.h
           synchronization/
           system/
           system_time.cc
           system_time.h
           task_queue.cc
           task_queue.h
            # rtc_base/task_queue_stdlib.cc
            # rtc_base/task_queue_stdlib.h
            task_queue_win.cc
            task_queue_win.h
            task_utils/
            third_party/
            thread_annotations.h
            thread.cc
            thread_checker.h
            thread.h
            thread_message.h
            time_utils.cc
            time_utils.h
            trace_event.h
            type_traits.h
            units/
            win/
            win32.cc
            win32.h
            zero_memory.cc
            zero_memory.h
			 
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
	
	
	system/arch.h
	system/file_wrapper.cc
	system/file_wrapper.h
	system/ignore_warnings.h
	system/inline.h
	system/no_unique_address.h
	system/rtc_export.h
	system/unused.h
	system/warn_current_thread_is_deadlocked.cc
	system/warn_current_thread_is_deadlocked.h



	third_party/sigslot/*.h
	third_party/base64/*.h
	
	
		third_party/sigslot/*.cc
		
	third_party/base64/*.cc


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