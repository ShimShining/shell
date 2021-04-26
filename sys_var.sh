#! /usr/bin/bash

#输出脚本的参数个数
echo "the number of parameter is $#"
#输出上一个命令的退出状态码
echo "the return code of last command is $?"
#输出当前脚本名字
echo "the current script is $0"
#输出所有的参数
echo "the parameter are $*"
#输出其中几个参数值
echo "\$1 = $1, \$7 = $7, \$11 = ${11}"
