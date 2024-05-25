#!/bin/bash

#【描述】  版本号比较
#【用法举例】   
#  用法1
#    source /app/bash-simplify/version_cmp.sh && version_cmp_gt 0.39.5  1.37.10   && echo "左版本号大于右版本号"
#  用法2
#   source <(curl --location --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
#   _importBSFn "version_cmp_gt.sh"
#   version_cmp_gt 0.39.5  0.37.10   && echo "左版本号不大于右版本号"
#【术语】 
#【备注】  

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

source <(curl --location --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)

_importBSFn "arg1EqNMsg.sh"


function version_cmp_gt() {
local ExitCode_Gt_Ok=0
local ExitCode_NotGt_Fail=1

# 若函数参数不为2个 ， 则返回错误
arg1EqNMsg $# 2 '命令语法" version_cmp_gt ver1 ver2" 命令举例" version_cmp_gt 0.39.5 0.39.10"' || return $?

#版本号1
local ver1=$1
#版本号2
local ver2=$2

local ver1_gt_ver2=false;   [[ $(echo -e "$ver1\n$ver2" | sort -V | head -n1) == "$ver2" ]] && ver1_gt_ver2=true

$ver1_gt_ver2 && return $ExitCode_Gt_Ok
$ver1_gt_ver2 || return $ExitCode_NotGt_Fail


}
