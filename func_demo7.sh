#! /usr/bin/bash

var="Hello Global var"

func()
{
	local var="Hello local var"
	echo "func inner var=$var."
	# 局部变量var2
	local var2="hello local var2"
}

echo $var
func
echo $var
echo "$var2"
