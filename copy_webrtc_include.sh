#!/bin/bash
# 拷贝webrtc中头文件的脚本文件
src=`find /root/webrtc/webrtc/src/ -name "*.h*"`
echo $src

for obj in $src
do 
	echo "cp header file $obj"
	cp --parents $obj ./include/
done
