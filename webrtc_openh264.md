gn gen --ide=vs2017 --winsdk=10.0.19041.0 --args='is_debug=true is_clang=true proprietary_codecs=true rtc_use_h264=true rtc_build_ssl=true ffmpeg_branding=\"Chrome\" target_cpu=\"x64\"' out/vs2017_test_debug


# rtc 日志模块打印日志启动

enable_bwe_test_logging=true


gn gen --ide=vs2017 --winsdk=10.0.19041.0 --args='is_debug=true is_clang=true proprietary_codecs=true rtc_use_h264=true enable_bwe_test_logging=true rtc_build_ssl=true ffmpeg_branding=\"Chrome\" target_cpu=\"x64\"' out/vs2017_test_debug