#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  


source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_reset.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git__chkDir__get__repoDir__arg_gitDir.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEq2.sh)

# git切换到远程标签
#  核心命令举例 'git checkout -b linux-5.1.y --track origin/linux-5.1.y' 
#   git_switch_to_remote_branch  /bal/linux-stable linux-5.1.y == 将git仓库'/bal/linux-stable'切换到远程分支 linux-5.1.y ， 并在该提交上建立本地分支linux-5.1.y
function git_switch_to_remote_branch() {
    local localTmpBranch="tmp_branch_$(date +%s)"
    local ExitCode_NoRemoteBranch=31

    #  若函数参数不为2个 ， 则返回错误
    argCntEq2 $* || return $?

    #若 该目录不是git仓库， 则返回错误
    # git 检查仓库目录 、 获取仓库目录 、 获取git目录参数 , 返回变量为 repoDir 、 arg_gitDir
    git__chkDir__get__repoDir__arg_gitDir $* || return $?
    
    #本地分支名称
    local branch=$2
    local remoteBranch="refs/heads/$branch" # refs/heads为远程分支前缀
    # local remoteTag="refs/tags/$tagName"  # refs/tags为远程分支前缀
    local ErrMsg_NoRemoteBranch="无该远程分支 [$remoteBranch], exit $ExitCode_NoRemoteBranch"

    #是否有对应的远程分支
    hasRemoteBranch=false; git $arg_gitDir ls-remote | egrep "${remoteBranch}$" && hasRemoteBranch=true;

    #若无该远程分支，则返回错误
    ( ! $hasRemoteBranch ) && { echo $ErrMsg_NoRemoteBranch ; return $ExitCode_NoRemoteBranch ;}
    
    #否则，重置工作树、强制删除该本地分支、检出该本地分支并跟踪该远程分支
    # git reset 可能报错，忽略
    git_reset $repoDir
    # 检出本地临时分支，只是给当前HEAD新建临时分支，没有任何实质变化.  目的是 当$branch是当前分支时，能正常删除之
    git $arg_gitDir checkout -b "$localTmpBranch"
    # git 删除分支 可能报错，忽略
    git $arg_gitDir branch --delete --force "$branch"
    # 检出本地分支并跟踪远程分支
    git $arg_gitDir checkout -b  "$branch"   --track "origin/$branch"
    # 删除本地临时分支
    git $arg_gitDir branch --delete --force "$localTmpBranch"



}