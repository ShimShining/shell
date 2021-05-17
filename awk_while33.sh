#! /bin/awk -f

BEGIN {
	#定义循环变量
	i=0
	#while循环开始
	while (++i <=9)
	{
		#输出循环变量的平方
		print i^2
	}
}
