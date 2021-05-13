#! /usr/bin/bash

if [ $1 -gt 5 ]; then
	echo "Column no.could not be greater than 5."
	exit
fi

res=`sort -k $1,$1 stocks.txt`
echo "$res"
