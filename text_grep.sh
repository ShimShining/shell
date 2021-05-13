#! /usr/bin/bash

echo "Please input name:"

read name

while [ $name != e ]
do
	number=`grep -c "$name" user.txt`
	echo "$number lines contains $name."
	echo -n "please input a name:"
	read name
done
