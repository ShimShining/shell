#! /bin/awk -f

BEGIN {
	#定义循环变量
	i=1
	do
	{
		print i^2
	}while (++i <= 9)
}
