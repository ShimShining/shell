#! /usr/bin/bash

#定义变量,设置初值为0
sum=0
#for循环开始,设置起始值为1,结束值为100,步长为2
for var in {1..100..2}
do
	#sum=$[$sum+$var]
	let "sum+=var"
done
echo "The sum is $sum"
