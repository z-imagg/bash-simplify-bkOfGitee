#!/bin/bash

#【描述】  git切换到远程标签
#【依赖】   
#【术语】 
#【备注】  

source /app/bash-simplify/_importBSFn.sh
_importBSFn "git_reset.sh"
_importBSFn "git__chkDir__get__repoDir__arg_gitDir.sh"
_importBSFn "argCntEq2.sh"

# git切换到远程标签
#  核心命令举例 'git checkout -b brch/v5.11 refs/tags/v5.11' 
function git_switch_to_remote_tag() {
    local localTmpBranch="tmp_branch_$(date +%s)"
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
    hasRemoteTag=false; git $arg_gitDir ls-remote | egrep "${remoteTag}$" && hasRemoteTag=true;

    #若无该远程分支，则返回错误
    ( ! $hasRemoteTag ) && { echo $ErrMsg_NoRemoteTag ; return $ExitCode_NoRemoteTag ;}
    
    #否则，重置工作树、强制删除该本地分支、检出该本地分支并跟踪该远程标签
    # git reset 可能报错，忽略
    git_reset $repoDir
    # 检出本地临时分支，只是给当前HEAD新建临时分支，没有任何实质变化. 目的是 当$brchLocal是当前分支时，能正常删除之
    git $arg_gitDir checkout -b "$localTmpBranch"
    # git 删除分支 可能报错，忽略
    git $arg_gitDir branch --delete --force "$brchLocal" || true 
    # 检出本地分支并跟踪远程标签
    git $arg_gitDir checkout -b  "$brchLocal"    $tag
#信任子仓库
( cd $repoDir && git submodule foreach --recursive  "bash -x  -c \"git config --global --add safe.directory $repoDir/\$path \" " ;)
#子仓库更新
( cd $repoDir && git  submodule    update --recursive --init ;)
    # 删除本地临时分支
    git $arg_gitDir branch --delete --force "$localTmpBranch"

    #显示当前所在提交
    git $arg_gitDir log --max-count=1
}

#用法举例
# source /app/bash-simplify/git_switch_to_remote_tag.sh
#  将git仓库/app/linux切换到远程标签v5.11 ， 并在该提交上建立本地分支brch/v5.11
#git_switch_to_remote_tag /app/linux v5.11
