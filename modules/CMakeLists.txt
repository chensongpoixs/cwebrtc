project(modules)









add_subdirectory(desktop_capture)
add_subdirectory(audio_coding)
add_subdirectory(video_capture)
add_subdirectory(audio_device)

add_subdirectory(video_coding)


if (CMAKE_SYSTEM_NAME MATCHES "Windows")
    message(STATUS "libwebrtc  modules  current platform: windows")
    add_subdirectory(audio_processing)
    
elseif (CMAKE_SYSTEM_NAME MATCHES "Linux")
	message(STATUS "libwebrtc modules current platform: unix")
     


endif()