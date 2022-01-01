gn gen out/vs_h264_openssl --args="is_debug=true target_os=\"win\" target_cpu=\"x86\" is_component_build=false proprietary_codecs=true rtc_use_h264=true ffmpeg_branding=\"Chrome\" rtc_build_ssl=true  --ide=vs2017

gn gen --ide=vs2017 --winsdk=10.0.17763.132 --args='is_debug=true is_clang=true proprietary_codecs=true rtc_use_h264=true rtc_build_ssl=true   ffmpeg_branding=\"Chrome\" target_cpu=\"x64\"' out/vs_h264


--args="is_debug=true proprietary_codecs=true rtc_use_h264=true ffmpeg_branding=\"Chrome\" rtc_build_ssl=true"

这个命令会在out目录下生成一个工作目录release_vs_h264_openssl。

--args内部参数的意义：

is_debug   	是否是Debug版，这里取false，表示编译Release版。
target_os	平台类型，可以取值win、android、ios、linux等，这里取win，表示Windows平台。
target_cpu	cpu类型，Windows下可以取x86、x64，这里取x86，对应32位版本。
is_component_build	是否使用动态运行期库，这里取false，使用静态运行期库，Release版本将对应MT，Debug版将对应MTd。
proprietary_codecs	是否使用版权编码，也就是H264，这里取true。
rtc_use_h264	是否使用H264，这里取true，注意Windows平台编码使用OpenH264，解码使用ffmpeg。
ffmpeg_branding	ffmpeg的分支名，这里采用Chrome的分支。
rtc_build_ssl	是否编译BoringSSL，这里取false，因为后面我们要替换成OpenSSL。
rtc_ssl_root	OpenSSL的头文件路径，会被写到生成的ninja文件中。



 error C2061: 语法错误: 标识符“bidirectional_iterator_tag”
————————————————
 


C:\Program Files (x86)\Windows Kits\10\Windows Performance Toolkit\

三、预置条件
windows环境上编译webrtc
编译OKwebrtc库，使用编译命令行为

gn gen out/Release --args="target_os=\"win\" target_cpu=\"x64\" is_debug=false rtc_use_h264=true is_component_ffmpeg=true ffmpeg_branding=\"Chrome\" enable_libaom=false gtest_enable_absl_printers=false libyuv_include_tests=false rtc_include_tests=false is_component_build=false rtc_enable_protobuf=true" --ide=vs2019

若是版本不支持Clang，可以使用如下命令行

gn gen out/test_vs2017_debug --args="target_os=\"win\" target_cpu=\"x64\" is_debug=true is_clang=false use_lld=false enable_libaom=false gtest_enable_absl_printers=false libyuv_include_tests=false rtc_include_tests=false is_component_build=false rtc_enable_protobuf=true" --ide=vs2017

VS配置安装Clang
webrtc默认编译器是Clang，所以使用VS进行编译时，需要在VS中增加Clang工具。

若不想在VS下使用Clang，可以在webrtc编译命令行中增加is_clang=false use_lld=false。

但是使用is_clang=false use_lld=false命令参数，webrtc不能使用H264功能，因为H264的解码调用的是ffmpeg的264解码器，编ffmpeg必须使用clang编译器。



//is_component_build=false proprietary_codecs=true rtc_use_h264=true ffmpeg_branding=\"Chrome\" rtc_build_ssl=true
gn gen --ide=vs2017 --args='target_os=\"win\" target_cpu=\"x64\" is_debug=true is_clang=true use_lld=false is_component_build=false rtc_use_h264=true ffmpeg_branding=\"Chrome\" rtc_build_ssl=true'  out/test_vs2017_debug

PS D:\Work\cmedia_server\webrtc_google\src> gn gen --ide=vs2017 --args='target_os=\"win\" target_cpu=\"x64
ue is_clang=false use_lld=false is_component_build=false'  out/test_vs2017_debug


apt-cahr npm 

















USE_AURA=1 

NO_TCMALLOC 

FULL_SAFE_BROWSING 

SAFE_BROWSING_CSD 

SAFE_BROWSING_DB_LOCAL 

CHROMIUM_BUILD 

