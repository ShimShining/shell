#! /usr/bin/bash

str=`cat demo.txt | grep "Suse"`
echo $str

str=`cat demo.txt | grep "Suse."`
echo $str
