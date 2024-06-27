#!/bin/bash

#【描述】  临时禁止bash调试
#【依赖】   
#【术语】 
#【使用】
#最常见用法， 临时禁止bash调试 以抑制 miniconda  的 activate 脚本 的大量输出
# source /app/bash-simplify/alias__bashTmpDisDbg.sh
# set -x
#miniconda 的 activate 脚本 有大量内容 若 bash 启用调试， 则 其占据大量输出，影响视觉
# bashTmpDisDbgBegin_alias ;  source /app/Miniconda3-py310_22.11.1-1/bin/activate ;   bashTmpDisDbgEnd_alias



#bash允许alias展开
shopt -s expand_aliases

alias bashTmpDisDbgBegin_alias='___do_bashTmpDisDbg=false; [[ $- == *x* ]] && { set +x ;  ___do_bashTmpDisDbg=true;}'
alias bashTmpDisDbgEnd_alias='$___do_bashTmpDisDbg && set -x'
