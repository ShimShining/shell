#! /usr/bin/bash

#根据第4列的第14-14个字符进行排序,并输出到文件
sort -t ' ' -n -k 4.14,4.15 demo7.txt > sorted_log.log

cat sorted_log
