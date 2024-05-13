#!/bin/bash

#【描述】软链接目录c++项目内目录CppPrj_IncDir为给定软链接target_inc_dir
#【依赖】
#【术语】
#【备注】 
#【举例】 "/fridaAnlzAp/clang-varBE/include/nlohmann" --> "/app/nlohmann--json/include/nlohmann/"

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

source /app/bash-simplify/_importBSFn.sh
_importBSFn "cdCurScriptDir.sh"
_importBSFn "git_Clone_SwitchTag.sh"
_importBSFn "arg1EqNMsg.sh"



function link_CppPrj_includeDir_to() {

#到当前目录
# cdCurScriptDir


    local exitCode_OK=0
    local errCode1=81

    arg1EqNMsg $# 5 '断言失败，需要4个参数, 用法[me.sh CppPrjGitRepoUrl GitTagName GitRepoLocalDir CppPrj_IncDir  target_inc_dir]' || return $?
    # set -x
    
    local REPO_URL=$1
    local tagName=$2
    local REPO_HOME=$3
# local REPO_HOME="/app/nlohmann--json"
    local _from_IncDir_relative=$4
    local CppPrj_IncDir="$REPO_HOME/$_from_IncDir_relative"
# local CppPrj_IncDir="$REPO_HOME/include/nlohmann/"
    local target_inc_dir=$5
    local errMsg1="期望为正确的软链接【$target_inc_dir --> $CppPrj_IncDir】，但此时是错误的软链接. 退出错误代码[$errCode1]"
    local linkTxt="$([[ -e $target_inc_dir ]] && ls -lh $target_inc_dir)"
    local okMsg2_newLink="【新建软链接指向】"
    local okMsg3_already="【已存在、且指向相同】"

#克隆本仓库
# git_Clone_SwitchTag http://giteaz:3000/util/nlohmann--json.git  tag__v3.11.3_fix  $REPO_HOME
git_Clone_SwitchTag $REPO_URL $tagName $REPO_HOME

    #是否已存在的目标软链接
    local hasTargetIncDir=false; [[ -s $target_inc_dir ]] && hasTargetIncDir=true
    #是否已存在的目标软链接是指向期望目录
    local Equal=false; [[ "X$(readlink -f $target_inc_dir)" == "X$(readlink -f $CppPrj_IncDir)" ]] && Equal=true

    #若无目标软链接, 则正常创造软链接，并正常返回
    ! $hasTargetIncDir && { ln -s  "$CppPrj_IncDir" $target_inc_dir ;echo $okMsg2_newLink; ls -lh $target_inc_dir; return $exitCode_OK ;}

    #已存在、且指向不同，则打印错误消息并返回错误
    $hasTargetIncDir && ! $Equal && { echo $errMsg1 ; ls -lh $target_inc_dir; return $errCode1 ;}
    
    #已存在、且指向相同，则打印正常并正常返回
    $hasTargetIncDir && $Equal && echo $okMsg3_already && ls -lh $target_inc_dir && return $exitCode_OK  

}

#不再直接执行
# link_CppPrj_includeDir_to $*  || exit $?

#用法举例
# source /app/bash-simplify/link_CppPrj_includeDir_to.sh
# link_CppPrj_includeDir_to http://giteaz:3000/util/nlohmann--json.git   tag__v3.11.3_fix   "/app/nlohmann--json"   include/nlohmann/   "/fridaAnlzAp/clang-varBE/include/nlohmann"
#   达到效果:
##   "/fridaAnlzAp/clang-varBE/include/nlohmann" --> "/app/nlohmann--json/include/nlohmann/"