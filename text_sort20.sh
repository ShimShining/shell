#! /usr/bin/bash

if [ $1 -gt 5 ]; then
	echo "column no. could not greater than 5."
	exit
fi

#进指定起始列
res=`sort -r -k $1 stocks.txt`
echo "$res"
