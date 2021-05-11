#! /usr/bin/bash

#定义两个数组
mus=(do re mi fa sol la xi)
simple=(1 2 3 4 5 6 7)

#连接数组
music=("${mus[@]}" "${simple[@]}")
echo "new array is:${music[@]}"

#输出新数组的长度
echo "new array length is ${#music[@]}"
