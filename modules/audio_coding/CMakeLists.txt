project(audio_coding)

cmake_minimum_required(VERSION 2.8)
MESSAGE(STATUS  "####################################")
MESSAGE(STATUS  "#############${PROJECT_NAME}###############")
MESSAGE(STATUS  "####################################")


FILE(GLOB audio_coding_module_typedefs_source
     
    audio_coding_module_typedefs.h
)

FILE(GLOB  audio_coding_source


    acm2/acm_receiver.cc
    acm2/acm_receiver.h
    acm2/acm_remixing.cc
    acm2/acm_remixing.h
    acm2/acm_resampler.cc
    acm2/acm_resampler.h
    acm2/audio_coding_module.cc
    acm2/call_statistics.cc
    acm2/call_statistics.h
    include/audio_coding_module.h
	
)
FILE(GLOB  legacy_encoded_audio_frame_source

    codecs/legacy_encoded_audio_frame.cc
    codecs/legacy_encoded_audio_frame.h
)

FILE(GLOB  webrtc_cng_source
    codecs/cng/webrtc_cng.cc
    codecs/cng/webrtc_cng.h

)

FILE(GLOB  audio_encoder_cng_source
    codecs/cng/audio_encoder_cng.cc
    codecs/cng/audio_encoder_cng.h
)

FILE(GLOB  red__source

	    codecs/red/audio_encoder_copy_red.cc
    codecs/red/audio_encoder_copy_red.h
)

FILE(GLOB g711_source

    codecs/g711/audio_decoder_pcm.cc
    codecs/g711/audio_decoder_pcm.h
    codecs/g711/audio_encoder_pcm.cc
    codecs/g711/audio_encoder_pcm.h
)

FILE(GLOB  g711_c_source

    codecs/g711/g711_interface.c
    codecs/g711/g711_interface.h
)

FILE(GLOB  g722_source
     codecs/g722/audio_decoder_g722.cc
     codecs/g722/audio_decoder_g722.h
     codecs/g722/audio_encoder_g722.cc
     codecs/g722/audio_encoder_g722.h

)

FILE(GLOB  g722_c_source

    codecs/g722/g722_interface.c
    codecs/g722/g722_interface.h
)

FILE(GLOB ilbc_source

     codecs/ilbc/audio_decoder_ilbc.cc
     codecs/ilbc/audio_decoder_ilbc.h
     codecs/ilbc/audio_encoder_ilbc.cc
     codecs/ilbc/audio_encoder_ilbc.h
)

