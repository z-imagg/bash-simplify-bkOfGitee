#!/bin/bash

#【描述】  建议 在 脚本中但非函数内 以 ‘trap...EXIT’ 指定 脚本退出时 执行 本exit_handler（若非正常返回码 则打印调用栈、错误消息等） 
#【用法举例】   
#  用法1
#    bash /app/bash-simplify/bash_exit_handler.sh ; echo $?
#【术语】 
#【备注】  

# funcLsInCallStack="${FUNCNAME[@]}"
# callStackLen="${#FUNCNAME[@]}"


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

# 退出时执行
function bash_exit_handler() {
local exit_code=$?
local _okCode=0
#若正常返回码 ，则直接正常返回
[[ exit_code -eq $_okCode ]] && return $_okCode

local callStackDepth="${#FUNCNAME[@]}"

local _errCode=1

local err_line="$1"
local err_msg="$2"
echo "[bash_exit_handler__错误] $err_line:$err_msg ; 调用栈中函数名们:[${FUNCNAME[@]}]"

# echo "======"

for depthK in $(seq 0 $((callStackDepth-2)) ); do
# echo "depthK=$depthK"
  caller $depthK
done

#以下这段while效果和上面for一样
# while利用的是'caller 超出当前深度的大深度' 该caller返回代码是非正常 从而引发while循环正常结束
# echo "-----"
# local i=0
# while caller $i; do
#   i=$((i+1))
# done

# echo "EXIT_HANDER_END"


return $exit_code
}



trap 'bash_exit_handler ${LINENO} "$BASH_COMMAND"  ' EXIT


#以下用于举例
function f2() {
date 

_not_a_command #命令不存在 退出代码为127
# ls /no_file_1 #文件不存在 退出代码为2
}

function f1(){
f2
ping  -c 1 localhost
}

f1


#运行例子输出
# bash /app/bash-simplify/bash_exit_handler.sh ; echo $?
# 2024年 05月 25日 星期六 22:19:14 CST
# /app/bash-simplify/bash_exit_handler.sh: 行 62: _not_a_command: 未找到命令
# [bash_exit_handler__错误] 1:_not_a_command ; 调用栈中函数名们:[bash_exit_handler f2 f1 main]
# 1 f2 /app/bash-simplify/bash_exit_handler.sh
#    f2行号1有点怪， 下面给两个行号是对的
# 67 f1 /app/bash-simplify/bash_exit_handler.sh
# 71 main /app/bash-simplify/bash_exit_handler.sh
# 127

