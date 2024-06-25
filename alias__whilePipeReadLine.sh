#!/bin/bash

#【描述】  用alias简化'while IFS read'，免去繁琐的记忆
#【依赖】   
#【术语】 
#【使用】
#请将以下source语句加入 ~/.bashrc 中, 再重新登陆终端, 以迫使alias生效
#   source /app/bash-simplify/alias__whilePipeReadLine.sh
#重新登陆终端后，可以使用本文中的alias了，  举例如下
#   ls / | alias__whilePipeReadLineBegin echo "此行内容为:$LineK"; alias__whilePipeReadLineEnd
#   ls ./*.gz | alias__whilePipeReadLineBeginEcho [[ -f $LineK ]] && echo "$LineK 是文件"; alias__whilePipeReadLineEnd


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

#bash允许alias展开
shopt -s expand_aliases

alias alias__whilePipeReadLineBeginEcho=' while IFS= read -r LineK; do true; echo -n "$LineK:";    '
alias alias__whilePipeReadLineBegin=' while IFS= read -r LineK; do true;     '
alias alias__whilePipeReadLineEnd='  done  '
