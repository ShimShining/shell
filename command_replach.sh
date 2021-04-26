#! /usr/bin/bash

#变量替换
v1=`pwb`
echo "the current working dir is $v1"
v2=$(ls .)
echo "the current dir files: $v2"