FILE(GLOB  ilbc_c_source

    codecs/ilbc/abs_quant.c
    codecs/ilbc/abs_quant.h
    codecs/ilbc/abs_quant_loop.c
    codecs/ilbc/abs_quant_loop.h
    codecs/ilbc/augmented_cb_corr.c
    codecs/ilbc/augmented_cb_corr.h
    codecs/ilbc/bw_expand.c
    codecs/ilbc/bw_expand.h
    codecs/ilbc/cb_construct.c
    codecs/ilbc/cb_construct.h
    codecs/ilbc/cb_mem_energy.c
    codecs/ilbc/cb_mem_energy.h
    codecs/ilbc/cb_mem_energy_augmentation.c
    codecs/ilbc/cb_mem_energy_augmentation.h
    codecs/ilbc/cb_mem_energy_calc.c
    codecs/ilbc/cb_mem_energy_calc.h
    codecs/ilbc/cb_search.c
    codecs/ilbc/cb_search.h
    codecs/ilbc/cb_search_core.c
    codecs/ilbc/cb_search_core.h
    codecs/ilbc/cb_update_best_index.c
    codecs/ilbc/cb_update_best_index.h
    codecs/ilbc/chebyshev.c
    codecs/ilbc/chebyshev.h
    codecs/ilbc/comp_corr.c
    codecs/ilbc/comp_corr.h
    codecs/ilbc/constants.c
    codecs/ilbc/constants.h
    codecs/ilbc/create_augmented_vec.c
    codecs/ilbc/create_augmented_vec.h
    codecs/ilbc/decode.c
    codecs/ilbc/decode.h
    codecs/ilbc/decode_residual.c
    codecs/ilbc/decode_residual.h
    codecs/ilbc/decoder_interpolate_lsf.c
    codecs/ilbc/decoder_interpolate_lsf.h
    codecs/ilbc/defines.h
    codecs/ilbc/do_plc.c
    codecs/ilbc/do_plc.h
    codecs/ilbc/encode.c
    codecs/ilbc/encode.h
    codecs/ilbc/energy_inverse.c
    codecs/ilbc/energy_inverse.h
    codecs/ilbc/enh_upsample.c
    codecs/ilbc/enh_upsample.h
    codecs/ilbc/enhancer.c
    codecs/ilbc/enhancer.h
    codecs/ilbc/enhancer_interface.c
    codecs/ilbc/enhancer_interface.h
    codecs/ilbc/filtered_cb_vecs.c
    codecs/ilbc/filtered_cb_vecs.h
    codecs/ilbc/frame_classify.c
    codecs/ilbc/frame_classify.h
    codecs/ilbc/gain_dequant.c
    codecs/ilbc/gain_dequant.h
    codecs/ilbc/gain_quant.c
    codecs/ilbc/gain_quant.h
    codecs/ilbc/get_cd_vec.c
    codecs/ilbc/get_cd_vec.h
    codecs/ilbc/get_lsp_poly.c
    codecs/ilbc/get_lsp_poly.h
    codecs/ilbc/get_sync_seq.c
    codecs/ilbc/get_sync_seq.h
    codecs/ilbc/hp_input.c
    codecs/ilbc/hp_input.h
    codecs/ilbc/hp_output.c
    codecs/ilbc/hp_output.h
    codecs/ilbc/ilbc.c
    codecs/ilbc/ilbc.h
    codecs/ilbc/index_conv_dec.c
    codecs/ilbc/index_conv_dec.h
    codecs/ilbc/index_conv_enc.c
    codecs/ilbc/index_conv_enc.h
    codecs/ilbc/init_decode.c
    codecs/ilbc/init_decode.h
    codecs/ilbc/init_encode.c
    codecs/ilbc/init_encode.h
    codecs/ilbc/interpolate.c
    codecs/ilbc/interpolate.h
    codecs/ilbc/interpolate_samples.c
    codecs/ilbc/interpolate_samples.h
    codecs/ilbc/lpc_encode.c
    codecs/ilbc/lpc_encode.h
    codecs/ilbc/lsf_check.c
    codecs/ilbc/lsf_check.h
    codecs/ilbc/lsf_interpolate_to_poly_dec.c
    codecs/ilbc/lsf_interpolate_to_poly_dec.h
    codecs/ilbc/lsf_interpolate_to_poly_enc.c
    codecs/ilbc/lsf_interpolate_to_poly_enc.h
    codecs/ilbc/lsf_to_lsp.c
    codecs/ilbc/lsf_to_lsp.h
    codecs/ilbc/lsf_to_poly.c
    codecs/ilbc/lsf_to_poly.h
    codecs/ilbc/lsp_to_lsf.c
    codecs/ilbc/lsp_to_lsf.h
    codecs/ilbc/my_corr.c
    codecs/ilbc/my_corr.h
    codecs/ilbc/nearest_neighbor.c
    codecs/ilbc/nearest_neighbor.h
    codecs/ilbc/pack_bits.c
    codecs/ilbc/pack_bits.h
    codecs/ilbc/poly_to_lsf.c
    codecs/ilbc/poly_to_lsf.h
    codecs/ilbc/poly_to_lsp.c
    codecs/ilbc/poly_to_lsp.h
    codecs/ilbc/refiner.c
    codecs/ilbc/refiner.h
    codecs/ilbc/simple_interpolate_lsf.c
    codecs/ilbc/simple_interpolate_lsf.h
    codecs/ilbc/simple_lpc_analysis.c
    codecs/ilbc/simple_lpc_analysis.h
    codecs/ilbc/simple_lsf_dequant.c
    codecs/ilbc/simple_lsf_dequant.h
    codecs/ilbc/simple_lsf_quant.c
    codecs/ilbc/simple_lsf_quant.h
    codecs/ilbc/smooth.c
    codecs/ilbc/smooth.h
    codecs/ilbc/smooth_out_data.c
    codecs/ilbc/smooth_out_data.h
    codecs/ilbc/sort_sq.c
    codecs/ilbc/sort_sq.h
    codecs/ilbc/split_vq.c
    codecs/ilbc/split_vq.h
    codecs/ilbc/state_construct.c
    codecs/ilbc/state_construct.h
    codecs/ilbc/state_search.c
    codecs/ilbc/state_search.h
    codecs/ilbc/swap_bytes.c
    codecs/ilbc/swap_bytes.h
    codecs/ilbc/unpack_bits.c
    codecs/ilbc/unpack_bits.h
    codecs/ilbc/vq3.c
    codecs/ilbc/vq3.h
    codecs/ilbc/vq4.c
    codecs/ilbc/vq4.h
    codecs/ilbc/window32_w32.c
    codecs/ilbc/window32_w32.h
    codecs/ilbc/xcorr_coef.c
    codecs/ilbc/xcorr_coef.h
)

FILE(GLOB  isac_common_source

     codecs/isac/audio_decoder_isac_t.h
     codecs/isac/audio_decoder_isac_t_impl.h
     codecs/isac/audio_encoder_isac_t.h
     codecs/isac/audio_encoder_isac_t_impl.h
)

