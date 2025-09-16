cmake_minimum_required (VERSION 3.5)

project(libwebrtc)

 include_directories(
       ./
	   ../
       ../third_party/abseil-cpp/
	   ../third_party/libyuv/include 
 )

 message(status   "-libwebrtc--> ${PROJECT_SOURCE_DIR}")

# link_directories(
#     "${PROJECT_SOURCE_DIR}/third_party/lib"
# )

# add_definitions("-g -pipe -W -Wall -fPIC -std=gnu++14 -DWEBRTC_POSIX
#     -DWEBRTC_LINUX -DNDEBUG -Wno-unused-parameter")

# add_definitions("-g -pipe -W -Wall -fPIC -std=gnu++14 
#     -DWEBRTC_POSIX
#     -DWEBRTC_LINUX 
#     -DNDEBUG -Wno-unused-parameter")


FILE(GLOB   api

	api/array_view.h
	api/function_view.h
	api/media_types.cc
	api/media_types.h
	api/priority.h
	api/ref_counted_base.h
	api/rtp_headers.cc
	api/rtp_headers.h
	api/rtp_packet_info.cc
	api/rtp_packet_info.h
	api/rtp_packet_infos (2).h
	api/rtp_packet_infos.h
	api/rtp_parameters.cc
	api/rtp_parameters.h
	api/rtp_transceiver_direction.h
	api/scoped_refptr.h
	api/sequence_checker.h
	api/stats_types.cc
	api/stats_types.h
	api/audio/audio_frame.cc
	api/audio/audio_frame.h
	api/audio/audio_frame_processor.h
	api/audio/audio_mixer.h
	api/audio/channel_layout.cc
	api/audio/channel_layout.h
	api/audio/echo_canceller3_config.cc
	api/audio/echo_canceller3_config.h
	api/audio/echo_canceller3_config_json.cc
	api/audio/echo_canceller3_config_json.h
	api/audio/echo_canceller3_factory.cc
	api/audio/echo_canceller3_factory.h
	api/audio/echo_control.h
	api/audio/echo_detector_creator.cc
	api/audio/echo_detector_creator.h
	api/audio_codecs/audio_format.cc
	api/audio_codecs/audio_format.h
	api/crypto/crypto_options.cc
	api/crypto/crypto_options.h
	#api/task_queue/default_task_queue_factory.h
	#api/task_queue/default_task_queue_factory_stdlib.cc
	#api/task_queue/default_task_queue_factory_win.cc
	api/task_queue/queued_task.h
	api/task_queue/task_queue_base.cc
	api/task_queue/task_queue_base.h
	api/task_queue/task_queue_factory.h
	api/transport/network_types.cc
	api/transport/network_types.h
	api/transport/rtp/dependency_descriptor.cc
	api/transport/rtp/dependency_descriptor.h
	api/transport/stun.cc
	api/transport/stun.h
	api/transport/webrtc_key_value_config.h
	api/units/data_rate.cc
	api/units/data_rate.h
	api/units/data_size.cc
	api/units/data_size.h
	api/units/frequency.cc
	api/units/frequency.h
	api/units/time_delta.cc
	api/units/time_delta.h
	api/units/timestamp.cc
	api/units/timestamp.h
	api/video/color_space.cc
	api/video/color_space.h
	api/video/hdr_metadata.cc
	api/video/hdr_metadata.h
	api/video/i420_buffer.cc
	api/video/i420_buffer.h
	api/video/nv12_buffer.cc
	api/video/nv12_buffer.h
	api/video/render_resolution.h
	api/video/video_codec_type.h
	api/video/video_content_type.cc
	api/video/video_content_type.h
	api/video/video_frame_buffer.cc
	api/video/video_frame_buffer.h
	api/video/video_frame.cc
	api/video/video_frame.h
	api/video/video_frame_type.h
	api/video/video_layers_allocation.h
	api/video/video_rotation.h
	api/video/video_sink_interface.h
	api/video/video_timing.cc
	api/video/video_timing.h
	api/video_codecs/bitstream_parser.h
)



FILE(GLOB signal_processing 
	
		common_audio/signal_processin/include/real_fft.h
		common_audio/signal_processin/include/signal_processing_library.h
		common_audio/signal_processin/include/spl_inl.h
		common_audio/signal_processin/include/spl_inl_armv7.h
		common_audio/signal_processin/include/spl_inl_mips.h
	    




		common_audio/signal_processing/complex_bit_reverse.c
		common_audio/signal_processing/complex_fft.c
		common_audio/signal_processing/complex_fft_tables.h
		common_audio/signal_processing/copy_set_operations.c
		common_audio/signal_processing/cross_correlation.c
		common_audio/signal_processing/division_operations.c
		common_audio/signal_processing/dot_product_with_scale.cc
		common_audio/signal_processing/dot_product_with_scale.h
		common_audio/signal_processing/downsample_fast.c
		common_audio/signal_processing/energy.c
		common_audio/signal_processing/get_scaling_square.c
		common_audio/signal_processing/min_max_operations.c
		common_audio/signal_processing/randomization_functions.c
		common_audio/signal_processing/real_fft.c
		common_audio/signal_processing/resample.c
		common_audio/signal_processing/resample_48khz.c
		common_audio/signal_processing/resample_by_2.c
		common_audio/signal_processing/resample_by_2_internal.c
		common_audio/signal_processing/resample_by_2_internal.h
		common_audio/signal_processing/resample_fractional.c
		common_audio/signal_processing/splitting_filter.c
		common_audio/signal_processing/spl_init.c
		common_audio/signal_processing/spl_inl.c
		common_audio/signal_processing/spl_sqrt.c
		common_audio/signal_processing/sqrt_of_one_minus_x_squared.c
		common_audio/signal_processing/vector_scaling_operations.c

)


FILE(GLOB  spl_sqrt_floor  



	common_audio/third_party/spl_sqrt_floor/spl_sqrt_floor.h

	common_audio/third_party/spl_sqrt_floor/spl_sqrt_floor.c
	common_audio/third_party/spl_sqrt_floor/spl_sqrt_floor.S
	
)


FILE(GLOB   ooura  

		common_audio/third_party/ooura/fft_size_128/ooura_fft.h
		common_audio/third_party/ooura/fft_size_128/ooura_fft.cc
		common_audio/third_party/ooura/fft_size_128/ooura_fft_mips.cc
		common_audio/third_party/ooura/fft_size_128/ooura_fft_sse2.cc
		common_audio/third_party/ooura/fft_size_128/ooura_fft_tables_common.h
		common_audio/third_party/ooura/fft_size_128/ooura_fft_tables_neon_sse2.h
		common_audio/third_party/ooura/fft_size_256/fft4g.cc
		common_audio/third_party/ooura/fft_size_256/fft4g.cc
)


FILE(GLOB common_audio
	common_audio/include/audio_util.h
	common_audio/audio_converter.cc
	common_audio/audio_converter.h
	common_audio/audio_util.cc
	common_audio/channel_buffer.cc
	common_audio/channel_buffer.h
	common_audio/fir_filter.h
	common_audio/fir_filter_avx2.cc
	common_audio/fir_filter_avx2.h
	common_audio/fir_filter_c.cc
	common_audio/fir_filter_c.h
	common_audio/fir_filter_factory.cc
	common_audio/fir_filter_factory.h
	common_audio/fir_filter_sse.cc
	common_audio/fir_filter_sse.h
	common_audio/ring_buffer.c
	common_audio/ring_buffer.h
	common_audio/wav_file.cc
	common_audio/wav_file.h
	common_audio/wav_header.cc
	common_audio/wav_header.h

)

