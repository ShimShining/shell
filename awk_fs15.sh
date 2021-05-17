#! /bin/awk -f

BEGIN {
	#定义记录分隔符
	RS=""
	#定义字段分隔符
	FS="\n"
}

#输出第一个字段
{ print $1}
