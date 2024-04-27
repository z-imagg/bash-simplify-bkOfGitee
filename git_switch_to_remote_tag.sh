#!/usr/bin/env bash

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

    # 若函数参数不为2个 ， 则返回错误
    argCntEq2 $* || return $?

    #若 该目录不是git仓库， 则返回错误
    # git 检查仓库目录 、 获取仓库目录 、 获取git目录参数 , 返回变量为 repoDir 、 arg_gitDir
    git__chkDir__get__repoDir__arg_gitDir $* || return $?
    
    #git仓库目录
    tagName=$2
    #本地分支名称
    brchLocal="brch/$tagName"

    HeadHasTag=false; git $arg_gitDir tag --points-at HEAD --list "$tagName" | grep "$tagName" && HeadHasTag=true
    
    #若当前提交无该标签， 则 切换到该标签
    #  否则 即已经切换到该标签 无需再切换
    $HeadHasTag || ( git_reset $repoDir ; git $arg_gitDir branch --delete --force "$brchLocal" ; git $arg_gitDir checkout -b  "$brchLocal"   "refs/tags/$tagName" ;)


}