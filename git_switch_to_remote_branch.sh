#!/usr/bin/env bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  


source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_reset.sh)

# git切换到远程标签
#  核心命令举例 'git checkout -b linux-5.1.y --track origin/linux-5.1.y' 
#   git_switch_to_remote_branch  /bal/linux-stable linux-5.1.y == 将git仓库'/bal/linux-stable'切换到远程分支 linux-5.1.y ， 并在该提交上建立本地分支linux-5.1.y
function git_switch_to_remote_branch() {
    local ExitCode_ok=0

    #若函数参数不为2个，则退出（退出码为23）
    [ ! $# -eq 2 ] && return 23

    repoDir=$1
    branchNm=$2

    arg_gitDir="--git-dir=$repoDir/.git/ --work-tree=$repoDir"

    local OkMsg_Tracked="already track branch [$branchNm], exit $ExitCode_ok"

    #若不是合法git仓库，则退出（退出码为24）
    [[  -f $repoDir/.git/config ]] || return 24

    HeadHasTag=false; git $arg_gitDir tag --points-at HEAD --list "$tagName" | grep "$tagName" && HeadHasTag=true
    
    #获取当前提交跟踪的远程分支
    # origin/linux-5.1.y
    # 若去掉 选项 --symbolic-full-name, 则输出 refs/remotes/origin/linux-5.1.y
    trackRemoteBranch=$(git $arg_gitDir rev-parse --abbrev-ref --symbolic-full-name @{u})
    #若当前跟踪分支 就是 目标远程分支, 则不用处理 直接正常退出
    [[ "origin/$branchNm" ==  "$trackRemoteBranch" ]] && { echo $OkMsg_Tracked && return $ExitCode_ok ;}

    #若当前提交无该标签， 则 提示重置、重置、切换到该标签
    #  否则 即已经切换到该标签 无需再切换
    $HeadHasTag || ( git_reset $repoDir ; git $arg_gitDir checkout -b  "$branchNm"   --track "origin/$branchNm" ;)


}