#! /usr/bin/bash

#使用条件测试判断/usr/bin/bash是否是一个常规文件
if [ -f /usr/bin/bash ]
then echo "/usr/bin/bash is a normal file"
fi
