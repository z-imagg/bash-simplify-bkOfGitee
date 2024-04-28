#!/bin/bash

#去此脚本所在目录
function getCurScriptDirName(){
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

#返回变量 __fn 、 __dire
__fn=$caller_file
__dire=$dirPth

}


#运行举例
# source /app/bash-simplify/cdCurScriptDir.sh
# getCurScriptDirName
