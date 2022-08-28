@echo on

setlocal
:: build openh264

start gn gen --ide=vs2017 --args='target_os=\"win\" target_cpu=\"x64\" is_debug=true is_clang=true use_lld=false is_component_build=false rtc_use_h264=true ffmpeg_branding=\"Chrome\" rtc_build_ssl=true'  out/test_vs2017_debug



pause
