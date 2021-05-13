#! /usr/bin/bash

res=`join student.txt phone.txt > contactjoin.txt`
cat contactjoin.txt
