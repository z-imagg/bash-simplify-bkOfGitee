#!/usr/bin/env bash

#【描述】  git忽略 文件可执行权限变更
#【依赖】   
#【术语】 
#【备注】  

# git忽略 文件可执行权限变更
function git_ignore_filemode() {
     arg_gitDir="--git-dir=$(pwd)/.git"
    (  git $arg_gitDir config --unset-all core.filemode  ; git $arg_gitDir config core.filemode false ; true ;)
}

# #用法举例:
# source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_ignore_filemode.sh)
#  git忽略 文件可执行权限变更
#    注意 '圆括号( cd x; ... ;)' 表示在子shell进程中切换目录 ，并不会影响当前shell的工作目录
# ( cd /app/qemu/ && git_ignore_filemode ;)