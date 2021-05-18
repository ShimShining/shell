#! /usr/bin/bash

echo "Start"

# 将ls -l命令执行结果重定向到文件描述符100
exec 100< <(ls -l)

#定义变量
num=1
#通过循环从文件描述符100读取数据行
while read line; do
	#输出数据
	echo "LINE $num: $line"
	num=$[ $num+1 ]
done <&100
#关闭文件描述符
exec 100>&-
echo "End"
