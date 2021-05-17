#! /bin/awk -f

#/^[\t]*$/ {
#next
#}
BEGIN {
	#输出报表头
	print "Scores list:"
}

{
	#gsub 删除空行
	gsub(/^[\t]*$/,"")
	#逐行输出成绩
	printf ("%s\t%d\t%d\t%d\t%d\t%d\n",$1,$2,$3,$4,$5,($2+$3+$4+$5))

	#计算总成绩
	total+=$2+$3+$4+$5
}
END {
	#计算平均分
	average=total/NR
	#格式化统计结果
	sum=sprintf("Total: %d students, average: %.2f",NR,average)
	print sum
}
