#! /bin/awk -f

#通过begin模式初始化变量
BEGIN {
	FS="[\t:]"
	RS="\n"
	count=30
	print "The report is about students's scores."
}
