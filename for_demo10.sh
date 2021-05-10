#! /usr/bin/bash

#定义数组
array=(Monday Tuesday Wednesdat Thursday Friday Saturday Sunday)
#for循环遍历数组
for day in ${array[*]}
do
	echo "Current day is $day"
done
