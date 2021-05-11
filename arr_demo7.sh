#! /usr/bin/bash

#定义数组
students=(Jhon Rose Tom Tim)

#输出元素的值
echo "the old students are: ${students[*]}"

#改变第一个元素值
students[0]=Susan

#改变第四个元素的值
students[3]=Jack
#输出新数组
echo "the new students are: ${students[*]}"

#声明关联数组
declare -A grades

grades=([jhon]=90 [rose]=88 [tim]=79 [tom]=89 [jack]=75)
#输出关联数组元素
echo "the old grades are: ${grades[@]}"
#改变tim的分数
grades[tim]=91
#重新输出分数
echo "the new grades are: ${grades[@]}" 