FILE(GLOB  isac_source

     codecs/isac/main/include/audio_decoder_isac.h
     codecs/isac/main/include/audio_encoder_isac.h
     codecs/isac/main/source/audio_decoder_isac.cc
     codecs/isac/main/source/audio_encoder_isac.cc
)

FILE(GLOB isac_bwinfo_source

			codecs/isac/bandwidth_info.h
)

FILE(GLOB isac_vad_source
    codecs/isac/main/source/filter_functions.c
    codecs/isac/main/source/filter_functions.h
    codecs/isac/main/source/isac_vad.c
    codecs/isac/main/source/isac_vad.h
    codecs/isac/main/source/os_specific_inline.h
    codecs/isac/main/source/pitch_estimator.c
    codecs/isac/main/source/pitch_estimator.h
    codecs/isac/main/source/pitch_filter.c
    codecs/isac/main/source/pitch_filter.h
    codecs/isac/main/source/settings.h
    codecs/isac/main/source/structs.h

)

FILE(GLOB isac_c_source
    codecs/isac/main/include/isac.h
    codecs/isac/main/source/arith_routines.c
    codecs/isac/main/source/arith_routines.h
    codecs/isac/main/source/arith_routines_hist.c
    codecs/isac/main/source/arith_routines_logist.c
    codecs/isac/main/source/bandwidth_estimator.c
    codecs/isac/main/source/bandwidth_estimator.h
    codecs/isac/main/source/codec.h
    codecs/isac/main/source/crc.c
    codecs/isac/main/source/crc.h
    codecs/isac/main/source/decode.c
    codecs/isac/main/source/decode_bwe.c
    codecs/isac/main/source/encode.c
    codecs/isac/main/source/encode_lpc_swb.c
    codecs/isac/main/source/encode_lpc_swb.h
    codecs/isac/main/source/entropy_coding.c
    codecs/isac/main/source/entropy_coding.h
    codecs/isac/main/source/filterbanks.c
    codecs/isac/main/source/intialize.c
    codecs/isac/main/source/isac.c
    codecs/isac/main/source/isac_float_type.h
    codecs/isac/main/source/lattice.c
    codecs/isac/main/source/lpc_analysis.c
    codecs/isac/main/source/lpc_analysis.h
    codecs/isac/main/source/lpc_gain_swb_tables.c
    codecs/isac/main/source/lpc_gain_swb_tables.h
    codecs/isac/main/source/lpc_shape_swb12_tables.c
    codecs/isac/main/source/lpc_shape_swb12_tables.h
    codecs/isac/main/source/lpc_shape_swb16_tables.c
    codecs/isac/main/source/lpc_shape_swb16_tables.h
    codecs/isac/main/source/lpc_tables.c
    codecs/isac/main/source/lpc_tables.h
    codecs/isac/main/source/pitch_gain_tables.c
    codecs/isac/main/source/pitch_gain_tables.h
    codecs/isac/main/source/pitch_lag_tables.c
    codecs/isac/main/source/pitch_lag_tables.h
    codecs/isac/main/source/spectrum_ar_model_tables.c
    codecs/isac/main/source/spectrum_ar_model_tables.h
    codecs/isac/main/source/transform.c

)

FILE(GLOB isac_fix_source
    codecs/isac/fix/source/audio_decoder_isacfix.cc
    codecs/isac/fix/source/audio_encoder_isacfix.cc


)

FILE(GLOB  isac_fix_common_source

    codecs/isac/fix/source/codec.h
    codecs/isac/fix/source/entropy_coding.h
    codecs/isac/fix/source/fft.c
    codecs/isac/fix/source/fft.h
    codecs/isac/fix/source/filterbank_internal.h
    codecs/isac/fix/source/settings.h
    codecs/isac/fix/source/structs.h
    codecs/isac/fix/source/transform_tables.c
)

