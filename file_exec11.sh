#! /usr/bin/bash

#创建标准错误副本
exec 99>&2

#将标准错误重定向到errlog
exec 2> errlog
#执行命令ls -lw
ls -lw
#恢复标准错误
exec 2>&99
#关闭文件描述符
exec 99>&-
