#! /usr/bin/bash

#替换1-3行的e字母
res=`sed '1,3 s/e/E/g' student.txt`
echo "$res"
