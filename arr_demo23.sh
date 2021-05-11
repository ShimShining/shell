#! /usr/bin/bash

a=(1 2 3 4 5)
#输出替换结果
echo "The replace result are:${a[@]/3/100}"
echo "the old array:${a[@]}"
a=(${a[@]/3/101})
echo "new variable a is: ${a[*]}"
