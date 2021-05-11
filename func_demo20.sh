#! /usr/bin/bash

#利用间接变量引用统计递归函数的调用次数

fact()
{
	local i=$1
	local k=$2

	if [ $i -eq 0 ]; then
		eval ${k}=1
		res=1
	else
		let "m=i-1"
		fact "$m" ${k}
		let "res=i*res"
		local j=${!k}
		eval ${k}=`expr ${j} + 1`
	fi
	return $res
}
level=0
fact $1 level
echo "The fact of $1 is: $res."
echo "The function of fact is invoked $level times."
