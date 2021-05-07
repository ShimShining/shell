#! /usr/bin/bash

# 输出字符串
echo hello world!

# 使用$?获取echo语句执行状态
echo $?

#执行一个无效命令
aaaa

# 输出执行状态
echo $?

#退出
exit 122
