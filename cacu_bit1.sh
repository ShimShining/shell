#! /usr/bin/bash

x=5

let "x<<=4"
echo $x

let "x>>=2"
echo $x

let "x|=2"
echo $x
