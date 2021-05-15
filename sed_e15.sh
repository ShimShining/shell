#! /usr/bin/bash

#将所有小写e替换为大写E,然后打印2-3行
res=`sed -n -e 's/e/E/g' -e '2,3 p' student.txt`
echo "$res"
