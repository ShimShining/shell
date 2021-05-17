#! /bin/awk -f

BEGIN {
	#循环读取数据
	while (getline < "awk_score.txt" >0){
		#当第一个字段为Kity时退出
		if ($1 == "Kity")
			break
		else
			print $1,$2,$3,$4,$5
	}
}
