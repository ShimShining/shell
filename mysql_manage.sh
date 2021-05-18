#! /usr/bin/bash

#Mysql服务脚本
#指定运行级别以及优先级
#chkconfig: - 64 36
#description: MySQL database server

#定义常量和函数
#mysql服务主程序的路径
mysql="/usr/bin/mysqld_safe"

#Mysql管理工具路径
mysqladmin="/usr/bin/mysqladmin"

#定义获取mysql选项的函数
get_mysql_option()
{
	#使用my_print_defaults命令输出各个选项
	result=`/usr/bin/my_print_defaults "$1" | sed -n "s/^--$2=//p" |tail -n 1`

	#如果文件不存在则使用默认值
	if [ -z "$result" ]; then
		result="$3"
	fi
}
#数据库文件路径
get_mysql_option mysqld datadir "/var/lib/mysql"

datadir="$result"

#Socket文件路径
get_mysql_option mysqld socket "$datadir/mysql.sock"
socket_file="$result"

#日志文件路径
get_mysql_option mysqld_safe log-error "/var/log/mysqld.log"
errlogfile="$result"

#进程ID文件
get_mysql_option mysqld_safe pid-file "/var/run/mysqld/mysqld.pid"
mypidfile="$result"

#定义状态处理函数
start() {
	#如果程序不可执行,则直接退出
	[ -x $mysql ] || exit 5
	#判断服务进程是否存在
	/usr/bin/mysqladmin --socket="$socketfile" --user=mysql ping 2>&1
	if [ $? = 0 ]; then
		echo "mysql has been already running."
		ret=0
	else
		if [ ! -d "$datadir/mysql" ]; then
			echo "mysql database dose not exist."
			exit 1
		fi

		$mysql --datadir="$datadir" --socket="$socketfile" --pid-file="$mypidfile" --basedir=/usr --user=mysql >/dev/null 2>&1 $
		ret=$?

		if [ $ret -eq 0 ]; then
			touch $lockfile
		else
			echo "start mysql failed."
		fi
	fi
	return $ret
}
stop() {
	#如果进程文件不存在,则直接退出
	if [ ! -f "$mypidfile" ]; then
		echo "mysql is not running."
		return 0
	fi
	#从进程文件中读取进程id
	mysqlpid=`cat "$mypidfile"`
	#如果进程id是整数,则调用mysqladmin停止mysql服务
	if [ -n "$mysqlpid" ]; then
		$mysqladmin --socket="socketfile" --user=root shutdown
		ret=$?
		#如果停止成功,则删除锁定文件和socket文件
		if [ $ret -eq 0 ]; then
			rm -f $lockfile
			rm -f "$socketfile"
			echo "mysql stopped."
			ret=0
		else
			echo "Stopping mysql failed."
			ret=1
		fi

	fi
	return $ret
}
restart() {
	stop
	start
}

#根据参数值执行相应操作
case "$1" in
	#启动服务
	start)
		start
		;;
	#停止服务
	stop)
		stop
		;;
	#查看状态
	status)
		#re=`pidof "$procname"`
		#if [ "$re" -gt 0 ]; then
		#	echo "mysql is running."
		#else
		#	echo "mysql is not running."
		#fi
		if [ -n pidof "$procname" ]; then
			echo "mysql is running."
		fi
		;;
	restart)
		restart
		;;
	*)
		echo $"Usage: $0 (start|stop|status|restart)"
		exit 2
esac
exit $?		
