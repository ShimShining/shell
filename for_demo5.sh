#! /usr/bin/bash

#使用ls命令的执行结果作为列表循环
for file in $(ls)
do
	echo " The file name is $file."
done
