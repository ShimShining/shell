#! /usr/bin/bash

#定义函数
error()
{
	echo "ERROR:" $@ 1>&2
}

warning()
{
	echo "WARNING:" $@ 1>&2
}
