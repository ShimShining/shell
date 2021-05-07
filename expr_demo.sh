#! /usr/bin/bash

#计算2和100的差 = -98
result=`expr 2 - 100`
echo "$result"
#计算2+100=102
result=`expr 2 + 100`
echo $result
#计算2X5=10
result=`expr 2 \* 5`
echo $result
#计算24除以3=8
result=`expr 24 / 3`
echo $result
#组合计算
result=`expr \( 2 - 6 \) \* 12`
echo $result
#错误的语法
result=`expr 2+5`
echo $result
#错误的语法
result=`expr 2-4*9`
echo $result
#错误的语法
result=`expr 1-(4-7) `
echo $result
