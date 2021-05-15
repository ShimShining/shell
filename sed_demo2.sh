#! /usr/bin/bash

#使用正则表达式定位
result=`sed -n '/^2002003/ p' student.txt`

echo "$result"