FILE(GLOB  resampler
	

	common_audio/resampler/include/resampler.h   
	common_audio/resampler/include/push_resampler.h
	common_audio/resampler/push_resampler.cc
	common_audio/resampler/push_sinc_resampler.cc
	common_audio/resampler/push_sinc_resampler.h
	common_audio/resampler/resampler.cc
	common_audio/resampler/sinc_resampler.cc
	common_audio/resampler/sinc_resampler.h
	common_audio/resampler/sinc_resampler_avx2.cc
	common_audio/resampler/sinc_resampler_sse.cc
	common_audio/resampler/sinusoidal_linear_chirp_source.cc
	common_audio/resampler/sinusoidal_linear_chirp_source.h
)




FILE(GLOB  vad


		common_audio/resampler/vad/include/vad.h
		common_audio/resampler/vad/include/webrtc_vad.h
		common_audio/resampler/vad/mock/mock_vad.h 


		common_audio/resampler/vad/vad.cc
		common_audio/resampler/vad/vad_core.c
		common_audio/resampler/vad/vad_core.h
		common_audio/resampler/vad/vad_filterbank.c
		common_audio/resampler/vad/vad_filterbank.h
		common_audio/resampler/vad/vad_gmm.c
		common_audio/resampler/vad/vad_gmm.h
		common_audio/resampler/vad/vad_sp.c
		common_audio/resampler/vad/vad_sp.h
		common_audio/resampler/vad/webrtc_vad.c
	

)



FILE(GLOB  common_video


	common_video/video_frame_buffer.cc
	common_video/h264/h264_bitstream_parser.h
	common_video/h264/h264_bitstream_parser.cc
	common_video/h264/h264_common.cc
	common_video/h264/h264_common.h
	common_video/h264/pps_parser.cc
	common_video/h264/pps_parser.h
	common_video/h264/sps_parser.cc
	common_video/h264/sps_parser.h
	common_video/h264/sps_vui_rewriter.cc
	common_video/h264/sps_vui_rewriter.h


	common_video/include/bitrate_adjuster.h
	common_video/include/incoming_video_stream.h
	common_video/include/quality_limitation_reason.h
	common_video/include/video_frame_buffer.h
	common_video/include/video_frame_buffer_pool.h

	common_video/libyuv/webrtc_libyuv.cc
	common_video/libyuv/include/webrtc_libyuv.h


)

FILE(GLOB  media  

	media/base/rtp_utils.cc
	media/base/rtp_utils.h
	media/base/turn_utils.h
	media/base/turn_utils.cc

)



FILE(GLOB system_wrappers

 
	system_wrappers/include/clock.h
	system_wrappers/include/cpu_features_wrapper.h
	system_wrappers/include/denormal_disabler.h
	system_wrappers/include/field_trial.h
	system_wrappers/include/metrics.h
	system_wrappers/include/ntp_time.h
	system_wrappers/include/sleep.h 
    system_wrappers/source/clock.cc
    system_wrappers/source/cpu_features.cc
    system_wrappers/source/denormal_disabler.cc
    system_wrappers/source/field_trial.cc
    system_wrappers/source/metrics.cc
    system_wrappers/source/sleep.cc
)


FILE(GLOB  audio_coding

		 
     moudules/audio_coding/codecs/isac/main/source/filter_functions.c
     moudules/audio_coding/codecs/isac/main/source/filter_functions.h
     moudules/audio_coding/codecs/isac/main/source/isac_vad.c
     moudules/audio_coding/codecs/isac/main/source/isac_vad.h
     moudules/audio_coding/codecs/isac/main/source/os_specific_inline.h
     moudules/audio_coding/codecs/isac/main/source/pitch_estimator.c
     moudules/audio_coding/codecs/isac/main/source/pitch_estimator.h
     moudules/audio_coding/codecs/isac/main/source/pitch_filter.c
     moudules/audio_coding/codecs/isac/main/source/pitch_filter.h
     moudules/audio_coding/codecs/isac/main/source/settings.h
     moudules/audio_coding/codecs/isac/main/source/structs.h
)


FILE(GLOB  audio_device

				modules/audio_device/audio_device_buffer.cc
				modules/audio_device/audio_device_buffer.h
				modules/audio_device/audio_device_config.h
				modules/audio_device/audio_device_data_observer.cc
				modules/audio_device/audio_device_generic.cc
				modules/audio_device/audio_device_generic.h
				modules/audio_device/audio_device_impl.h
				modules/audio_device/audio_device_name.cc
				modules/audio_device/audio_device_name.h
				 
				modules/audio_device/fine_audio_buffer.cc
				modules/audio_device/fine_audio_buffer.h
				 
				modules/audio_device/mock_audio_device_buffer.h
				 
				modules/audio_device/include/audio_device_data_observer.h
				modules/audio_device/include/audio_device_default.h
				modules/audio_device/include/audio_device_defines.h
				modules/audio_device/include/audio_device_factory.cc
				modules/audio_device/include/audio_device_factory.h
				modules/audio_device/include/audio_device.h
				modules/audio_device/include/fake_audio_device.h
				modules/audio_device/include/mock_audio_device.h
				modules/audio_device/include/mock_audio_transport.h
				#modules/audio_device/include/test_audio_device.cc
				#modules/audio_device/include/test_audio_device.h

	
)


