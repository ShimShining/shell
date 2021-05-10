#! /usr/bin/bash

#九九乘法表
#外层循环
for (( i=1; i<10; i++))
do
	#内层循环
	for (( j=1; j<=i; j++))
	do
		let "mul=i*j"
		printf "$i*$j=$mul"
		if [ $mul -gt 9 ]; then
			printf "   "
		else
			printf "    "
		fi
	done
	echo
done
