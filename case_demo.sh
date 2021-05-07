#! /usr/bin/bash

case "$1" in
	#启动服务
	start)
	log_daemon_msg "Starting resin"
	#如果变量USER不为空,则切换到USER身份,启动Resin
	if test -n "$USER"; then
		su $USER -c """$RESIN_EXE $ARGS $START_ARGS $START_CMD"""1>>$CONSOLE 2>> $CONSOLE
	else
		#输出错误
		err=`$RESIN_EXE $ARGS $START_CMD 2>&1`
		if [ $? != 0 ]; then
			log_daemon_msg $err
		fi
	fi
	
	log_end_msg $?
	;;
	#停止服务
	stop)
	log_daemon_msg "Stopping Resin"
	if test -n "$USER"; then
		su $USER -c """$RESIN_EXE $ARGS shutdown""" 1>> $CONSOLE 2>>$CONSOLE
	else
		err=`$RESIN_EXE $ARGS shutdown 2>&1`
		if [ $? != 0 ]; then
			log_daemon_msg $err
		fi
	fi

	log_end_msg $?
	;;
	#查看服务状态
	status)
	$RESIN_EXE $ARGS status || exit3
	;;
	#重新启动服务
	restart)
	$0 stop
	$0 start
	;;
	#其他情况
	*)
	echo "Usage: $0 {start|stop|status|restart}"
	exit 1
esac
