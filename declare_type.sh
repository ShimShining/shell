#! /usr/bin/bash

#定义一个变量x,将一个算术赋给他
x=6/3
echo "$x"
#定义变量x为整数
declare -i x
echo "$x"
#将算术式赋值给变量-i x
x=6/3
echo "$x"
#将字符串赋给变量x
x=hello
echo "$x"
#将浮点数赋值给变量x
x=3.14
echo "$x"
#取消变量x的整数属性
declare +i x
x=6/3
echo "$x"
#求表达式的值
x=[6/3]
echo "$x"
#求表达式的值
x=$((6/3))
echo "$x"
#声明只读变量x
declare -r x
echo "$x"
#尝试为只读变量赋值
x=6
echo "$x"
