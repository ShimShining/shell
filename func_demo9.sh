#! /usr/bin/bash

#定义函数
func()
{
	# 输出所有参数
	echo "all parameters are $*"
	# 输出所有的参数
	echo "ALL parameters are $@"
	#输出脚本名称
	echo "the script's name is $0"
	#输出第一个参数
	echo "The first parameter is $1"
	#输出第二个参数
	echo "The second paramter is $2"
	# 输出第三个参数
	echo "The third parameter is $3"
}

# 调用函数
func hello world
