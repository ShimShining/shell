#! /usr/bin/bash

#提取所有行的第一列
cut -d ":" -f 1 user.txt > allusers.txt
echo "all users:"
cat allusers.txt

#使用-s参数只提取正确行
cut -s -d ":" -f 1 user.txt > validusers.txt
echo "valid users:"
cat validusers.txt
