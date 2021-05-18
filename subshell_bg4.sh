#! /usr/bin/bash

#输出开始提示信息
echo "Before starting subshell"
#圆括号结构开始
(
	count=1
	while [ $count -le 10 ]
	do
		echo $count
		sleep 1
		(( count++ ))
	done
) &
echo "Finished"
