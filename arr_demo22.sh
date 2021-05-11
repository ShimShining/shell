#! /usr/bin/bash

music=(do re mi fa sol la xi)
#对数组元素切片
str=(${music[4]:1:3})
echo $str
