#! /usr/bin/bash

str=`cat demo.txt | egrep "(U|Su|^F)"`
echo $str
