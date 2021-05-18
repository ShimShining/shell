#! /usr/bin/bash

(
	##在子shell中定义变量
	x=500
	#将变量x的值存储到临时文件tmp
	echo $x > tmp
)
#在父shell中直接引用x的值
echo "direct x=$x"
#从临时文件中读取
read b <tmp
echo $b
