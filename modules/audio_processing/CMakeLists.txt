project(audio_processing)

cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")



		## include/audio_processing.cc
		## include/audio_processing.h
		## include/audio_frame_proxies.cc
		## include/audio_frame_proxies.h
		## audio_buffer.cc
		## audio_buffer.h
		## splitting_filter.cc
		## splitting_filter.h
		## three_band_filter_bank.cc
		## three_band_filter_bank.h
		## high_pass_filter.cc
		## high_pass_filter.h
		## include/aec_dump.cc
		## include/aec_dump.h
		## audio_processing_builder_impl.cc
		## audio_processing_impl.cc
		## audio_processing_impl.h
		## common.h
		## echo_control_mobile_impl.cc
		## echo_control_mobile_impl.h
		## echo_detector/circular_buffer.cc
		## echo_detector/circular_buffer.h
		## echo_detector/mean_variance_estimator.cc
		## echo_detector/mean_variance_estimator.h
		## echo_detector/moving_max.cc
		## echo_detector/moving_max.h
		## echo_detector/normalized_covariance_estimator.cc
		## echo_detector/normalized_covariance_estimator.h
		## gain_control_impl.cc
		## gain_control_impl.h
		## gain_controller2.cc
		## gain_controller2.h
		## level_estimator.cc
		## level_estimator.h
		## render_queue_item_verifier.h
		## residual_echo_detector.cc
		## residual_echo_detector.h
		## typing_detection.cc
		## typing_detection.h
		## voice_detection.cc
		## voice_detection.h	
		## optionally_built_submodule_creators.cc
		## optionally_built_submodule_creators.h	
		## rms_level.cc
		## rms_level.h	
		## include/audio_processing_statistics.cc
		## include/audio_processing_statistics.h
		##include/audio_frame_view.h
		## logging/apm_data_dumper.cc
		## logging/apm_data_dumper.h
		##include/mock_audio_processing.h
		##
		##
		### aec_dump
		##aec_dump/aec_dump_factory.h
		##aec_dump/null_aec_dump_factory.cc
		##  aec_dump/aec_dump_impl.cc
		##  aec_dump/aec_dump_impl.h
		##  aec_dump/capture_stream_info.cc
		##  aec_dump/capture_stream_info.h
		##  aec_dump/write_to_file_task.cc
		##  aec_dump/write_to_file_task.h
		## 
		## #aec3
		##aec3/adaptive_fir_filter.cc
		## aec3/adaptive_fir_filter_erl.cc
		## aec3/aec3_common.cc
		## aec3/aec3_fft.cc
		## aec3/aec_state.cc
		## aec3/aec_state.h
		## aec3/alignment_mixer.cc
		## aec3/alignment_mixer.h
		## aec3/api_call_jitter_metrics.cc
		## aec3/api_call_jitter_metrics.h
		## aec3/block_buffer.cc
		## aec3/block_delay_buffer.cc
		## aec3/block_delay_buffer.h
		## aec3/block_framer.cc
		## aec3/block_framer.h
		## aec3/block_processor.cc
		## aec3/block_processor.h
		## aec3/block_processor_metrics.cc
		## aec3/block_processor_metrics.h
		## aec3/clockdrift_detector.cc
		## aec3/clockdrift_detector.h
		## aec3/coarse_filter_update_gain.cc
		## aec3/coarse_filter_update_gain.h
		## aec3/comfort_noise_generator.cc
		## aec3/comfort_noise_generator.h
		## aec3/decimator.cc
		## aec3/decimator.h
		## aec3/delay_estimate.h
		## aec3/dominant_nearend_detector.cc
		## aec3/dominant_nearend_detector.h
		## aec3/downsampled_render_buffer.cc
		## aec3/downsampled_render_buffer.h
		## aec3/echo_audibility.cc
		## aec3/echo_audibility.h
		## aec3/echo_canceller3.cc
		## aec3/echo_canceller3.h
		## aec3/echo_path_delay_estimator.cc
		## aec3/echo_path_delay_estimator.h
		## aec3/echo_path_variability.cc
		## aec3/echo_path_variability.h
		## aec3/echo_remover.cc
		## aec3/echo_remover.h
		## aec3/echo_remover_metrics.cc
		## aec3/echo_remover_metrics.h
		## aec3/erl_estimator.cc
		## aec3/erl_estimator.h
		## aec3/erle_estimator.cc
		## aec3/erle_estimator.h
		## aec3/fft_buffer.cc
		## aec3/filter_analyzer.cc
		## aec3/filter_analyzer.h
		## aec3/frame_blocker.cc
		## aec3/frame_blocker.h
		## aec3/fullband_erle_estimator.cc
		## aec3/fullband_erle_estimator.h
		## aec3/matched_filter.cc
		## aec3/matched_filter_lag_aggregator.cc
		## aec3/matched_filter_lag_aggregator.h
		## aec3/moving_average.cc
		## aec3/moving_average.h
		## aec3/nearend_detector.h
		## aec3/refined_filter_update_gain.cc
		## aec3/refined_filter_update_gain.h
		## aec3/render_buffer.cc
		## aec3/render_delay_buffer.cc
		## aec3/render_delay_buffer.h
		## aec3/render_delay_controller.cc
		## aec3/render_delay_controller.h
		## aec3/render_delay_controller_metrics.cc
		## aec3/render_delay_controller_metrics.h
		## aec3/render_signal_analyzer.cc
		## aec3/render_signal_analyzer.h
		## aec3/residual_echo_estimator.cc
		## aec3/residual_echo_estimator.h
		## aec3/reverb_decay_estimator.cc
		## aec3/reverb_decay_estimator.h
		## aec3/reverb_frequency_response.cc
		## aec3/reverb_frequency_response.h
		## aec3/reverb_model.cc
		## aec3/reverb_model.h
		## aec3/reverb_model_estimator.cc
		## aec3/reverb_model_estimator.h
		## aec3/signal_dependent_erle_estimator.cc
		## aec3/signal_dependent_erle_estimator.h
		## aec3/spectrum_buffer.cc
		## aec3/stationarity_estimator.cc
		## aec3/stationarity_estimator.h
		## aec3/subband_erle_estimator.cc
		## aec3/subband_erle_estimator.h
		## aec3/subband_nearend_detector.cc
		## aec3/subband_nearend_detector.h
		## aec3/subtractor.cc
		## aec3/subtractor.h
		## aec3/subtractor_output.cc
		## aec3/subtractor_output.h
		## aec3/subtractor_output_analyzer.cc
		## aec3/subtractor_output_analyzer.h
		## aec3/suppression_filter.cc
		## aec3/suppression_filter.h
		## aec3/suppression_gain.cc
		## aec3/suppression_gain.h
		## aec3/transparent_mode.cc
		## aec3/transparent_mode.h
		## 
		##aec3/aec3_common.h
		##aec3/aec3_fft.h
		##aec3/block_buffer.h
		## aec3/fft_buffer.h
		## aec3/render_buffer.h
		## aec3/spectrum_buffer.h 
		##aec3/adaptive_fir_filter.h 
		##aec3/adaptive_fir_filter_erl.h
		##aec3/matched_filter.h
		##aec3/vector_math.h
		##aec3/fft_data.h
		##aec3/adaptive_fir_filter_avx2.cc
		## aec3/adaptive_fir_filter_erl_avx2.cc
		## aec3/fft_data_avx2.cc
		## aec3/matched_filter_avx2.cc
		## aec3/vector_math_avx2.cc
		##  #cflags = [ "/arch:AVX2" ]
		##  
		##  
		##  
		##  
		##  #aecm
		##aecm/aecm_core.cc
		## aecm/aecm_core.h
		## aecm/aecm_defines.h
		## aecm/echo_control_mobile.cc
		## aecm/echo_control_mobile.h
		##aecm/aecm_core_neon.cc
		##aecm/aecm_core_c.cc   
	  
	  
	  
