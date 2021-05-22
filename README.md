# 0.书籍信息
- author: 张春晓
- 版次,印次: 2014,12,2019,8
- 章节目录
    - 1.认识shell编程(1-2章)
    - 2.shell编程基础(3-13章)
    - 3.shell编程实战(14-15章)
- 学习计划
    - 先看书本章节
    - 再看对应章节PPT
    - 上机练习
- 预计花费40h (差不多10d)
- 实际花费60+h (历时30d)
- 整体感觉较为基础,课程章节内容较为断裂,无循序渐进的联系,且某些地方讲的不怎么清晰,需要较好的Linux基础
---
# 1.第一章:shell入门基础
## 为什么学shell编程
- 简化系统管理员日常维护工作
- 从重复劳动中解脱出来
- shell程序的特点
    - 简单易学
    - 解释性语言,无需编译
## 什么是shell
- 1979年 第一个重要的标准Unix shell在第七版中退出,以作者Stephen Bourne名字命名,叫做Bourne shell,简称sh
- 20世纪70年代末,BSD UNIX发布c shell,简称csh
- tsh,ksh,bash...zsh
- shell又称命令解释器
- 识别用户输入的各种命令,并传递给操作系统
- shell既是用户交互的界面,也是控制系统的脚本语言
- 1987 Bourne-Again Shell,简称bash
- shell作为程序设计语言,实现许多功能,提高系统管理的自动化水平
## shell程序执行
- 交互式执行
- 作为程序文件执行
- 对于需要经常重复执行的shell语句,将它们保存在文件中来执行
- 包含多个shell语句的文件称为shell脚本,可以使用任何的文本编辑器查看或者修改shell脚本文件
- 示例脚本
```
#! /bin/sh
# for循环开始                                               
for filename in `ls .`                                  
do                                                          
# 如果文件包含txt                                                 
if echo "$filename" | grep "txt"                              
then                                                          
# 输出文件名                                                  
echo "$filename"                                       
fi                                                  
done   
```
- 将脚本编辑完成后,脚本文件需要给用户加上可执行权限
```
# 添加可执行权限
chmod u+x hello.sh
# 执行脚本
./hello.sh
```
## 向shell脚本传递参数
- shell脚本可以接受用户输入,根据用户输入的参数值来执行不同的操作
- shell脚本参数
    
变量 | 说明
--- | ---
$n | 表示传递给脚本的第n个参数,$1表示第一个参数,$2表示第2个参数
$# | 命令行参数个数
$0 | 当前脚本的名称
$* | 以"参数1 参数2 参数3..."的形式返回所有参数的值
$@ | 以"参数1""参数2""参数3"...的形式返回所有参数的值
$_ | 保存之前执行的命令最后一个参数
- 示例代码如下
```
#! /bin/bash

echo "$# parameters"
echo "$@"
```
### 参数扩展
- 参数扩展是通过选项名称来获取选项的值,不依靠参数的位置
- 可以通过getopts命令来获取选项的值
- 示例代码如下
```
#! /bin/bash

# 输出参数索引
echo "OPTIOND starts at $OPTIND"
# 接受参数
while getopts ":pq:" optname
        do
        case "$optname" in
        "p")
          echo "Option $optnamer is specified"
        ;;
        "q")
          echo "Option $optname has value $OPTARG"
        ;;
        "?")
          echo "Unknown option $OPTARG"
        ;;
        ":")
          echo "No argument value for option $OPTARG"
        ;;
        *)
          # should not occur
          echo "Unkonwn error while processing options"
        ;;
        esac
        echo "OPTIND is now $OPTIND"
        done
```
## 第一个简单的Shell程序
### shell脚本的基本元素
- 1.第一行的解释器指定 #! /bin/bash(#! path)
- 2.注释:说明某些代码的作用 
    - #单行注释
    - :<<BLOCK
    - 块注释内容,配合here document,使用输出重定向完成注释
    - BLOCK
