project(desktop_capture)




FILE(GLOB  desktop_capture_differ_sse2_source

		./differ_vector_sse2.cc
		./differ_vector_sse2.h
)



FILE(GLOB  screen_drawer_source

	  ./screen_drawer.cc
      ./screen_drawer.h
	  ./screen_drawer_win.cc
)

FILE(GLOB  primitives_source

		./desktop_capture_types.h
		./desktop_frame.cc
		./desktop_frame.h
		./desktop_geometry.cc
		./desktop_geometry.h
		./desktop_region.cc
		./desktop_region.h
		./shared_desktop_frame.cc
		./shared_desktop_frame.h
		./shared_memory.cc
		./shared_memory.h
)



FILE(GLOB   desktop_capture_generic_source


    ./blank_detector_desktop_capturer_wrapper.cc
    ./blank_detector_desktop_capturer_wrapper.h
    ./cropped_desktop_frame.cc
    ./cropped_desktop_frame.h
    ./cropping_window_capturer.cc
    ./cropping_window_capturer.h
    ./desktop_and_cursor_composer.cc
    ./desktop_and_cursor_composer.h
    ./desktop_capture_metrics_helper.cc
    ./desktop_capture_metrics_helper.h
    ./desktop_capture_options.cc
    ./desktop_capture_options.h
    ./desktop_capturer.cc
    ./desktop_capturer.h
    ./desktop_capturer_differ_wrapper.cc
    ./desktop_capturer_differ_wrapper.h
    ./desktop_capturer_wrapper.cc
    ./desktop_capturer_wrapper.h
    ./desktop_frame_generator.cc
    ./desktop_frame_generator.h
    ./desktop_frame_rotation.cc
    ./desktop_frame_rotation.h
    ./differ_block.cc
    ./differ_block.h
    ./fake_desktop_capturer.cc
    ./fake_desktop_capturer.h
    ./fallback_desktop_capturer_wrapper.cc
    ./fallback_desktop_capturer_wrapper.h
    ./full_screen_application_handler.cc
    ./full_screen_application_handler.h
    ./full_screen_window_detector.cc
    ./full_screen_window_detector.h
    ./mouse_cursor.cc
    ./mouse_cursor.h
    ./mouse_cursor_monitor.h
    ./resolution_tracker.cc
    ./resolution_tracker.h
    ./rgba_color.cc
    ./rgba_color.h
    ./screen_capture_frame_queue.h
    ./screen_capturer_helper.cc
    ./screen_capturer_helper.h
    ./window_finder.cc
    ./window_finder.h
	./app_capturer_win.cc
        win/desktop_device_info_win.cc
        win/win_shared.cc
	  ./cropping_window_capturer_win.cc
      ./desktop_frame_win.cc
      ./desktop_frame_win.h
      ./mouse_cursor_monitor_win.cc
      ./screen_capturer_win.cc
      ./win/cursor.cc
      ./win/cursor.h
      ./win/d3d_device.cc
      ./win/d3d_device.h
      ./win/desktop.cc
      ./win/desktop.h
      ./win/desktop_capture_utils.cc
      ./win/desktop_capture_utils.h
      ./win/display_configuration_monitor.cc
      ./win/display_configuration_monitor.h
      ./win/dxgi_adapter_duplicator.cc
      ./win/dxgi_adapter_duplicator.h
      ./win/dxgi_context.cc
      ./win/dxgi_context.h
      ./win/dxgi_duplicator_controller.cc
      ./win/dxgi_duplicator_controller.h
      ./win/dxgi_frame.cc
      ./win/dxgi_frame.h
      ./win/dxgi_output_duplicator.cc
      ./win/dxgi_output_duplicator.h
      ./win/dxgi_texture.cc
      ./win/dxgi_texture.h
      ./win/dxgi_texture_mapping.cc
      ./win/dxgi_texture_mapping.h
      ./win/dxgi_texture_staging.cc
      ./win/dxgi_texture_staging.h
      ./win/full_screen_win_application_handler.cc
      ./win/full_screen_win_application_handler.h
      ./win/scoped_gdi_object.h
      ./win/scoped_thread_desktop.cc
      ./win/scoped_thread_desktop.h
      ./win/screen_capture_utils.cc
      ./win/screen_capture_utils.h
      ./win/screen_capturer_win_directx.cc
      ./win/screen_capturer_win_directx.h
      ./win/screen_capturer_win_gdi.cc
      ./win/screen_capturer_win_gdi.h
      ./win/screen_capturer_win_magnifier.cc
      ./win/screen_capturer_win_magnifier.h
      ./win/selected_window_context.cc
      ./win/selected_window_context.h
      ./win/window_capture_utils.cc
      ./win/window_capture_utils.h
      ./win/window_capturer_win_gdi.cc
      ./win/window_capturer_win_gdi.h
      ./window_capturer_win.cc
      ./window_finder_win.cc
      ./window_finder_win.h
#"d3d11.lib",
  #    "dxgi.lib",
  
     win/wgc_capture_session.cc
     win/wgc_capture_session.h
     win/wgc_capture_source.cc
     win/wgc_capture_source.h
     win/wgc_capturer_win.cc
     win/wgc_capturer_win.h
     win/wgc_desktop_frame.cc
     win/wgc_desktop_frame.h
	 
	 
	 
)



# FILE(GLOB  desktop_capture_mock_source


# 		./mock_desktop_capturer_callback.cc
#       ./mock_desktop_capturer_callback.h
# )


#add_library(desktop_capture_mock STATIC ${desktop_capture_mock_source})


add_library(desktop_capture_generic STATIC ${desktop_capture_generic_source})
add_library(primitives STATIC ${primitives_source})
add_library(desktop_capture_differ_sse2 STATIC  ${desktop_capture_differ_sse2_source})

add_library(screen_drawer  STATIC  ${screen_drawer_source})

set(AllFile

#${desktop_capture_mock_source}
${desktop_capture_generic_source}
${primitives_source}
${desktop_capture_differ_sse2_source}
${screen_drawer_source}

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
	string(REPLACE \. \\   GROUP ${GROUP})
	
    # Group into "Source Files" and "Header Files"
    set(GROUP "${GROUP}")
    source_group("${GROUP}" FILES "${fileItem}")
endforeach()



#set_property(TARGET  desktop_capture_mock PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})


set_property(TARGET  desktop_capture_generic PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  primitives   PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  desktop_capture_differ_sse2   PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})

set_property(TARGET  screen_drawer    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
