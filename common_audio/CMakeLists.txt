project(common_audio)
cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")



FILE(GLOB signal_processing 
	
		signal_processin/include/real_fft.h
		signal_processin/include/signal_processing_library.h
		signal_processin/include/spl_inl.h
		signal_processin/include/spl_inl_armv7.h
		signal_processin/include/spl_inl_mips.h
	  
		signal_processing/complex_bit_reverse.c
		signal_processing/complex_fft.c
		signal_processing/complex_fft_tables.h
		signal_processing/copy_set_operations.c
		signal_processing/cross_correlation.c
		signal_processing/division_operations.c
		signal_processing/dot_product_with_scale.cc
		signal_processing/dot_product_with_scale.h
		signal_processing/downsample_fast.c
		signal_processing/energy.c
		signal_processing/get_scaling_square.c
		signal_processing/min_max_operations.c
		signal_processing/randomization_functions.c
		signal_processing/real_fft.c
		signal_processing/resample.c
		signal_processing/resample_48khz.c
		signal_processing/resample_by_2.c
		signal_processing/resample_by_2_internal.c
		signal_processing/resample_by_2_internal.h
		signal_processing/resample_fractional.c
		signal_processing/splitting_filter.c
		signal_processing/spl_init.c
		signal_processing/spl_inl.c
		signal_processing/spl_sqrt.c
		signal_processing/sqrt_of_one_minus_x_squared.c
		signal_processing/vector_scaling_operations.c
     ring_buffer.c
     ring_buffer.h
     signal_processing/auto_corr_to_refl_coef.c
     signal_processing/auto_correlation.c
     signal_processing/complex_fft_tables.h
     signal_processing/copy_set_operations.c
     signal_processing/cross_correlation.c
     signal_processing/division_operations.c
     signal_processing/downsample_fast.c
     signal_processing/energy.c
     signal_processing/filter_ar.c
     signal_processing/filter_ma_fast_q12.c
     signal_processing/get_hanning_window.c
     signal_processing/get_scaling_square.c
     signal_processing/ilbc_specific_functions.c
     signal_processing/include/real_fft.h
     signal_processing/include/signal_processing_library.h
     signal_processing/include/spl_inl.h
     signal_processing/include/spl_inl_armv7.h
     signal_processing/levinson_durbin.c
     signal_processing/lpc_to_refl_coef.c
     signal_processing/min_max_operations.c
     signal_processing/randomization_functions.c
     signal_processing/real_fft.c
     signal_processing/refl_coef_to_lpc.c
     signal_processing/resample.c
     signal_processing/resample_48khz.c
     signal_processing/resample_by_2.c
     signal_processing/resample_by_2_internal.c
     signal_processing/resample_by_2_internal.h
     signal_processing/resample_fractional.c
     signal_processing/spl_init.c
     signal_processing/spl_inl.c
     signal_processing/spl_sqrt.c
     signal_processing/splitting_filter.c
     signal_processing/sqrt_of_one_minus_x_squared.c
     signal_processing/vector_scaling_operations.c
     vad/include/webrtc_vad.h
     vad/vad_core.c
     vad/vad_core.h
     vad/vad_filterbank.c
     vad/vad_filterbank.h
     vad/vad_gmm.c
     vad/vad_gmm.h
     vad/vad_sp.c
     vad/vad_sp.h
     vad/webrtc_vad.c
	signal_processing/complex_fft.c
	    signal_processing/dot_product_with_scale.cc 
     signal_processing/dot_product_with_scale.h 
)


FILE(GLOB  spl_sqrt_floor  



	third_party/spl_sqrt_floor/spl_sqrt_floor.h

	third_party/spl_sqrt_floor/spl_sqrt_floor.c
	third_party/spl_sqrt_floor/spl_sqrt_floor.S
	
)


FILE(GLOB   ooura  

		third_party/ooura/fft_size_128/ooura_fft.h
		third_party/ooura/fft_size_128/ooura_fft.cc
		third_party/ooura/fft_size_128/ooura_fft_mips.cc
		third_party/ooura/fft_size_128/ooura_fft_sse2.cc
		third_party/ooura/fft_size_128/ooura_fft_tables_common.h
		third_party/ooura/fft_size_128/ooura_fft_tables_neon_sse2.h
		third_party/ooura/fft_size_256/fft4g.cc
		third_party/ooura/fft_size_256/fft4g.cc
)


