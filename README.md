# -1 shell学习笔记
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