- 3.可执行语句:实现程序的功能
- 命令解释器用例解释并执行当前脚本文件中的语句(语法:#! 解释器path),示例代码如下
```
# 指定解释器为php
#! /usr/local/php5/bin/php

<?php
        // 输出hello world 字符串
        print "Hello World php";
?>
```
```
#指定解释器为more                                         
#! /bin/more                                                                                        
echo "Hello more world"   
```
- 块注释
```
#! /bin/bash
:<<BLOCK                                                     
本脚本的作用是演示快注释
author:shining
BLOCK
echo "Hello commit"   
```
- 第一个脚本hello.sh
```
#! /bin/bash

#输出字符串
echo "hello bash shell"
```
### shell程序退出状态
- Unix和Linux中,每个命令都会返回一个退出状态码
- 退出状态码是一个整数,取值区间[0,255]
- 通常情况下,成功返回0,不成功返回非0值
- 非0值被解释成一个错误码
- 程序和工具都会返回0作为退出码来表示成功
- shell脚本中的函数和脚本本身都会返回退出状态码
- 脚本或脚本函数执行的最后命令决定退出状态码
- 用户也可以在脚本中使用exit语句将指定退出码传递给shell
- 示例代码如下
```
#! /bin/bash
echo "hello exit code" 
# 退出状态为0,命令执行成功
echo $?
# 无效的命令                                             
abc
# 非零的退出状态,因为命令执行失败
echo $?
echo
# 返回120退出状态给shell
exit 120
echo $?  
```
### 如何执行shell程序
- 1.授予用户执行该脚本文件的权限,直接执行(./hello.sh)
- 2.通过shell脚本解释器来执行(/bin/bash hello.sh)
- 3.通过source命令执行(source hello.sh)
    - source命令时shell内部命令
    - 其功能是读取指定的shell程序文件,并且依次执行其中所有的语句
    - 该命令与前面两种执行方式的区别在于,source只是简单的读取脚本中的语句,依次在当前shell里面执行,不会创建新的子shell进程,脚本里面创建的变量都会保存到当前shell里面
---
# 2.Shell编程环境搭建
- 不同的操作系统搭建shell编程环境(win,Linux,BSD分支)
- 编辑器选择
- 系统环境搭建
## 不同系统搭建shell编程环境
### Windows
- 安装Unix模拟器 =>Cygwin(一个优秀的Unix模拟器)
- [Cygwin官网](https://www.cygwin.com/)
- cygwin安装(参考网上教程)
- 其他方案1: Windows cmd ssh 其他Linux主机
- 其他方案2: 下载Git客户端工具,自带bash(可能在某些地方有点出入,但是作为学习够用)
### Linux
- Linux默认安装shell脚本的运行环境
- Linux上可能同时安装多个shell,这些shell在语法上有差别,可以使用系统变量$SHELL来获取当前使用的是哪种shell
```
echo $SHELL
```
### Linux BSD分支
- 默认情况下FreeBSD使用的shell是csh(echo $SHELL查看)
## 编辑器
### 图形化编辑器
- Eclipse + ShellEd(安装参考网上)
- 其他图形化编辑器: UItraEdit
- 其他图形化编辑器: Notepad++
### 自带的编辑器vi/vim
- vi是Linux最常用的编辑器
- Linux发行版都默认安装vi(visual interface)
- vi拥有非常多的命令
- vim是vi编辑器的增强版
- vi有三种使用模式,在不同模式下,用户可以执行不同的操作
    - 一般模式
    - 编辑模式
    - 命令模式
- 一般模式
    - 用户刚进入vi编辑器时,当前的模式就是一般模式
    - 一般模式是三个模式中功能最为复杂的模式
    - 一般操作都在此模式下完成
    - 一般模式提供许多快捷键,分为四类
        - 光标移动快捷键
        - 文本操作快捷键
        - 文本复制快捷键
        - 删除文本快捷键
- 光标移动快捷键
    
操作 | 快捷键 | 说明
--- | --- | ---
向下移动光标 | 向下方向键,j键,空格键 | 每按一次键,光标向正下方移动1行
向上移动光标 | 向上方向键,k键,backspace键 | 每按一次,光标向正上方移动1行
向左移动光标 | 向左方向键,h键 | 每按1次,光标会向左移动1个字符
向右移动光标 | 向右方向键,l键 | 每按1次键,光标会向右移动1个字符
移至下1行行首 | 回车键 | 每按1次键,光标会移动到下1行的行首
移至上1行行首 | -键 | 每按1次,光标会移动到上1行的行首
移至文件最后一行 | G键 | 将光标移到到文件最后1行的行首
- 文本操作快捷键
    
操作 | 快捷键 | 说明
--- | --- | ---
右插入 | a | 在当前光标所处位置的右边插入文本
左插入 | i | 在当前光标所处位置的左边插入文版
行尾追加 | A | 在当前行的末尾追加文本
行首插入 | I | 在当前行的开始处插入文本
插入行 | O或o | O键在当前行的上面插入1个新行,o键在当前行的下面插入1个新行
覆盖文本 | R | 覆盖当前光标所在位置以及后面的若干文本
合并行 | J | 将当前光标所在行与下面的1行合并为1行
- 文本复制和粘贴的快捷键
    
操作 | 快捷键 | 说明
--- | :---: | ---
复制行 | yy | 将当前行复制带缓冲区,如果要定义多个缓冲区,可以使用ayy,byy,cyy;其中yy前面的字符表示缓冲区的名字,可以适任意单个字母;可以将多个单独行复制到多个缓冲区中,各个行缓冲区相互之间不受影响
复制多个行 | nyy  | 将当前行及下面的n行复制到缓冲区,其中n表示一个整数,与yy类似,可以使用anyy,bnyy来命名缓冲区
复制单词 | yw | 复制从光标当前位置到当前单词词尾的字符
复制多个单词 | nyw | n是一个整数,表示从光标位置开始,复制后面的n个单词
复制光标到行首 | y^ | 从当前光标所处的位置开始,复制到当前行的行首
复制光标到行尾 | y$ | 从当前光标所处的位置开始,复制到当前行的行尾
粘贴到光标后面的位置 | p | 将缓冲区的字符串插入到当前光标所处的位置后面,如果定义了多个缓冲区,则使用ap方式来粘贴,a表示缓冲区的名字
粘贴到光标前面的位置 | P | 将缓冲区中的字符插入到当前光标所处位置的前面,如果定义了多个缓冲区,则使用aP方式来粘贴,a表示缓冲区名字
- 删除文本快捷键
    
操作 | 快捷键 | 说明
--- | --- | ---
删除当前字符 | x | 删除光标所在位置的字符
删除多个字符 | nx | 删除从光标所在位置开始,后面的n个字符
删除当前行 | dd | 删除光标所处的整个行
删除多个行 | ndd | 删除包括当前行在内的n行
撤销上一步操作 | u | 撤销刚刚执行的操作
撤销多个操作 | U | 撤销针对当前行的所有操作
- 常用的其他命令
    
操作 | 命令 | 说明
--- | --- | ---
跳转至指定行 | :n,:n+,n- | :n表示跳转至行号为n的行,:n+表示向下跳n行,:n-表示向上跳n行
显示或者隐藏行号 | :set nu,set nonu | set nu表示在每行的前面显示行号;:set nonu表示隐藏行号
替换首次出现字符串1 | :s/old/new | 用字符串new替换当前行中首次出现的字符串old
替换当前行所有字符串 | :s/old/new/g | 用字符串new替换当前行中所有的字符串old
替换指定行的字符串 | :n,m s/old/new/g | 用字符串new替换从n到m行的所有字符串old
替换全文所有字符串 | :%s/old/new/g | 用字符串new替换当前文件中所有的字符串ild
设置文件格式 | :set fileformat=unix | 将文件修改为unix格式,如在win下面的文本文件在Linux下会出现^M,fileformat可以取unix,dos等值
- 编辑模式
    - 用户执行了插入或者追加操作后,都会使得vi从一般模式切换到到编辑模式
    - 使用上下左右四个方向键移动光标
    - backspace或del来删除光标前得字符
    - 插入字符
- 命令模式
    - 命令模式是使用较多的一种模式
    - 命令模式下,用户主要完成文件的打开,保存,将光标跳转至某行,显示行号等
- 常用的vi命令
    
操作 | 命令 | 说明
--- | --- | ---
打开文件 | :e filename | 打开另外一个文件,将文件名作为参数
保存文件 | :w | 保存文件,将文件的改动写入磁盘,如果将文件另存为其他的文件名,可以将新的文件名作为参数
退出编辑器 | :q | 退出vi编辑器
不保存修改强制退出编辑器 | :q! | 不保存修改,直接退出编辑器
退出并保存文件 | :wq |将文件保存后退出vi编辑器
## 系统环境的单间
- sh的配置文件主要有2个
    - 每个用户主目录中的.profile
    - /etc/profile文件,所有用户共同使用的文件
    - 每个用户登录shell时,先读取和执行/etc/profile文件中的脚本,再读取和执行各个自主目录的.profile文件
    - 可以将所有用户需要执行的脚本放在/etc/profile文件中
- bash的配置文件主要有5个,4个位于用户主目录
    - .bash_profile
        - 保存每个用户自己始于心动ongoing的shell信息
        - 用户登录时,该文件将被读取执行,该文件只被执行1次
        - 默认情况下,.bash_profile常用来设置环境变量,执行用户的.bashrc
    - .bashrc
        - 包含专属于某个用户的bash相关信息
        - 用户登录及每次打开新的bash时,该文件被读取并执行
    - .bash_logout
        - 当前用户每次退出shell时被执行
        - 没有特别的要求,该文件的内容通常为空
    - .bash_history
    - /etc/bashrc(位于etc)
        - 与sh的/etc/profile非常相似,是所有bash用户的共同使用文件
        - 任何用户在登录bash后,都会执行该文件中的代码
### 命令别名
- 命令别名是命令的另外一个名词
- 设置命令别名的作用主要是为了简化命令的输入
- 命令别名需要使用alias完成设置
```
# 语法:alias command_alias = command
alias rm="rm -i"
```
---
# 3.变量和引用
- 什么是变量,变量的命名,变量的类型,变量的作用域,系统变量,环境变量和用户自定义变量
- 变量的赋值和替换
- 引用: 全引用,部分引用,命令替换和转义
## 3.1认识变量
### 变量
- 变量是程序设计语言中的一个可以变化的量
- 本质上讲,变量是在程序中保存用户数据的一块内存空间,变量名就是这块内存空间的地址
- 程序运行过程中,保存数据的内存空间内容可能会不断发生变化,但是代表内存地址的变量名保持不变
### 变量的命名
- shell中变量可以由字母,数字以及下划线组成,只能以字母或下划线开头
- 变量名长度,shell未作出明确的规定
- 命名应尽可能选有明确意义的变量名
### 变量的类型
- shell是一种动态类型和弱类型语言
- 变量的数据类型无需显示的声明,变量的数据类型会根据不同的操作有所变化
- shell中的变量不区分数据类型,统一按照字符串存储
- 根据变量的上下文环境,运行程序做一些不同的操作,比如字符串的比较和整数的加减
- 数据类型示例代码如下:
```
#! /usr/bin/bash

#定义变量x,并且赋初值123
x=123
#param x add 1
let "x += 1"
#print x value
echo "x = $x"
#output space line
echo
#replace param x 1 to abc,and save it in param y
y=${x/1/abc}
#output param y value
echo "y = $y"
#declare param y
declare -i y
#output y value
echo "y = $y"
#param y add 1
let "y += 1"
#print y value
echo "y = $y"
#output space line
echo
#assign str to variable z
z=abc22
#print variable z value
echo "z = $z"
#replace variable z abc to number 11,and assign to variable m
m=${z/abc/11}
#print variable m 
echo "m = $m"
#variable m add 1
let "m += 1"
#print m value
echo "m = $m"

echo
#assign empty str to variable n
n=''
#print n
echo "n = $n"
#variable n add 1
let "n += 1"
echo "n = $n"
echo
#print null variable p value
echo "p = $p"
#variable p add 1
let "p += 1"
echo "p = $p"
# 执行结果
$ ./konw_param.sh
x = 124

y = abc24
y = abc24
y = 1

z = abc22
m = 1122
m = 1123

n =
n = 1

p =
p = 1
```
### 变量的定义
- shell中,用户可以直接使用变量,无需先进行定义
- 用户第一次使用某个变量名时,实际上同时定义了这个变量,在变量的作用域内,用户都可以使用该变量
```
#! /usr/bin/bash

#定义变量a
a=1
#定义变量b
b="Hello"
#定义变量c
c="hello world"
```
- declare声明变量
    - declare attribute variable
    - -p: 显示所有变量的值
    - -i: 将变量定义为整数,在之后就可以直接对表达式求值,结果只能是整数,如果求值失败或者不是整数,就设置为0
    - -r: 将变量声明为只读变量,只读变量不允许修改,也不允许删除
    - -a: 变量声明为数组,没有必要,所有变量都不必显式定义为数组,某种意义上,所有变量都是数组(?)
    - -f: 显示所有自定义函数,包括名称和函数体
    - -x: 将变量设置成环境变量,这样在随后的脚本和程序中可以使用
- declare示例代码
```
#! /usr/bin/bash

#定义一个变量x,将一个算术赋给他
x=6/3
echo "$x"
#定义变量x为整数
declare -i x
echo "$x"
#将算术式赋值给变量-i x
x=6/3
echo "$x"
#将字符串赋给变量x
x=hello
echo "$x"
#将浮点数赋值给变量x
x=3.14
echo "$x"
#取消变量x的整数属性
declare +i x
x=6/3
echo "$x"
#求表达式的值
x=[6/3]
echo "$x"
#求表达式的值
x=$((6/3))
echo "$x"
#声明只读变量x
declare -r x
echo "$x"
#尝试为只读变量赋值
x=6
echo "$x"
# 执行结果
$ ./declare_type.sh
6/3
6/3
2
0
./declare_type.sh: line 16: 3.14: syntax error: invalid arithmetic operator (error token is ".14")
0
6/3
[6/3]
2
2
./declare_type.sh: line 32: x: readonly variable
2
```
### 变量和引号
- shell语言中一共有三种引号
    - 单引号''
        - 单引号括起来的字符都作为普通字符来出现
    - 双引号""
        - 双引号括起来的除$,\,\`和``这几个字符仍保留其特殊功能外,其余字符作为普通字符对待 
    - 反引号``
        - 反引号括起来的字符串被shell解释为命令
        - 在执行时,shell首先执行该命令,并以命令的标准输出结果取代整个反引号部分
- ``反引号代表shell命令示例代码
```
#! /usr/bin/bash

#输出当前目录
echo "current directory is `pwd`"
```
### 变量的作用域
- shell中的变量分为 全局变量和局部变量2种
    - 全局变量
        - 在脚本中定义,也可以在函数中定义
        - 脚本中定义的变量都是全局变量,其作用域为从被定义的地方开始,一直到shell脚本结束或者被显式的删除
        - 示例代码
        ```
        #! /usr/bin/bash
        
        #定义函数
        func()
        {
        	#输出变量x的值
        	echo "$v1"
        	#修改变量x的值
        	v1=200
        }
        #在脚本中定义变量x
        v1=100
        #调用函
        func
        #输出变量x的值
        echo "$v1"
        ```
        - 内部定义全局变量
        ```
        #! /usr/bin/bash
        
        func()
        {
        	#在函数内部定义变量
        	v2=200
        }
        #调用函数
        func
        echo "$v2"
        ```
    - 局部变量
        - 局部变量的使用范围较小,通常仅限于某个程序段访问
        - shell语言中,可以使用关键字local定义局部变量
        - 函数的参数也是局部变量
        - local定义局部变量
        ```
        #! /usr/bin/bash
        
        #定义函数
        func()
        {
        	#使用local关键字定义局部变量
        	local v2=200
        }
        #调用函数
        func
        #输出local 变量v2的值
        echo "v2 = $v2"
        ```
- 局部变量和全局变量的区别示例代码
```
#! /usr/bin/bash

#定义函数
func()
{
	#输出全局变量v1的值
	echo "global variable v1 is $v1"
	#定义局部变量v1
	local v1=2
	#输出局部变量v1的值
	echo "local variable v1 is $v1"
}
#定义全局变量v1
v1=1
#调用函数
func
#输出全局变量v1的值
echo "second global variable v1 is $v1"
```
### 系统变量
- 系统变量主要在对参数判断和命令返回值判断时使用,包括脚本和函数的参数以及脚本和函数的返回值
    
变量 | 说明
--- | ---
$n | n是一个整数,从1开始,表示参数的位置,$1表示第一个参数,$2表示第二个参数
$# | 命令行参数个数
$0 | 当前shell脚本的名称
$? | 前一个命令或者函数的返回或状态码
$* | 以"参数1 参数2 ..."的形式返回所有的参数,通过字符串返回
$@ | 以"参数1""参数2"...的形式返回所有的参数
$$ | 返回本程序的进程ID(PID)
- 系统变量示例代码
```
#! /usr/bin/bash

#输出脚本的参数个数
echo "the number of parameter is $#"
#输出上一个命令的退出状态码
echo "the return code of last command is $?"
#输出当前脚本名字
echo "the current script is $0"
#输出所有的参数
echo "the parameter are $*"
#输出其中几个参数值
echo "\$1 = $1, \$7 = $7, \$6 = ${11}"
```
### 环境变量
- shell的环境变量是所有的shell程序都可以使用的变量
- shell程序在运行时,都会接收一组变量,这组变量就是环境变量
- 环境变量会影响到所有脚本的执行结果
    
变量 | 说明
--- | ---
PATH | 命令搜索路径,以冒号分割
HOME | 用户的主目录,是cd命令的默认参数
COLUMNS | 定义了命令编辑模式下可使用命令行的长度
HISTFILE | 命令历史文件
HISTSIZE | 命令历史文件中最多包含的命令条数
HISTFILESIZE | 命令历史文件中包含的最大行数
IFS | 定义shell使用的分隔符
LOGNAME | 当前的登录名
SHELL | shell的全路径名
TERM | 终端类型
TMOUT | shell自动退出的时间,单位为秒,若设置为0,则禁止shell自动退出
PWD | 当前工作目录
- 可以使用set命令查看当前系统的环境变量
```
set | less
```
- 环境变量获取shell一些环境变量值示例代码
```
#! /usr/bin/bash

#输出命令搜索路径
echo "command path is $PATH"
#输出当前的登录名
echo "current login name is $LOGINNANE"
#输出当前用户的主目录
echo "current user's home is $HOME"
#输出当前的shell
echo "current sh is $SHELL"
#输出当前工作目录
echo "current path is $PWD"
```
## 变量赋值和清空
- shell中赋值语法为:variable_name=value(=前后不能有空格符)
- 如果值包含有空格,则需要加上引号
### 引用变量的值
- shell章可以在变量名前面加上$,来获取该变量的值
### 清除变量
- shell中某个变量不再需要时,可以主动将其清除
- 变量清除后,其所代表的值也会消失
- 清除变量使用关键字unset,语法为: unset variable_name
- unset清除变量示例代码
```
#! /usr/bin/bash

v1="hello World"
echo "first print v1 = $v1"
unset v1
echo "the variable v1 has been unset"
echo "after unset v1,v1 = $v1"
```
## 变量引用和替换
- 变量的引用和替换是shell对于变量功能的扩展
### 引用
- 将字符串用引用符号括起来,防止其中的特殊字符被shell解释为其他含义
- 特殊字符是指除了字面含义,还可以解释为其他含义的字符,例如$,*
    
符号 | 说明
--- | ---
双引号 | 除美元符号,单引号,单引号,反引号,反斜线之外,其他所有字符都将保持字面含义
单引号 | 所有的字符豆浆保持字面意义
反引号 | 反引号中的字符串将被解释为shell命令
反斜线 | 转义字符,屏蔽后面的字符的特殊意义
- shell中,一个字符串被单引号引用后,包含的字符都是字面含义,因此单引号称为全引用
```
#! /bin/bash

#定义变量v1
v1="chunxiao"
#输出含有变量名的字符串
echo 'Hello, $v1'
# 输出
Hello, $v1
```
### 变量替换
- 在shell程序中,将某个shell命令的执行结果赋值给某个变量,bash中有2种语法可以进行命令替换
- 分别是使用反引号和圆括号,两种方法是等价的
    - `shell_command`
    - $(shell_command)
- 示例代码
```
#! /bin/bash

#变量替换
v1=`pwd`
#输出变量的值
echo "current working directory is $v1"
```
### 转义
- 转义的作用是转换某些特殊字符的含义
- 转义使用反斜线表示
- 当反斜线后面的1个字符具有特殊含义时,反斜线将屏蔽该字符的特殊含义
```
echo $SHELL
echo \$SHELL
```
# 4.条件测试和判断语句
## 知识点
- 条件测试:shell程序中的文件,变量,字符串数值以及逻辑等条件测试
- 条件判断语句:介绍基本的if,if else以及 if elif语句的使用方法
- 多条件判断语句case,case的基本语法以及使用case来解决一些实际问题
- 运算符:介绍shell中常用的运算符的使用方法,算术运算符,位运算符以及自增,自减运算符等
## 4.1 条件测试
- 正确处理shell程序运行过程中遇到的各种情况,Linux shell提供了一组测试运算符
### 4.1.1 条件测试的基本语法
- 在shell程序中,用户可以使用测试语句来测试指定的条件表达式的真或者假
- 指定条件为真时,整个条件测试的返回值为0
- 指定的条件为假,条件测试语句的返回值为非0值
- 条件测试语法
    - test expression: test 1 -eq 2
    - [ expression ]: [ -e file ]条件表达式和左右方括号之间必须有一个空格
### 4.1.2字符串测试
- 通常情况下,对于字符串的操作主要包括判断字符串变量是否是空和两个字符串是否相等
- 用户可以通过以下5种运算符来对字符串进行操作
运算符 | 说明 
--- | ---
string | 判断指定的字符串是否为空
string1 = string2 | 判断2个字符串string1和string2是否相等
string1 != string2 | 判断两个字符串string1和string2是否不相等
-n string | 判断string是否是非空串
-z string | 判断string是否是空串
### 4.1.3整数测试
- 与字符串测试类型,整数测试也有两种语法
    - test number1 op number2
    - [ number1 op number2 ]
    - number1和number2分别表示参与比较的两个整数,可以是常量或者变量
    - op表示运算符,见下表
运算符 | 说明
--- | ---
number1 -eq number2 | 比较number1是否等于number2,如果相等,测试结果为0
number1 -ne number2 | 比较number1和number2是否不相等,如果不相等,测试结果为0
number1 -gt number2 | 比较number1是否大于number2,如果大于,测试结果为0
number1 -lt number2 | 比较number1是否小于number2,如果小于,测试结果为0
number1 -ge number2 | 比较number1是否大于等于number2,如果为真,测试结果为0
number1 -le number2 | 比较number1是否小于等于number2,如果为真,测试结果为0
### 4.1.4 文件测试
- 文件测试语法如下
    - test op file
    - [ op file ]
    - op表示操作符,file表示要测试的文件名
操作符 | 说明
--- | --- 
-a file | 文件是否存在,如果文件file存在,则结果为0
-b file | 文件是否存在,且为块文件,如果file是一个已经存在的块文件,则结果为0
-c file | 文件是否存在,且为字符文件.如果file是一个已经存在的字符文件,则结果为0
-d file | 文件是否存在,且为目录
-e file | 同-a操作符
-s file | 文件长度是否大于0或者文件为非空文件
-f file | 文件存在,且为常规文件
-w file | 文件是否存在且可写
-L file | 文件是否存在且为符号链接
-u file | 文件是否设置suid位
-r file | 文件是否存在且可读
-x file | 文件是否存在且可执行
- 使用chmod u+s file 给文件file设置setuid权限,执行该文件的用户就会临时拥有该文件所有者的权限
### 4.1.5 逻辑操作符
- 逻辑操作符可以将多个不同的条件组合起来,从而构成一个复杂的条件表达式
操作符 | 说明
--- | ---
!expression | 逻辑非,取反操作
expression1 -a expression2 | 逻辑与
expression1 -o expression2 | 逻辑或
## 4.2 条件判断语句
- 条件判断语句是一种最简单的流程控制语句
- 使得程序根据不同的条件执行不同的程序分支
### 4.2.1 简单的if语句进行条件判断
- 语法
```
if expression
then
    statement1
    statement2
    ...
fi
```
- 上面的语法中,expression通常代表一个条件表达式,但是也可以是shell命令
- 为了使得代码紧凑,可以将if和then子句写在同一行中,此时需要再expression表达式后加上一个分号
```
if expression; then
    statement1
    statement2
    ...
fi
```
- 分号的作用是表示if子句已经借宿,后面的代码式then子句
- if :; then statement1;fi.冒号可以做为空命令条件,表示一直为真
- 用&&代替if语句
```
test "$(whoami)"!="root" && (echo you are using a non-privileged account;exit 1)
```
### 4.2.2 if else基本语法
```
if expression
then
    statement1
    statement2
    ...
else
    statement1
    statement2
    ...
fi
```
### 4.2.3 if elif多条件判断
- if elif基本语法
```
if expression
then
    statement1
    statement2
    ...
elif expression2
then
    statement1
    statement2
    ...
elif expression3
then
    statement1
    statement2
    ...
else
    statement1
    statement2
    ...
fi
```
- 根据学生成绩输出对应的等级demo
```
#! /usr/bin/bash

echo "please enter a score: "
read score

if [-z "$score" ]; then
    echo "U enter nothing,please enter a score:"
    read score
fi

if [ "$score" -lt 0 -0 "$score" -gt 100 ]; then
    echo "score should be between 0 and 100,please enter again:"
    read score
fi

if [ "$score" -ge 90 ]; then
    echo "The grade is A."
elif [ "$score" - ge 80 ]; then
    echo "The grade is B."
elif [ "$score" -ge 70 ]; then
    echo "The grade is C."
elif [ "$score" -ge 60 ]; then
    echo "The grade is D."
else
    echo "The grade is E."
fi
```
### 4.2.4 使用exit语句退出程序
- exit语句的基本作用是终止shell程序执行
- exit语句还可以带一个可选的参数,用来指定程序退出时状态码
- exit status
    - status表示退出状态
    - 参数是一个整数值,取值范围是0-255
    - shell程序的退出状态也储存在$?中,用户可以通过该变量取得shell程序返回给父进程的退出状态码
## 多条件判断语句case
- case基本语法如下
```
case variable in
value1)
    statement1
    statement2
    ...;;
value2)
    statement1
    statement2
    ...;;
