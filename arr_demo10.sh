#! /usr/bin/bash

#定义数组
declare -A arr
#初始化数组
arr=([a]=a [b]=b)

echo "the old arr are: ${arr[@]}"
#追加元素
arr[c]=c

echo "the new arr are: ${arr[*]}"