FILE(GLOB  audio_processing_source

		audio_buffer.cc
		audio_buffer.h	  

		audio_processing_builder_impl.cc
		audio_processing_impl.cc
		audio_processing_impl.h
		capture_levels_adjuster/
		common.h
		echo_control_mobile_impl.cc
		echo_control_mobile_impl.h
		echo_detector/
		gain_control_impl.cc
		gain_control_impl.h
		gain_controller2.cc
		gain_controller2.h
		high_pass_filter.cc
		high_pass_filter.h 
		level_estimator.cc
		level_estimator.h 
		optionally_built_submodule_creators.cc
		optionally_built_submodule_creators.h
		render_queue_item_verifier.h
		residual_echo_detector.cc
		residual_echo_detector.h
		rms_level.cc
		rms_level.h
		splitting_filter.cc
		splitting_filter.h
		three_band_filter_bank.cc
		three_band_filter_bank.h 
		voice_detection.cc
		voice_detection.h
		include/audio_frame_proxies.cc
		include/audio_frame_proxies.h
		include/audio_frame_view.h
		include/audio_processing.cc
		include/audio_processing.h
		include/audio_processing_statistics.cc
		include/audio_processing_statistics.h
		include/mock_audio_processing.h

		aes3/adaptive_fir_filter_avx2.cc
		aes3/adaptive_fir_filter.cc
		aes3/adaptive_fir_filter_erl_avx2.cc
		aes3/adaptive_fir_filter_erl.cc
		aes3/adaptive_fir_filter_erl.h
		aes3/adaptive_fir_filter.h
		aes3/aec3_common.cc
		aes3/aec3_common.h
		aes3/aec3_fft.cc
		aes3/aec3_fft.h
		aes3/aec_state.cc
		aes3/aec_state.h
		aes3/alignment_mixer.cc
		aes3/alignment_mixer.h
		aes3/api_call_jitter_metrics.cc
		aes3/api_call_jitter_metrics.h
		aes3/block_buffer.cc
		aes3/block_buffer.h
		aes3/block_delay_buffer.cc
		aes3/block_delay_buffer.h
		aes3/block_framer.cc
		aes3/block_framer.h
		aes3/block_processor.cc
		aes3/block_processor.h
		aes3/block_processor_metrics.cc
		aes3/block_processor_metrics.h
		aes3/clockdrift_detector.cc
		aes3/clockdrift_detector.h
		aes3/coarse_filter_update_gain.cc
		aes3/coarse_filter_update_gain.h
		aes3/comfort_noise_generator.cc
		aes3/comfort_noise_generator.h
		aes3/decimator.cc
		aes3/decimator.h
		aes3/delay_estimate.h
		aes3/dominant_nearend_detector.cc
		aes3/dominant_nearend_detector.h
		aes3/downsampled_render_buffer.cc
		aes3/downsampled_render_buffer.h
		aes3/echo_audibility.cc
		aes3/echo_audibility.h
		aes3/echo_canceller3.cc
		aes3/echo_canceller3.h
		aes3/echo_path_delay_estimator.cc
		aes3/echo_path_delay_estimator.h
		aes3/echo_path_variability.cc
		aes3/echo_path_variability.h
		aes3/echo_remover.cc
		aes3/echo_remover.h
		aes3/echo_remover_metrics.cc
		aes3/echo_remover_metrics.h
		aes3/erle_estimator.cc
		aes3/erle_estimator.h
		aes3/erl_estimator.cc
		aes3/erl_estimator.h
		aes3/fft_buffer.cc
		aes3/fft_buffer.h
		aes3/fft_data_avx2.cc
		aes3/fft_data.h
		aes3/filter_analyzer.cc
		aes3/filter_analyzer.h
		aes3/frame_blocker.cc
		aes3/frame_blocker.h
		aes3/fullband_erle_estimator.cc
		aes3/fullband_erle_estimator.h
		aes3/matched_filter_avx2.cc
		aes3/matched_filter.cc
		aes3/matched_filter.h
		aes3/matched_filter_lag_aggregator.cc
		aes3/matched_filter_lag_aggregator.h

		aes3/mock/mock_block_processor.cc
		aes3/mock/mock_block_processor.h
		aes3/mock/mock_echo_remover.cc
		aes3/mock/mock_echo_remover.h
		aes3/mock/mock_render_delay_buffer.cc
		aes3/mock/mock_render_delay_buffer.h
		aes3/mock/mock_render_delay_controller.cc
		aes3/mock/mock_render_delay_controller.h
		aes3/moving_average.cc
		aes3/moving_average.h
		aes3/nearend_detector.h
		aes3/refined_filter_update_gain.cc
		aes3/refined_filter_update_gain.h
		aes3/render_buffer.cc
		aes3/render_buffer.h
		aes3/render_delay_buffer.cc
		aes3/render_delay_buffer.h
		aes3/render_delay_controller.cc
		aes3/render_delay_controller.h
		aes3/render_delay_controller_metrics.cc
		aes3/render_delay_controller_metrics.h
		aes3/render_signal_analyzer.cc
		aes3/render_signal_analyzer.h
		aes3/residual_echo_estimator.cc
		aes3/residual_echo_estimator.h
		aes3/reverb_decay_estimator.cc
		aes3/reverb_decay_estimator.h
		aes3/reverb_frequency_response.cc
		aes3/reverb_frequency_response.h
		aes3/reverb_model.cc
		aes3/reverb_model_estimator.cc
		aes3/reverb_model_estimator.h
		aes3/reverb_model.h
		aes3/signal_dependent_erle_estimator.cc
		aes3/signal_dependent_erle_estimator.h
		aes3/spectrum_buffer.cc
		aes3/spectrum_buffer.h
		aes3/stationarity_estimator.cc
		aes3/stationarity_estimator.h
		aes3/subband_erle_estimator.cc
		aes3/subband_erle_estimator.h
		aes3/subband_nearend_detector.cc
		aes3/subband_nearend_detector.h
		aes3/subtractor.cc
		aes3/subtractor.h
		aes3/subtractor_output_analyzer.cc
		aes3/subtractor_output_analyzer.h
		aes3/subtractor_output.cc
		aes3/subtractor_output.h
		aes3/suppression_filter.cc
		aes3/suppression_filter.h
		aes3/suppression_gain.cc
		aes3/suppression_gain.h
		aes3/transparent_mode.cc
		aes3/transparent_mode.h
		aes3/vector_math_avx2.cc
		aes3/vector_math.h


		aecm/aecm_core.cc
		aecm/aecm_core_c.cc
		aecm/aecm_core.h
		aecm/aecm_defines.h
		aecm/echo_control_mobile.cc
		aecm/echo_control_mobile.h

		aec_dump/aec_dump_factory.h
		aec_dump/aec_dump_impl.cc
		aec_dump/aec_dump_impl.h
		aec_dump/capture_stream_info.cc
		aec_dump/capture_stream_info.h
		aec_dump/null_aec_dump_factory.cc
		aec_dump/write_to_file_task.cc
		aec_dump/write_to_file_task.h

		agc/agc.cc
		agc/agc.h
		agc/agc_manager_direct.cc
		agc/agc_manager_direct.h
		agc/clipping_predictor.cc
		agc/clipping_predictor_evaluator.cc
		agc/clipping_predictor_evaluator.h
		agc/clipping_predictor.h
		agc/clipping_predictor_level_buffer.cc
		agc/clipping_predictor_level_buffer.h
		agc/gain_control.h
		agc/gain_map_internal.h
 
		agc/egacy/analog_agc.cc
		agc/egacy/analog_agc.h
		agc/egacy/digital_agc.cc
		agc/egacy/digital_agc.h
		agc/egacy/gain_control.h
		agc/loudness_histogram.cc
		agc/loudness_histogram.h
		agc/mock_agc.h
		agc/utility.cc
		agc/utility.h
 

		agc2/adaptive_agc.cc
		agc2/adaptive_agc.h
		agc2/adaptive_digital_gain_applier.cc
		agc2/adaptive_digital_gain_applier.h
		agc2/adaptive_mode_level_estimator.cc
		agc2/adaptive_mode_level_estimator.h
		agc2/agc2_common.h
		agc2/agc2_testing_common.cc
		agc2/agc2_testing_common.h
		agc2/biquad_filter.cc
		agc2/biquad_filter.h
		agc2/compute_interpolated_gain_curve.cc
		agc2/compute_interpolated_gain_curve.h
		agc2/cpu_features.cc
		agc2/cpu_features.h
		agc2/fixed_digital_level_estimator.cc
		agc2/fixed_digital_level_estimator.h
		agc2/gain_applier.cc
		agc2/gain_applier.h
		agc2/interpolated_gain_curve.cc
		agc2/interpolated_gain_curve.h
		agc2/limiter.cc
		agc2/limiter_db_gain_curve.cc
		agc2/limiter_db_gain_curve.h
		agc2/limiter.h
		agc2/noise_level_estimator.cc
		agc2/noise_level_estimator.h
 
		agc2/rnn_vad/auto_correlation.cc
		agc2/rnn_vad/auto_correlation.h
		agc2/rnn_vad/common.h
		agc2/rnn_vad/DEPS
		agc2/rnn_vad/features_extraction.cc
		agc2/rnn_vad/features_extraction.h
		agc2/rnn_vad/lp_residual.cc
		agc2/rnn_vad/lp_residual.h
		agc2/rnn_vad/pitch_search.cc
		agc2/rnn_vad/pitch_search.h
		agc2/rnn_vad/pitch_search_internal.cc
		agc2/rnn_vad/pitch_search_internal.h
		agc2/rnn_vad/ring_buffer.h
		agc2/rnn_vad/rnn.cc
		agc2/rnn_vad/rnn_fc.cc
		agc2/rnn_vad/rnn_fc.h
		agc2/rnn_vad/rnn_gru.cc
		agc2/rnn_vad/rnn_gru.h
		agc2/rnn_vad/rnn.h
		agc2/rnn_vad/rnn_vad_tool.cc
		agc2/rnn_vad/sequence_buffer.h
		agc2/rnn_vad/spectral_features.cc
		agc2/rnn_vad/spectral_features.h
		agc2/rnn_vad/spectral_features_internal.cc
		agc2/rnn_vad/spectral_features_internal.h
		agc2/rnn_vad/symmetric_matrix_buffer.h
		agc2/rnn_vad/vector_math_avx2.cc
		agc2/rnn_vad/vector_math.h
		agc2/saturation_protector_buffer.cc
		agc2/saturation_protector_buffer.h
		agc2/saturation_protector.cc
		agc2/saturation_protector.h
		agc2/vad_with_level.cc
		agc2/vad_with_level.h
		agc2/vector_float_frame.cc
		agc2/vector_float_frame.h




		vad/common.h
		vad/gmm.cc
		vad/gmm.h
		vad/noise_gmm_tables.h
		vad/pitch_based_vad.cc
		vad/pitch_based_vad.h
		vad/pitch_internal.cc
		vad/pitch_internal.h
		vad/pole_zero_filter.cc
		vad/pole_zero_filter.h
		vad/standalone_vad.cc
		vad/standalone_vad.h
		vad/vad_audio_proc.cc
		vad/vad_audio_proc.h
		vad/vad_audio_proc_internal.h
		vad/vad_circular_buffer.cc
		vad/vad_circular_buffer.h
		vad/voice_activity_detector.cc
		vad/voice_activity_detector.h
		vad/voice_gmm_tables.h




		ns/fast_math.cc
		ns/fast_math.h
		ns/histograms.cc
		ns/histograms.h
		ns/noise_estimator.cc
		ns/noise_estimator.h
		ns/noise_suppressor.cc
		ns/noise_suppressor.h
		ns/ns_common.h
		ns/ns_config.h
		ns/ns_fft.cc
		ns/ns_fft.h
		ns/prior_signal_model.cc
		ns/prior_signal_model_estimator.cc
		ns/prior_signal_model_estimator.h
		ns/prior_signal_model.h
		ns/quantile_noise_estimator.cc
		ns/quantile_noise_estimator.h
		ns/signal_model.cc
		ns/signal_model_estimator.cc
		ns/signal_model_estimator.h
		ns/signal_model.h
		ns/speech_probability_estimator.cc
		ns/speech_probability_estimator.h
		ns/suppression_params.cc
		ns/suppression_params.h
		ns/wiener_filter.cc
		ns/wiener_filter.h



		transient/click_annotate.cc
		transient/common.h
		transient/daubechies_8_wavelet_coeffs.h
		transient/dyadic_decimator.h
		transient/file_utils.cc
		transient/file_utils.h
		transient/moving_moments.cc
		transient/moving_moments.h 
		transient/transient_detector.cc
		transient/transient_detector.h
		transient/transient_suppressor.h
		transient/transient_suppressor_impl.cc
		transient/transient_suppressor_impl.h
		transient/windows_private.h
		transient/wpd_node.cc
		transient/wpd_node.h
		transient/wpd_tree.cc
		transient/wpd_tree.h


		capture_levels_adjuster/audio_samples_scaler.cc
		capture_levels_adjuster/audio_samples_scaler.h
		capture_levels_adjuster/capture_levels_adjuster.cc
		capture_levels_adjuster/capture_levels_adjuster.h

 

		utility/cascaded_biquad_filter.cc
		utility/cascaded_biquad_filter.h
		utility/delay_estimator.cc
		utility/delay_estimator.h
		utility/delay_estimator_internal.h
		utility/delay_estimator_wrapper.cc
		utility/delay_estimator_wrapper.h
		 
		utility/pffft_wrapper.cc
		utility/pffft_wrapper.h


		logging/apm_data_dumper.h
		logging/apm_data_dumper.cc 
		 

		echo_detector/circular_buffer.cc
		echo_detector/circular_buffer.h
		echo_detector/mean_variance_estimator.cc
		echo_detector/mean_variance_estimator.h
		echo_detector/moving_max.cc
		echo_detector/moving_max.h
		echo_detector/normalized_covariance_estimator.cc
		echo_detector/normalized_covariance_estimator.h
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
)

 
add_library(${PROJECT_NAME} 			 STATIC      ${audio_processing_source})
#add_library(desktop_capture_mock STATIC ${audio_device_api_source})

 set_target_properties(${PROJECT_NAME}      			      					PROPERTIES LINKER_LANGUAGE CXX)  
#add_library(desktop_capture_differ_sse2 STATIC  ${desktop_capture_differ_sse2_source})

#add_library(screen_drawer  STATIC  ${screen_drawer_source})

set(AllFile



${audio_processing_source} 	 					

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



#set_property(TARGET  desktop_capture_mock PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})


#set_property(TARGET audio_device_api  				PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})  
set_property(TARGET       ${PROJECT_NAME}                                                              PROPERTY FOLDER  ${LIWEBRTC_IDE_FOLDER}/modules)



#set_property(TARGET  desktop_capture_differ_sse2   PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})

#set_property(TARGET  screen_drawer    PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
