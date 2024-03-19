#!/usr/bin/env bash


#1.  source 例子

source <(echo 'alias zls="ls"')
#上一行 中 echo替换为cat，则得到如下行, 好处是 cat不用处理引号转义问题，而echo则必须处理引号转义问题

#写一段复杂脚本，且 不处理引号转义问题  ，将该脚本输出到临时文件，然后将临时文件交给source执行、或者交给bash执行
source <(cat << 'EOF'  
#复杂脚本内容开始
alias getCurScriptFullPath='var=xxx yyy.sh arg1 arg2'
vvv=$(qqq.sh ppp)
alias ttt='bbb.sh zzz > t.out'
#复杂脚本内容结束
EOF
)



###################


#2. alias例子

#必须有此行，否则 下面的my_alias会报 找不到该命令
shopt -s expand_aliases

alias my_alias=' ls -l'
my_alias

###################

#3. xx例子