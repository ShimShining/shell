#! /usr/bin/bash

#输出所有参数
echo "$*"
#将参数作为列表条件
for arg in $*
do
	echo "$arg"
done
