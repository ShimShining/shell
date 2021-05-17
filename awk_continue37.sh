#! /bin/awk -f

BEGIN {
	while(getline < "awk_score.txt" > 0){
		if($1 == "Kity")
			continue
		else
			print $1,$2,$3,$4,$5
	}
}
