#! /usr/bin/bash

#删除第一行
result=`sed -e '1 d' student.txt`
echo "$result"

echo "=========================="
#删除最后一行
res=`sed -e '$ d' student.txt`
echo "$res"
