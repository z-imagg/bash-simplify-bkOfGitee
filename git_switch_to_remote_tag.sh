#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  

source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_reset.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git__chkDir__get__repoDir__arg_gitDir.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEq2.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git__chkDir__get__repoDir__arg_gitDir.sh)

# git切换到远程标签
#  核心命令举例 'git checkout -b brch/v5.11 refs/tags/v5.11' 
#   git_switch_to_remote_tag  /app/linux v5.11 == 将git仓库/app/linux切换到远程标签v5.11 ， 并在该提交上建立本地分支brch/v5.11
function git_switch_to_remote_tag() {
    local ExitCode_NoRemoteTag=31

    # 若函数参数不为2个 ， 则返回错误
    argCntEq2 $* || return $?

    #若 该目录不是git仓库， 则返回错误
    # git 检查仓库目录 、 获取仓库目录 、 获取git目录参数 , 返回变量为 repoDir 、 arg_gitDir
    git__chkDir__get__repoDir__arg_gitDir $* || return $?
    
    #git仓库目录
    local tag=$2
    # local remoteBranch="refs/heads/$branch" # refs/heads为远程分支前缀
    local remoteTag="refs/tags/$tag"  # refs/tags为远程分支前缀
    local ErrMsg_NoRemoteTag="无该远程标签 [$remoteTag], exit $ExitCode_NoRemoteTag"
    #本地分支名称
    brchLocal="BrchAsTag/$tag"

    #是否有对应的远程标签
    hasRemoteBranch=false; git $arg_gitDir ls-remote | egrep "${remoteBranch}$" && hasRemoteBranch=true;

    #若无该远程分支，则返回错误
    ( ! $hasRemoteBranch ) && { echo $ErrMsg_NoRemoteTag ; return $ExitCode_NoRemoteTag ;}
    
    #否则，重置工作树、强制删除该本地分支、检出该本地分支并跟踪该远程标签
    # git reset 可能报错，忽略
    git_reset $repoDir
    # git 删除分支 可能报错，忽略
    git $arg_gitDir branch --delete --force "$brchLocal"
    # 检出本地分支并跟踪远程标签
    git $arg_gitDir checkout -b  "$brchLocal"    $tag


}