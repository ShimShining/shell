#! /usr/bin/bash

#捕获DEBUG信号
trap 'echo "Before execute line:$LINENO,a=$a,b=$b,c=$c"' DEBUG

#定义变量a
a=1

if [ $a -eq 1 ]; then
	b=2
else
	b=1
fi
#定义变量c
c=3

echo "END"
