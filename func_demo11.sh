#! /usr/bin/bash

#定义函数
func()
{
	#逐个接收选项及其参数
	while getopts "a:b:c" arg
	do
		case "$arg" in
			a)
				#输出-a选项参数
				echo "a's arg is $OPTARG"
				;;
			b)
				#输出-b选项参数
				echo "b's arg is $OPTARG"
				;;
			c)
				echo "c"
				;;
			?)
				#未知选项
				echo "unknown arg"
				;;
		esac
	done
}

func -a hello -b world
