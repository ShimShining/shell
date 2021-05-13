#! /usr/bin/bash

#自定义页眉
str=`pr -h " List of System" -a -f 4 demo.txt`
echo "$str"
