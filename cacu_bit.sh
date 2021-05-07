#! /usr/bin/bash

res=$[ 2<<3 ]
echo $res
res=$[ 8 >> 2 ]
echo $res
res=$[ 8&4 ]
echo $res
res=$[ ~8 ]
echo $res
res=$[ 10 ^ 6 ]
echo $res