value3)
    statement1
    statement2
    ...
    ;;
*)
    statement1
    statement2
    ...;;
esac
```
- variable是一个变量,会与value进行比较.,与某个值相等,则执行该组语句,遇到;;跳出case语句
- 无value匹配则执行*后面的语句
 ```
#! /bin/sh

#输出提示信息
echo "Hit a key,then hit return."
#读取用户按下的键
read keypress
#case语句开始
case "$keypress" in
   #小写字母
   [[:lower:]])
      echo "Lowercase letter.";;
   #大写字母
   [[:upper:]])
      echo "Uppercase letter.";;
   #单个数字
   [0-9])
      echo "Digit.";;
   #其他字符
   *)
      echo "other letter.";;
esac
```
## 4.4 运算符
- 介绍算术运算符,位运算符,自增,自减运算符
### 4.4.1 算术运算符
- +,-,\*,/,%,\*\*
- Linux有4种方式来执行算符运算符
    - expr 1 + 2
    - $((1+2))
    - $[1+2]
    - let n=n+1
- expr expression
    - expr是一个shell命令,可以计算某个表达式的值
    - result=`expr 2 - 100`
    - echo $result
    - result=`expr \( 2 - 6 \) \* 12`
    - echo $result
- $((...))
    - 使用这种形式来进行算术运算写法比较自由,无需对运算符和括号做转义,可以采用松散或者紧凑的格式来书写表达式
    - result=$((3+6))
    - result=$(( 3 + 6 ))
    - result=$(((1-4) * 5)))
- $[...]
    - res=$[4+6]
    - result=$[(1+2)*5]
    - result=$[2**4]
- let命令
    - let命令可以执行一个或者多个算术表达式
    - 其中变量名无需$符号
    - 表达式中含有空格或者其他特殊字符,则必须将其引用起来
    - n=10
    - let n=n+1
    - let n=n*10
    - let n=n**2
- 符合算术运算符
    - +=
    - -=
    - \*=
    - /=
    - %=
### 4.4.2 位运算符
- 位运算符通常出现在整数间,针对的不是整数,而是其二进制表示形式中的某个或者某些位
- << 左移 4<<2 4左移2位
- >> 右移 8>>2 8右移2位
- & 按位与 8 & 4
- | 按位或
- ~ 按位非
- ^ 按位异或
- res=$[4<<2]
- res=$[8>>2]
- res=$[8 & 4]
- res=$[~8]
- res=$[10 ^ 6]
- 复合位运算
    - <<=    x<<=3
    - >>=
    - &=
    - |=
    - ^=
    - x=5
    - let "x<<=4"
    - let "x>>2"
    - let "x|=2"
### 4.4.3 自增自减运算符
- ++var
- --var
- var++
- var--
### 4.4.4 数字常量的进制
- 2进制
    - 2#1000
    - 
- 8进制
    - 0100
    - 8#100
- 16进制
    - 0x100
    - 16#100
---
# 循环结构
- 步进循环语句for: 主要介绍带列表的for语句,不带列表的for语句,类C风格的for循环语句以及使用for循环来处理数组
- util循环语句: 主要介绍util语句的基本语法以及如何使用until语句来批量添加用户
- while循环语句: 主要介绍while循环语句的基本语法以,分别使用计数器,结束标记,标志以及命令行等方法来控制while循环结构
- while与until的区别
- 嵌套循环
- 利用break和continue语句控制循环,使用break和continue语句来退出循环和跳过循环体中某些语句,以及break与continue的区别
## 5.1 步进循环语句for
- for循环是最简单,也是最常用的循环语句
- for循环通常用于遍历整个对象或者数字列表
- 按照循环条件不同,可分为三种
    - 带列表的for循环
    - 不带列表的for循环
    - 类C风格的for循环
### 5.1.1 带列表的for循环语句
- 带列表的for循环语句通用用于将一组语句执行已知次数
- 基本语法如下
```
for variable in {list}
do
    statement1
    statement2
    ...
done
```
- list是一个列表,可以是一系列数字或者字符串,元素之间由空格隔开
- do和done之间的所有语句称为循环体
- 当list所有的元素都被访问后,for循环结构终止,程序将继续执行done后面的其他语句
- shell允许用户指定for语句的步长,基本语法如下
```
for i in {start..end..step}
do
    statement1
    statement2
    ...
done
```
- 通过shell命令作为for循环的遍历列表
```
#! /bin/bash

#使用ls命令的执行结果作为列表
for file in $(ls)
do
   #输出每个文件名
   echo "$file"
done
```
- 通配符作为条件列表
```
#! /bin/bash

#使用通配符作为列表条件
for file in *
do
   echo "$file"
done
```
### 不带列表的for循环语句
- 某些情况下,for循环的条件列表可以完全省略,称为不带列表的for循环语句
- 没有循环列表的for语句,shell将从命令行获取条件列表,语法如下
```
for variable
do 
    statement1
    statement2
    ...
done
# 等价于下面语法
for variable in "$@"
do
    statement1
    statement2
    ...
done
#demo
#! /bin/bash

#不带条件列表
for arg
do
   #输出每个参数
   echo "$arg"
done
```
### 5.1.3 类C风格的for循环语句
- 语法如下
```
for ((expression1;expression2;expression3))
do
    statement1
    statement2
    ...
done
#demo
#! /bin/bash

#for循环开始
for (( i=1;i<5;i++))
do
   #输出循环变量i的值
   echo "$i"
done
```
- expression1是条件变量的初始化语句
- expression2是决定是否执行for循环的条件,当expression2的值为非0时,退出for循环体
- expression3用来改变条件变量的值,可以递增或递减
### 用for循环语句遍历数组
- for循环遍历数组非常方便,shell针对数组,提供了一种特殊语法的for循环语句,基本语法如下
```
for variable in ${array[*]}
do
    statement1
    ...
done
# demo
#! /bin/bash

