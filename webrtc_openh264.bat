@echo on

setlocal
:: build openh264

start gn gen --ide=vs2017 --args='target_os=\"win\" target_cpu=\"x64\" is_debug=true is_clang=true use_lld=false is_component_build=false rtc_use_h264=true ffmpeg_branding=\"Chrome\" rtc_build_ssl=true'  out/test_vs2017_debug_chensong



start gn gen --ide=vs2017 --args='target_os=\"win\" target_cpu=\"x64\" is_debug=false is_clang=true proprietary_codecs=true use_lld=false is_component_build=false rtc_use_h264=true ffmpeg_branding=\"Chrome\" rtc_build_ssl=true'  out/test_vs2017_realse





gn gen out/linux --args='target_os="linux" target_cpu="x64" is_debug=false is_clang=false proprietary_codecs=true use_lld=false is_component_build=false rtc_use_h264=true ffmpeg_branding="Chrome" rtc_build_ssl=true'   
# linux --> webrtc TODO@chensong 2023-03-29
gn gen out/Release-gcc --args='target_os="linux" target_cpu="x64" is_debug=false  proprietary_codecs=true use_lld=false is_component_build=false rtc_use_h264=true ffmpeg_branding="Chrome" rtc_build_ssl=true  is_component_build=false use_sysroot=false is_clang=false use_lld=false treat_warnings_as_errors=false rtc_include_tests=false rtc_build_examples=false use_custom_libcxx=false use_rtti=true'
pause
