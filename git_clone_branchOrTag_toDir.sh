#!/usr/bin/env bash

#【描述】  git克隆仓库的给定分支或标签到给定目录
#【依赖】   
#【术语】 
#【备注】  


source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_reset.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git__chkDir__get__repoDir__arg_gitDir.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEqN.sh)

# git克隆仓库的给定分支或标签到给定目录
function git_clone_branchOrTag_toDir() {

    #  若参数个数不为3个 ，则返回错误
    echo 3 | argCntEqN $* || return $?

    #git仓库Url
    repoUrl=$1
    #初始分支名称
    initBrch=$2
    #git仓库存放目录
    repoDir=$3

    #若git仓库存放目录存在，则返回错误（退出码为34）
    [[ -e $repoDir ]] || return 34

    git clone -b $initBrch $repoUrl  $repoDir

}

# #用法举例:
#  git克隆仓库的给定分支或标签到给定目录
# source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_clone_branchOrTag_toDir.sh)
#  克隆 https://github.com/qemu/qemu.git 的标签 v5.0.0 到 本地目录 /tmp/qemu/ 
# git_clone_branchOrTag_toDir https://github.com/qemu/qemu.git v5.0.0 /tmp/qemu/ 