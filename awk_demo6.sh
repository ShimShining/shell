#! /usr/bin/bash

#输出以Tom和Kon开头的行
res=`awk '/^(Tom|Kon)/ {print}' awk_score.txt`
echo "$res"