FILE(GLOB  audio_processing

	
		modules/audio_processing/audio_buffer.cc
		modules/audio_processing/audio_buffer.h
		modules/audio_processing/audio_processing_builder_impl.cc
		modules/audio_processing/audio_processing_impl.cc
		modules/audio_processing/audio_processing_impl.h
		modules/audio_processing/capture_levels_adjuster/
		modules/audio_processing/common.h
		modules/audio_processing/echo_control_mobile_impl.cc
		modules/audio_processing/echo_control_mobile_impl.h
		modules/audio_processing/echo_detector/
		modules/audio_processing/gain_control_impl.cc
		modules/audio_processing/gain_control_impl.h
		modules/audio_processing/gain_controller2.cc
		modules/audio_processing/gain_controller2.h
		modules/audio_processing/high_pass_filter.cc
		modules/audio_processing/high_pass_filter.h 
		modules/audio_processing/level_estimator.cc
		modules/audio_processing/level_estimator.h 
		modules/audio_processing/optionally_built_submodule_creators.cc
		modules/audio_processing/optionally_built_submodule_creators.h
		modules/audio_processing/render_queue_item_verifier.h
		modules/audio_processing/residual_echo_detector.cc
		modules/audio_processing/residual_echo_detector.h
		modules/audio_processing/rms_level.cc
		modules/audio_processing/rms_level.h
		modules/audio_processing/splitting_filter.cc
		modules/audio_processing/splitting_filter.h
		modules/audio_processing/three_band_filter_bank.cc
		modules/audio_processing/three_band_filter_bank.h 
		modules/audio_processing/voice_detection.cc
		modules/audio_processing/voice_detection.h
		modules/audio_processing/include/audio_frame_proxies.cc
		modules/audio_processing/include/audio_frame_proxies.h
		modules/audio_processing/include/audio_frame_view.h
		modules/audio_processing/include/audio_processing.cc
		modules/audio_processing/include/audio_processing.h
		modules/audio_processing/include/audio_processing_statistics.cc
		modules/audio_processing/include/audio_processing_statistics.h
		modules/audio_processing/include/mock_audio_processing.h
		
modules/audio_processing/aes3/adaptive_fir_filter_avx2.cc
modules/audio_processing/aes3/adaptive_fir_filter.cc
modules/audio_processing/aes3/adaptive_fir_filter_erl_avx2.cc
modules/audio_processing/aes3/adaptive_fir_filter_erl.cc
modules/audio_processing/aes3/adaptive_fir_filter_erl.h
modules/audio_processing/aes3/adaptive_fir_filter.h
modules/audio_processing/aes3/aec3_common.cc
modules/audio_processing/aes3/aec3_common.h
modules/audio_processing/aes3/aec3_fft.cc
modules/audio_processing/aes3/aec3_fft.h
modules/audio_processing/aes3/aec_state.cc
modules/audio_processing/aes3/aec_state.h
modules/audio_processing/aes3/alignment_mixer.cc
modules/audio_processing/aes3/alignment_mixer.h
modules/audio_processing/aes3/api_call_jitter_metrics.cc
modules/audio_processing/aes3/api_call_jitter_metrics.h
modules/audio_processing/aes3/block_buffer.cc
modules/audio_processing/aes3/block_buffer.h
modules/audio_processing/aes3/block_delay_buffer.cc
modules/audio_processing/aes3/block_delay_buffer.h
modules/audio_processing/aes3/block_framer.cc
modules/audio_processing/aes3/block_framer.h
modules/audio_processing/aes3/block_processor.cc
modules/audio_processing/aes3/block_processor.h
modules/audio_processing/aes3/block_processor_metrics.cc
modules/audio_processing/aes3/block_processor_metrics.h
modules/audio_processing/aes3/clockdrift_detector.cc
modules/audio_processing/aes3/clockdrift_detector.h
modules/audio_processing/aes3/coarse_filter_update_gain.cc
modules/audio_processing/aes3/coarse_filter_update_gain.h
modules/audio_processing/aes3/comfort_noise_generator.cc
modules/audio_processing/aes3/comfort_noise_generator.h
modules/audio_processing/aes3/decimator.cc
modules/audio_processing/aes3/decimator.h
modules/audio_processing/aes3/delay_estimate.h
modules/audio_processing/aes3/dominant_nearend_detector.cc
modules/audio_processing/aes3/dominant_nearend_detector.h
modules/audio_processing/aes3/downsampled_render_buffer.cc
modules/audio_processing/aes3/downsampled_render_buffer.h
modules/audio_processing/aes3/echo_audibility.cc
modules/audio_processing/aes3/echo_audibility.h
modules/audio_processing/aes3/echo_canceller3.cc
modules/audio_processing/aes3/echo_canceller3.h
modules/audio_processing/aes3/echo_path_delay_estimator.cc
modules/audio_processing/aes3/echo_path_delay_estimator.h
modules/audio_processing/aes3/echo_path_variability.cc
modules/audio_processing/aes3/echo_path_variability.h
modules/audio_processing/aes3/echo_remover.cc
modules/audio_processing/aes3/echo_remover.h
modules/audio_processing/aes3/echo_remover_metrics.cc
modules/audio_processing/aes3/echo_remover_metrics.h
modules/audio_processing/aes3/erle_estimator.cc
modules/audio_processing/aes3/erle_estimator.h
modules/audio_processing/aes3/erl_estimator.cc
modules/audio_processing/aes3/erl_estimator.h
modules/audio_processing/aes3/fft_buffer.cc
modules/audio_processing/aes3/fft_buffer.h
modules/audio_processing/aes3/fft_data_avx2.cc
modules/audio_processing/aes3/fft_data.h
modules/audio_processing/aes3/filter_analyzer.cc
modules/audio_processing/aes3/filter_analyzer.h
modules/audio_processing/aes3/frame_blocker.cc
modules/audio_processing/aes3/frame_blocker.h
modules/audio_processing/aes3/fullband_erle_estimator.cc
modules/audio_processing/aes3/fullband_erle_estimator.h
modules/audio_processing/aes3/matched_filter_avx2.cc
modules/audio_processing/aes3/matched_filter.cc
modules/audio_processing/aes3/matched_filter.h
modules/audio_processing/aes3/matched_filter_lag_aggregator.cc
modules/audio_processing/aes3/matched_filter_lag_aggregator.h

modules/audio_processing/aes3/mock/mock_block_processor.cc
modules/audio_processing/aes3/mock/mock_block_processor.h
modules/audio_processing/aes3/mock/mock_echo_remover.cc
modules/audio_processing/aes3/mock/mock_echo_remover.h
modules/audio_processing/aes3/mock/mock_render_delay_buffer.cc
modules/audio_processing/aes3/mock/mock_render_delay_buffer.h
modules/audio_processing/aes3/mock/mock_render_delay_controller.cc
modules/audio_processing/aes3/mock/mock_render_delay_controller.h
modules/audio_processing/aes3/moving_average.cc
modules/audio_processing/aes3/moving_average.h
modules/audio_processing/aes3/nearend_detector.h
modules/audio_processing/aes3/refined_filter_update_gain.cc
modules/audio_processing/aes3/refined_filter_update_gain.h
modules/audio_processing/aes3/render_buffer.cc
modules/audio_processing/aes3/render_buffer.h
modules/audio_processing/aes3/render_delay_buffer.cc
modules/audio_processing/aes3/render_delay_buffer.h
modules/audio_processing/aes3/render_delay_controller.cc
modules/audio_processing/aes3/render_delay_controller.h
modules/audio_processing/aes3/render_delay_controller_metrics.cc
modules/audio_processing/aes3/render_delay_controller_metrics.h
modules/audio_processing/aes3/render_signal_analyzer.cc
modules/audio_processing/aes3/render_signal_analyzer.h
modules/audio_processing/aes3/residual_echo_estimator.cc
modules/audio_processing/aes3/residual_echo_estimator.h
modules/audio_processing/aes3/reverb_decay_estimator.cc
modules/audio_processing/aes3/reverb_decay_estimator.h
modules/audio_processing/aes3/reverb_frequency_response.cc
modules/audio_processing/aes3/reverb_frequency_response.h
modules/audio_processing/aes3/reverb_model.cc
modules/audio_processing/aes3/reverb_model_estimator.cc
modules/audio_processing/aes3/reverb_model_estimator.h
modules/audio_processing/aes3/reverb_model.h
modules/audio_processing/aes3/signal_dependent_erle_estimator.cc
modules/audio_processing/aes3/signal_dependent_erle_estimator.h
modules/audio_processing/aes3/spectrum_buffer.cc
modules/audio_processing/aes3/spectrum_buffer.h
modules/audio_processing/aes3/stationarity_estimator.cc
modules/audio_processing/aes3/stationarity_estimator.h
modules/audio_processing/aes3/subband_erle_estimator.cc
modules/audio_processing/aes3/subband_erle_estimator.h
modules/audio_processing/aes3/subband_nearend_detector.cc
modules/audio_processing/aes3/subband_nearend_detector.h
modules/audio_processing/aes3/subtractor.cc
modules/audio_processing/aes3/subtractor.h
modules/audio_processing/aes3/subtractor_output_analyzer.cc
modules/audio_processing/aes3/subtractor_output_analyzer.h
modules/audio_processing/aes3/subtractor_output.cc
modules/audio_processing/aes3/subtractor_output.h
modules/audio_processing/aes3/suppression_filter.cc
modules/audio_processing/aes3/suppression_filter.h
modules/audio_processing/aes3/suppression_gain.cc
modules/audio_processing/aes3/suppression_gain.h
modules/audio_processing/aes3/transparent_mode.cc
modules/audio_processing/aes3/transparent_mode.h
modules/audio_processing/aes3/vector_math_avx2.cc
modules/audio_processing/aes3/vector_math.h
		
		
		modules/audio_processing/aecm/aecm_core.cc
	    modules/audio_processing/aecm/aecm_core_c.cc
	    modules/audio_processing/aecm/aecm_core.h
	    modules/audio_processing/aecm/aecm_defines.h
	    modules/audio_processing/aecm/echo_control_mobile.cc
	    modules/audio_processing/aecm/echo_control_mobile.h
		
 modules/audio_processing/aec_dump/aec_dump_factory.h
 modules/audio_processing/aec_dump/aec_dump_impl.cc
 modules/audio_processing/aec_dump/aec_dump_impl.h
 modules/audio_processing/aec_dump/capture_stream_info.cc
 modules/audio_processing/aec_dump/capture_stream_info.h
 modules/audio_processing/aec_dump/null_aec_dump_factory.cc
 modules/audio_processing/aec_dump/write_to_file_task.cc
 modules/audio_processing/aec_dump/write_to_file_task.h
		
modules/audio_processing/agc/agc.cc
modules/audio_processing/agc/agc.h
modules/audio_processing/agc/agc_manager_direct.cc
modules/audio_processing/agc/agc_manager_direct.h
modules/audio_processing/agc/clipping_predictor.cc
modules/audio_processing/agc/clipping_predictor_evaluator.cc
modules/audio_processing/agc/clipping_predictor_evaluator.h
modules/audio_processing/agc/clipping_predictor.h
modules/audio_processing/agc/clipping_predictor_level_buffer.cc
modules/audio_processing/agc/clipping_predictor_level_buffer.h
modules/audio_processing/agc/gain_control.h
modules/audio_processing/agc/gain_map_internal.h
#modules/audio_processing/agc/legacy
modules/audio_processing/agc/egacy/analog_agc.cc
modules/audio_processing/agc/egacy/analog_agc.h
modules/audio_processing/agc/egacy/digital_agc.cc
modules/audio_processing/agc/egacy/digital_agc.h
modules/audio_processing/agc/egacy/gain_control.h
modules/audio_processing/agc/loudness_histogram.cc
modules/audio_processing/agc/loudness_histogram.h
modules/audio_processing/agc/mock_agc.h
modules/audio_processing/agc/utility.cc
modules/audio_processing/agc/utility.h

#modules/audio_processing/agc2/

modules/audio_processing/agc2/adaptive_agc.cc
modules/audio_processing/agc2/adaptive_agc.h
modules/audio_processing/agc2/adaptive_digital_gain_applier.cc
modules/audio_processing/agc2/adaptive_digital_gain_applier.h
modules/audio_processing/agc2/adaptive_mode_level_estimator.cc
modules/audio_processing/agc2/adaptive_mode_level_estimator.h
modules/audio_processing/agc2/agc2_common.h
modules/audio_processing/agc2/agc2_testing_common.cc
modules/audio_processing/agc2/agc2_testing_common.h
modules/audio_processing/agc2/biquad_filter.cc
modules/audio_processing/agc2/biquad_filter.h
modules/audio_processing/agc2/compute_interpolated_gain_curve.cc
modules/audio_processing/agc2/compute_interpolated_gain_curve.h
modules/audio_processing/agc2/cpu_features.cc
modules/audio_processing/agc2/cpu_features.h
modules/audio_processing/agc2/fixed_digital_level_estimator.cc
modules/audio_processing/agc2/fixed_digital_level_estimator.h
modules/audio_processing/agc2/gain_applier.cc
modules/audio_processing/agc2/gain_applier.h
modules/audio_processing/agc2/interpolated_gain_curve.cc
modules/audio_processing/agc2/interpolated_gain_curve.h
modules/audio_processing/agc2/limiter.cc
modules/audio_processing/agc2/limiter_db_gain_curve.cc
modules/audio_processing/agc2/limiter_db_gain_curve.h
modules/audio_processing/agc2/limiter.h
modules/audio_processing/agc2/noise_level_estimator.cc
modules/audio_processing/agc2/noise_level_estimator.h
#modules/audio_processing/agc2/rnn_vad
modules/audio_processing/agc2/rnn_vad/auto_correlation.cc
modules/audio_processing/agc2/rnn_vad/auto_correlation.h
modules/audio_processing/agc2/rnn_vad/common.h
modules/audio_processing/agc2/rnn_vad/DEPS
modules/audio_processing/agc2/rnn_vad/features_extraction.cc
modules/audio_processing/agc2/rnn_vad/features_extraction.h
modules/audio_processing/agc2/rnn_vad/lp_residual.cc
modules/audio_processing/agc2/rnn_vad/lp_residual.h
modules/audio_processing/agc2/rnn_vad/pitch_search.cc
modules/audio_processing/agc2/rnn_vad/pitch_search.h
modules/audio_processing/agc2/rnn_vad/pitch_search_internal.cc
modules/audio_processing/agc2/rnn_vad/pitch_search_internal.h
modules/audio_processing/agc2/rnn_vad/ring_buffer.h
modules/audio_processing/agc2/rnn_vad/rnn.cc
modules/audio_processing/agc2/rnn_vad/rnn_fc.cc
modules/audio_processing/agc2/rnn_vad/rnn_fc.h
modules/audio_processing/agc2/rnn_vad/rnn_gru.cc
modules/audio_processing/agc2/rnn_vad/rnn_gru.h
modules/audio_processing/agc2/rnn_vad/rnn.h
modules/audio_processing/agc2/rnn_vad/rnn_vad_tool.cc
modules/audio_processing/agc2/rnn_vad/sequence_buffer.h
modules/audio_processing/agc2/rnn_vad/spectral_features.cc
modules/audio_processing/agc2/rnn_vad/spectral_features.h
modules/audio_processing/agc2/rnn_vad/spectral_features_internal.cc
modules/audio_processing/agc2/rnn_vad/spectral_features_internal.h
modules/audio_processing/agc2/rnn_vad/symmetric_matrix_buffer.h
modules/audio_processing/agc2/rnn_vad/vector_math_avx2.cc
modules/audio_processing/agc2/rnn_vad/vector_math.h
modules/audio_processing/agc2/saturation_protector_buffer.cc
modules/audio_processing/agc2/saturation_protector_buffer.h
modules/audio_processing/agc2/saturation_protector.cc
modules/audio_processing/agc2/saturation_protector.h
modules/audio_processing/agc2/vad_with_level.cc
modules/audio_processing/agc2/vad_with_level.h
modules/audio_processing/agc2/vector_float_frame.cc
modules/audio_processing/agc2/vector_float_frame.h




modules/audio_processing/vad/common.h
modules/audio_processing/vad/gmm.cc
modules/audio_processing/vad/gmm.h
modules/audio_processing/vad/noise_gmm_tables.h
modules/audio_processing/vad/pitch_based_vad.cc
modules/audio_processing/vad/pitch_based_vad.h
modules/audio_processing/vad/pitch_internal.cc
modules/audio_processing/vad/pitch_internal.h
modules/audio_processing/vad/pole_zero_filter.cc
modules/audio_processing/vad/pole_zero_filter.h
modules/audio_processing/vad/standalone_vad.cc
modules/audio_processing/vad/standalone_vad.h
modules/audio_processing/vad/vad_audio_proc.cc
modules/audio_processing/vad/vad_audio_proc.h
modules/audio_processing/vad/vad_audio_proc_internal.h
modules/audio_processing/vad/vad_circular_buffer.cc
modules/audio_processing/vad/vad_circular_buffer.h
modules/audio_processing/vad/voice_activity_detector.cc
modules/audio_processing/vad/voice_activity_detector.h
modules/audio_processing/vad/voice_gmm_tables.h




modules/audio_processing/ns/fast_math.cc
modules/audio_processing/ns/fast_math.h
modules/audio_processing/ns/histograms.cc
modules/audio_processing/ns/histograms.h
modules/audio_processing/ns/noise_estimator.cc
modules/audio_processing/ns/noise_estimator.h
modules/audio_processing/ns/noise_suppressor.cc
modules/audio_processing/ns/noise_suppressor.h
modules/audio_processing/ns/ns_common.h
modules/audio_processing/ns/ns_config.h
modules/audio_processing/ns/ns_fft.cc
modules/audio_processing/ns/ns_fft.h
modules/audio_processing/ns/prior_signal_model.cc
modules/audio_processing/ns/prior_signal_model_estimator.cc
modules/audio_processing/ns/prior_signal_model_estimator.h
modules/audio_processing/ns/prior_signal_model.h
modules/audio_processing/ns/quantile_noise_estimator.cc
modules/audio_processing/ns/quantile_noise_estimator.h
modules/audio_processing/ns/signal_model.cc
modules/audio_processing/ns/signal_model_estimator.cc
modules/audio_processing/ns/signal_model_estimator.h
modules/audio_processing/ns/signal_model.h
modules/audio_processing/ns/speech_probability_estimator.cc
modules/audio_processing/ns/speech_probability_estimator.h
modules/audio_processing/ns/suppression_params.cc
modules/audio_processing/ns/suppression_params.h
modules/audio_processing/ns/wiener_filter.cc
modules/audio_processing/ns/wiener_filter.h



modules/audio_processing/transient/click_annotate.cc
modules/audio_processing/transient/common.h
modules/audio_processing/transient/daubechies_8_wavelet_coeffs.h
modules/audio_processing/transient/dyadic_decimator.h
modules/audio_processing/transient/file_utils.cc
modules/audio_processing/transient/file_utils.h
modules/audio_processing/transient/moving_moments.cc
modules/audio_processing/transient/moving_moments.h 
modules/audio_processing/transient/transient_detector.cc
modules/audio_processing/transient/transient_detector.h
modules/audio_processing/transient/transient_suppressor.h
modules/audio_processing/transient/transient_suppressor_impl.cc
modules/audio_processing/transient/transient_suppressor_impl.h
modules/audio_processing/transient/windows_private.h
modules/audio_processing/transient/wpd_node.cc
modules/audio_processing/transient/wpd_node.h
modules/audio_processing/transient/wpd_tree.cc
modules/audio_processing/transient/wpd_tree.h


modules/audio_processing/capture_levels_adjuster/audio_samples_scaler.cc
modules/audio_processing/capture_levels_adjuster/audio_samples_scaler.h
modules/audio_processing/capture_levels_adjuster/capture_levels_adjuster.cc
modules/audio_processing/capture_levels_adjuster/capture_levels_adjuster.h

modules/audio_processing/utility/


modules/audio_processing/utility/cascaded_biquad_filter.cc
modules/audio_processing/utility/cascaded_biquad_filter.h
modules/audio_processing/utility/delay_estimator.cc
modules/audio_processing/utility/delay_estimator.h
modules/audio_processing/utility/delay_estimator_internal.h
modules/audio_processing/utility/delay_estimator_wrapper.cc
modules/audio_processing/utility/delay_estimator_wrapper.h
#modules/audio_processing/utility/DEPS
modules/audio_processing/utility/pffft_wrapper.cc
modules/audio_processing/utility/pffft_wrapper.h


modules/audio_processing/logging/apm_data_dumper.h


modules/audio_processing/echo_detector/

modules/audio_processing/echo_detector/circular_buffer.cc
modules/audio_processing/echo_detector/circular_buffer.h
modules/audio_processing/echo_detector/mean_variance_estimator.cc
modules/audio_processing/echo_detector/mean_variance_estimator.h
modules/audio_processing/echo_detector/moving_max.cc
modules/audio_processing/echo_detector/moving_max.h
modules/audio_processing/echo_detector/normalized_covariance_estimator.cc
modules/audio_processing/echo_detector/normalized_covariance_estimator.h
)



