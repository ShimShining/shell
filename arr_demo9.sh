#! /usr/bin/bash

#定义数组
arr=(1 2)
#输出数组
echo "the old arr are:${arr[@]}"

#向数组追加元素
arr[2]=3
arr[3]=4
echo "add arr are: ${arr[@]}"
