#! /usr/bin/bash

#定义调试开关
export DEBUG=false

#调试函数
DEBUG()
{
	if [ "$DEBUG" == "true" ]; then
		$@
	fi
}

a=1
#调用调试函数
DEBUG echo "a=$a"

if [ $a -eq 1 ]; then
	b=2
else
	b=1
fi
#调用调试函数
DEBUG echo "b=$b"
c=3
#调用调试函数
DEBUG echo "c=$c"
