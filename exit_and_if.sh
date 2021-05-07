#! /usr/bin/bash

#如果文件已存在则直接退出
if [ -e "$1" ]
then
	echo "File $1 exists."
	exit 1
else 
	touch "$1"
	echo "file $1 has been created."
	exit 0
fi
