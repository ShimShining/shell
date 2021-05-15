#! /usr/bin/bash

result=`sed 's/<[^>]*>//g' a.html`

echo "$result"
