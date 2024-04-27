#!/usr/bin/env bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  

# git切换到远程标签
#  核心命令举例 'git checkout -b brch/v5.11 refs/tags/v5.11' 
#   git_switch_to_remote_tag  /app/linux v5.11 == 将git仓库/app/linux切换到远程标签v5.11 ， 并在该提交上建立本地分支brch/v5.11
function git_switch_to_remote_tag() {

    #若函数参数不为2个，则退出（退出码为23）
    [ ! $# -eq 2 ] && return 23

    repoDir=$1
    tagName=$2

    #若不是合法git仓库，则退出（退出码为24）
    [[ ! ( -f $repoDir/.git/config ) ]] && return 24

    HeadHasTag=false; git --git-dir=$repoDir/.git/ tag --points-at HEAD --list "$tagName" | grep "$tagName" && HeadHasTag=true
    
    #若当前提交无该标签， 则 切换到该标签
    #  否则 即已经切换到该标签 无需再切换
    $HeadHasTag || git checkout -b  "brch/$tagName"   "refs/tags/$tagName"


}