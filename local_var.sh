#! /usr/bin/bash

#定义函数
func()
{
	#使用local关键字定义局部变量
	local v2=200
}
#调用函数
func
#输出local 变量v2的值
echo "v2 = $v2"
