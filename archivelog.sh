#! /usr/bin/bash

#归档文件名生成函数
function filename()
{
	timestamp=$(date +%Y%m%d%H%M%S)
	echo "$1".$timestamp."tar"
}

#过期日志归档
function archivelog()
{
	archivefile=`filename httpd_log`
	archivedest=$1

	if [ ! -d $archivedest ]; then
		mkdir -p $archivedest
	fi

	cd /var/log/httpd

	find . -mtime +1 -exec tar -rf $archiverdest$archivefile {} \;

	zip $archivedest$archivefile".zip" $archivedest$archivefile

	if [ $? -eq 0 ]; then
		rm -rf $archivedest$archivefile
	fi

	return $?
}

#已归档日志删除函数
function removearchivelog() {
	cd /var/log/httpd

	find . -mtime +1 -exec -f $archivedest$archivefile {} \;
}

#将过期日志归档
archivelog "/root/chapter15/"

#删除已归档日志
if [ $? -eq 0 ]; then
	removearchivelog
fi

exit 0
