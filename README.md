**WebRTC is a free, open software project** that provides browsers and mobile
applications with Real-Time Communications (RTC) capabilities via simple APIs.
The WebRTC components have been optimized to best serve this purpose.

**Our mission:** To enable rich, high-quality RTC applications to be
developed for the browser, mobile platforms, and IoT devices, and allow them
all to communicate via a common set of protocols.

The WebRTC initiative is a project supported by Google, Mozilla and Opera,
amongst others.

### Development

See [here][native-dev] for instructions on how to get started
developing with the native code.

[Authoritative list](native-api.md) of directories that contain the
native API header files.

### More info

 * Official web site: http://www.webrtc.org
 * Master source code repo: https://webrtc.googlesource.com/src
 * Samples and reference apps: https://github.com/webrtc
 * Mailing list: http://groups.google.com/group/discuss-webrtc
 * Continuous build: https://ci.chromium.org/p/webrtc/g/ci/console
 * [Coding style guide](g3doc/style-guide.md)
 * [Code of conduct](CODE_OF_CONDUCT.md)
 * [Reporting bugs](docs/bug-reporting.md)
 * [Documentation](g3doc/sitemap.md)

[native-dev]: https://webrtc.googlesource.com/src/+/main/docs/native-code/



win



```
gn gen --ide=vs2022 --args='target_os=\"win\" target_cpu=\"x64\" is_debug=true is_clang=true use_lld=false is_component_build=false rtc_use_h264=true rtc_use_h265=true  ffmpeg_branding=\"Chrome\" rtc_build_ssl=true' 


gn gen --ide=vs2022 --args='target_os=\"win\" target_cpu=\"x64\" is_debug=true is_clang=true use_lld=false is_component_build=false rtc_use_h264=true rtc_use_h265=true  ffmpeg_branding=\"Chrome\" rtc_build_ssl=true  use_custom_libcxx=false  proprietary_codecs=true'  out/vs2022_debug_chensong
```


relase



```
gn gen --ide=vs2022 --args='target_os=\"win\" target_cpu=\"x64\" is_debug=false is_clang=true use_lld=false is_component_build=false rtc_use_h264=true rtc_use_h265=true  ffmpeg_branding=\"Chrome\" rtc_build_ssl=true  use_custom_libcxx=false  proprietary_codecs=true'  out/vs2022_release_chensong

```