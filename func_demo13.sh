#! /usr/bin/bash

#定义全局变量
file="/bin/ls"
#定义函数
func()
{
	if [ -e "$file" ]; then
		echo "the file exists."
	else
		echo "the file doesn't exist."
	fi
}
# 调用函数
func

# 修改全局变量
file="bin/a"
#再次调用函数
func
