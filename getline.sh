#! /usr/bin/bash

get_line()
{
	string=$1
	file=$2
	line=`grep -n $string $file`
	if [ $? -eq 0 ]; then
		printf "$tring is found as the %drd line in $file \n" `echo $line | cut -f1 -d:`
		num=`grep $string $file | wc -l`
		res=0
	else
		printf "$tring is not found in $file \n"
		num=0
		res=1
	fi
	return $res

}

if [ ! -f testfile.$$ ]; then
	cat >> testfile.$$ <<EOF
first line
second line
third line
EOF
fi

num=0
res=o
for i in second six line
do
	echo
	get_line "$i" testfile.$$
	echo "return value: $res"

	if [ $num -gt 0 ]; then
		echo "$num occurences found totally."
	fi
done
