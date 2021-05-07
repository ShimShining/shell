#! /usr/bin/bash

echo "Please enter a score: "
read score

if [ -z "$score" ]; then
	echo "You enter nothing,please enter a score: "
	read score
else
	if [ "$score" -lt 0 -o "$score" -gt 100 ]; then
		echo "The score shoule be between 0 and 100,please enter again: "
		read score
	fi
fi

if [ "$score" -ge 90 ]; then
	echo "The grade is A."
elif [ "$score" -ge 80 ]; then
	echo "The grade is B."
elif [ "$score" -ge 70 ]; then
	echo "The grade is C."
elif [ "$score" -ge 60 ]; then
	echo "The grade is D."
else
	echo "The grade is E."
fi
