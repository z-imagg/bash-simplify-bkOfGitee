#!/usr/bin/env bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  

# git仓库重置（丢弃工作区修改）
#  核心命令举例 'git clean --force -d ; git reset --hard ' 
#   git_reset  /bal/linux-stable  == 将git仓库'/bal/linux-stable' 重置
function git_reset() {
    local ExitCode_ok=0

    #若函数参数不为1个，则退出（退出码为23）
    [ ! $# -eq 1 ] && return 23

    repoDir=$1

    arg_gitDir="--git-dir=$repoDir/.git/ --work-tree=$repoDir"
    #若不是合法git仓库，则退出（退出码为24）
    [[ ! -f $repoDir/.git/config ]] && return 24

    #若当前提交无该标签， 则 切换到该标签
    #  否则 即已经切换到该标签 无需再切换
    resetMsg="press_enter_to_reset_repo(drop_modify):"
    #  'read -p $msg' 被.Dockerfile运行时 msg不显示, 因此改为 'echo $msg && read' 
    echo -n "$resetMsg" && read  &&   ( git $arg_gitDir clean --force -d  ; git $arg_gitDir reset --hard   ;)


}