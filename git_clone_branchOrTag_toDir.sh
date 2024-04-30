#!/bin/bash

#【描述】  若该目录不存在,则git克隆仓库的给定分支或标签到给定目录
#【依赖】   
#【术语】 
#【备注】  


source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_reset.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git__chkDir__get__repoDir__arg_gitDir.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEqN.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_ignore_filemode_noCd.sh)


# 若该目录不存在,则git克隆仓库的给定分支或标签到给定目录
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

#若主机目录是合法git仓库，  
git__chkDir__get__repoDir__arg_gitDir "$hostRepoDir" && \
#则 切换到给定分支 
{ git_switch_to_remote_branch "$hostRepoDir" "$initBrch" && \
# 子模块更新
( cd $repoDir && git  submodule    update --recursive --init ;) && \
# 返回正常
return $ExitCode_Ok ;}



#克隆仓库
git clone -b $initBrch $repoUrl  $repoDir && \
#子模块更新
( cd $repoDir && git  submodule    update --recursive --init ;) && \
#git项目忽略文件权限变动
git_ignore_filemode_noCd $repoDir

}

# #用法举例:
#  git克隆仓库的给定分支或标签到给定目录
# source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_clone_branchOrTag_toDir.sh)
#  克隆 https://github.com/qemu/qemu.git 的标签 v5.0.0 到 本地目录 /tmp/qemu/ 
# git_clone_branchOrTag_toDir https://github.com/qemu/qemu.git v5.0.0 /tmp/qemu/ 