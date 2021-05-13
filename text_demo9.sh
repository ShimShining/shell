#! /usr/bin/bash

#双层嵌套循环输出乘法表
for (( i=1; i<=9; i++ ))
do
	for (( j=1; j<=i; j++ ))
	do 
		echo -n -e "$i*$j\t"
	done
	echo ""
done