FILE(GLOB common_audio_source
	include/audio_util.h
	audio_converter.cc
	audio_converter.h
	audio_util.cc
	channel_buffer.cc
	channel_buffer.h
	fir_filter.h
	#fir_filter_avx2.cc
	#fir_filter_avx2.h
	fir_filter_c.cc
	fir_filter_c.h
	fir_filter_factory.cc
	fir_filter_factory.h
	#fir_filter_sse.cc
	#fir_filter_sse.h
	ring_buffer.c
	ring_buffer.h
	wav_file.cc
	wav_file.h
	wav_header.cc
	wav_header.h

)

FILE(GLOB  resampler
	
	resampler/sinc_resampler.h
	resampler/include/resampler.h   
	resampler/include/push_resampler.h
	resampler/push_resampler.cc
	resampler/push_sinc_resampler.cc
	resampler/push_sinc_resampler.h
	resampler/resampler.cc
	resampler/sinc_resampler.cc
	resampler/sinc_resampler.h
	#resampler/sinc_resampler_avx2.cc
	#resampler/sinc_resampler_sse.cc
	resampler/sinusoidal_linear_chirp_source.cc
	resampler/sinusoidal_linear_chirp_source.h
	fir_filter.h
	 fir_filter_c.cc
     fir_filter_c.h
     fir_filter_factory.cc
     fir_filter_factory.h
	 
	 
	  # fir_filter_sse.cc
      # fir_filter_sse.h
     #  resampler/sinc_resampler_sse.cc
     ##  fir_filter_avx2.cc
     #  fir_filter_avx2.h
     #  resampler/sinc_resampler_avx2.cc
      # signal_processing/cross_correlation_neon.c
     #  signal_processing/downsample_fast_neon.c
     #  signal_processing/min_max_operations_neon.c
)




FILE(GLOB  vad


		resampler/vad/include/vad.h
		resampler/vad/include/webrtc_vad.h
		resampler/vad/mock/mock_vad.h 


		resampler/vad/vad.cc
		resampler/vad/vad_core.c
		resampler/vad/vad_core.h
		resampler/vad/vad_filterbank.c
		resampler/vad/vad_filterbank.h
		resampler/vad/vad_gmm.c
		resampler/vad/vad_gmm.h
		resampler/vad/vad_sp.c
		resampler/vad/vad_sp.h
		resampler/vad/webrtc_vad.c


	vad/include/webrtc_vad.h
    vad/vad_core.c
    vad/vad_core.h
    vad/vad_filterbank.c
    vad/vad_filterbank.h
    vad/vad_gmm.c
    vad/vad_gmm.h
    vad/vad_sp.c
    vad/vad_sp.h
    vad/webrtc_vad.c
	

)

 



if (CMAKE_SYSTEM_NAME MATCHES "Windows")
    message(STATUS "common_audio current platform: windows")
     
	FILE(GLOB common_audio_win_source 
		fir_filter_avx2.cc
		fir_filter_avx2.h 
		fir_filter_sse.cc
		fir_filter_sse.h  
		resampler/sinc_resampler_avx2.cc
		resampler/sinc_resampler_sse.cc
	)
elseif (CMAKE_SYSTEM_NAME MATCHES "Linux")
	message(STATUS "common_audio current platform: unix")
	#FILE(GLOB common_audio_linux_source 
	#	fir_filter_avx2.cc
	#	fir_filter_avx2.h 
	#	fir_filter_sse.cc
	#	fir_filter_sse.h 
    #)


endif()


add_library(${PROJECT_NAME}  STATIC   ${vad}

  ${resampler}

	${common_audio_source}
	${ooura}
	${spl_sqrt_floor}
	${signal_processing}
	)
	
	
	
	
set(AllFile 

        ${vad}

  ${resampler}

	${common_audio_source}
	${ooura}
	${spl_sqrt_floor}
	${signal_processing}
		
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



 set_property(TARGET ${PROJECT_NAME}  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER})
 #set_property(TARGET rtc_pc_base  PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/${PROJECT_NAME})
	
	