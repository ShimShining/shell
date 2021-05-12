#! /usr/bin/bash

str=`cat demo.txt | grep "^UTS"`
echo $str

str=`cat demo.txt | grep "^UTS[0-9]"`
echo $str
