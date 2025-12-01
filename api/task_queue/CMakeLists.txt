project(task_queue)

include_directories(

    .
)


FILE(GLOB  task_queue_source 

    queued_task.h
    task_queue_base.h
    task_queue_base.cc
    task_queue_factory.h
  #deps = [
 #   "../../rtc_base:checks",
 #   "../../rtc_base:macromagic",
  #  "../../rtc_base/system:rtc_export",
 # ]

)


 
if (CMAKE_SYSTEM_NAME MATCHES "Windows")
    message(STATUS "current platform: windows")
    FILE(GLOB  default_task_queue_factory_source
        default_task_queue_factory.h
        default_task_queue_factory_win.cc
    )
elseif (CMAKE_SYSTEM_NAME MATCHES "Linux")
	message(STATUS "current platform: unix")
    FILE(GLOB  default_task_queue_factory_source
        default_task_queue_factory.h
        default_task_queue_factory_stdlib.cc
    )


endif()

add_library(${PROJECT_NAME} STATIC  ${task_queue_source})


add_library(default_task_queue_factory STATIC  ${default_task_queue_factory_source})


set_property(TARGET ${PROJECT_NAME}  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})
set_property(TARGET default_task_queue_factory  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/api/${PROJECT_NAME})


