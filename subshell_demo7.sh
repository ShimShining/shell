#! /usr/bin/bash

#创建名称为fifo的命名管道
if [ ! -e fifo ]; then
	mkfifo fifo
fi

#子shell
(
	x=500
	echo $x > fifo
) &
#从管道中读取数据
read y < fifo
echo $y


