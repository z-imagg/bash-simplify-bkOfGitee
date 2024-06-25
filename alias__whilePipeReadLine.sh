#!/bin/bash

#【描述】  用alias简化'while IFS read'，免去繁琐的记忆
#【依赖】   
#【术语】 
#【使用】
#请将以下source语句加入 ~/.bashrc 中, 再重新登陆终端, 以迫使alias生效
#   source /app/bash-simplify/alias__whilePipeReadLine.sh
#重新登陆终端后，可以使用本文中的alias了，  举例如下
#   ls / | whileIFSReadBegin_alias echo "第$k行为:$LineK"; whileIFSReadEnd_alias
#   ls ./*.gz | whileIFSReadBeginEcho_alias [[ -f $LineK ]] && echo "  是文件"; whileIFSReadEnd_alias



#bash允许alias展开
shopt -s expand_aliases

alias whileIFSReadBeginEcho_alias='{ k=0 &&  while IFS= read -r LineK; do true; k=$((k+1)); echo -n "[$k]=$LineK:";    '
alias whileIFSReadBegin_alias='{ k=0 &&   while IFS= read -r LineK; do true;  k=$((k+1));    '
alias whileIFSReadEnd_alias='  done  ;}'
