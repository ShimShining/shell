#! /usr/bin/bash

#查找包含ps字符串的进程
ps -ef | grep ps
#显示当前shell的层次
echo $SHLVL
#查找执行subshell_demo2.sh的进程id
pidof -x subshell_demo2.sh

exit 0
