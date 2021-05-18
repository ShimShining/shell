#! /usr/bin/bash

#定义响应函数
function signal_handle { 
	echo "Good Bye."
}

#绑定响应函数
trap signal_handle 0
