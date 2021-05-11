#! /usr/bin/bash

#定义函数john
jhon(){
	echo "Hello this is Jhon."
}

#定义函数Alice
alice(){
	#调用jhon
#	jhon
	echo "I am alice"
}
#调用函数alice
#alice
sayhello(){
	jhon
	alice
}
sayhello
