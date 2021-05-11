#! /usr/bin/bash

arr=(do re mi fa sol la xi)
len="${#arr[@]}"
#通过循环遍历数组
for (( i=0; i<$len; i++))
do
	echo "${arr[$i]}"
done
