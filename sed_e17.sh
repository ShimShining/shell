#! /usr/bin/bash

#组合命令
result=`sed -n '1,5 {
	s/e/E/g
	s/a/A/g
	2 i 2002017 Tome
	p
}' student.txt`
echo "$result"