_HAS_EXCEPTIONS=0 

__STD_C 

_CRT_RAND_S 

_CRT_SECURE_NO_DEPRECATE 

_SCL_SECURE_NO_DEPRECATE 

_ATL_NO_OPENGL 
_WINDOWS 

CERT_CHAIN_PARA_HAS_EXTRA_FIELDS 

PSAPI_VERSION=2 

WIN32 

_SECURE_ATL 

_USING_V110_SDK71_ 

WINAPI_FAMILY=WINAPI_FAMILY_DESKTOP_APP 

WIN32_LEAN_AND_MEAN 

NOMINMAX 

_UNICODE 

UNICODE 

NTDDI_VERSION=NTDDI_WIN10_RS2 

_WIN32_WINNT=0x0A00 

WINVER=0x0A00 

NDEBUG 

NVALGRIND 

DYNAMIC_ANNOTATIONS_ENABLED=0 

WEBRTC_ENABLE_PROTOBUF=1 

WEBRTC_INCLUDE_INTERNAL_AUDIO_DEVICE 

RTC_ENABLE_VP9 

HAVE_SCTP 

WEBRTC_NON_STATIC_TRACE_EVENT_HANDLERS=1 

WEBRTC_WIN 

ABSL_ALLOCATOR_NOTHROW=1 

GTEST_API_= 

GTEST_HAS_POSIX_RE=0 

GTEST_LANG_CXX11=1 

GTEST_HAS_TR1_TUPLE=0 

GTEST_HAS_ABSL=1 

HAVE_WEBRTC_VIDEO


////////////////////////////////////////////

debug
{

USE_AURA=1 
;NO_TCMALLOC 
;FULL_SAFE_BROWSING 
;SAFE_BROWSING_CSD 
;SAFE_BROWSING_DB_LOCAL 
;CHROMIUM_BUILD 
;_HAS_EXCEPTIONS=0 
;__STD_C 
;_CRT_RAND_S 
;_CRT_SECURE_NO_DEPRECATE 
;_SCL_SECURE_NO_DEPRECATE 
;_ATL_NO_OPENGL 
;_WINDOWS 
;CERT_CHAIN_PARA_HAS_EXTRA_FIELDS 
;PSAPI_VERSION=2 
;WIN32 
;_SECURE_ATL 
;_USING_V110_SDK71_ 
;WINAPI_FAMILY=WINAPI_FAMILY_DESKTOP_APP 
;WIN32_LEAN_AND_MEAN 
;NOMINMAX 
;_UNICODE 
;UNICODE 
;NTDDI_VERSION=NTDDI_WIN10_RS2 
;_WIN32_WINNT=0x0A00 
;WINVER=0x0A00 
;_DEBUG 
;DYNAMIC_ANNOTATIONS_ENABLED=1 
;WTF_USE_DYNAMIC_ANNOTATIONS=1 
;_HAS_ITERATOR_DEBUGGING=0 
;WEBRTC_ENABLE_PROTOBUF=1 
;WEBRTC_INCLUDE_INTERNAL_AUDIO_DEVICE 
;RTC_ENABLE_VP9 
;HAVE_SCTP 
;WEBRTC_NON_STATIC_TRACE_EVENT_HANDLERS=1 
;WEBRTC_WIN 
;ABSL_ALLOCATOR_NOTHROW=1 
;GTEST_API_= 
;GTEST_HAS_POSIX_RE=0 
;GTEST_LANG_CXX11=1 
;GTEST_HAS_TR1_TUPLE=0 
;GTEST_HAS_ABSL=1 
;HAVE_WEBRTC_VIDEO
}


third_party/abseil-cpp ;third_party/libyuv/include ;third_party/jsoncpp/overrides/include ;third_party/jsoncpp/source/include ;third_party/googletest/custom ;third_party/googletest/src/googlemock/include ;third_party/googletest/custom ;third_party/googletest/src/googletest/include



openH264

H264 (125, level-asymmetry-allowed=1;packetization-mode=1;profile-level-id=42e01f;x-google-max-bitrate=100000;x-google-min-bitrate=4000;x-google-start-bitrate=8000)