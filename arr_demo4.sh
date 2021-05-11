#! /usr/bin/bash

#定义数组
array=([1]=one [4]=four)

#输出数组长度
echo "the array length is ${#array[@]}"

#输出第四个元素
echo "the fouth element is ${#array[4]}"
