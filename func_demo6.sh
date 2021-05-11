#! /usr/bin/bash

# 在函数外定义全局变量
var="hello world"

func()
{
	var="orange apple banana"
	echo "$var"
	# 在函数内部定义全局变量
	var2="Hello shin"
}

#输出变量var
echo "$var"

func
# 重新输出变量var
echo "$var"

# 输出函数内部定义的全局变量var2
echo "$var2"
