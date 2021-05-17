#! /bin/awk -f

BEGIN {
	#定义数组
	stu[1]="200200110"
	stu[2]="200200164"
	stu[3]="200200167"
	stu[4]="200200168"
	stu[5]="200200172"

	#计算数组长度
	len=length(stu)

	#通过for循环遍历数组
	for (i=1; i<=len; i++){
		print i,stu[i]
	}
}
