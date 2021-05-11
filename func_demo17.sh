#! /usr/bin/bash

#定义递归函数
func()
{
	read y
	func "$y"
	echo "$y"
}

#调用函数
func
