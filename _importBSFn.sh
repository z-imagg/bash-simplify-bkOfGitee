#!/bin/bash

#【描述】  导入在标签tag_release上的给定脚本
#【依赖】   
#【术语】 _importBSFn == import bash-simplify file name , scriptFN==scriptFileName, als==alias,tmp_dis_bash_dbg==tmp_disable_bash_debug, dis==disable, en==enable, rtd=return_code
#【备注】  

#bash允许alias展开
shopt -s expand_aliases   

#本函数开头: 若启用调试 但 调用深度大于3 则临时关调试
alias alsDisDbgIfStackDepthGtN='local tmp_dis_bash_dbg=false; [[ $- == *x* && ${#BASH_SOURCE[@]} -gt 3 ]] && set +x  && tmp_disable_bash_dbg=true'

#本函数次尾(真末尾影响返回码): 若临时关了调试 则启用
alias alsEnIfDisDbg='$tmp_dis_bash_dbg && set -x'

#本函数次尾(真末尾影响返回码): 若临时关了调试 则启用、return给定返回码
alias alsEnIfDisDbg_return='{ { alsEnIfDisDbg ;} ; return $rtd ;}'

function _importBSFn() {
#本函数开头: 若启用调试 但 调用深度大于3 则临时关调试
alsDisDbgIfStackDepthGtN

local  tagName="tag_release"

#若函数参数不为1个 ， 则返回错误（退出码为23）
[ $# -eq 1 ] || { local rtd=23; alsEnIfDisDbg_return ;}

local scriptFN=$1

#若文件名不以'.sh'结尾, 则补上
[[ $scriptFN = *.sh ]] || scriptFN="$scriptFN.sh"

#TODO 检查仓库 /app/bash-simplify/.git是否处于标签$tagName

F="/app/bash-simplify/${scriptFN}"
#若文件不存在，则返回错误（退出码为51）
[[ ! -f $F ]] && { local rtd=51; alsEnIfDisDbg_return ;}

#本函数次尾(真末尾影响返回码): 若临时关了调试 则启用
alsEnIfDisDbg

source $F

# source /app/bash-simplify/${scriptFN}
#上一行带入实际值 后 举例如下:
# source /app/bash-simplify/git__chkDir__get__repoDir__arg_gitDir.sh
}

#使用举例
#1. 导入 _importBSFn.sh
# source <(curl --silent "http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh")
# 或
# source /app/bash-simplify/_importBSFn.sh
#2. _importBSFn 导入 目标脚本文件
# _importBSFn git__chkDir__get__repoDir__arg_gitDir
#  等同于
# _importBSFn git__chkDir__get__repoDir__arg_gitDir.sh

