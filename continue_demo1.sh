#! /usr/bin/bash

for i in {1..10}
do
	if [[ "$i%2" -eq 1 ]]; then
		continue;
	fi
	echo $i
done
