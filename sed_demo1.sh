#! /usr/bin/bash

#输出1-3行,不使用-n选项
sed '1,3p' student.txt

echo "---------------------"
#输出1-3行,使用-n选项
sed -n '1,3p' student.txt
