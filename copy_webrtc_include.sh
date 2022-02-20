#!/bin/bash
# 拷贝webrtc中头文件的脚本文件
src=`find webrtc/ -name "*.h*"`
echo $src

for obj in $src
do 
	echo "cp header file $obj"
	cp --parents $obj inc/
done
