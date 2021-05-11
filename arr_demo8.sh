#! /usr/bin/bash

#定义数组
a=(a b c def)
#输出数组所有元素
echo "the old elements are: ${a[@]}"

#为数组重新赋值
a=(h i j k l)
#输出数组所有的元素
echo "the second elements are: ${a[*]}"

a=(m n)
echo "last elements: ${a[@]}"
