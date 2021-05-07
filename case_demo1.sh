#! /usr/bin/bash

#输出提示信息
echo "Hit a key,then hit return."
#读取用户按下的键
read keypress
#case语句开始
case "$keypress" in
	#小写字母
	[[:lower:]])
		echo "Lowercase letter.";;
	[[:upper:]])
		echo "Uppercase letter.";;
	[0-9])
		echo "Digit.";;
	*)
		echo "other letter."
esac
