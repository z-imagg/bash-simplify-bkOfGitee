#!/bin/bash

#【描述】  用alias简化'while IFS read'，免去繁琐的记忆
#【依赖】   
#【术语】 
#【使用】
#请将以下source语句加入 ~/.bashrc 中, 再重新登陆终端, 以迫使alias生效
#   source /app/bash-simplify/alias__whilePipeReadLine.sh
#重新登陆终端后，可以使用本文中的alias了，  举例如下
#   ls / | whileIFSReadBegin_alias echo "此行内容为:$LineK"; whileIFSReadEnd_alias
#   ls ./*.gz | whileIFSReadBeginEcho_alias [[ -f $LineK ]] && echo "  是文件"; whileIFSReadEnd_alias


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

#bash允许alias展开
shopt -s expand_aliases

alias whileIFSReadBeginEcho_alias=' while IFS= read -r LineK; do true; echo -n "$LineK:";    '
alias whileIFSReadBegin_alias=' while IFS= read -r LineK; do true;     '
alias whileIFSReadEnd_alias='  done  '