FILE(GLOB  rtc_base 

             rtc_base/arraysize.h
             rtc_base/async_packet_socket.cc
             rtc_base/async_packet_socket.h
             rtc_base/async_resolver.cc
             rtc_base/async_resolver.h
             rtc_base/async_resolver_interface.cc
             rtc_base/async_resolver_interface.h
             rtc_base/async_socket.cc
             rtc_base/async_socket.h
             rtc_base/async_udp_socket.cc
             rtc_base/async_udp_socket.h
             rtc_base/atomic_ops.h
             rtc_base/bit_buffer.cc
             rtc_base/bit_buffer.h
             rtc_base/bitstream_reader.cc
             rtc_base/bitstream_reader.h
             rtc_base/buffer.h
             rtc_base/buffer_queue.cc
             rtc_base/buffer_queue.h
             rtc_base/byte_buffer.cc
             rtc_base/byte_buffer.h
             rtc_base/byte_io.h
             rtc_base/byte_order.h
             rtc_base/checks.cc
             rtc_base/checks.h
             rtc_base/compile_assert_c.h
             rtc_base/constructor_magic.h
             #rtc_base/containers/
             rtc_base/copy_on_write_buffer.cc
             rtc_base/copy_on_write_buffer.h
             rtc_base/crc32.cc
             rtc_base/crc32.h
             rtc_base/deprecated/
             rtc_base/deprecation.h
             rtc_base/dscp.h
             rtc_base/event.cc
             rtc_base/event.h
             rtc_base/event_tracer.cc
             rtc_base/event_tracer.h
             rtc_base/experiments/
             rtc_base/fake_clock.cc
             rtc_base/fake_clock.h
             rtc_base/gtest_prod_util.h
             rtc_base/helpers.cc
             rtc_base/helpers.h
             rtc_base/ignore_wundef.h
             rtc_base/internal/
             rtc_base/ip_address.cc
             rtc_base/ip_address.h
             rtc_base/location.cc
             rtc_base/location.h
             rtc_base/logging.cc
             rtc_base/logging.h
             rtc_base/memory/
             rtc_base/message_digest.cc
             rtc_base/message_digest.h
             rtc_base/message_handler.cc
             rtc_base/message_handler.h
             rtc_base/net_helper.cc
             rtc_base/net_helper.h
             rtc_base/net_helpers.cc
             rtc_base/net_helpers.h
             rtc_base/network/
             rtc_base/network_constants.cc
             rtc_base/network_constants.h
             rtc_base/network_monitor.cc
             rtc_base/network_monitor.h
             rtc_base/null_socket_server.cc
             rtc_base/null_socket_server.h
             rtc_base/numerics/
             rtc_base/openssl_adapter.cc
             rtc_base/openssl_adapter.h
             rtc_base/openssl_certificate.cc
             rtc_base/openssl_certificate.h
             rtc_base/openssl_digest.cc
             rtc_base/openssl_digest.h
             rtc_base/openssl.h
             rtc_base/openssl_identity.cc
             rtc_base/openssl_identity.h
             rtc_base/openssl_key_pair.cc
             rtc_base/openssl_key_pair.h
             rtc_base/openssl_session_cache.cc
             rtc_base/openssl_session_cache.h
             rtc_base/openssl_stream_adapter.cc
             rtc_base/openssl_stream_adapter.h
             rtc_base/openssl_utility.cc
             rtc_base/openssl_utility.h
             rtc_base/physical_socket_server.cc
             rtc_base/physical_socket_server.h
             rtc_base/platform_thread.cc
             rtc_base/platform_thread.h
             rtc_base/platform_thread_types.cc
             rtc_base/platform_thread_types.h
             rtc_base/race_checker.cc
             rtc_base/race_checker.h
             rtc_base/random.cc
             rtc_base/random.h
             rtc_base/rate_limiter.cc
             rtc_base/rate_limiter.h
             rtc_base/rate_statistics.cc
             rtc_base/rate_statistics.h
             rtc_base/rate_tracker.cc
             rtc_base/rate_tracker.h
             rtc_base/ref_counted_object.h
             rtc_base/ref_counter.h
             rtc_base/ref_count.h
             rtc_base/rtc_certificate.cc
             rtc_base/rtc_certificate_generator.cc
             rtc_base/rtc_certificate_generator.h
             rtc_base/rtc_certificate.h
             rtc_base/sanitizer.h
             rtc_base/socket_address.cc
             rtc_base/socket_address.h
             rtc_base/socket.cc
             rtc_base/socket_factory.h
             rtc_base/socket.h
             rtc_base/socket_server.h
             rtc_base/ssl_adapter.cc
             rtc_base/ssl_adapter.h
             rtc_base/ssl_certificate.cc
             rtc_base/ssl_certificate.h
             rtc_base/ssl_fingerprint.cc
             rtc_base/ssl_fingerprint.h
             rtc_base/ssl_identity.cc
             rtc_base/ssl_identity.h
             rtc_base/ssl_roots.h
             rtc_base/ssl_stream_adapter.cc
             rtc_base/ssl_stream_adapter.h
             rtc_base/stream.cc
             rtc_base/stream.h
             rtc_base/string_encode.cc
             rtc_base/string_encode.h
             rtc_base/strings/
             rtc_base/string_to_number.cc
             rtc_base/string_to_number.h
             rtc_base/string_utils.cc
             rtc_base/string_utils.h
             rtc_base/swap_queue.h
             rtc_base/synchronization/
             rtc_base/system/
             rtc_base/system_time.cc
             rtc_base/system_time.h
             rtc_base/task_queue.cc
             rtc_base/task_queue.h
            # rtc_base/task_queue_stdlib.cc
            # rtc_base/task_queue_stdlib.h
             rtc_base/task_queue_win.cc
             rtc_base/task_queue_win.h
             rtc_base/task_utils/
             rtc_base/third_party/
             rtc_base/thread_annotations.h
             rtc_base/thread.cc
             rtc_base/thread_checker.h
             rtc_base/thread.h
             rtc_base/thread_message.h
             rtc_base/time_utils.cc
             rtc_base/time_utils.h
             rtc_base/trace_event.h
             rtc_base/type_traits.h
             rtc_base/units/
             rtc_base/win/
             rtc_base/win32.cc
             rtc_base/win32.h
             rtc_base/zero_memory.cc
             rtc_base/zero_memory.h
			 
	rtc_base/strings/json.cc
	rtc_base/strings/json.h
	rtc_base/strings/string_builder.cc
	rtc_base/strings/string_builder.h			 
			 
	rtc_base/synchronization/mutex.cc
	rtc_base/synchronization/mutex_critical_section.h
	rtc_base/synchronization/mutex.h
	rtc_base/synchronization/mutex_pthread.h
	rtc_base/synchronization/sequence_checker.cc
	rtc_base/synchronization/sequence_checker.h
	rtc_base/synchronization/sequence_checker_internal.cc
	rtc_base/synchronization/sequence_checker_internal.h
	rtc_base/synchronization/yield.cc
	rtc_base/synchronization/yield.h
	rtc_base/synchronization/yield_policy.cc
	rtc_base/synchronization/yield_policy.h



rtc_base/deprecated/recursive_critical_section.cc
rtc_base/deprecated/recursive_critical_section.h


rtc_base/internal/default_socket_server.cc
rtc_base/internal/default_socket_server.h


rtc_base/network/sent_packet.h
rtc_base/network/sent_packet.cc 



rtc_base/task_utils/pending_task_safety_flag.cc
rtc_base/task_utils/pending_task_safety_flag.h
rtc_base/task_utils/repeating_task.cc
rtc_base/task_utils/repeating_task.h
rtc_base/task_utils/to_queued_task.h



rtc_base/memory/aligned_malloc.cc
rtc_base/memory/aligned_malloc.h
rtc_base/memory/fifo_buffer.cc
rtc_base/memory/fifo_buffer.h



rtc_base/containers/as_const.h
rtc_base/containers/flat_map.h
rtc_base/containers/flat_tree.cc
rtc_base/containers/flat_tree.h
rtc_base/containers/invoke.h
rtc_base/containers/not_fn.h
rtc_base/containers/void_t.h



rtc_base/experiments/field_trial_parser.cc  
rtc_base/experiments/field_trial_parser.h


rtc_base/system/arch.h
rtc_base/system/file_wrapper.cc
rtc_base/system/file_wrapper.h
rtc_base/system/ignore_warnings.h
rtc_base/system/inline.h
rtc_base/system/no_unique_address.h
rtc_base/system/rtc_export.h
rtc_base/system/unused.h
#rtc_base/system/warn_current_thread_is_deadlocked.cc
rtc_base/system/warn_current_thread_is_deadlocked.h




)



