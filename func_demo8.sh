#! /usr/bin/bash

#定义函数
func()
{
	# 输出参数个数
	echo "the function has $# params."
}

# 调用函数
func a b c d e f g h g hello
func 12 3 "hello word"
func