FILE(GLOB  isac_fix_c_source

    codecs/isac/fix/include/audio_decoder_isacfix.h
    codecs/isac/fix/include/audio_encoder_isacfix.h
    codecs/isac/fix/include/isacfix.h
    codecs/isac/fix/source/arith_routines.c
    codecs/isac/fix/source/arith_routines_hist.c
    codecs/isac/fix/source/arith_routines_logist.c
    codecs/isac/fix/source/arith_routins.h
    codecs/isac/fix/source/bandwidth_estimator.c
    codecs/isac/fix/source/bandwidth_estimator.h
    codecs/isac/fix/source/decode.c
    codecs/isac/fix/source/decode_bwe.c
    codecs/isac/fix/source/decode_plc.c
    codecs/isac/fix/source/encode.c
    codecs/isac/fix/source/entropy_coding.c
    codecs/isac/fix/source/filterbank_tables.c
    codecs/isac/fix/source/filterbank_tables.h
    codecs/isac/fix/source/filterbanks.c
    codecs/isac/fix/source/filters.c
    codecs/isac/fix/source/initialize.c
    codecs/isac/fix/source/isac_fix_type.h
    codecs/isac/fix/source/isacfix.c
    codecs/isac/fix/source/lattice.c
    codecs/isac/fix/source/lattice_c.c
    codecs/isac/fix/source/lpc_masking_model.c
    codecs/isac/fix/source/lpc_masking_model.h
    codecs/isac/fix/source/lpc_tables.c
    codecs/isac/fix/source/lpc_tables.h
    codecs/isac/fix/source/pitch_estimator.c
    codecs/isac/fix/source/pitch_estimator.h
    codecs/isac/fix/source/pitch_estimator_c.c
    codecs/isac/fix/source/pitch_filter.c
    codecs/isac/fix/source/pitch_filter_c.c
    codecs/isac/fix/source/pitch_gain_tables.c
    codecs/isac/fix/source/pitch_gain_tables.h
    codecs/isac/fix/source/pitch_lag_tables.c
    codecs/isac/fix/source/pitch_lag_tables.h
    codecs/isac/fix/source/spectrum_ar_model_tables.c
    codecs/isac/fix/source/spectrum_ar_model_tables.h
    codecs/isac/fix/source/transform.c

)

add_library(audio_coding_module_typedefs  STATIC  ${audio_coding_module_typedefs_source})
add_library(audio_coding  STATIC  ${audio_coding_source})
add_library(legacy_encoded_audio_frame  STATIC  ${legacy_encoded_audio_frame_source})
add_library(webrtc_cng  STATIC  ${webrtc_cng_source})
add_library(audio_encoder_cng  STATIC  ${audio_encoder_cng_source})
add_library(red  STATIC  ${red__source})
add_library(g711  STATIC  ${g711_source})
add_library(g711_c  STATIC  ${g711_c_source})
add_library(g722  STATIC  ${g722_source})
add_library(g722_c  STATIC  ${g722_c_source})
add_library(ilbc  STATIC  ${ilbc_source})
add_library(ilbc_c  STATIC  ${ilbc_c_source})
add_library(isac_common  STATIC  ${isac_common_source})
add_library(isac  STATIC  ${isac_source})
add_library(isac_bwinfo  STATIC  ${isac_bwinfo_source})
add_library(isac_vad  STATIC  ${isac_vad_source})
add_library(isac_c  STATIC  ${isac_c_source})
add_library(isac_fix  STATIC  ${isac_fix_source})
add_library(isac_fix_common  STATIC  ${isac_fix_common_source})
add_library(isac_fix_c  STATIC  ${isac_fix_c_source})
add_library(audio_coding  STATIC  ${audio_coding_source})
add_library(audio_coding  STATIC  ${audio_coding_source})
add_library(audio_coding  STATIC  ${audio_coding_source})
add_library(audio_coding  STATIC  ${audio_coding_source})
add_library(audio_coding  STATIC  ${audio_coding_source})
add_library(audio_coding  STATIC  ${audio_coding_source})
add_library(audio_coding  STATIC  ${audio_coding_source})
 
 
 

set_target_properties(audio_coding_module_typedefs                               PROPERTIES LINKER_LANGUAGE CXX) 
set_target_properties(isac_bwinfo                               PROPERTIES LINKER_LANGUAGE CXX) 
set_target_properties(audio_coding_module_typedefs                               PROPERTIES LINKER_LANGUAGE CXX) 


set(AllFile

#${desktop_capture_mock_source}
${audio_coding_module_typedefs_source} 
${audio_coding_source}
${legacy_encoded_audio_frame_source}
${webrtc_cng_source}
${audio_encoder_cng_source}
${red__source}
${g711_source}
${g711_c_source}
${g722_source}
${g722_c_source}
${ilbc_source}
${ilbc_c_source}
${isac_common_source}
${isac_source}
${isac_bwinfo_source}
${isac_vad_source}
${isac_c_source}
${isac_fix_source}
${isac_fix_common_source}
${isac_fix_c_source}
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


set_property(TARGET  audio_coding_module_typedefs 							PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  audio_coding 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  legacy_encoded_audio_frame 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  webrtc_cng 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  audio_encoder_cng 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  red 													PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  g711 													PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  g711_c 													PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  g722 													PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  g722_c 													PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  ilbc 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  ilbc_c 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  isac_common 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  isac 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  isac_bwinfo 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  isac_vad 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  isac_fix 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  isac_fix_common 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  isac_fix_c 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  ilbc_c 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  ilbc_c 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  ilbc_c 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  ilbc_c 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})
set_property(TARGET  ilbc_c 											PROPERTY FOLDER ${LIWEBRTC_IDE_FOLDER}/modules/${PROJECT_NAME})

