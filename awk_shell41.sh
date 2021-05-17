#! /bin/awk -f

BEGIN {
	#通过管道符获取who命令的执行结果
	while ("who" | getline) n++
		printf("There are %d online users.\n",n)
}
