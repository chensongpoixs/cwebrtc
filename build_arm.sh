一、安装依赖

在WebRTC的编译脚本中已经预留了对交叉编译的支持,只需要执行

```
$ ./build/linux/sysroot_scripts/install-sysroot.py --arch=arm
```

如果是aarch64

```

$ ./build/install-build-deps.sh
$ ./build/linux/sysroot_scripts/install-sysroot.py --arch=arm64
```

1
2
3
4

二、编译arm linux库

```
$  gn gen  ../debug-arm --args='target_os="linux" target_cpu="arm"'
$  ninja -C ../debug-arm
$  gn gen  ../release-arm --args='target_os="linux" target_cpu="arm" is_debug = false'
$  ninja -C ../release-arm
```


如果是aarch64

```
$ gn gen  ../debug-arm64 --args='target_os="linux" target_cpu="arm64"'
$  ninja -C ../debug-arm64
$  gn gen  ../release-arm64 --args='target_os="linux" target_cpu="arm64" is_debug = false'
$  ninja -C ../release-arm64
```