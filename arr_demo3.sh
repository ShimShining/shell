#! /usr/bin/bash

#定义数组
array=(1 2 3 4 5 6 7 8)
#输出第一个数组元素
echo "the first element is ${#array[0]}"

#输出所有元素的值
echo "all elements are ${array[@]}"

#输出数组长度
echo "the length of arr is ${#array[@]}"
