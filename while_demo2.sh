#! /usr/bin/bash

#提示用户输入数字
echo "Please enter a number between 1 and 10. Enter 0 to exit:"
read num
#while循环开始
while [ $num -ne 0 ]
do
	if [ $num -lt 5 ]; then
		echo "Too small, enter again,enter 0 to exit:"
		read num
	elif [ $num -gt 5 ]; then
		echo "Too big, enten again,enter 0 to exit:"
		read num
	else
		echo "Congratulation,u are right."
		exit 0
	fi
done