#定义数组
array=(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
#通过for循环遍历数组元素
for day in ${array[*]}
do
   #输出每个数组元素的值
   echo $day
done
```
- variable是循环变量,in关键字后面的部分表示要遍历的数组
- array是数组的名称
## 5.2 until循环语句
- until语句的作用是将循环体重复执行,直到某个条件成立为止,语法如下
```
until expression
do
    statement1
    statement2
    ....
done
#demo
#! /bin/bash

#定义循环变量i
i=1
#当i的值小于9时执行循环
until [[ "$i" -gt 9 ]]
do
   #计算i的平方
   let "square=i*i"
   #输出i的平方
   echo "$i*$i=$square"
   #循环变量加1
   let "i=i+1"
done
```
- expression是一个条件表达式,当该表达式值不为0,执行循环体
- 当expression值为0时,将退出until循环结构,继续执行done后面的其他语句
## while循环语句
- while是另外一种常见的循环结构,可以使程序重复执行一系列操作,直到某个条件为真,退出循环,基本语法如下
```
while expression
do
    statement1
    statement2
    ...
done
```
- expression表示while循环体执行时需要满足的条件,通常是一个测试表达式
### 通过计数器控制while循环结构
- 所谓计数器,实际上是一个循环变量,当该变量的值在某个范围内时执行循环体;当超过该范围时,终止循环
```
#! /bin/bash

#定义循环变量
i=1
#while循环开始
while [[ "$i" -lt 10 ]]
do
   #计算平方
   let "square=i*i"
   #输出平方
   echo "$i*$i=$square"
   #循环 变量自增
   let "i=i+1"
done
```
### 通过结束标记控制while循环结构
- 可以在程序中设置一个特殊的标记值,当该标记值出现时,终止while循环
```
#! /bin/bash

#提示用户输入数字
echo "Please enter a number between 1 and 10.Enter 0 to exit."
#读取用户输入的数字
read var
#while循环开始
while [[ "$var" != 0 ]]
do
   #提示用户输入数字太小
   if [ "$var" -lt 5 ]
   then
      echo "Too small. Try again."
      read var
   #提示用户输入数字太大
   elif [ "$var" -gt 5 ]
   then
      echo "Too big. Try again."
      read var;
    else
       echo "Congratulation! You are right."
       exit 0;
    fi
done
```
### while语句与until语句\
- while是expression为真执行循环体,expression为假时退出循环体
- until是expression为假时执行循环体,expression为真时退出循环体
- 在执行机制方面,两个语句是一样的,都会首先判断expression的真假,再根据结果决定是否执行循环体
## 5.4 嵌套循环
- 嵌套循环是一种常见的结构
```
for (( i=1; i<=9; i++))
do
    for (( j=1; j<=i; j++))
    do
        let "mul=i*j"
        printf "$i*$j=$mul"
        if [ $mul -gt 9 ]; then
            printf "   "
        else
            printf "    "
        fi
    done
    echo
done
```
##  5.5 利用break和continue语句控制循环
- break用于立即跳出当前循环
- continue用于跳过循环体某些语句,继续执行下一次循环
### break语句控制循环
- break语句的作用是立即跳出某个循环结构
- 可以在for,while或者until语句中
```
for (( i=1; i<=9; i++)
do
    for (( j=1; j<=i; j++))
    do
        let "mul=i*j"
        printf "$i*$j=$mul"
        if [ $mul -gt 9 ]; then
            printf "   "
        else
            printf "    "
        fi
    done
    echo
    if [ $i -eq 5 ]; then
        break;
    fi
done
```
- break语句指定数字,跳出指定层数循环
```
#! /bin/bash

for ((i=1;i<=9;i++))
do
   for ((j=1;j<=i;j++))
   do
      let "product=i*j"
      printf "$i*$j=$product"
      if [[ "$product" -gt 9 ]]
      then
         printf "   "
      else
         printf "    "
      fi
      if [[ "$j" -eq 5 ]]
      then
         #增加参数2
         break 2
      fi
   done
   echo
done
```
### 利用continue语句控制循环
- continue的作用是跳过当前循环体中该语句后面的语句,重新从循环语句开始执行
```
#! /bin/bash

for var in {1..10}
do
   #如果当前数字为奇数
   if [[ "$var%2" -eq 1 ]]
   then
      #跳过后面的语句
      continue
   fi
   echo "$var"
done
```
### break和continue的区别
- break直接退出当前循环结构
- continue则是跳过当次循环,重新执行下一次循环
- 没有参数的break和continue语句都只是影响到本层的循环流程
- 如果想要影响多层循环,可以附加数字参数
```
for i in a b c d
do
   echo -n "$i "
   for j in `seq 10`
   do
      if [ $j -eq 5 ];then
         #指定跳出层数2
         break 2
      fi
      echo -n "$j "
   done
   echo
done
```
```
#!/bin/sh

for i in a b c d
do
   echo -n "$i "
   for j in `seq 10`
   do
      if [ $j -eq 5 ];then
         #使用含有数字参数的continue语句
         continue 2
      fi
      echo -n "$j "
   done
   echo
done
```
---
# 6 函数
- 函数的基础知识,什么是函数,函数的定义方法,函数的调用方法,函数的返回值,函数和别名的区别,以及函数中的全局变量和局部变量
- 函数参数传递,带参数的函数调用方法,如何获取函数的参数个数,通过位置变量获取参数值,移动位置变量,通过getopts获取参数值,简介参数传递,全局变量传递参数以及传递数组参数
- 函数库文件,共享函数.函数库文件的定义和库文件中的函数调用方法
- 递归函数
## 6.1 函数
### 什么是函数
- 一组功能相对独立的代码集中起来,形成代码块,这个代码可以完成某个具体的功能
- 定义函数后,可以通过函数名来调用其所对应的一组代码
### 6.1.2函数的定义方法
- 可以通过两种语法来定义函数
```
function_name()
{
    statement1
    statement2
    ...
    statementn
}
#或者
function function_name()
{
    statement1
    statement2
    ...
    statementn
}
```
### 6.1.3 函数的调用
- 函数的基本语法如下
```
function_name param1 param2...
```
### 6.1.4 函数链接
- 是指在shell函数中调用另外一个函数的过程
- 先声明定义,后使用
### 6.1.5 函数的返回值
- 可以使用return语句来返回某个数值
- return语句只能返回某个0到255之间的整数值
- 使用echo语句将需要返回的数据写入到标准输出(stdout),这个操作由echo语句完成,然后在调用程序中将函数的执行结果赋给一个变量,这种做法实际上就是命令替换的一个变种
```
#! /bin/bash

#定义函数
length()
{
   #接收参数
   str=$1
   result=0
   if [ "$str" != "" ]; then
      #计算字符串长度
      result=${#str}
   fi
   #将长度值写入标准输出
   echo "$result"
}
#调用函数
len=$(length "abc123")
#输出执行结果
echo "the string's length is $len"
```
### 6.1.6 函数和别名
- 别名是一个shell命令的缩写或者其他容易记忆的名称,语法如下
```
alias name="command [options]"
alias chmodx="chmod u+x"
```
- 不再需要某个别名时,可以使用unalias命令将其删除
```
unalias chmodx
```
### 全局变量和局部变量
- 默认情况下除了函数参数关联的特殊变量之外,其他所有变量都是全局的有效范围
- 函数内部,如果没有使用local关键字修饰,函数中的变量也是全局变量
## 6.2 函数参数
### 6.2.1 含有参数的函数调用方法
- shell将脚本参数和函数做了统一处理,shell采用相同的方法来处理脚本的参数和函数参数
```
function_name param1 param2...
```
### 6.2.2 获取函数参数个数
- 函数内部也是通过位置变量来接受参数的值($#,$@,$*,${n})
### 6.2.3 通过位置变量接受参数值
- $0表示脚本名称,$n表示第n个参数,$@,$*获取所有参数的值
### 6.2.4 移动位置参数
- 通过shift命令来使得脚本的所有位置参数向左移动一个位置
```
#! /bin/bash

#定义函数
func()
{
   #通过while循环和shift命令依次获取参数值
   while (($# > 0))
   do
      echo "$1"
      shift
    done
}
```
### 6.2.5 通过getopts接收函数参数
- getopts是bash内置的一个命令,可以获取函数的选项以及参数值,或者脚本命令行选项以及参数值,语法如下
```
getopts optstring [arg]
```
- 参数optstring包含一个可以为getopts命令识别的选项名称列表
- 某个选项名称的后面跟着一个冒号,则可以为该选项提供参数值,该参数值会被保存到一个名称为$OPTARG的系统变量中
- getopts命令会依次遍历每个选项,选项名称将被保存到args变量中
```
#! /bin/bash

#定义函数
func()
{
   #逐个接收选项及其参数
   while getopts "a:b:c" arg
   do
      #当指定了-a选项时
      case "$arg" in
         a)
            #输出-a选项的参数值
            echo "a's argument is $OPTARG"
            ;;
         b)
            echo "b's argument is $OPTARG."
            ;;
         c)
            echo "c"
            ;;
         ?)
            #未知选项
            echo "unkown argument."
            exit 1
            ;;
      esac
   done
}
#调用函数
func -a hello -b world
```
### 6.2.6 间接参数传递
- shell中函数支持间接参数传递
- 间接参数传递是指通过变量引用来实现函数参数的传递,间接变量是指某个变量又是另外一个变量的变量名
```
var=name
name=jhon
${name}
${!var}
```
### 6.2.7 通过全局变量传递数据
- 可以通过全局变量来传递
- 全局变量会导致程序结构非常不清晰,代码的可读性较差
```
#! /bin/bash

#定义全局变量
file="/bin/ls"
#定义函数
func()
{
   if [ -e "$file" ]
   then
      echo "the file exists."
   else
      echo "the file does not exist."
   fi
}
#调用函数
func
#修改全局变量的值
file="/bin/a"
#调用函数
func
```
### 6.2.8 传递数组参数
- 严格来说,shell并不支持将数组作为参数传递给函数,可以通过一些变通的方法来实现数组参数的传递
- 先将数组元素展开,然后作为多个由空格隔开的多个参数传递给函数
```
#! /bin/bash

#定义函数
func()
{
   echo "number of elements is $#."
   while [ $# -gt 0 ]
   do
      	echo "$1"
      	shift
    done
}
#定义数组
a=(a b "c d" e)
#调用函数
func "${a[@]}"
```
## 6.3函数库文件
- 为了方便重用某些功能,可以创建一些可重用的函数,这些函数可以单独放在函数库文件中,其他脚本可以引用
### 6.3.1 函数库文件的定义'
- 创建一个函数库文件的过程非常类似于写一个shell脚本
- 脚本与库文件之间的区别在于函数库文件通常只包含函数,脚本可以包含函数和变量的定义以及可以执行的代码
- 可执行的代码是指脚本中位于函数外部的代码,脚本载入后,这些代码会被立即执行,无需另外调用
```
#! /bin/bash

#定义函数
error()
{
   echo "ERROR:" $@ 1>&2
}
warning()
{
   echo "WARNING:" $@ 1>&2
}
```
### 6.3.2 函数库文件调用
- 在程序中载入库文件,然后可以直接调用库文件中的函数,载入的命令为
```
. lib_filename
```
- lib_filename表示库文件的名称,必须是一个合法的文件名,库文件可以使用相对路径,也可以使用绝对路径
- 圆点和文件名之间有一个空格
## 6.4 递归函数
- 函数可以直接或间接调用自身
- 递归函数的调用过程就是反复地调用其自身,每调用一次就进入新的一层
```
# 实现了根据用户输入的数值计算其阶乘的方法
#! /bin/bash

#定义递归函数
fact()
{
   #定义局部变量
   local n="$1"
   #当n等于0时终止递归调用
   if [ "$n" -eq 0 ]
   then
      result=1
   else
      #当n大于0时，递归计算n-1的阶乘
      let "m=n-1"
      fact "$m"
      let "result=$n * $?"
   fi
   #将计算结果以退出状态码的形式返回
   return $result
}

#调用递归函数
fact "$1"

echo "Factorial of $1 is $?"
```
---
# 7 数组
- shell中定义数组变量的各种方法.通过指定元素值来定义数组;通过declare语句定义数组,通过元素值集合定义数组;通过键值对定义数组,以及通过字符串定义数组
- 数组赋值: 如何为数组元素赋值,通过循环为数组元素赋值,通过索引为数组元素赋值,通过集合为数组元素赋值,以及在数组末尾追加新元素
- 访问数组,数组元素的访问方法,通过索引访问数组元素,计算数组长度,通过循环遍历数组元素,以字符串的形式输出所有的数组元素,以切片的方式获取部分数组元素以及数组元素的替换
- 删除数组,如何销毁数组变量,包括删除某个指定的数组元素以及删除整个数组
- 数组的其他操作: 数组的复制,数组的连接以及如何从文本文件中加载数据到数组
## 7.1 定义数组
- 所谓数组,是指将具有相同类型的若干变量按照一定的顺序组织起来的一种数据类型
### 7.1.1 通过指定元素值来定义数组
- 可以通过直接指定数组中的元素值来定义一个新的数组变量,基本语法如下
```
array[key]=value
```
- array表示数组变量名称,key表示数组元素索引,通常是一个整数值,value表示key所对应的数组元素的值
```
#! /bin/bash

#指定数组元素值
array[1]=one
array[3]=three

#输出数组元素
echo "${array[@]}"
```
### 7.1.2 通过declare语句定义数组
- declare语句除了可以用来声明变量之外,还可以用来定义数组,语法如下
```
declare -a array
```
- -a选项表示后面定义的是一个数组,其名称为array
### 7.1.3 通过元素值集合定义数组
- 基本语法如下
```
array=(val1 val2 val3 ... valn)
```
- 这些值之间由空格隔开
- shell会将这些值从下标为0的第一个元素开始,一次将这些值赋给数组的所有元素
- 数组元素的个数与值的个数相同
```
#! /bin/bash

#定义数组
array=(1 2 3 4 5 6 7 8)
#输出第1个数组元素的值
echo "the first element is ${array[0]}"
#输出所有元素的值
echo "the elements of this array are ${array[@]}"
#输出数组长度
echo "the size of the array is ${#array[@]}"
```
### 7.1.4 通过键值对定义数组
- 基本语法如下
```
array=([0]=val0 [1]=val1 .... [n]=valn)
```
- 提供的键值对中的索引不一定是连续的,可以任意指定要赋值的元素的索引
- 之所以可以这样做,是因为已经显示指定了索引,shell就可以知道值和索引的对应关系
```
#! /bin/bash

#定义数组
array=([1]=one [4]=four)
#输出数组长度
echo "the size of the array is  ${#array[@]}"
#输出索引为4的元素的值
echo "the fourth element is ${array[4]}"
```
- 关联数组的声明
```
#! /bin/bash

#声明数组
declare -A array

#为数组赋值
array=([flower]=rose [fruit]=apple)
#输出第1个元素的值
echo "the flower is ${array[flower]}"
#输出第2个元素的值
echo "the fruit is ${array[fruit]}"
#输出数组长度
echo "the size of the array is ${#array[@]}"
```
### 7.1.5 数组和普通变量
- shell中所有普通变量实际上都可以当做数组变量来使用,对普通变量操作与对相同名称的下标为0的元素操作是等效的
```
#! /bin/bash

#定义字符串变量
array="hello, world."
#输出下标为0的元素的值
echo "${array[0]}"
#输出所有元素的值
echo "${array[@]}"
#输出所有元素的值
echo "${array[*]}"
```
## 7.2 数组的赋值
### 7.2.1 按索引为元素赋值
- 按索引赋值是最基本的赋值方式,语法如下
```
array[n]=valuen
```
```
#! /bin/bash

#定义数组
students=(John Rose Tom Tim)

#输出元素值
echo "the old students are: ${students[*]}"

#改变第1个元素的值
students[0]=Susan
#改变第4个元素的值
students[3]=Jack
#输出数组新的值
echo "the new students are: ${students[*]}"

#声明关联数组
declare -A grades
#初始化新的数组
grades=([john]=90 [rose]=87 [tim]=78 [tom]=85 [jack]=76)
#输出数组元素值
echo "the old grades are: ${grades[@]}"
#改变Tim的分数
grades[tim]=84
#重新输出数组元素值
echo "the new grades are: ${grades[@]}"
```
### 7.2.2 通过集合为数组赋值
- 通过集合为数组赋值与通过集合定义数组的语法完全相同
- 当为某个数组提供一组值时,shell会从第一个元素开始,依次将这些值赋给每个元素
- 当新的值集合个数超过原来的数组长度时,shell会在数组末尾追加新的元素
- 新的值集合个数少于原来的数组长度时,shell会从第一个元素开始赋值,然后删除超出的元素
```
#! /bin/bash

#定义数组
a=(a b c def)
#输出所有元素的值
echo "${a[@]}"
#为数组元素重新赋值
a=(h i j k l)
#输出所有元素的值
echo "${a[@]}"
#为数组元素重新赋值
a=(m n)
echo "${a[@]}"
```
### 7.2.3 在数组末尾追加新的元素
- 通过索引为数组赋值时,如果指定的索引不存在,shell会自动添加一个新的元素,并且将指定的值赋给该元素
- 向关联数组追加新的元素
```
#! /bin/bash

#定义数组
declare -A array
#初始化数组
array=([a]=a [b]=b)

echo "the old elements are ${array[@]}"
#向数组追加元素
array[c]=c

echo "the new elements are ${array[@]}"
```
### 7.2.4 通过循环为数组元素赋值
- 可以用任一循环语句,for,while,until为数组赋值
```
#! /bin/bash

#通过循环为数组赋值
for i in {1..10}
do
   array[$i]=$i
done
#输出元素的值
echo "${array[@]}"
```
## 7.3 访问数组
### 7.3.1 访问数组第1个元素
- shell中,当直接使用数组名来访问数组时,得到的是下标为0的元素的值
```
#! /bin/bash

#定义数组
array=(1 2 3 4 5)
#通过数组名访问数组
echo "${array}"
```
### 通过下标访问数组元素
- 通常情况下,访问数组中某个具体元素是通过下标来指定,基本语法如下
```
array[n]
```
- array是数组名称,n表示下标
- shell中下标从0开始,最后一个元素下标为n-1
```
#! /bin/bash

#定义数组
array=(Mon Tue Wed Thu Fri Sat Sun)
#输出下标为0的元素
echo "the first element is ${array[0]}"
#输出下标为3的元素
echo "the fourth element is ${array[3]}"
```
### 7.3.3 计算数组的长度
- shell中用户可以通过$#来获取数组的长度,基本语法如下
```
${#array[@]}
${#array[*]}
```
```
#! /bin/bash

#定义数组
array=(Mon Tue Wed Thu Fri Sat Sun)
#输出数组长度
echo "the length of the array is ${#array[@]}"
```
```
# 通过$#操作符获取某个数组元素的长度
#! /bin/bash

#定义数组
linux[0]="Debian"
linux[1]="RedHat"
linux[2]="Ubuntu"
linux[3]="Suse"

#输出第4个元素
echo "the fourth element is ${linux[3]}"
#输出第4个元素的值
echo "the length of the fourth element is ${#linux[3]}"
#输出第1个元素的值
echo "the first element is ${linux}"
#输出第1个元素的长度
echo "the length of the first element is ${#linux}"
```
### 7.3.4 通过循环遍历数组元素
```
#通过for循环结构来遍历数组
#! /bin/bash                       
                                   
#定义数组                          
array=(Mon Tue Wed Thu Fri Sat Sun)
#通过下标访问数组                  
for i in {0..6}                    
do                                 
   echo "${array[$i]}"             
done 
# 改进
#! /bin/bash

array=(Mon Tue Wed Thu Fri Sat Sun)
#获取数组长度
len="${#array[@]}"
#通过循环结构遍历数组
for ((i=0;i<$len;i++))
do
   echo "${array[$i]}"
done
```
### 7.3.5 引用所有的数组元素
- 指定下标为@或者*,表示引用当前数组中的所有元素
- @或者*称为通配符,表示匹配所有元素
```
#! /usr/bin/bash

array=(do re mi fa sol la xi)

for e in "${array[@]}"
do
    echo "$e"
done
```
### 切片方式获取部分数组元素
- 切片,是指截取数组的部分元素或者某个元素的部分内容
- 切片的基本语法如下
```
${array[@|*]:start:length}
```
```
#! /bin/bash

linux=("Debian" "RedHat" "Ubuntu" "Suse" "Fedora" "UTS" "CentOS")
#数组切片
echo ${linux[@]:2:4}
```
- 切片结果以数组形式保存,只能以@通配符进行匹配
```
#! /bin/bash

#定义数组
linux=("Debian" "RedHat" "Ubuntu" "Suse" "Fedora" "UTS" "CentOS")
#切片并保存为新的数组
array=(${linux[@]:2:4})
#获取新的数组的长度
length="${#array[@]}"
#输出数组长度
echo "the length of new array is $length"
#通过循环输出各个元素
for ((i=0;i<$length;i++))
do
   echo "${array[$i]}"
done
```
- 数组元素切片
```
#! /bin/bash

linux=("Debian" "RedHat" "Ubuntu" "Suse" "Fedora" "UTS" "CentOS")
#对数组元素切片
str=(${linux[4]:2:4})
#输出切片结果
echo "$str"
```
### 7.3.7 数组元素的替换
- 将某个数组元素部分内容用其他的字符串来替代,但是并不影响原来数组的值,基本语法如下
```
${array[@|*]/pattern/replacement}
```
```
#! /bin/bash

#定义数组
a=(1 2 3 4 5)
#输出替换结果
echo "the result is ${a[@]/3/100}"
#输出原始数组
echo "the old array is ${a[@]}"
#将替换结果赋给一个数组变量
a=(${a[@]/3/100})
#输出新的数组变量的值
echo "the new array is ${a[@]}"
```
## 7.4 删除数组
- 数组变量不再需要时,可以将其删除,释放相应的内存
### 删除指定数组元素
- unset命令来删除某个数组元素,基本语法如下
```
unset array[n]
# demo
#! /bin/bash

linux=("Debian" "RedHat" "Ubuntu" "Suse" "Fedora" "UTS" "CentOS")
输出原始数组长度
echo "the length of original array is ${#linux[@]}"
#输出数组的原始值
echo "the old array is ${linux[@]}"
#删除下标为3的元素
unset linux[3]
输出新的数组的长度
echo "the length of new array is ${#linux[@]}"
#输出新的数组的值
echo "the new array is ${linux[@]}"
```
### 7.4.2 删除整个数组
- unset同样可以删除整个数组,语法如下
```
unset array
```
## 7.5 数组的其他操作
- 数组的复制,连接以及文本文件加载到数组中
### 7.5.1 复制数组
- 所谓复制数组,是指创建一个已经存在的数组的副本,基本语法如下
```
newarray=("${array[@]}")
# demo
#! /bin/bash

linux=("Debian" "RedHat" "Ubuntu" "Suse" "Fedora" "UTS" "CentOS")
#复制数组
linux2=("${linux[@]}")
echo "${linux2[@]}"
```
### 7.5.2 连接数组
- 连接数组是指将2个数组元素连接在一起,变成一个大的数组,基本语法如下
```
("${array1[@]}" "${array2[@]}")
```
### 加载文件内容到数组
- 可以将普通文本文件的内容直接加载到数组中,文件中每一行构成数组1个元素内容
```
#! /usr/bin/bash

content=(`cat "demo.txt"`)
for s in "${content[@]}"
do
    echo "$s"
done
```
---
# 8. 正则表达式
- 什么是正则表达式
- 正则表达式基础,元字符,扩展元字符
- grep命令
## 8.1 什么是正则表达式
- 正则表达式是用来描述某些字符串匹配规则的工具
### 8.1.1 为什么使用正则表达式
- 需要处理从文本中查找符合某些比较复杂规则的字符串
### 8.1.2 如何学习正则表达式
- 重点理解元字符
- 掌握好正则表达式的语法
- 开拓思路 寻找最佳正则的标点方法
### 如何实践正则表达式
- 一个正则表达式完成后,并不能保证这个表达式一定是在准确的,需要不断的测试才可以确定其正确与否
- 在shell中可以使用grep或egrep命令来测试
- 也可以使用在线的正则表达式测试网站来测试
```
#! /bin/bash

str=`cat version.txt|grep rev`
echo "$str"
```
## 8.2 正则表达式基础
### 正则表达式的原理
- 输入文本
    - 正则表达式
        - 符合规则的文本
        - 不符合规则的文本

### 基本正则表达式
- BRE(Basic Regular Expression),又称标准正则表达式,仅支持最基本的元字符集
- 基本正则表达式是POSIX规范制定的两种正则表达式语法标准之一
- 另外一种语法标准称为扩展正则表达式
- 元字符主要有以下几种
    
元字符 | 名称 | 含义
--- | --- | ---
^ | 行首定位符 | 是正则表达式的定位符之一,用来匹配行首的字符,表示行首是^后面的字符,正则表达式中的定位符与其他元字符不同,他们不是用来匹配具体的文本,而是匹配某个具体的位置
$ | 行尾定位符 | 用来定位文本行的末尾,行尾定位符位于所作用的字符之后
. | 单个字符匹配 | 用来匹配任意单个字符,包括空格,不包括换行符,当使用.后,意味着该位置一定有一个字符,无论是什么字符,才会匹配上
\* | 限定符 | 星号是正则表达式中的限定符之一.限定符本身不代表任何字符,它是用来指定其前面的一个字符必须要重复出现多少次才能满足匹配,表示匹配其前导字符的任意次数,包括0次
[abc] | 字符集匹配-方括号 | 指定一个字符集合,其中a,b,c表示任意单个字符,方括号的某个字符在文本中出现则算是匹配;对于连续的数字或者字母,可以使用连字符"-",例如[a-z],[0-9]
[^abc] | 字符集不匹配 | 不匹配列出的任意字符
\\(\\) | 定义子表达式,在后续正则表达式中可以通过转义序列来引用正则表达式,最多可9个| "\\(love\\).*\1",等同于love.*love
x\\{m,n\\} | 区间表达式 | x最少出现m次,最多出现n次
\\< | 词首定位符 | "\\<hello"匹配含有hello开头的文本行
\\> | 词尾定位符 | "hello\\>"匹配含有hello结尾的文本行
### 扩展正则表达式
- ERE(Extended Regular Expression),扩展正则表达式,支持比基本正则更多的元字符
- 扩展正则表达式对某些基本正则表达式所支持的元字符并不支持
- ^ $ \. \* [] [^]均支持
    
元字符 | 名称 | 说明
--- | --- | ---
\+ | 限定符 | 前面的字符至少出现1次
? | 限定符? | 用来限定前面的字符最多出现1次,即前面的字符可以重复0次或者1次
\| | 竖线 | 表示多个正则表达式之间或的关系 | 基本用法 Expression1\|Expression2...
() | 圆括号 | 用来表示一组可选值的集合
### Perl正则表达式
- shell中的grep和egrep都支持perl正则表达式
- perl正则表达式的元字符与扩展正则表达式的元字符大致相同
    
元字符 | 名称 | 说明
--- | --- | ---
\d | 数字匹配 | 匹配0到9中的任意一个数字字符,等价于表达式[0-9]
\D | 非数字匹配 | 匹配一个非数字字符,等价于表达式[^0-9]
\s | 空白字符匹配 | 匹配任何空白字符,包括空白,制表符以及换页符,等价于表达式[\f\n\r\t\v]
\S | 非空白字符匹配 | 匹配任何非空白字符
### 正则表达式字符集
- 一个正则表达式是由一系列字符组成的字符串,包括元字符和普通字符
- 正则表达式中,普通字符集中的字符只表示它们的字面含义,不对其他字符产生影响
- 正则表达式最简单形式就是只由普通字符组成,不包含元字符
    - [cC]hina
    - [a-zA-Z]
    - [0-9]
    - ...
- POSIX标准字符类
    
字符类 | 说明
--- | ---
[:alnum:] | 匹配任意一个字母或数字,等价于a-zA-Z0-9
[:alpha:] | 匹配任意一个字母,等价于a-zA-Z
[:digit:] | 匹配任意一个数字,等价于0-9
[:lower] | 匹配任意一个小写字母,等价于a-z
[:upper:] | 匹配任意一个大写字母,等价于A-Z
[:space:] | 匹配任意一个空白字符,包括空白,制表符,以及分页符
[:blank:] | 匹配空格和制表符
[:graph:] | 匹配任意一个看得见的可打印字符,不包括空白字符
[:print:] | 匹配任何一个可以打印的字符,包括空白字符,但是不包括控制字符,字符串结束符\0,EOF文件结束符
[:cntrl:] | 匹配任何一个控制字符,即ASCII字符集的前32个字符,例如换行符,制表符等
[:punct:] | 匹配任何一个标点符号
[:xdigit:] | 匹配十六进制数字,即0-9,a-f以及A-F
## 8.3 正则表达式应用
### 匹配单个字符
- 正则表达式中,可用来匹配单个字符的表达式有4种
    - 单个一般字符
        - 一般字符是指除了正则表达式中已经定义的元字符之外的所有字符 
        - 当需要匹配某个一般字符时,可以直接将该字符作为表达式或者是表达式的一部分
    - 转义后的元字符
        - 如果要匹配元字符本身,需要加上转义字符\\
            - \\\.
            - \\\*
    - 圆点
        - \. 
    - 方括号表达式
        - 方括号表达式用来表示一个可选字符集
        - 一次只能匹配方括号中的一个字符
        - 方括号表达式仍然表示的是匹配单个字符
### 匹配多个字符
- 将多个字符按照指定的顺序拼接起来
```
#! /bin/bash

#筛选符合格式的电话号码
str=`egrep "800-[[:digit:]]{3}-[[:digit:]]{4}$" demo4.txt`

echo "$str"
```
### 匹配字符串的开始或者结尾
- ^a 匹配a开始
- e$ 匹配以e结尾
- ^$ 匹配空行
### 子表达式
- 由多个普通字符或者元字符组成的一个小的正则表达式,称为子表达式
- 子表达式也是一个完整的正则表达式
- 子表达式作为大的正则表达式的一部分使用,而不是单独使用
- 子表达式作为一个整体看待
- 子表达式使用圆括号()括起来
### 通配符
- shell用了正则表达式中的某些字符作为其通配符,\*,?,[]以及^
- 这些字符与在正则表达式中的含义有区别
- \*shell中表示匹配任意字符
- \*正则表达式中表示前导字符出现0次或多次
- ...
## grep命令
- grep命令名称为:全局搜索正则表达式并打印文本行(Global Search Regular Expression and Print out the line)
- grep的基本语法如下
```
grep [options] pattern [file...]
```
`
选项 | 说明
--- | ---
-c | 只打印匹配的文本行的行数,不显示匹配的内容
-i | 匹配时忽略字母的大小写
-h | 当搜索多个文件时,不显示匹配文件名前缀
-l | 只列出含有匹配的文本行的文件的文件名,不显示具体的匹配内容
-n | 累出所有匹配的文本,并显示行号
-s | 不显示关于不存在或者无法读取文件的错误信息
-v | 只显示不匹配的文本行
-w | 匹配整个单词
-x | 匹配整个文本行
-r | 递归搜索
-q | 禁止输出任何匹配结果,而是以退出状态码的形式表示搜索是否成功,其中0表示找到了匹配的文本行
-b | 打印匹配的文本行到文件头的偏移量,单位为字节
-E | 支持扩展正则表达式
-P | 支持perl正则表达式
-F | 不支持正则表达式,将模式按字面意义匹配
### grep命令族
- grep
- egrep: grep的扩展,使用扩展正则表达式作为默认的引擎
- fgrep: (fixed grep),所有的字母都看作单词,元字符也作为一般字符处理,不拥有特殊含义
---
# 9 基本文本处理
- echo输出文本,echo的基本语法,输出普通字符,转义字符,变量,命令执行结果等各种数据的方法
- 文本的格式化输出,制表符,fold,fmt以及pr命令
- sort对文本排序
- 文本统计
- cut 命令选取特定的文本
- paste命令拼接文本行
- join命令连接文本行
- tr命令替换文件内容
## 9.1 使用echo命令输出文本
### 显示普通字符
- echo命令的功能就是输出一行文本,在shell中多用于显示提示信息或者程序产生的数据,基本语法如下
```
echo [options] string
```
- 可同时指定多个文本,文本之间由空格隔开
- echo -n 不换行显示
- echo -e 支持转义字符输出
- echo "${variable}" 输出变量值
- echo `command` 显示shell命令的执行结果
```
#! /bin/bash

#显示date命令的执行结果
echo `date`
#显示ls命令的执行结果
echo `ls`
```
- echo 命令执行结果重定向
    - > 覆盖输出
    - >> 追加
```
#! /bin/bash

#将要输出的信息写入文件
echo "Hello, world." > hello.txt
#将输出的信息追加到文件的结尾
echo "Hello, echo." >> hello.txt
```
## 9.2 文本格式化输出
- 制表符
    - \\t
    - echo输出制表符需要加上-e选项
- pr命令
- fmt命令
### fold命令格式化行
- fold功能是将超过指定宽度的文本行进行折叠处理,使得超过指定宽度的字符转到下一行输出,基本语法如下
```
fold [options] [file...]
```
- options选项
    - -b 按字节计算宽度,默认情况下fold按列来计算宽度
    - -s 在空格处折断行
    - -w 指定宽度,默认值是80
    - file参数用来指定要输出的文件名,可以是多个文件,文件名之间用空格隔开
```
fold -w 90 demo.txt
```
### fmt命令格式化段落
- fmt是shell中一个简单的文本格式化工具,基本语法如下
```
fmt [-width] [options] [file]
```
- options选项
    - -c 保留每个段落的前2行的缩进,该段落的剩余的行的左边距与第2行相同
    - -t 与-c基本相同,-t选项每个段落的第1行和第2行的缩进必须是不同的,否则第一行将被看做是一个单独段落
    - -s 只折断超出指定宽度的行,不合并少于指定宽度的行
    - -u 统一空格的个数,单词之间保留1个,句子之间保留2个
    - -w 指定每个航的最大宽度,默认值75
```
fmt -c -w 80 demo.txt > demo1.txt
```
### rev命令反转字符顺序
- rev基本语法如下
```
rev [file...]
```
### pr命令格式化文本页
- pr功能是将文本文件的内容转换成适合打印的格式,基本语法如下
```
pr [option] [file...]
```
```
#! /bin/bash

#自定义页眉
str=`pr -h "List of Countries" -a -f -4 demo4.txt`
echo "$str"
```
## 9.3 sort命令对文本排序
- shell中sort命令有3种模式
    - 排序文本
    - 检查文件是否已经排序
    - 河滨文件
- 基本语法如下
```
sort [options] [file]...
```
### 单个关键字排序
- 可以使用-k选项来定义排序关键字,基本语法如下
```
-k pos1[,pos2]
sort -k 2,3 demo5.txt
#根据第4列的第14~15个字符排序，并输出到文件
sort -t ' ' -n -k 4.14,4.15 demo7.txt > sorted_log
```
- pos1表示排序关键字的起始位置,pos2表示排序关键字的结束位置,两者之间用逗号隔开
### 根据指定列排序
- 一般情况下,sort命令使用几个列组成一个关键字来排序
- -k选项也可以实现指定某一个列为关键字进行排序
```
-k pos,pos
```
- 同时还可根据某个列中的子串来排序
```
-k pos.[start],pos.[end]
```
### 根据关键字降序排序
- sort提供了-r和r修饰符,用来实现根据关键字降序排列
- -r选项是作为全局选项使用
- 修饰符r可以附加在组成关键字的列号后面,其作用域为所附加的列
```
#使用-r选项降序排序
sort -r -k 2,3 demo5.txt
#使用修饰符实现降序
sort -k 2,3r demo5.txt
```
### 数值列的排序
- 默认情况下,sort命令会将所有的列看做是字符串,并且按照字符串的排序规则进行排序
- -n选项或者修饰符n十分sort命令将数值字段,按数字大小排序
```
#对第3列按数值排序
sort -n -k 3,3  demo5.txt
```
### 自定义列分隔符
- 默认情况下,sort命令会将连续的空格,制表符作为列的分隔符
- 其他分隔符,比如冒号,分号,逗号,需要使用-t参数指定
```
#自定义分隔符
sort -t : -k3n,3 /etc/passwd
```
### 删除重复行
- sort命令 -u可删除重复行
### 根据多个关键字排序
- sort命令可以使用-k参数指定多个关键字进行排序
- 优先使用前面的关键字判断,如果前面的一样,则使用下一个关键字
```
sort [options] -k pos1,pos2 -k pos3,pos4 .... [file...]
#根据第3列的数值降序，第4列的数值升序排序
sort -k 3,3nr -k 4,4n demo6.txt
```
### sort命令合并文件
- sort命令可方便的合并多个文件,同时将文本文件内容进行排序,基本语法如下
```
sort file1 file2 ...
sort demo5.txt demo6.txt > result.txt
```
## 9.4 文本统计
- wc
- cat
- grep
### 输出含有行号的文本行
- 可以使用命令cat -n filename
- grep -n "" filename
- nl [option] [file]
    - -b显示风格,可以取a,t及n;a表示为所有行加行号;t表示仅仅非空行加行号;n表示不加行号
    - -i 行号的增量 默认值1
    - -v 行号的起始值,默认值1
    ```
    #为文本添加行号，并输出到文件
    nl -b a ex9-1.sh > textwithlineno.txt
    ```
### 统计行数
- grep -c 统计符合筛选条件的文本行条数
    - grep -c "reg" demo5.txt 
- wc
    - shell中用来对文本进行各种统计的命令
    - 基本语法: wc [option] [file]
    - options
        - -c 统计文本的字节数
        - -m 统计字符数
        - -l 统计行数
        - -L 统计最长行长度
        - -w 统计单词数
    - cat ex9-1.sh | wc -l
    - find /etc -name "*.conf" | wc -l
### 统计单词数和字符数
- wc -w
    - cat demo1.txt | wc -w 
- wc -m
    - cat demo1.txt | wc -m
## cut命令选取文本列
- cut命令可以在垂直方向上对文本进行操作
### cut命令及其语法
- 基本语法
```
cut option [file]
```
- options
    - -b 只选择指定的字节
    - -c 只选择指定的字符
    - -d 自定义列分隔符,默认值为制表符
    - -f 只选择列表中指定的文本列,文本列用列号表示,多个列之间用逗号隔开
    - -n 取消分割多字节字符
    - -s 不输出不包含分隔符的行
    - file表示要处理的文件列表,多个文件之间用空格隔开
### 选择指定的文本列
- 选取指定的文本列,需使用-f选项,该选项接受一个文本列的列表,cut命令会从文本文件中需验证列表中列出的列
```
#自定义分隔符为冒号，选择第1列和第6列
cut -d ":" -f 1,6 passwd
```
### 选择指定数量的字符
- cut -c list 从每一行中选择指定数量的字符
    - cut -c 1-4,6:选取1到4个字符和第6个字符
    - cut -c 3,5,8: 选取第3,5,8个字符
    - cut -c -4,8: 选取1-4个字符和第8个
    - cut -c 3- : 选取第3到末尾的全部字符
    - cut -c1-3,5 passwd
### 排除不包含分隔符的行
- cut -s可以排除掉不包含正确分隔符的行
- cut -s -d ":" -f 1 passwd > validusers.txt
## paste拼接文本列
- 将多个文件的列合并起来
### paste命令及其语法
- 将某些文本行并行的联接在一起,形成一个新的文件
- 基本语法
```
paste [option] [file]
```
- options
    - -d 指定拼接结果中列分隔符,默认情况下为制表符分割
    - -s 将多个文件串行的拼接在一起,即将后面文件的内容追加到前面一个文件的后面
- paste students.txt phones.txt > contactinfo.txt
### 自定义列分隔符
- 默认情况下,paste使用制表符作为新生成文件的列分隔符
- 可以使用-d选项来自定义所需要的分隔符
```
#自定义列分隔符
paste -d "," students.txt phones.txt > contactinfo.txt
```
### 拼接指定的文本列
- paste命令不直接支持只选择文本中的某些列进行拼接,可以配合cut命令间接实现
- 先使用cut命令将需要的列提取出来,存储到新的文件,再使用paste拼接
- 或者先paste拼接,再使用cut提取
- 推荐使用第一种(先提取再拼接),效率较高
```
#选择students.txt文件的第1列 
cut -f1 students.txt > students.tmp
#选择phones.txt文件的第2列             
cut -f2 phones.txt > phones.tmp    
#将生成的2个临时文件拼接            
paste students.tmp phones.tmp > contactinfo.txt

#先将2个文件拼接
paste students.txt phones.txt > contactinfo.tmp
#再从拼接结果中选择第1和3列
cut -f1,3 contactinfo.tmp > contactinfo.txt
```
## 9.7 使用join命令连接文本
- join命令用来联接文本文件中的数据行,根据联接的两个文本文件的公共列来连接数据行,基本语法如下
```
join [option] file1 file2
#使用默认选项联接2个文件
join students.txt phones.txt > contactinfo.txt
```
### 指定联接关键字列
- 默认情况下,join会将两个文件的第一列做为关键字列进行比较匹配
- 可以使用-1和-2选项指定第1个文件和第2个文件的关键字列进行匹配
- 这两个选项都使用列号做为参数值
```
#指定students.txt的第1列和scores.txt文件的第2列作为列关键字

join -1 1 -2 2 students.txt scores.txt > studentsscores.txt
```
### 内联文本文件
- 默认情况下,join命令只输出关键字匹配的文本行,忽略关键字不匹配的行
- 这种只输出匹配的文本行就是内联
### 做联接文本文件
- 在联接结果中输出左边文件的所有行,即使右边的文件没有匹配的行
- 右边文件没有的行,用空白符填充
- join -a 1 filenum file1 file2 选项-a 1表示显示第1个文件的所有的行，无论是否匹配成功。
- join -a 1 students.txt phones.txt > contactinfo.txt
### 右联接文本文件
- 在联接结果中输出右边文件所有的行
- join -a 2 filenum file1 file2
- join -a 2 students.txt phones.txt > contactinfo.txt
### 全联接文本文件
- 联接结果中输出两个文件的匹配行和所有不匹配行
- 不匹配的行由空白填充
- join -a 1 -a 2 file1 file2
- join -a 1 -a 2 student.txt phone.txt > res.txt
### 自定义输出列
- 可以使用-o选项来指定要输出的列的清单
- -o filenum.filed
- 指定参数值=0,表示仅仅输出关键字列
- 指定多个列,多个列之间使用空格隔开
```
#联接文件，并指定输出列的清单
join -1 1 -2 2 -o 1.1 1.2 2.3 students.txt scores.txt > studentsscores.txt
```
## 9.8 tr命令替换文件内容
- 批量替换文本中的字符
### tr命令及其语法
- tr是translate的前两个字母,其功能是转换或者删除指定的字符,tr命令不能直接从文件中读取数据,只能从标准输入获取数据
- 并且将处理结果写到标准输出设备
```
tr [option] set1 [set2]
```
- 使用tr命令,可以快速的将文本中连续出现多个相同的字符压缩为1个字符
- tr -s "[a-z]" < demo.txt  # 压缩重复字符
```
#删除空白行
cat demo10.txt | tr -s ["\n"]
```
- 大小写替换
    - 语法: tr [a-z] [A-Z]
    - 使用上述命令,出现在输入文本中的字符集[a-z]中的字母,将被字符集[A-Z]的大写字母替代
- echo "adjfj" | tr 'a-z' 'A-Z'
### 删除指定字符
- tr命令可以快速的删除文本中出现的字符
- 删除指定字符时,需要使用-d选项
```
#删除数字和冒号
tr -d "[0-9][:]" < demo11.txt
#使用补集删除某些字符
tr -cs "[a-z][A-Z]" "[\n*]" < demo11.txt

```
---
# 流编辑-sed
- sed工具介绍,sed工具的主要操作,工作方式,地址表示方式,sed中使用正则表达式
- sed命令常用操作:注释方法,打印文本,替换文本,删除文本,追加文本,移到下一行,读写文件以及多行模式
- 组合命令:将多条命令应用到一个地址范围
## sed命令及其语法
- sed是将一系列编辑命令应用于一批文本的理想工具
### sed命令
- sed命令是一个非交互式的文本编辑器,可以对来自文本文件以及标准输入的文本进行编辑
- 标准输入可以是来自键盘,文件重定向,字符串,变量或者是管道的文本
- sed命令会从文本或者标准输入中一次读取一行数据,将其复制到缓冲区,然后读取命令行或脚本编辑的子命令,对缓冲区中的文本进行编辑,重复此过程,直到所有的文本行都处理完毕
- sed的基本语法如下
```
sed [options] [script] [inputfile...]
```
### 10.1.2 sed命令的工作方式
- 可以直接在命令行执行sed命令,基本语法如下
```
sed [options] commands inputfile
```
- 同样可以将sed子命令写入文件,通过sed命令读取该文件且执行其中的命令,基本语法如下
```
sed [options] -f script inputfile
```
- 可以将sed的操作命令写入文件,将该脚本文件授予执行权限,且首行指定解释器为/bin/sed sed -f
```
./script inputfile
```
###  10.1.3 使用行号定位文本
- 定位单个行: x
- 定位某段连续的行: x,y
- 指定起始行和步长: first~step
- 第一行: 1
- 最后一行: $
- 指定某行后面的几行: x,+n
### 10.1.4 使用正则表达式定位文本行
- 语法:/regexp/
## 10.2 sed命令常用操作
- 编辑命令:打印,插入语,删除,替换
### 10.2.1 sed编辑命令基本语法
```
[address1[,address2]] command [argument]
```
### 10.2.2 选择文本
- sed命令中,选择文本行主要通过位置参数来完成,基本语法如下
```
[address1[,address2] p
```
- 子命令p表示将缓冲区中的文本执行输出操作
```
#输出1~3行，不使用-n选项
sed '1,3p' students.txt
echo "===================================="
#输出1~3行，使用-n选项
sed -n '1,3p' students.txt
#使用正则表达式作为定位参数
sed -n '/^2002013/ p' student.txt
```
### 10.2.3 替换文本
- 文本替换需要使用s子命令,基本语法如下
```
[address1[,address2] s/pattern/replacement/[flag]
```
```
#只将第一次出现的小写字母e替换成大写的E
sed 's/e/E/' student.txt
#将所有的小写字母都替换成大写字母E
sed 's/e/E/g' student.txt
#使用行号来定位文本行,完成替换
sed '1,3 s/e/E/g' student.txt
#通过行号和正则表达式来定位文本行,完成替换
sed '1,/^2002013/ s/e/E/g' student.txt
#将文本文件中的HTML标记清空
sed 's/<[^>]*>//g' a.html
#引用与模式匹配的子串
sed 's/string/long &/' demo.txt
#使用\n的形式来引用模式中的子串
sed 's/\(This\)\(is\)\(a\)\(string\)/\2 \1 \3 \4' demo.txt
```
### 10.2.4 删除文本
- sed提供d子命令来实现文本行的删除,语法如下
```
[address1[,address2] d
```
- 省略位置参数,则表示删除文本文件中的所有行
- 执行删除操作时,sed命令会首先读取一行文本到缓冲区,将符合位置参数的文本行删除,接着再读取并处理下一行
```
#删除第一行
sed -e '1 d' student.txt
#删除最后一行
sed -e '$ d' student.txt
#删除1-4行
sed -e '1,4 d' student.txt
#删除奇数行
sed -e '1~2 d' student.txt
#删除偶数行
sed -e '0~2 d' student.txt
#删除第一行开始到2002013行
sed -e '1,/^2002013/ d' student.txt
#删除第四行到最后
sed -e '4,$ d' student.txt
```
### 10.2.5 追加文本
- 将某些文本插入到某个位置,sed提供a子命令来实现文本的追加,基本语法如下
```
[address1] a string
```
- a子命令最多使用1个位置参数,参数string表示要追加的文本
- a子命令会将string代表的文本追加到address1所表示的位置后面
```
#在第2行后面追加文本
sed '2 a 2002015 Timer' student.txt
#通过正则表达式指定追加文本的位置
sed '/^2002013/ a 2002014 Tom' student.txt
```
### 插入文本
- 插入文本与追加文本类似,区别是插入的位置不同,插入文本的位置是位置参数指定的位置之前插入,使用子命令i实现,语法如下
```
[address1] i string
```
```
#在第2行签插入文本
sed '2 i 2002002 Tim' student.txt
```
## 10.3 组合命令
- sed支持多个子命令组合在一起使用
### 10.3.1 使用-e选项执行多个子命令
- sed -e选项可以使得sed将跟在其后面的字符串作为子命令执行
- 多个子命令,则必须使用多个-e选项
```
#将所有的小写字母e替换成大写E,并答应2,3行
sed -n -e 's/e/E/g' -e '2,3 p' student.txt
```
### 10.3.2 使用分号执行多个子命令
- 可以使用分号来将各个子命令隔开,语法如下
```
sed -e 'command1;command2...' filename
#使用分号隔开多个子命令
sed -e 's/e/E/g;2 i 2002002 Amer' student.txt
```
### 对同一个地址使用多个子命令
- 基本语法如下
```
address{
    command1
    command2
    ...
}
#组合命令
sed -n '1,5 {
    s/e/E/g
    s/a/A/g
    2 a 2002003 Shin
    p
}' student.txt
```
### 10.3.4 sed脚本
- sed 提供了-f选项,sed命令可以从指定的脚本文件中读取子命令,然后对每个文本执行各个子命令,语法如下
```
sed -f scriptfile filename
```
- sed 脚本语法比较简单,将各个子命令依次列出来,不需要使用引号
- 将多个子命令写在同一行,需要使用分号隔开
- sed脚本支持代码注释,#表示这一行为注释,不能跨行注释
---
# 文本处理利器awk
- awk入门,awk的功能,工作方式,基本语法以及工作流程
- awk的模式匹配: BEGIN模式,END模式,关系表达式,正则表达式以及混合模式
- 变量: awk程序中变量的定义方法,系统变量以及使用系统变量获取记录和字段的值
- 运算符和表达式: 主要介绍各种运算符,包括算术运算符,赋值运算符,条件运算符,逻辑运算符,以及关系运算符
- 函数:主要介绍awk内置的常用字符串函数和算术函数
- 数组: 数组的定义和引用方法以及数组的遍历
- 流程控制: 介绍awk中的if,while,do...while,break,continue,next,exit等流程控制语句
- awk程序的格式化输出: print printf sprintf
- awk程序与shell的交互:管道和system
## 11.1 awk入门
- awk是一种非常强大的数据处理工具,其本身可以称为一种程序设计语言
### 11.1.1 awk的功能
- awk是一种处理文本数据的编程语言
- awk的设计使得它非常适合于处理由行和列组成的文本数据
- awk是一种编程环境,提供了正则表达式的匹配,流程控制,运算符,表达式,变量以及函数等一系列程序设计语言所具备的特性
### 11.1.2 awk的基本语法
- awk的基本语法如下
```
awk pattern { action }
```
- pattern表示匹配的模式,action表示要执行的操作
- pattern和actions都是可选的,但是两者必须保证至少有一个
- 省略pattern,表示对所有文本执行action
- 省略action,表示将匹配成功的行输出到屏幕
### 11.1.3 awk的工作流程
- (1) 自动从指定的数据文件中读取文本行
- (2)自动更新awk的内置系统变量的值,例如列数变量NF,行数变量NR,行变量$0,以及各个列变量$1,$2等
- (3)依次执行程序中所有的匹配模式及其操作
- (4)当执行完所有的匹配模式及其操作之后,如果数据文件中仍有未读取的数据行,则返回到第一步,重复执行1-4步
### 11.1.4 执行awk程序的几种方式
- 通过命令行执行awk程序
```
awk 'program-text' datafile
# 打印数据文件
awk '{print}' awk_score.txt
```
- 执行awk脚本
    - awk成语语句比较多的情况下,可以将所有的语句写在一个脚本文件中,通过awk命令来解释并执行其中的语句
    - 语法如下
    ```
    awk -f program-file file
    #输出所有的行
    awk -f awk_demo.awk awk_score.txt
    ```
- 可执行脚本文件
    - 可以通过类似shell脚本的方式执行awk程序
    - 这种方式需要再awk程序中指定命令解释器,并且赋予脚本文件可执行权限
    - 指定命令解释器的语法:#! /bin/awk -f,必须位于脚本文件的第一行
    - 可以使用以下命令执行awk程序:awk-script file
    ```
    #! /bin/awk -f

    #输出所有的行
    { print }
    ```
## awk的模式匹配
- awk中,匹配模式处于非常重要的地位,决定着匹配模式后面的操作会影响到哪些文本
- awk的匹配模式主要包括
    - 关系表达式
    - 正则表达式
    - 混合模式
    - BEGIN模式
    - END模式
### 11.2.1 关系表达式
- awk提供了许多关系运算符,例如> < ==等
- awk可以使用关系表达式作为匹配模式,当某个文本行满足关系表达式,将会执行相应的操作
```
#! /bin/bash

#打印第2列的成绩超过80的行
result=`awk '$2 > 80 { print }' scores.txt`

echo "$result"
```
### 11.2.2 正则表达式
- awk支持以正则表达式作为匹配模式,与sed一样,需要将正则表达式放在两条斜线之间:/regexp/
```
#输出以字符T开头的行
awk '/^T/ { print }' scores.txt
#输出以Tom或者Kon开头的行
awk '/^(Tom|Kon)/ { print }' scores.txt
```
### 11.2.3 混合模式
- awk支持使用逻辑运算符&&,||或者!将多个表达式组合起来作为一个模式
```
#混合模式
awk '/^K/ && $2 > 80 {print}' awk_score.txt
```
### 11.2.4 区间模式
- awk支持一种区间模式,可以通过模式匹配一段连续的文本行,区间模式的语法如下
```
pattern1,pattern2
```
- pattern可以是关系表达式,也可以是正则表达式,也可以是混合模式
```
#区间模式
awk '/^Nancy/,$2==92 {print}' awk_score.txt
```
### 11.2.5 BEGIN模式
- BEGIN模式是一种特殊的内置模式,成立的时机是awk程序刚开始执行,此时尚未读取任何数据,该模式对应的操作只被执行一次
- awk读取数据之后,BEGIN模式便不再成立
- 可以将与数据文件无关,而且在整个程序生命周期中,只需执行1次的代码放在BEGIN模式对应的操作中
```
#! /bin/awk -f

#通过BEGIN模式输出字符串
BEGIN { print "Hello! World." }
```
```
#! /bin/awk -f

#通过BEGIN模式初始化变量
BEGIN {
   FS="[\t:]"
   RS="\n"
   count=30
   print "The report is about students's scores."
}
```
### 11.2.6 END模式
- END模式是awk的另外一种特殊模式,成立的时机是在awk命令处理完所有的数据,即将推出程序时
- 整个程序的生命周期中,该模式对应的操作只被执行一次
```
#! /bin/awk -f

#输出报表头
BEGIN {
   print "scores report"
   print "================================="
}
#输出数据
{ print }
#报表完成
END {
   print "================================"
   print "printing is over"
}
```
## 11.3 变量
- awk本身支持变量的相关操作,包括变量的定义,引用以及运算
- 包含很多系统变量
### 11.3.1 变量的定义和引用
- awk的变量名只能包含字母,数字和下划线,并且不能以数字开头,且区分大小写
- awk中定义变量,只要给出一个变量名并且赋予适当的值即可
- 定义awk变量无需指定类型,会根据变量所处的环境自动判断
- 没有指定值,数值类型的变量的缺省值为0,字符串类型的变量缺省值为空串
```
#! /bin/awk -f

BEGIN {
   #定义变量x
   x=3
   #定义变量message
   message="Hello " "world"
   #输出变量
   print x
   print message
}
```
### 11.3.2 系统内置变量
- awk提供了许多实用的系统变量,例如字段变量,字段数变量,以及记录数变量
    
变量 | 说明
--- | ---
$0 | 记录变量,表示当前正在处理的记录
$n | 字段变量,其中n为正数,且n大于0,表示第n个字段
NF | 整数值,宝石当前记录的字段数
NR | 整数值,表示awk已经读入的记录数
FILENAME | 表示正在处理的数据文件名称
FS | 字段分割符,默认值是空格或制表符
RS | 记录分隔符,默认是换行符
### 11.3.3 记录分隔符和字段分隔符
- 记录分隔符由系统变量RS来指定,如果没有指定,则默认使用换行符\n
```
#! /bin/awk -f
   
BEGIN {
     #定义记录分隔符
     RS=""
   }
   
   {
      print
      print "=========================================="
   }
```
```
#! /bin/awk -f

BEGIN {
   #定义记录分隔符
   RS=""
   #定义字段分隔符
   FS="\n"
}
#输出第1个字段
{ print $1 }
```
### 11.3.4 记录和字段的引用
- awk中,可以使用系统变量来引用数据文件中的记录和字段
- awk每次只读取1行文本,在awk程序中,记录和字段的引用都是针对当前记录来说的
- 变量$0表示正在读取的当前记录,该变量将整个记录作为一个字符串来处理
```
#! /bin/awk -f

#通过$0引用整个记录
{ print $0 }
```
```
#! /bin/awk -f

{
   #输出第1个字段以及第2~5个字段的和
   print $1, $2+$3+$4+$5
}
```
11.4 运算符和表达式
- awk支持常用的运算符以及表达式,算术,逻辑以及关系
### 11.4.1 算术运算符
- +,-,*,/,%,^
### 赋值运算符
- =
- +=
- -=
- *=
- /=
- %=
- ^=
```
#! /bin/awk -f

BEGIN {
   #简单赋值
   x=4
   print x
   #求和赋值
   x+=10
   print x
   #乘积赋值
   x*=2
   print x
   #幂运算赋值
   x^=2
   print x
}
```
### 11.4.3 条件运算符
- awk的条件运算符只有1个,语法如下
```
Expression?value1:value2
```
- 这是一个三目运算符
```
#! /bin/awk -f

{
   #如果大于90，输出A，否则输出B
   grade=($2>90?"A":"B")
   print grade
}
```
### 11.4.4 逻辑运算符
- &&
- ||
- !
```
#! /bin/awk -f

#输出所有的字段的值都大于80的记录
$2 > 80 && $3 > 80 && $4 > 80 && $5 >80 {
   print 
}
```
### 11.4.5 关系运算符
- > >=
- < <=
- == !=
- ~:匹配运算符,$1~/^T/表示匹配第一个字段以字符T开头的记录
- !~: 不匹配运算符,$1 !~/a/ 表示匹配第一个字段不含有字符a的记录
```
#! /bin/awk -f

#匹配第1个字段以字符K开头的记录
$1 ~ /^K/ { print }
```
### 11.4.6 其他运算符
- awk还支持其他一些运算符
    - 正号+
    - 负号-
    - 自增++
    - 自减--
## 11.5 函数
- awk本身提供了许多系统函数,字符串函数以及算术函数
- 用户还可以自定义函数,自定义函数使用较少
### 11.5.1 字符串函数
- 字符串是awk中的两大类型之一
    
函数 | 说明
--- | ---
index(string1,string2) | 返回string2在string1中的位置,如果string在string1中出现多次,则返回第1次出现的位置,如果string1不包含string2,则该函数返回0
length(string) | 返回字符串string的长度
match(string,regexp) | 在字符串string搜索符合正则表达式的子字符串,如果有多个匹配的字符串,则以第一个匹配的字符串为准,该函数的返回值体现在系统变量RSTSRT和RLENGTH
split(string,array,seperator) | 根据指定的分隔符,将指定字符串分割成多个字段,并存储在数组array中
sub(regexp,replacement,string) | 将字符串string中的第一个符合正则表达式regexp的子串替换成replacement
gsub(regexp,replacement,string) | 将字符串string中的所有的符合正则表达式regexp的字符串都替换成replacement
substr(string,start,[length]) | 从字符串string中截取指定的子串,起始位置为start,长度为length,如果省略length,则表示从start开始截取到字符串结束
- index函数,length函数
```
#! /bin/awk -f

BEGIN {
   #输出子串在父串中出现的位置
   print index("Hello,world.","world")
      #输出字符串的长度
   print length("Hello, world.")

}
```
- match函数
```
#! /bin/awk -f

BEGIN {
    #通过正则表达式搜索子串
    match("Hello, world.",/o/)
    print RSTART,RLENGTH
}
```
- split函数,分割符可以使用正则表达式
```
#! /bin/awk -f

BEGIN {
   string="5P12p89"
   #使用分隔符P或者p分隔字符串
   split(string,arr,/[Pp]/)
   #输出第1~3个数组元素
   print arr[1]
   print arr[2]
   print arr[3]
}
```
- sub(regexp,replacement,string)和gsub函数
```
#! /bin/awk -f

BEGIN {
   #定义字符串
   string="abcd6b12abcabc212@123465"
   #将第1个符合正则表达式/(abc)+[0-9]*/的子串用括号括起来
   sub(/(abc)+[0-9]*/,"(&)",string)
   print string
   
   #将所有符合正则表达式/(abc)+[0-9]*/的子串用括号括起来
   gsub(/(abc)+[0-9]*/,"(&)",string)
   print string
}
```
- substr(string,start,[length])截取子串
```
#! /bin/awk -f

BEGIN {
    #定义字符串
    pages="p12-P23 P56-p78"
    #通过循环匹配字符串中的数字
    while(match(pages,/[0-9]+/) >0){
        #截取并输出匹配的子串
        print substr(pages,RSTART,RLENGTH)
        sub(/[0-9]+/,"",pages)
    }
}
```
### 11.5.2 算术函数
- int(x):返回数值x的整数部分
- sqrt(x)
- exp(x):返回e的x次方
- log(x):返回e为底的对数值
- sin(x),cos(x)
- rand():返回介于0-1之间的随机数
- srand([x]):以x为种子返回一个随机数
## 11.6 数组
### 11.6.1 数组的定义和赋值
- 定义数组时,无需指定其类型和大小,数组元素赋值语法如下
```
#赋值
array[n]=value
#引用
array[n]
```
```
#! /bin/awk -f

BEGIN {
   #为数组元素赋值
   arr[1]="Tim"
   arr["a"]=12
   arr[3]=3.1415
   arr[4]=5
   #输出数组元素的值
   print arr[1],arr["a"]*arr[3],arr[4]
}
```
### 11.6.2 遍历数组
- awk中,数组的长度可以使用length函数获得,该函数以数组名作为参数,返回数组的长度
```
#! /bin/awk -f
BEGIN {
   #定义数组
   stu[1]="200200110"
   stu[2]="200200164"
   stu[3]="200200167"
   stu[4]="200200168"
   stu[5]="200200172"
   #计算数组的长度
   len=length(stu)
      #通过循环遍历数组
   for(i=1;i<=len;i++)
   {
       print i,stu[i]
   }
}
```
- 使用for结构来遍历数组
```
#! /bin/awk -f

BEGIN {
   #定义数组
   arr[1]="Tim"
   arr[2]="John"
   arr["a"]=12
   arr[3]=3.1415
   arr[4]=5
   arr[99]=23

   #遍历数组
   for(n in arr)
   {
      print arr[n]
   }
}
```
## 11.7 流程控制
- awk支持程序的流程控制,条件判断,循环以及其他一些流程控制语句,例如continue,break,exit等
### 11.7.1 if语句
- 基本语法如下
```
if (expression){
    statement1
    statement2
    ...
}
else {
    statement3
    statement4
    ...
}
```
```
#! /bin/awk -f
{
   #90分以上为A
   if ($2 >= 90) {
       print $1,"A"
   }
   else {
      #80分以上为B
      if($2 >= 80 && $2 < 90)
      {
         print $1,"B"
      }
      #其余为C
      else
      {
         print $1,"C"
      }
   }
}
```
### 11.7.2 while语句
- 基本语法如下
```
while (expression){
    statement1
    statement2
    ...
}
```
```
#! /bin/awk -f

BEGIN {
   #定义循环变量
   i=0
   #while循环开始
   while (++i <= 9)
   {
      #输出循环变量i的平方
      print i^2
   }
}
```
### 11.7.3 do...while语句
- 基本语法如下
```
do{
    statement1
    statement2
    ...
}while(Expression)
```
```
#! /bin/awk -f

BEGIN {
   #定义循环变量
   i=1
   do
   {
      #输出循环变量的平方
      print i^2
   }while (++i<=9)
}
```
### 11.7.4 for循环语句
- 基本语法如下
```
for(Expression1;Expression2;Expression3){
    statement1
    statement2
    ...
}
```
- for循环 九九乘法表打印
```
#! /bin/awk -f

BEGIN {
    for(i=1;i<10;i++){
        for(j=1,j<=i;j++){
            # 将每一行连接起来
            if(i*j < 10){
                row=row"    "i*j
            }
            else {
                row=row"   "i*j
            }
        }
        print row
        row=""
    }
}
```
### 11.7.5 break语句
- break语句退出当前循环
```
#! /bin/awk -f

BEGIN {
   #循环读取数据
   while( getline < "scores.txt" > 0)
   {
      #当第1个字段的额值为Kity时退出
      if($1=="Kity")
         break
      else
         print $1,$2,$3,$4,$5
   }
}
```
### 11.7.6 continue语句
- continue语句是跳过循环结构中该语句后面尚未执行的语句,继续下一次循环
```
#! /bin/awk -f

BEGIN {
   #通过循环读取数据
   while( getline < "scores.txt" > 0)
   {
      #当第1个字段含有字符串Nancy时跳过后面的语句
      if($1 == "Kity")
         continue
      print $1,$2,$3,$4,$5
   }
}
```
### 11.7.7 next语句
- next语句是用在整个awk程序中,当遇到next语句,该语句后面的所有程序语句都被忽略
- awk会继续读取下一行数据,并且从第一个模式及其操作开始执行
```
#! /bin/awk -f

#当读取的行为空行时跳过后面的语句
/^[\t]*$/ {
   next
}

#输出各个字段
{
   print $1,$2,$3,$4,$5
}
```
### 11.7.8 exit语句
- exit语句是终止awk程序的执行
## awk程序的格式化输出
### 11.8.1 基本print语句
- print string1,string2....
- print会自动使用空格将各个参数值隔开
### 11.8.2 格式化输出语句printf
- awk的printf函数与c语言中的基本相同,基本语法如下
```
printf(format,[arguments])
```
- 多个参数之间用逗号隔开
- 参数列表的项是有顺序的,与前面的格式化字符中的格式说明相对应
```
#! /bin/awk -f

{
  printf("%s\t%d\t%d\t%d\t%d\t%d\n",$1,$2,$3,$4,$5,($2 + $3 + $4 + $5))
}
```
### 11.8.3 使用sprintf()函数生成格式化字符串
- sprintf函数的功能与printf的功能大致相同
- sprintf只是以字符串形式返回格式化结果,并不输出到到标准输出设备
- 可以将格式化的结果用print或者printf输出到标准输出设备
```
#! /bin/awk -f

BEGIN {
   print "Scores list"
}

{
   printf ("%s\t%d\t%d\t%d\t%d\t%d\n",$1,$2,$3,$4,$5,($2 + $3 + $4 + $5))
   total+=$2 + $3 + $4 + $5
}

END {
   average=total/NR
   sum=sprintf("Total: %d students, average: %.2f",NR,average)
   print sum
}
```
## awk的程序与shell的交互
- awk使用2种机制来实现与shell的交互
    - 管道
    - system
### 通过管道实现与shell的交互
```
#! /bin/awk -f

BEGIN {
   while("who" | getline) n++
   printf("There %d online users.\n",n)
}
```
### 通过system函数实现与shell交互
- 使用awk函数system()可与shell交互
```
system(shell_command)
```
- 此种方式不能在awk中直接获取shell命令的执行结果
- 要实现数据传递,必须借助其他一些手段
```
#! /bin/awk -f

BEGIN {
    #通过system调用shell命令
    system("ls | filelist")
    
    while(getline < "filelist" > 0){
        print $1
    }
}
```
---
# 12 文件的操作
- 文件
- 查找文件
- 比较文件
- 重定向
## 12.1 文件
- ls
### 文件类型
- 普通文件
- 目录
- 伪文件
### 文件的权限
- -rwzr-xr-x
## 12.2 查找文件
- locate
- whereis
- find
### 12.2.1 find命令以及语法
- find 命令基本语法如下
```
find path test action
```
### find 命令: 路径
- find /usr/bin
- find /
- find .
- find ~root
```
find . -name "*.sh"`
#find命令同时搜索多个路径的方法
find /etc /usr/local -name httpd.conf
```
### find命令: 测试
- find命令的测试条件用来对搜索结果进行筛选
- 只有符合指定条件的文件才会出现在最终的搜索结果中
    
条件 | 说明
--- | ---
-name pattern | 表示包含指定匹配模式的文件名
-iname pattern | 表示包含指定匹配模式的文件名,不区分大小写
-type | 指定文件类型,可以取d和f的这两个值,分别表示目录和普通文件
-perm mode | 匹配其权限设置为mode的文件
-user userid | 匹配其所有者为指定用户id的文件
-group groupid | 匹配其所属组为指定组id的文件
-size size | 匹配其大小为size的文件
-empty | 匹配空文件
-amin [-+]n | 文件最后一次访问时间,-n表示距今n分钟以内,+n表示访问时间距今n分钟以前,n表示恰好n分钟
-atime [-+]n | 文件最后一次访问时间,-n表示访问时间n天以内
-cmin [-+]n | 文件最后一次状态改变的时间
-ctime [-+]n | 文件最后一次状态改变的时间
-mmin [-+]n | 文件内容最后一次被修改的时间
-mtime [-+]n | 文件内容最后一次被修改的时间
```
find /etc -type f -print | wc -l
find /etc -type d -print | wc -l
find /etc -name httpd.conf -print
find /etc -name "httpd.conf*" -print
find /etc -name rc[1-9].d -print
```
### find命令: 使用!运算符对测试求反
- !用来对测试条件取反
- 可以加在任何测试条件前面,表示其后测试的相反条件
- !前后必须有空格符
- 需要使用单引号或者反斜线将!引用起来
```
find /data1/wwwwrooot -type f \! -name "*.jpg" -print
```
### find命令:处理文件权限错误信息
```
#使用重定向将错误消息丢弃
find / -name httpd.conf 2> /dev/null
```
### find命令: 动作
- find命令action参数是find命令对于搜索结果的动作
    
动作 | 说明
--- | ---
-print | 默认动作,将搜索结果写入到标准输出
-fprint file | 与-print相同,但是将搜索结果写入到文件file
-ls | 以详细格式显示搜索结果
-fls file | 同-ls,将搜索结果写入文件file
-delete | 将搜索到的文件删除
-exec command {} \; | 查找并执行命令,{}表示搜索到的文件名
-ok command {} \: | 查找并执行命令,但是需要用户确认
```
#! /bin/bash

find ./tmp -name "*.php" -exec rm -f {} \;

if [ $? -eq 0 ]
then
   echo "the files have been deleted successfully.";
else
   echo "Failed to delete files.";
fi
```
## 12.3 比较文件
- comm
    - comm [options] file1 file2
    - comm -2 -3 students.txt students1.txt
    - comm -1 -3 students.txt students1.txt
    - comm -1 -2 students.txt students1.txt
    - options
        - -1:不显示第一个文件中独有的文本行
        - -2:不显示第二个文件独有的文本行
        - -3:不显示两个文件中共同的文本行
        - --check-order:检查参与的2个文件是否已排序
        - --nocheck-order:不检查参与比较的两个文件是否已经排序
- diff
    - diff不要求参与比较的文件是有序的
    - diff可以比较普通文件,还可以比较多个目录内容的差异
    - diff [options] files
    - diff students.txt students1.txt 
## 12.4 文件描述符
### 什么是文件描述符
- 文件描述符是一个非负整数,实际上是一个索引值,指向内核为每一个进程所维护的该进程打开文件的记录表
### 标准输入,标准输出,标准错误
- 0标准输入
- 1标准输出
- 2标准错误输出
## 12.5 重定向
- 输出重定向(覆盖)
    - cmd > file 
    - ls -l /etc > filelist
- 输出重定向(追加)
    - cmd [n]>> file
    - 操作符也支持一组命令重定向
        - { cmd1;cmd2... } [n]>> file
- 输入重定向
    - cmd < file 
- 当前文档
    - 输入重定向的另外一个用途是生成当前文档,基本语法如下
    ```
    cmd << delimiter
    document content
    delimiter
    ```
- 重定向2个文件描述符
    - n>&m
    - n和m都是文件描述符,n为文件描述符m的副本
- 使用exec命令分配文件描述符
- 可以使用exec命令创建新的文件描述符,将文件描述符绑定到文件或者另外一个文件描述符或者文件
    
重定向 | 说明
--- | ---
exec 2>file | 将所有命令的标准错误重定向到文件file
exec n<file | 以只读的方式打开名称为file的文件,并且使用文件描述符n,n大于3
exec n>file | 以写入的方式打开名称为file的文件,并且使用文件描述符n,n大于3
exec n<>file | 以读写方式打开文件file,并且使用文件描述符n,n大于3
exec n>&- | 关闭文件描述符
exec n>&m | 使得文件描述符n称为文件描述符m的副本,将文件描述符m复制到n
```
#! /bin/bash

exec 99>&2

exec 2> errlog

ls -lw

exec 2>&99

exec 99>&-
```
- 列出当前目录中的文件，并且在文件名前面加上行号
```
#!/bin/bash                                                                                                                                                                                                     
echo 'START'
exec 100< <(ls -l)
num=1
while read line; do
    echo "LINE $num: $line"
    num=$(($num + 1))
done <&100
exec 100>&-                     # close it                                                                                                                                                                      
echo 'END'
```
---
# 13 子shell与进程处理
- 子shell相关知识,shell内部命令,外部命令,圆括号以及子shell中变量的作用域
- 进程管理,shell脚本管理进程,作业控制,信号以及trap命令
## 子shell
- 子shell是父shell的一个子进程
- 子shell本身也可以创建自己的子进程
### 内部命令,保留字和外部命令
- 内部命令是包含在shell工具包的命令
    
内部命令 | 说明
--- | ---
\. | 读取shell脚本,并在当前shell中执行脚本
alias | 设置命令别名
bg | 将作业置于后台运行
cd | 切换目录
echo | 打印指定的文本
eval | 将参数作为shell命令执行
exec | 以特定的程序取代shell或者改变当前shell的输出输入
exit | 退出shell
export | 将变量声明为环境变量
fc | 与命令历史一起运行
fg | 将作业置于前台运行
getopts | 处理命令行选项
history | 显示命令历史
jobs | 显示在后台运行的作业
kill | 向进程发送信号
logout | 从shell中注销
pwd | 显示当前工作目录
set | 设置shell环境变量
shift | 变换命令行参数
```
#! /bin/bash
ps -ef|grep ps
echo $SHLVL
pidof -x ex13-2.sh
exit 0
```
### 子shell中执行命令
- 圆括号结构,当一组命令放在圆括号中时,该组命令会在一个子shell中执行,基本语法如下
```
#使用分号
(cmd1;cmd2...)
#使用换行符
(
    cmd1
    cmd2
    ....
)
```
```
#!/bin/bash
echo
echo "Subshell level OUTSIDE subshell = $BASH_SUBSHELL"
echo
outer_variable=Outer
(
echo "Subshell level INSIDE subshell = $BASH_SUBSHELL"
inner_variable=Inner
echo "From subshell, \"inner_variable\" = $inner_variable"
echo "From subshell, \"outer\" = $outer_variable"
)
echo
echo "Subshell level OUTSIDE subshell = $BASH_SUBSHELL"
echo
if [ -z "$inner_variable" ]
then
  echo "inner_variable undefined in main body of shell"
else
  echo "inner_variable defined in main body of shell"
fi
echo "From main body of shell, \"inner_variable\" = $inner_variable"
echo
exit 0
```
- 后台运行或异步执行
    - command&
- 命令替换
    - `command`
    - $(command)
    - command会在一个子shell中执行,不会影响到当前的shell环境
    ```
    #! /bin/bash
    (cd /;ls;echo "current working directory is ";pwd)
    echo "current working directory is"
    pwd
    ```
### 子shell的变量值传回父shell
- 子shell可以访问父shell的变量
- 父shell中无法访问子shell的变量
- 通过临时文件访问
```
#! /bin/bash

(
   x=500
   echo "$x" >tmp
)

echo "$x"

read b <tmp

echo "$b"
```
- 使用命名管道符访问
```
#! /bin/bash
if [ ! -e fifo ];then
   mkfifo fifo
fi
(
   x=500
   echo "$x" > fifo
)&
read y <fifo
echo "$y"
```
- 不使用子shell
    - 使用source命令来执行脚本,被调用的脚本在当前shell进程中执行 
    ```
    #! /bin/bash

    message="Hello world."

    source ./output.sh
    ```
## 进程处理
### 什么是进程
- 进程是指在自身的虚拟地址空间运行的一个单独的程序,是程序执行的基本单元
- Web服务器监控脚本的编写
```
#! /bin/bash
RESTART="/sbin/service httpd restart"
PGREP="/usr/bin/pgrep"
HTTPD="httpd"
$PGREP ${HTTPD} &>/dev/null
if [ $? -ne 0 ]
then
   $RESTART
fi
```
### 作业控制
- 作业控制是控制正在运行的组成作业的进程的行为
### 信号与trap
- 信号是Linux系统中非常重要的一种通信机制
- 可以通过kill命令给某个进程发送一个特定的信号
```
kill [-s signal|-p] pid
trap [[arg] sigspec...]
```
- trap命令的使用方法
```
#! /bin/bash

function signal_handler {
   echo "Good bye."
}

trap signal_handler 0
```
---
# 14 shell脚本调试技术
- shell常见的语法错误和逻辑错误
- shell脚本调试技术: echo,trap,tee以及钩子程序调试
## 常见错误
- 关键字书写错误
- 引号错误
- 漏掉空格符
- 变量的大小写问题
## shell脚本调试技术
- 使用echo命令调试脚本
- 使用trap命令调试shell脚本
    - shell脚本执行的时候,会产生3个伪信号,分别为EXIT,ERR,DEBUG
        - EXIT信号在退出某个函数或某个脚本执行完成时触发
        - ERR信号在某条命令返回非0状态时触发
        - DEBUG信号在脚本的每一条命令执行之前触发
    ```
    #! /bin/bash
    ERRTRAP()
    {
       echo "[LINE:$1] Error:Command or function exited with status code $?"
    }
    func()
    {
       return 1
    }
    trap 'ERRTRAP $LINENO' ERR
    abc
    func
    ```
    - 通过捕获DEBUG信号来进行程序调试
    ```
    trap 'echo "before execute line:$LINENO,a=$a,b=$b,c=$c"' DEBUG
    a=1
    if [ "$a" -eq 1 ]
    then
       b=2
    else
       b=1
    fi
    c=3
    echo "end"
    ```
    - 使用tee命令调试shell脚本
        - 管道和重定向的脚本中,需要使用tee命令来调试
        - tee命令会从标准输入读取数据,将其内容输出到标准输出设备,同时又可以将内容保存成文件
        ```
        #! /bin/bash

        list=`ls -l | tee list.txt | awk '{print toupper($9)}'`
        echo "$list"
        ```
    - 使用调试钩子调试shell脚本
        - 设置调试开关变量,开关为true才输出调试信息
        ```
        if [ "$DEBUG" = true ]; then
            输出调试信息
        fi
        ```
        ```
        #! /bin/bash
        export DEBUG=true
        DEBUG()
        {
           if [ "$DEBUG" == "true" ];then
              $@
           fi
        }
        a=1
        DEBUG echo "a=$a"
        if [ "$a" -eq 1 ]
        then
             b=2
        else
             b=1
        fi
        DEBUG echo "b=$b"
        c=3
        DEBUG echo "c=$c"
        ```
# 15 实践


