#!/bin/bash

#【描述】  用alias简化'while IFS read'，免去繁琐的记忆
#【依赖】   
#【术语】 
#【使用】
#加载语句:  source /app/bash-simplify/alias__whilePipeReadLine.sh
#1. 日常使用 （请将'加载语句'加入 ~/.bashrc 中, 再重新登陆终端, 以迫使alias生效  , 重新登陆终端后 )
#2. 脚本调用 （任意x.sh中 引入 '加载语句' 后）
# 可以使用本文中的alias了，  举例如下
#   ls / | whileIFSReadEcho_alias
#   ls / | whileIFSReadBegin_alias echo "第$k行为:$LineK"; whileIFSReadEnd_alias
#   ls ./*.gz | whileIFSReadBeginEcho_alias [[ -f $LineK ]] && echo "  是文件"; whileIFSReadEnd_alias



#bash允许alias展开
shopt -s expand_aliases

alias whileIFSReadBeginEcho_alias='{ k=0 &&  while IFS= read -r LineK; do true; k=$((k+1)); echo -n "[$k]=$LineK:";    '
alias whileIFSReadBegin_alias='{ k=0 &&   while IFS= read -r LineK; do true;  k=$((k+1));    '
alias whileIFSReadEnd_alias='  done  ;}'

alias whileIFSReadEcho_alias='{ k=0 &&  while IFS= read -r LineK; do true; k=$((k+1)); echo  "[$k]=$LineK";    done  ;}'