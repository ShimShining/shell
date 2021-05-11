#! /usr/bin/bash

#定义数组
mus=(do re mi fa sol la xi)

#切片后再是数组
arr=(${mus[@]:2:4})
echo "slice arr length is ${#arr[@]}"

for (( i=0; i<${#arr[@]}; i++ ))
do
	echo "${arr[$i]}"
done
