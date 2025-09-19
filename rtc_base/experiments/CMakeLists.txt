project(experiments)


cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")


FILE(GLOB  alr_experiment_source

	alr_experiment.cc 
	alr_experiment.h

)

FILE(GLOB  field_trial_parser_source

    field_trial_list.cc
    field_trial_list.h
    field_trial_parser.cc
    field_trial_parser.h
    field_trial_units.cc
    field_trial_units.h
    struct_parameters_parser.cc
    struct_parameters_parser.h
)

FILE(GLOB quality_rampup_experiment_source 

	quality_rampup_experiment.h 
	quality_rampup_experiment.cc 
)
FILE(GLOB  quality_scaler_settings_source

	quality_scaler_settings.h 
	quality_scaler_settings.cc 
)

FILE(GLOB bandwidth_quality_scaler_settings_source

	bandwidth_quality_scaler_settings.cc
	bandwidth_quality_scaler_settings.h
)

FILE(GLOB  quality_scaling_experiment_source

	quality_scaling_experiment.cc 
	quality_scaling_experiment.h
)
FILE(GLOB normalize_simulcast_size_experiment_source

	normalize_simulcast_size_experiment.h 
	normalize_simulcast_size_experiment.cc 
)
FILE(GLOB  balanced_degradation_settings_source

	balanced_degradation_settings.cc 
	balanced_degradation_settings.h 
)

FILE(GLOB  cpu_speed_experiment_source

	cpu_speed_experiment.h 
	cpu_speed_experiment.cc 
)

FILE(GLOB  encoder_info_settings_source

	encoder_info_settings.h 
	encoder_info_settings.cc 

)

FILE(GLOB  rtt_mult_experiment_source

	rtt_mult_experiment.h 
	rtt_mult_experiment.cc 
)

FILE(GLOB jitter_upper_bound_experiment_source

	jitter_upper_bound_experiment.h 
	jitter_upper_bound_experiment.cc 
)
FILE(GLOB  rate_control_settings_source

	rate_control_settings.h
	rate_control_settings.cc 
)
FILE(GLOB keyframe_interval_settings_experiment_source

	keyframe_interval_settings.h
	keyframe_interval_settings.cc 
)

FILE(GLOB  stable_target_rate_experiment_source
	stable_target_rate_experiment.h 
	stable_target_rate_experiment.cc 
)


FILE(GLOB  min_video_bitrate_experiment_source

	min_video_bitrate_experiment.h 
	min_video_bitrate_experiment.cc 
)

add_library(alr_experiment             		   					STATIC  ${alr_experiment_source}                         ) 
add_library(field_trial_parser             		   					STATIC  ${field_trial_parser_source}                         ) 
add_library(quality_rampup_experiment             		   					STATIC  ${quality_rampup_experiment_source}                         ) 
add_library(quality_scaler_settings             		   					STATIC  ${quality_scaler_settings_source}                         ) 
add_library(bandwidth_quality_scaler_settings             		   					STATIC  ${bandwidth_quality_scaler_settings_source}                         ) 
add_library(quality_scaling_experiment             		   					STATIC  ${quality_scaling_experiment_source}                         ) 
add_library(normalize_simulcast_size_experiment             		   					STATIC  ${normalize_simulcast_size_experiment_source}                         ) 
add_library(balanced_degradation_settings             		   					STATIC  ${balanced_degradation_settings_source}                         ) 
add_library(cpu_speed_experiment             		   					STATIC  ${cpu_speed_experiment_source}                         ) 
add_library(encoder_info_settings             		   					STATIC  ${encoder_info_settings_source}                         ) 
add_library(rtt_mult_experiment             		   					STATIC  ${rtt_mult_experiment_source}                         ) 
add_library(jitter_upper_bound_experiment             		   					STATIC  ${jitter_upper_bound_experiment_source}                         ) 
add_library(rate_control_settings             		   					STATIC  ${rate_control_settings_source}                         ) 
add_library(keyframe_interval_settings_experiment             		   					STATIC  ${keyframe_interval_settings_experiment_source}                         ) 
add_library(stable_target_rate_experiment             		   					STATIC  ${stable_target_rate_experiment_source}                         ) 
add_library(min_video_bitrate_experiment             		   					STATIC  ${min_video_bitrate_experiment_source}                         ) 
 



set_target_properties(alr_experiment      			      					PROPERTIES LINKER_LANGUAGE CXX)  

set(AllFile 

          
		${alr_experiment_source}  
		${field_trial_parser_source}
		${quality_rampup_experiment_source}
		${quality_scaler_settings_source}
		${bandwidth_quality_scaler_settings_source}
		${quality_scaling_experiment_source}
		${normalize_simulcast_size_experiment_source}
		${balanced_degradation_settings_source}
		${cpu_speed_experiment_source}
		${encoder_info_settings_source}
		${rtt_mult_experiment_source}
		${jitter_upper_bound_experiment_source}
		${rate_control_settings_source}
		${keyframe_interval_settings_experiment_source}
		${stable_target_rate_experiment_source}
		${min_video_bitrate_experiment_source}
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


 
set_property(TARGET alr_experiment                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET field_trial_parser                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET quality_rampup_experiment                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET quality_scaler_settings                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET bandwidth_quality_scaler_settings                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET quality_scaling_experiment                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET normalize_simulcast_size_experiment                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET balanced_degradation_settings                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET cpu_speed_experiment                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET encoder_info_settings                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET rtt_mult_experiment                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET jitter_upper_bound_experiment                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET rate_control_settings                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET keyframe_interval_settings_experiment                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET stable_target_rate_experiment                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
set_property(TARGET min_video_bitrate_experiment                                      PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/rtc_base/${PROJECT_NAME}) 
 


