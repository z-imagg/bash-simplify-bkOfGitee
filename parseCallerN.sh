#!/usr/bin/env bash

source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEq1.sh)


#解析当前调用栈中第N个调用者
function parseCallerN(){
argCntEq1 $* || return $?

#{演示用
caller 0
caller 1
#调用栈中的函数们
local funcLsInCallStack="${FUNCNAME[@]}"
#调用栈长度
local callStackLen="${#FUNCNAME[@]}"
#}

N=$1

realN=$((N+1))

#'caller 0' == '直接调用者所在行号 直接调用者函数名 直接调用者函数所在源文件'
local lnNum_func_file=$(caller ${realN})
#转为数组
local str_arr=(${lnNum_func_file})
#直接调用者所在行号
local lnNum=${str_arr[0]}
#直接调用者函数名
local func=${str_arr[1]}
#直接调用者函数所在源文件
local file=${str_arr[2]}

#返回变量 _lnNum 、 _func 、 _file
_lnNum=$lnNum
_func=$func
_file=$file
}

#bash允许alias展开
shopt -s expand_aliases

alias parseDirectCaller='parseCallerN 0'

#运行举例
# source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/parseCallerN.sh)
# 获取当前函数的直接调用者
# parseCallerN 1
# 获取当前函数的爷爷调用者
# parseCallerN 2

#在bash终端下，直接书写的函数f1, 不算一级
# function f1() { source /app/bash-simplify/parseCallerN.sh   ;  set -x; parseCallerN 0 ; set +x; } ; f1
# + caller 0 == 1 f1 main #parseCallerN的 直接调用者（爸爸）
# + caller 1   == 空
# + local 'funcLsInCallStack=parseCallerN f1' #调用栈中的函数们
# + local callStackLen=2


#在脚本文件f1.sh中 直接数学的函数f1，才算一级
# echo 'function f1() { source /app/bash-simplify/parseCallerN.sh   ;  set -x; parseCallerN 0 ; set +x; } ; f1 '>/tmp/f1.sh ;  bash /tmp/f1.sh
# + caller 0 == 1 f1 /tmp/f1.sh   #parseCallerN的 直接调用者（爸爸）
# + caller 1 == 1 main /tmp/f1.sh #parseCallerN的 爷爷
# + local 'funcLsInCallStack=parseCallerN f1 main' #parseCallerN的 调用栈中的函数们
# + local callStackLen=3 #f2的调用栈长度

