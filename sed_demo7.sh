#! /usr/bin/bash

result=`sed 's/string/long &/' sed_demo.txt`

echo "$result"
