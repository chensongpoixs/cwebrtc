# 拷贝webrtc中头文件的脚本文件
src=`find ./ -name "*.h*"`
echo $src

for obj in $src
do 
	echo "cp header file $obj"
	cp --parents $obj D:/dep/webrtc/m110_include/
done
