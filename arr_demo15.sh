#! /usr/bin/bash

#定义数组
linux[0]="Debian"
linux[1]="RedHat"
linux[2]="Ubuntu"
linux[3]="Suse"

#输出第四个元素
echo "The fourth elem is ${linux[3]}"
#输出第四个元素的长度
echo "The fourth elem length is ${#linux[3]}"
#输出第一个元素
echo "the first elem is ${linux}"
#输出第一个元素的长度
echo "the first elem length is ${#linux}"
