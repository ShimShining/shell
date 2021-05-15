#! /usr/bin/bash

#删除第1-4行
res=`sed -e '1,4 d' student.tx`
echo "$res"
echo "======================="
#删除奇数行
res=`sed -e '1~2 d' student.txt`
echo "$res"
echo "======================="
#删除偶数行
res=`sed -e '0~2 d' student.txt`
echo "$res"
echo "========================"
#删除第一行开始到匹配2002013行
res=`sed -e '1,/^2002013/ d' student.txt`
echo "$res"
echo "=========================="
# 删除第4行到最后
res=`sed -e '4,$ d' student.txt`
echo "$res"
