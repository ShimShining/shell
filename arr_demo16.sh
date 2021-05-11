#! /usr/bin/bash

#定义数组
arr=(mon tue wed thu fri sat sun)
for i in {0..6}
do
	echo "${arr[$i]}"
done
