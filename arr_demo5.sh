#! /usr/bin/bash

#声明数组
declare -A array
#为数组赋值
array=([flower]=rose [fruit]=apple)

#输出第一个元素
echo "the first element is ${array[flower]}"
#输出第二个元素
echo "the second element is ${array[fruit]}"
#输出数组的长度
echo "the length is ${#array[@]}"
