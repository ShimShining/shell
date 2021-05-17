#! /bin/awk -f

#输出表头
BEGIN {
	print "Scrore Report:"
	print "============================="
}
#输出数据
{print}
#报表完成
END {
	print "============================="
	print "Printing is over."
}
