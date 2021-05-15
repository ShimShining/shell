#! /usr/bin/bash

#使用分号隔开多个命令
res=`sed -e 's/e/E/g;2 i 2002018 Time' student.txt`
echo "$res"
