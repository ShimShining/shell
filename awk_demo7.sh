#! /usr/bin/bash

#混合模式
res=`awk '/^K/ && $2 > 80 {print}' awk_score.txt`

echo "$res"
