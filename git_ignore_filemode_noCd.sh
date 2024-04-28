#!/usr/bin/env bash

#【描述】  git忽略 文件可执行权限变更
#【依赖】   
#【术语】 
#【备注】  

source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEq1.sh)

# git忽略 文件可执行权限变更
function git_ignore_filemode_noCd() {
argCntEq1 $* || return $?

local repoDir=$1
local arg_gitDir="--git-dir=$repoDir/.git/ --work-tree=$repoDir"
(  git $arg_gitDir config --unset-all core.filemode  ; git $arg_gitDir config core.filemode false ; true ;)
}

# #用法举例:
# source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_ignore_filemode_noCd.sh)
#  git忽略 文件可执行权限变更
# git_ignore_filemode_noCd /app/qemu/