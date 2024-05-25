#!/bin/bash

#【描述】  获得直接调用本函数的函数所在脚本所在目录
# 【用法举例】 
#  用法1 
#    source /app/bash-simplify/cdCurScriptDir.sh && getCurScriptDirName
#  用法2
#   source /app/bash-simplify/_importBSFn.sh #or:#  source <(curl --location --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
#   _importBSFn "cdCurScriptDir.sh" 
#   getCurScriptDirName
#【术语】 
#【备注】 


#获得直接调用本函数的函数所在脚本所在目录
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

