#! /bin/awk -f

BEGIN {
	#为数组元素赋值
	arr[1]="Tim"
	arr[2]="Jhon"
	arr["a"]=12
	arr[3]=3.1415
	arr[4]=5
	#输出数组元素值
	print arr[1],arr[2],arr["a"]*arr[3],arr[4]
}
