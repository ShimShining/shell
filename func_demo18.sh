#! /usr/bin/bash

#定义递归函数
fact()
{
	#定义阶乘起始值
	#reslut=1
	#定义局部变量
	local n="$1"
	if [ "$n" -eq 0 ]; then
		result=1
	else
		let "m=n-1"
		fact "$m"
		let "result=n * result"
	fi
	#将计算结果以退出码的形式返回
	#echo "$result"
	return $result
}

#调用递归函数
#res=$(fact "$1")
fact "$1"
#echo "Factorial of $1 return is $res"
echo "Factorial of $1 is $result"
