#! /usr/bin/bash

#定义循环变量
i=1
#while循环开始
while [ $i -lt 10 ]
do
	let "squre=i*i"
	echo "$i*$i=$squre"
	let "i++"
done
