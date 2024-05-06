#!/bin/bash

#【描述】  git 检查仓库目录 、 获取仓库目录 、 获取git目录参数
#【依赖】   
#【术语】 
#【备注】  

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

_importBSFn "argCntGe1.sh"

function git__chkDir__get__repoDir__arg_gitDir() {

# 若函数参数 小于1个 ， 则返回错误
argCntGe1 $* || return $?

repoDir=$1
local repoCfgF="$repoDir/.git/config"

#若不是合法git仓库，则退出（退出码为14）
[[ -f $repoCfgF ]] || return 14

arg_gitDir="--git-dir=$repoDir/.git/ --work-tree=$repoDir"


#返回变量为 repoDir 、 arg_gitDir
}


#用法举例: 
# _importBSFn "git__chkDir__get__repoDir__arg_gitDir.sh"
# git 检查仓库目录 、 获取仓库目录 、 获取git目录参数 , 返回变量为 repoDir 、 arg_gitDir
#  若 该目录不是git仓库， 则返回错误
# git__chkDir__get__repoDir__arg_gitDir $* || return $?
