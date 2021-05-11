#! /usr/bin/bash

#定义函数
length()
{
	# 接受参数
	str=$1
	result=0
	if [ "$str" != "" ]; then
		# 计算字符串长度
		result=${#str}
	fi
	# 将长度值写入标准输出
	echo "$result"
}

# 调用函数
len=$(length "abcd123")
echo "the string length is $len"

