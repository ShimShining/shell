#! /usr/bin/bash

#外层循环
for i in a b c d
do
	echo -n "$i "
	for j in `seq 10`
	do
		if [ $j -eq 5 ]; then
			break 2;
		fi
		echo -n "$j "
	done
	echo
done
