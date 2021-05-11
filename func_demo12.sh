#! /usr/bin/bash

#定义函数
func()
{
	echo "$1"
}

#定义变量
var=name
name=shining
#调用函数
func $var
func $name
func ${!var}
#修改变量的值
name=Alice
func $var
func ${!var}
