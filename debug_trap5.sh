#! /usr/bin/bash

#定义信号处理函数
ERRTRAP()
{
	echo "[LINE:$1] Error:Command or function exited with status code $?"
}

#定义函数
func()
{
	return 1
}

#使用trap命令捕获err信号

trap 'ERRTRAP $LINENO' ERR
#调用错误的命令
abc
#调用函数
func
