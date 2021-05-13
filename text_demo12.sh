#! /usr/bin/bash

#指定行宽度
str=`fmt -c -w 80 demo.txt`
echo $str

#不合并不足指定行宽的行
str=`fmt -s -c -w 80 demo.txt`
echo $str
