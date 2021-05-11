#! /usr/bin/bash

for i in {1..10}
do
	array[$i]=$i
done
echo "${array[@]}"
