#! /usr/bin/bash

#输出提示信息
echo "please enter a number: "
#读取用户输入
read num
#如果用户没有输入,则提示用户重新输入
if [ -z "$num" ]; then
	echo "You enter nothing,please enter a number: "
	read num
else
	#若果用户输入的数据不对,则重新输入
	if [ "$num" -lt 0 -o "$num" -gt 100 ]; then
		echo "the number should be between 0 and 100,please enter again:"
		read num
	fi
fi
if [ "$num" -ge 90 ]; then
	echo "The Grade is A."
else
	if [ "$num" -ge 80 ]; then
		echo "The grade is B."
	else
		if [ "$num" -ge 70 ]; then
			echo "The grade is C."
		else
			if [ "$num" -ge 60 ]; then
				echo "The grade is D."
			else
				echo "The grade is E."
			fi
		fi
	fi
fi
