#! /usr/bin/bash

#在第二行后面追加文本
result=`sed '2 a 2002019 Tom' student.txt`
echo "$result"
