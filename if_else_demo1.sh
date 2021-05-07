#! /usr/bin/bash

#输出提示信息
echo "Please enter a Number:"
#从键盘读取用户输入的数字
read num
#如果用户输入的数字大于10
if [ "$num" -gt 10 ]; then
	echo "the number id greater 10,num={$num}"
else
	echo "the number is equal or less than 10,num=${num}"
fi
