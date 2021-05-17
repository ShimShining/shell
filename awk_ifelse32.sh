#! /bin/awk -f

{
	#90分以上为A
	if ($2 >= 90){
		print $1,"A"
	}
	else {
		# 80分以上为B
		if ($2 >=80){
			print $1,"B"
		}
		else {
			print $1,"C"
		}
	}
}
