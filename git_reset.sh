#!/usr/bin/env bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  

source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEq1.sh)

# git仓库重置（丢弃工作区修改）
#  核心命令举例 'git clean --force -d ; git reset --hard ' 
#   git_reset  /bal/linux-stable  == 将git仓库'/bal/linux-stable' 重置
function git_reset() {
    #  若函数参数不为1个 ， 则返回错误
    argCntEq1 || return $?

    #返回变量为 repoDir 、 arg_gitDir
    git__chkDir__get__repoDir__arg_gitDir $* && return $?

    #若当前提交无该标签， 则 切换到该标签
    #  否则 即已经切换到该标签 无需再切换
    resetMsg="press_enter_to_reset_repo(drop_modify):"
    #  'read -p $msg' 被.Dockerfile运行时 msg不显示, 因此改为 'echo $msg && read' 
    echo -n "$resetMsg" && read  &&   ( git $arg_gitDir clean --force -d  ; git $arg_gitDir reset --hard   ;)


}