FILE(GLOB  rtp_rtcp 



modules/rtp_rtcp/include/receive_statistics.h
modules/rtp_rtcp/include/report_block_data.cc
modules/rtp_rtcp/include/report_block_data.h
modules/rtp_rtcp/include/rtcp_statistics.h
modules/rtp_rtcp/include/rtp_cvo.h
modules/rtp_rtcp/include/rtp_header_extension_map.h
modules/rtp_rtcp/include/rtp_rtcp_defines.cc
modules/rtp_rtcp/include/rtp_rtcp_defines.h

modules/rtp_rtcp/source/byte_io.h
modules/rtp_rtcp/source/receive_statistics_impl.cc
modules/rtp_rtcp/source/receive_statistics_impl.h

modules/rtp_rtcp/source/rtcp_packet/app.cc
modules/rtp_rtcp/source/rtcp_packet/app.h
modules/rtp_rtcp/source/rtcp_packet/bye.cc
modules/rtp_rtcp/source/rtcp_packet/bye.h
modules/rtp_rtcp/source/rtcp_packet/common_header.cc
modules/rtp_rtcp/source/rtcp_packet/common_header.h
modules/rtp_rtcp/source/rtcp_packet/dlrr.cc
modules/rtp_rtcp/source/rtcp_packet/dlrr.h
modules/rtp_rtcp/source/rtcp_packet/extended_reports.cc
modules/rtp_rtcp/source/rtcp_packet/extended_reports.h
modules/rtp_rtcp/source/rtcp_packet/nack.cc
modules/rtp_rtcp/source/rtcp_packet/nack.h
modules/rtp_rtcp/source/rtcp_packet/pli.cc
modules/rtp_rtcp/source/rtcp_packet/pli.h
modules/rtp_rtcp/source/rtcp_packet/psfb.cc
modules/rtp_rtcp/source/rtcp_packet/psfb.h
modules/rtp_rtcp/source/rtcp_packet/receiver_report.cc
modules/rtp_rtcp/source/rtcp_packet/receiver_report.h
modules/rtp_rtcp/source/rtcp_packet/remote_estimate.cc
modules/rtp_rtcp/source/rtcp_packet/remote_estimate.h
modules/rtp_rtcp/source/rtcp_packet/report_block.cc
modules/rtp_rtcp/source/rtcp_packet/report_block.h
modules/rtp_rtcp/source/rtcp_packet/rrtr.cc
modules/rtp_rtcp/source/rtcp_packet/rrtr.h
modules/rtp_rtcp/source/rtcp_packet/rtpfb.cc
modules/rtp_rtcp/source/rtcp_packet/rtpfb.h
modules/rtp_rtcp/source/rtcp_packet/sdes.cc
modules/rtp_rtcp/source/rtcp_packet/sdes.h
modules/rtp_rtcp/source/rtcp_packet/sender_report.cc
modules/rtp_rtcp/source/rtcp_packet/sender_report.h
modules/rtp_rtcp/source/rtcp_packet/target_bitrate.cc
modules/rtp_rtcp/source/rtcp_packet/target_bitrate.h
modules/rtp_rtcp/source/rtcp_packet.cc
modules/rtp_rtcp/source/rtcp_packet.h
modules/rtp_rtcp/source/rtp_dependency_descriptor_extension.cc
modules/rtp_rtcp/source/rtp_dependency_descriptor_extension.h
modules/rtp_rtcp/source/rtp_dependency_descriptor_reader.cc
modules/rtp_rtcp/source/rtp_dependency_descriptor_reader.h
modules/rtp_rtcp/source/rtp_dependency_descriptor_writer.cc
modules/rtp_rtcp/source/rtp_dependency_descriptor_writer.h
modules/rtp_rtcp/source/rtp_format.cc
modules/rtp_rtcp/source/rtp_format.h
modules/rtp_rtcp/source/rtp_format_h264.cc
modules/rtp_rtcp/source/rtp_format_h264.h
modules/rtp_rtcp/source/rtp_format_video_generic.cc
modules/rtp_rtcp/source/rtp_format_video_generic.h
modules/rtp_rtcp/source/rtp_generic_frame_descriptor.cc
modules/rtp_rtcp/source/rtp_generic_frame_descriptor_extension.cc
modules/rtp_rtcp/source/rtp_generic_frame_descriptor_extension.h
modules/rtp_rtcp/source/rtp_generic_frame_descriptor.h
modules/rtp_rtcp/source/rtp_header_extension_map.cc
modules/rtp_rtcp/source/rtp_header_extensions.cc
modules/rtp_rtcp/source/rtp_header_extensions.h
modules/rtp_rtcp/source/rtp_packet.cc
modules/rtp_rtcp/source/rtp_packet.h
modules/rtp_rtcp/source/rtp_packet_received.cc
modules/rtp_rtcp/source/rtp_packet_received.h
modules/rtp_rtcp/source/rtp_packet_to_send.cc
modules/rtp_rtcp/source/rtp_packet_to_send.h
modules/rtp_rtcp/source/rtp_rtcp_config.h
modules/rtp_rtcp/source/rtp_util.cc
modules/rtp_rtcp/source/rtp_util.h
modules/rtp_rtcp/source/rtp_video_header.cc
modules/rtp_rtcp/source/rtp_video_header.h
modules/rtp_rtcp/source/rtp_video_layers_allocation_extension.cc
modules/rtp_rtcp/source/rtp_video_layers_allocation_extension.h
modules/rtp_rtcp/source/time_util.cc
modules/rtp_rtcp/source/time_util.h


)

