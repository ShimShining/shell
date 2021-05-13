#! /usr/bin/bash

# 拼接指定的文本列
# cut选取第一个文本列存储为文件
cut -d " " -f 1 student.txt > student.tmp
#选取第二个文件的列存储为文本
cut -d " " -f 2 phone.txt > phone.tmp
#paste拼接选取后的文本

paste student.tmp phone.tmp > contactinfo.txt

cat contactinfo.txt


