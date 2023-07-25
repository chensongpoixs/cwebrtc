 Windows SDK 10.0.18362.0
 
 gn gen --ide=vs2019 --args='target_os=\"win\" target_cpu=\"x64\" is_debug=true is_clang=true use_lld=false is_component_build=false rtc_use_h264=true ffmpeg_branding=\"Chrome\" rtc_build_ssl=true'  out/test_vs2019_debug_chensong

 gn gen --target=x64 --ide=vs2019 --args='is_debug=false rtc_enable_protobuf=false is_clang=false target_cpu=\"x64\"  enable_iterator_debugging=true  use_custom_libcxx=false symbol_level=0 rtc_include_tests=false' out/relese_x64
 
 
 gn gen --ide=vs2019    --winsdk=10.0.22621.0  --args='target_os=\"win\" target_cpu=\"x64\" is_debug=true is_clang=true proprietary_codecs=true use_lld=false use_custom_libcxx=false symbol_level=0 is_component_build=false rtc_use_h264=true ffmpeg_branding=\"Chrome\" rtc_build_ssl=true'  out/vs2019_debug