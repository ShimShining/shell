#! /usr/bin/bash

func()
{
	#在函数内部定义变量
	v2=200
}
#调用函数
func
echo "$v2"
