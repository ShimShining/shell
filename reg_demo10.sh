#! /usr/bin/bash

str=`cat demo.txt | grep -P "^UTS\d"`

echo $str
