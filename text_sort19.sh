#! /usr/bin/bash

#通过第3列和第4列排序
result=`sort -k 3,4 stocks.txt`

echo "$result"
