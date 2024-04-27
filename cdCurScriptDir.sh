#!/usr/bin/env bash

#去此脚本所在目录
function cdCurScriptDir(){
#'caller 0' == '直接调用者所在行号 直接调用者函数名 直接调用者函数所在源文件'
local callerInfo__lnNum_func_file=$(caller 0)
#转为数组
local str_arr=(${callerInfo__lnNum_func_file})
#直接调用者所在行号
local caller_lnNum=${str_arr[0]}
#直接调用者函数名
local caller_func=${str_arr[1]}
#直接调用者函数所在源文件
local caller_file=${str_arr[2]}

local dirPth=$(dirname $caller_file)
cd $dirPth
}


#运行举例

function __cdCurScriptDir__demo_1() {
mkdir -p /tmp/my/
cat  << 'EOF' > /tmp/my/f1.txt
source /app/bash-simplify/cdCurScriptDir.sh
cdCurScriptDir
EOF

bash -x /tmp/my/f1.txt
}

function __cdCurScriptDir__demo_2() {
mkdir -p /tmp/my/
cat  << 'EOF' > /tmp/my/f2.txt
source /app/bash-simplify/cdCurScriptDir.sh
function func01(){
cdCurScriptDir
}
func01
EOF

bash -x /tmp/my/f2.txt
}


#运行举例结果
# source /app/bash-simplify/cdCurScriptDir.sh ; __cdCurScriptDir__demo_1
# + source /app/bash-simplify/cdCurScriptDir.sh
# + cdCurScriptDir
# ++ caller 0
# + local 'callerInfo__lnNum_func_file=2 main /tmp/my/f1.txt'  # 'caller 0' == '直接调用者所在行号 直接调用者函数名 直接调用者函数所在源文件'
# + str_arr=('2' 'main' '/tmp/my/f1.txt')
# + local str_arr
# + local caller_lnNum=2
# + local caller_func=main
# + local caller_file=/tmp/my/f1.txt
# ++ dirname /tmp/my/f1.txt
# + local dirPth=/tmp/my
# + cd /tmp/my

# source /app/bash-simplify/cdCurScriptDir.sh ; __cdCurScriptDir__demo_2
# + source /app/bash-simplify/cdCurScriptDir.sh
# + func01
# + cdCurScriptDir
# ++ caller 0
# + local 'callerInfo__lnNum_func_file=3 func01 /tmp/my/f2.txt' # 'caller 0' == '直接调用者所在行号 直接调用者函数名 直接调用者函数所在源文件'
# + str_arr=('3' 'func01' '/tmp/my/f2.txt')
# + local str_arr
# + local caller_lnNum=3
# + local caller_func=func01
# + local caller_file=/tmp/my/f2.txt
# ++ dirname /tmp/my/f2.txt
# + local dirPth=/tmp/my
# + cd /tmp/my
