#! /usr/bin/bash

#通过数字来引用模式中的子串
result=`sed 's/\(This\) \(is\) \(a\) \(string\)/\2 \1 \3 \4/' sed_demo.txt`

echo "$result"
