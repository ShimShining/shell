#! /bin/awk -f

#当读取到空行时跳过后面的语句
/^[\t]*$/ {
	next
}
# 输出各字段
{
	print
}
