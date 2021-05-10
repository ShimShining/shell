#! /usr/bin/bash

#定义循环变量i
i=1
#当i的值小于9时执行循环体
until [ $i -gt 9 ]
do
	let "square=i*i"
	echo "$i*$i=$square"
	let "i=i+1"
done
