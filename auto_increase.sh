#! /usr/bin/bash

x=7
x=$[ x+ (++x) ]
echo $x

x=$[ --x ]
echo $x

x=$((x++))
echo $x

x=$(( x--))
echo $x
