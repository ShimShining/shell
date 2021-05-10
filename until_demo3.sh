#! /usr/bin/bash

i=1
until [ $i -eq 21 ]
do
	userdel -r user$i
	let "i++"
done
