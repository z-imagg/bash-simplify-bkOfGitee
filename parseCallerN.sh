#!/bin/bash

source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEq1.sh)


#解析当前调用栈中第N个调用者
function parseCallerN(){
argCntEq1 $* || return $?

#{演示用
# caller 0
# caller 1
# #调用栈中的函数们
# local funcLsInCallStack="${FUNCNAME[@]}"
# #调用栈长度
# local callStackLen="${#FUNCNAME[@]}"
#}

N=$1

realN=$((N+1))

#'caller 0' == '直接调用者所在行号 直接调用者函数名 直接调用者函数所在源文件'
local lnNum_func_file=$(caller ${realN})
#如果'call realN'返回空串,说明realN超出了调用栈长度, 则返回错误（错误代码35）
[[ -z "$lnNum_func_file" ]] && return 35

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

#运行举例
# source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/parseCallerN.sh)
# 获取当前函数的直接调用者 即 获得 爸爸
# parseCallerN 1
# parseDirectCaller
# 获取当前函数的爷爷调用者 即 获得 爷爷
# parseCallerN 2

#在bash终端下，直接书写的函数f1, 不算一级
# function f1() { source /app/bash-simplify/parseCallerN.sh   ;  set -x; parseCallerN 0 ; set +x; } ; f1
# + caller 0 == 1 f1 main #parseCallerN的 直接调用者（爸爸）
# + caller 1   == 空
# + local 'funcLsInCallStack=parseCallerN f1' #parseCallerN的 调用栈中的函数们
# + local callStackLen=2  #parseCallerN的调用栈长度


#在脚本文件f1.sh中 直接数学的函数f1，才算一级
# echo 'function f1() { source /app/bash-simplify/parseCallerN.sh   ;  set -x; parseCallerN 0 ; set +x; } ; f1 '>/tmp/f1.sh ;  bash /tmp/f1.sh
# + caller 0 == 1 f1 /tmp/f1.sh   #parseCallerN的 直接调用者（爸爸）
# + caller 1 == 1 main /tmp/f1.sh #parseCallerN的 爷爷
# + local 'funcLsInCallStack=parseCallerN f1 main' #parseCallerN的 调用栈中的函数们
# + local callStackLen=3 #parseCallerN的调用栈长度


#别名parseDirectCaller举例
# cat  << 'EOF' > /tmp/f3.sh
# #!/usr/bin/bash
# alias parseDirectCaller='parseCallerN 0'
# # 注意alias必须在'#!/usr/bin/bash'的直接下方, 否则alias不生效
# shopt -s expand_aliases   #bash允许alias展开
# function f3() { 
#     source /app/bash-simplify/parseCallerN.sh   ;  
#     set -x; parseDirectCaller ; set +x; 
# }
# f3
# EOF
# bash /tmp/f3.sh

# + parseCallerN 0
# + caller 0 == 8 f3 /tmp/f3.sh    #parseCallerN的 直接调用者（爸爸）
# + caller 1 == 11 main /tmp/f3.sh #parseCallerN的 爷爷
# + local funcLsInCallStack=parseCallerN f3 main #parseCallerN的 调用栈中的函数们
# + local callStackLen=3    #f2的调用栈长度
