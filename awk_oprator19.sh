#! /bin/awk -f

BEGIN {
	#简单赋值
	x=4
	print x
	#求和赋值表达式
	x+=10
	print x
	#乘积赋值
	x*=2
	print x
	#幂运算赋值
	x^=2
	print x
}

