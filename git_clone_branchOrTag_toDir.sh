#!/usr/bin/env bash

#【描述】  git克隆仓库的给定分支或标签到给定目录
#【依赖】   
#【术语】 
#【备注】  


source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_reset.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git__chkDir__get__repoDir__arg_gitDir.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEqN.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_ignore_filemode.sh)


# git克隆仓库的给定分支或标签到给定目录
function git_clone_branchOrTag_toDir() {
    local ExitCode_Ok=0

    #  若参数个数不为3个 ，则返回错误
    echo 3 | argCntEqN $* || return $?

    #git仓库Url
    local repoUrl=$1
    #初始分支名称
    local initBrch=$2
    #git仓库存放目录
    local repoDir=$3
    local repoCfgF="$repoDir/.git/config"

    #若已经是一个git仓库，则返回正常（退出码为0）
    [[ -f $repoCfgF ]] && return $ExitCode_Ok

    #否则 即目录存在 但不是一个git仓库，则返回错误（退出码为34）
    [[ -e $repoDir ]] && return 34

git clone -b $initBrch $repoUrl  $repoDir && \
#git项目忽略文件权限变动
( cd $repoDir ; git_ignore_filemode ;)

}

# #用法举例:
#  git克隆仓库的给定分支或标签到给定目录
# source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_clone_branchOrTag_toDir.sh)
#  克隆 https://github.com/qemu/qemu.git 的标签 v5.0.0 到 本地目录 /tmp/qemu/ 
# git_clone_branchOrTag_toDir https://github.com/qemu/qemu.git v5.0.0 /tmp/qemu/ 