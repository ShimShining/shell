#! /usr/bin/bash

linux=(Debian Redhat Ubuntu Suse Fedora UTS Centos)

#数组切片
echo ${linux[@]:2:4}
