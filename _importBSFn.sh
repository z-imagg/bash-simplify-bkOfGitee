#!/bin/bash

#【描述】  导入在标签tag_release上的给定脚本
#【依赖】   
#【术语】 _importBSFn == import bash-simplify file name , scriptFN==scriptFileName, 
#       OKRtCod==Ok Return Code==正常返回代码, ErrRtCod==Error Return Code==错误返回代码
#       ErrRtMsg==Error Return Message==错误返回代码对应的错误消息
#【备注】  

#断言 本地仓库/app/bash-simplify在标签tag_release上 且 远程该标签与本地该标签相同 
function __assert__gitRepo__bash_simplify__in__tag_release() {

local arg_gitDir="--git-dir=$repoDir/.git/ --work-tree=$repoDir"
#正常退出代码
local OKRtCod=0
local ErrRtCod__no_remote__tag_release=13
local ErrRtMsg__no_remote__tag_release="错误消息,无远端标签tag_release,错误退出代码$ErrRtCod__no_remote__tag_release,[$repoDir]"
local ErrRtCod__local_HEAD_not_in__tag_release=14
local ErrRtMsg__local_HEAD_not_in__tag_release="错误消息,本地HEAD无本地标签tag_release,错误退出代码$ErrRtCod__local_HEAD_not_in__tag_release,[$repoDir]"
local ErrRtCod__remote__tag_release__hash__notEqual_local=15
local ErrRtMsg__remote__tag_release__hash__notEqual_local="错误消息,本地标签tag_release的提交hash和远端该标签的提交hash不同,本地代码太旧了？错误退出代码$ErrRtCod__remote__tag_release__hash__notEqual_local,[$repoDir]"

#远端标签tag_release的提交id
#  【cut指定分割符号为tab办法】 -d$'\t' 或者  从复制一个真实的tab符号-d'	'
local remote__tag_release__hash=$(git $arg_gitDir ls-remote  --tags 2>/dev/null | egrep "tag_release$" | cut -d'	' -f 1 )
#若 无远端标签tag_release ，则打印错误消息 并返回错误
[[ "X$remote__tag_release__hash" == "X" ]] && { echo $ErrRtMsg__no_remote__tag_release ; return  $ErrRtCod__no_remote__tag_release ;}

#本地头上的标签tag_release
local localTag=$(git $arg_gitDir  tag   --points-at HEAD  --list "tag_release")
#若 本地HEAD无本地标签tag_release ，则打印错误消息 并返回错误
[[ "X$localTag" == "X" ]] && { echo $ErrRtMsg__local_HEAD_not_in__tag_release ; return $ErrRtCod__local_HEAD_not_in__tag_release ;}

#远端标签tag_release的提交id
local local__tag_release__hash=$(git $arg_gitDir rev-list -n 1 tag_release)
#若 本地标签tag_release的提交hash和远端该标签的提交hash不同 ，则打印错误消息 并返回错误
[[ "X$local__tag_release__hash" != "X$remote__tag_release__hash" ]] && { echo $ErrRtMsg__remote__tag_release__hash__notEqual_local ; return $ErrRtCod__remote__tag_release__hash__notEqual_local ;} 

#以上检查都通过，则返回正常
return $OKRtCod

}
function _importBSFn() {

local repoDir="/app/bash-simplify"
local arg_gitDir="--git-dir=$repoDir/.git/ --work-tree=$repoDir"

#正常退出代码
local OKRtCod=0

#断言 本地仓库/app/bash-simplify在标签tag_release上 且 远程该标签与本地该标签相同 
__assert__gitRepo__bash_simplify__in__tag_release || return $?

#/app/bash-simplify/.git/ 所处的标签名称
local  tagName="tag_release"

#若函数参数不为1个 ， 则返回错误（退出码为23）
[ $# -eq 1 ] || return 23

local scriptFN=$1
#删除'x.sh'末尾的'.sh'
local funcName=${scriptFN%.sh}

#若该函数已导入，则不再重复导入 
#  优点： 不会大量导入同一个函数; 
#  缺点:  若存在同名函数，只会导入第一个函数。因此要求 /app/bash-simplify/*.sh 全局不能存在同名函数。 
type $funcName 1>/dev/null 2>/dev/null && return $OKRtCod

#若文件名不以'.sh'结尾, 则补上
[[ $scriptFN == *.sh ]] || scriptFN="$scriptFN.sh"

#TODO 检查仓库 /app/bash-simplify/.git是否处于标签$tagName

F="/app/bash-simplify/${scriptFN}"
local ErrMsg_F_NotExisted="_importBSFn 意欲导入的bash脚本文件不存在 F='$F'"
#若文件不存在，则返回错误
[[ ! -f $F ]] && { echo $ErrMsg_F_NotExisted ; return 51 ;}

source $F

# source /app/bash-simplify/${scriptFN}
#上一行带入实际值 后 举例如下:
# source /app/bash-simplify/git__chkDir__get__repoDir__arg_gitDir.sh
}

#使用举例
#1. 导入 _importBSFn.sh
# source <(curl --location --silent "http://giteaz:3000/util/bash-simplify/raw/tag/tag_release/_importBSFn.sh")
# 或
# source /app/bash-simplify/_importBSFn.sh
#2. _importBSFn 导入 目标脚本文件
# _importBSFn git__chkDir__get__repoDir__arg_gitDir
#  等同于
# _importBSFn git__chkDir__get__repoDir__arg_gitDir.sh

