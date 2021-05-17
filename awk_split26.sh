#! /bin/awk -f

BEGIN {
	string="5P12p89"
	#使用split分割字符串string(P或者p为分隔符)
	split(string,arr,/[Pp]/)
	print arr[1]
	print arr[2]
	print arr[3]
}