file(GLOB all_src
   # "rtc_base/*.h"
   # "rtc_base/*.cc"
   # "rtc_base/strings/*.h"
   # "rtc_base/strings/*.cc"
   # "rtc_base/synchronization/*.h"
   # "rtc_base/synchronization/*.cc"
   # "rtc_base/deprecated/*.h"
   # "rtc_base/deprecated/*.cc"
	#"rtc_base/win/*.h"
   # "rtc_base/win/*.cc"
   # "rtc_base/internal/*.h"
   # "rtc_base/internal/*.cc"
   #  "rtc_base/task_utils/*.h"
   # "rtc_base/task_utils/*.cc"
   # "rtc_base/third_party/sigslot/*.h"
   # "rtc_base/third_party/sigslot/*.cc"
   # "rtc_base/third_party/base64/*.h"
   # "rtc_base/third_party/base64/*.cc"
   # "api/task_queue/*.h"
   # "api/task_queue/*.cc"
   # "api/units/*.h"
   # "api/units/*.cc"
   # "api/crypto/*.h"
   # "api/crypto/*.cc"
   # "system_wrappers/include/*.h"
   # "system_wrappers/source/*.cc"


	#######################

	#"rtc_base/*.h"
   #"rtc_base/strings/*.h"
   #"rtc_base/synchronization/*.h"
   #"rtc_base/deprecated/*.h"
   #"rtc_base/internal/*.h"
   #"rtc_base/network/*.h"
   #"rtc_base/task_utils/*.h"
   #"rtc_base/memory/*.h"
   #"rtc_base/containers/*.h"
   #"rtc_base/experiments/*.h"
   #"rtc_base/system/*.h"
   "rtc_base/third_party/sigslot/*.h"
   "rtc_base/third_party/base64/*.h"
    #"api/*.h"
    #"api/task_queue/*.h"
    #"api/units/*.h"
    #"api/crypto/*.h"
    #"api/audio/*.h"
    #"api/video/*.h"
    #"api/transport/*.h"
    #"api/transport/rtp/*.h"
    #"api/audio_codecs/*.h"
   # "system_wrappers/source/*.h"
    "modules/video_capture/*.h"
    #"modules/audio_device/*.h"
    "modules/audio_device/dummy/*.h"
   # "modules/audio_processing/*.h"
   # "modules/audio_processing/include/*.h"
   # "modules/audio_processing/aec3/*.h"
   # "modules/audio_processing/aecm/*.h"
   # "modules/audio_processing/aec_dump/*.h"
   # "modules/audio_processing/agc/*.h"
   # "modules/audio_processing/agc/legacy/*.h"
   # "modules/audio_processing/agc2/*.h"
   # "modules/audio_processing/agc2/rnn_vad/*.h"
   ## "modules/audio_processing/vad/*.h"
   # "modules/audio_processing/ns/*.h"
   # "modules/audio_processing/transient/*.h"
   # "modules/audio_processing/capture_levels_adjuster/*.h"
   # "modules/audio_processing/utility/*.h"
   # "modules/audio_processing/logging/*.h"
   # "modules/audio_processing/echo_detector/*.h"
    #"modules/audio_coding/codecs/isac/main/source/*.h"
    "modules/third_party/fft/*.h"
    #"modules/rtp_rtcp/include/*.h"
    #"modules/rtp_rtcp/source/*.h"
    #"modules/rtp_rtcp/source/rtcp_packet/*.h"
   # "common_video/*.h"
  #  "common_video/libyuv/*.h"
  #  "common_video/h264/*.h"
    #"common_audio/*.h"
    #"common_audio/*.h"
    #"common_audio/resampler/*.h"
    #"common_audio/signal_processing/*.h"
    #"common_audio/signal_processing/*.h"
    #"common_audio/vad/*.h"
   # "common_audio/third_party/ooura/fft_size_128/*.h"
   # "common_audio/third_party/ooura/fft_size_256/*.h"
   # "common_audio/third_party/spl_sqrt_floor/*.h"
    #"media/base/*.h"
    "../third_party/pffft/src/*.h"
    "../third_party/rnnoise/src/*.h"

	##########

	#"rtc_base/*.cc"
   #"rtc_base/strings/*.cc"
   #"rtc_base/synchronization/*.cc"
   #"rtc_base/deprecated/*.cc"
   #"rtc_base/internal/*.cc"
   #"rtc_base/network/*.cc"
   #"rtc_base/task_utils/*.cc"
   #"rtc_base/memory/*.cc"
   #"rtc_base/containers/*.cc"
   #"rtc_base/experiments/*.cc"
   #"rtc_base/system/*.cc"
    "rtc_base/third_party/sigslot/*.cc"
    "rtc_base/third_party/base64/*.cc"
    #"api/*.cc"
    #"api/task_queue/*.cc"
    #"api/units/*.cc"
    #"api/crypto/*.cc"
    #"api/audio/*.cc"
    #"api/video/*.cc"
    #"api/transport/*.cc"
    #"api/transport/rtp/*.cc"
    #"api/audio_codecs/*.cc"
  #  "system_wrappers/source/*.cc"
    "modules/video_capture/*.cc"
   # "modules/audio_device/*.cc"
    "modules/audio_device/dummy/*.cc"
  #  "modules/audio_processing/*.cc"
  #  "modules/audio_processing/include/*.cc"
  #  "modules/audio_processing/aec3/*.cc"
  #  "modules/audio_processing/aecm/*.cc"
  #  "modules/audio_processing/aec_dump/*.cc"
  #  "modules/audio_processing/agc/*.cc"
  #  "modules/audio_processing/agc/legacy/*.cc"
  #  "modules/audio_processing/agc2/*.cc"
  #  "modules/audio_processing/agc2/rnn_vad/*.cc"
  # # "modules/audio_processing/vad/*.cc"
  #  "modules/audio_processing/ns/*.cc"
  #  "modules/audio_processing/transient/*.cc"
  #  "modules/audio_processing/capture_levels_adjuster/*.cc"
  #  "modules/audio_processing/utility/*.cc"
  #  "modules/audio_processing/logging/*.cc"
  #  "modules/audio_processing/echo_detector/*.cc"
   # "modules/audio_coding/codecs/isac/main/source/*.c"
    "modules/third_party/fft/*.c"
   # "modules/rtp_rtcp/include/*.cc"
   # "modules/rtp_rtcp/source/*.cc"
   # "modules/rtp_rtcp/source/rtcp_packet/*.cc"
   # "common_video/*.cc"
   ## "common_video/libyuv/*.cc"
   # "common_video/h264/*.cc"
   # "common_audio/*.cc"
   # "common_audio/*.c"
    #"common_audio/resampler/*.cc"
   # "common_audio/signal_processing/*.c"
   # "common_audio/signal_processing/*.cc"
   # "common_audio/vad/*.c"
    #"common_audio/third_party/ooura/fft_size_128/*.cc"
    #"common_audio/third_party/ooura/fft_size_256/*.cc"
    # "common_audio/third_party/spl_sqrt_floor/*.c"
	 #"common_audio/third_party/spl_sqrt_floor/*.S"
    #"media/base/*.cc"
    "../third_party/pffft/src/*.c"
    "../third_party/rnnoise/src/*.cc"
)
if (CMAKE_SYSTEM_NAME MATCHES "Windows")
    file(GLOB rtc_base_win
        "rtc_base/win/windows_version.h"
		"rtc_base/win/windows_version.cc"
		 "rtc_base/win/scoped_com_initializer.h"
		"rtc_base/win/scoped_com_initializer.cc"
    )

    file(GLOB api_win
        "api/task_queue/default_task_queue_factory.h"
		"api/task_queue/default_task_queue_factory_win.cc"
    )

    file(GLOB video_capture_win
	"modules/video_capture/windows/*.h"
        "modules/video_capture/windows/*.cc"
    )

    file(GLOB audio_device_win
		#"modules/audio_device/win/*.h"
      #  "modules/audio_device/win/*.cc"

		modules/audio_device/win/audio_device_core_win.cc
		modules/audio_device/win/audio_device_core_win.h
		modules/audio_device/win/audio_device_module_win.cc
		modules/audio_device/win/audio_device_module_win.h
		modules/audio_device/win/core_audio_base_win.cc
		modules/audio_device/win/core_audio_base_win.h
		modules/audio_device/win/core_audio_input_win.cc
		modules/audio_device/win/core_audio_input_win.h
		modules/audio_device/win/core_audio_output_win.cc
		modules/audio_device/win/core_audio_output_win.h
		modules/audio_device/win/core_audio_utility_win.cc
		modules/audio_device/win/core_audio_utility_win.h
    )

