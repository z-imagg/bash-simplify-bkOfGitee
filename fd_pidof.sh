#!/bin/bash

#【描述】  查看给定应用的进程们的/proc/<pid>/fd/
#【依赖】   
#【术语】 
#【使用举例】
# source /app/bash-simplify/fd_pidof.sh ;   fd_pidof gitkraken

source /app/bash-simplify/argCntEq1.sh

# 查看给定应用的进程们的/proc/<pid>/fd/
function fd_pidof() {
    local appName=$1

    # 若函数参数不为1个 ， 则返回错误
    argCntEq1 $* || return $?

    #pidof后的tr将空格替换为换行 以方便后面while循环
    pidof $appName|   tr ' ' '\n' | \
    while IFS=  read -r pidK; do \
    echo "appName[$appName],appFullPath[$(readlink -f /proc/$pidK/exe)],proc_fd[/proc/$pidK/fd/]"; \
    ls -lh    /proc/$pidK/fd;  \
    done
}

