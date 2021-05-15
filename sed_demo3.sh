#! /usr/bin/bash

echo "substitute the first pattern."
#只将每行中第1次出现的小写字母e替换为大写字母
result=`sed 's/e/E/' student.txt`
echo "$result"

echo "substitute all the patterns."
result=`sed 's/e/E/g' student.txt`
echo "$result"
