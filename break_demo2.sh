#! /usr/bin/bash

for (( i=1; i<=9; i++ ))
do
	for (( j=1; j<=i; j++ ))
	do
		let "mul=i*j"
		printf "$i*$j=$mul"
		if [ $mul -gt 9 ]; then
			printf "   "
		else
			printf "    "
		fi
		if [ $j -eq 5 ]; then
			break 2;
		fi
	done
	echo
done
