#! /usr/bin/bash

#使用正则表达式标定位置
res=`sed '1,/^2002013/ s/e/E/g' student.txt`
echo "$res"