endif()
#add_library(${PROJECT_NAME} ${all_src})

# target_link_libraries(${PROJECT_NAME} 

#     libssl.lib 
    
#     libcrypto.lib)


#if (CMAKE_SYSTEM_NAME MATCHES "Windows")
#   target_link_libraries(${PROJECT_NAME} 
#
#    libssl.lib 
#    
#    libcrypto.lib)
#endif()

if (CMAKE_SYSTEM_NAME MATCHES "Windows")
    add_library(${PROJECT_NAME}   STATIC
        ${all_src}
        ${rtc_base_win}
        ${api_win}
        ${audio_device_win}
        ${video_capture_win}
		${signal_processing}
		${spl_sqrt_floor}
		${ooura}
		${common_audio}
		${resampler}
		${vad}
		${common_video}
		${media}
		${system_wrappers}
		${audio_coding}
		${audio_device}
		${audio_processing}
		${rtc_base}
		${rtp_rtcp}
		${api}
)
add_dependencies(${PROJECT_NAME} libyuv)
add_dependencies(${PROJECT_NAME} libuv)
add_dependencies(${PROJECT_NAME} libsrtp2)
add_dependencies(${PROJECT_NAME} yaml_cpp)
elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")
    file(GLOB exclude_src
        "./src/rtc_base/win32.cc"
        "./src/rtc_base/task_queue_win.cc"
        "./src/api/task_queue/default_task_queue_factory_win.cc"
    )
    list(REMOVE_ITEM all_src ${exclude_src})
    add_library(${PROJECT_NAME} 
        ${all_src}
		${signal_processing}
		${spl_sqrt_floor}
		${ooura}
		${common_audio}
		${resampler}
		${vad}
		${common_video}
		${media}
		${system_wrappers}
		${audio_coding}
		${audio_device}
		${audio_processing}
		${rtc_base}
		${rtp_rtcp}
		${api}
    )
endif()

set(AllFile ${all_src}
        ${rtc_base_win}
        ${api_win}
        ${audio_device_win}
        ${video_capture_win}
		${signal_processing}
		${spl_sqrt_floor}
		${ooura}
		${common_audio}
		${resampler}
		${vad}
		${common_video}
		${media}
		${api}
		${system_wrappers}
		${audio_coding}
		${audio_device}
		${audio_processing}
		${rtc_base}
		${rtp_rtcp}
		)





foreach(fileItem ${AllFile})       
    # Get the directory of the source file
    get_filename_component(PARENT_DIR "${fileItem}" DIRECTORY)
	
    # Remove common directory prefix to make the group
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}" "" GROUP "${PARENT_DIR}")
    # Make sure we are using windows slashes
    string(REPLACE "/" "\\" GROUP "${GROUP}")
	#message(status   "---> fileItem = ${fileItem}     GROUP ---->  ${GROUP}")
    # Group into "Source Files" and "Header Files"
    set(GROUP "${GROUP}")
    source_group("${GROUP}" FILES "${fileItem}")
endforeach()



