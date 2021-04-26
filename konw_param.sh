#! /usr/bin/bash

#定义变量x,并且赋初值123
x=123
#param x add 1
let "x += 1"
#print x value
echo "x = $x"
#output space line
echo
#replace param x 1 to abc,and save it in param y
y=${x/1/abc}
#output param y value
echo "y = $y"
#declare param y
declare -i y
#output y value
echo "y = $y"
#param y add 1
let "y += 1"
#print y value
echo "y = $y"
#output space line
echo
#assign str to variable z
z=abc22
#print variable z value
echo "z = $z"
#replace variable z abc to number 11,and assign to variable m
m=${z/abc/11}
#print variable m 
echo "m = $m"
#variable m add 1
let "m += 1"
#print m value
echo "m = $m"

echo
#assign empty str to variable n
n=''
#print n
echo "n = $n"
#variable n add 1
let "n += 1"
echo "n = $n"
echo
#print null variable p value
echo "p = $p"
#variable p add 1
let "p += 1"
echo "p = $p"
