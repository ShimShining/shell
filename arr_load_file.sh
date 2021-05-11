#! /usr/bin/bash

#加载文件内容
content=(`cat "demo.txt"`)
#通过循环输出数组内容
for s in "${content[@]}"
do
	echo "$s"
done
