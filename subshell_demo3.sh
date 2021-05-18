#! /usr/bin/bash

echo
#输出子shell的层次
echo "subshell level OUTSIDE subshell = $BASH_SUBSHELL"

echo
#定义子shell外面的变量
outer_var=Outer
#圆括号开始
(
	#输出子shell的层次
	echo "Subshell level INSIDE subshell = $BASH_SUBSHELL"
	#定义子shell内的变量
	inner_var=Inner
	#输出子shell的变量
	echo "From subshell \"inner_var\" = $inner_var"
	#输出圆括号外面定义的变量
	echo "From subshell \"Outer_var\" = $outer_var"
)
echo
#输出子shell级别
echo "Subshell lever OUTSIDE subshell = $BASH_SUBSHELL"
echo
#判断INNER变量是否定义
if [ -z "$inner_var" ]; then
	echo "undefine"
else
	echo "DEFINE"
fi

#输出圆括号内定义的变量
echo "FROM main body of shell,\"inner_var\" = $inner_var"
