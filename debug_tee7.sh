#! /usr/bin/bash

#将文件名转换为大写
list=`ls -l | tee list.txt | awk '{print toupper($9)}'`

echo $list
