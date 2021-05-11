#! /usr/bin/bash

#定义求和函数
sum(){
	let "z=$1 + $2"
	# 将和作为退出状态码
	return $z
}
sum 253 4
echo $?
