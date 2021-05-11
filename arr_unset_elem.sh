#! /usr/bin/bash

linux=(Debian RedHat Ubuntu Suse Fedora UTS Centos)

echo "the old array length is ${#linux[@]}"

#输出原始数组
echo "The old array is ${linux[@]}"

#删除下标为3的元素
unset linux[3]

echo "the length of unset array is ${#linux[@]}"

echo "the new array is: ${linux[@]}"
