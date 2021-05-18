#! /usr/bin/bash

#Apache httpd进程监控shell

#启动服务命令
RESTART="/sbin/service httpd start"

#pgrep路径
PGREP="/usr/bin/pgrep"

#Apache web 服务进程名称
HTTPD="httpd"

#查找httpd进程
$PGREP $(HTTPD) &>/dev/null
#如果没有找到服务,则重新启动
if [ $? -ne 0 ]; then
	$RESTART
fi
