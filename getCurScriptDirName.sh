#!/usr/bin/env bash

#若仓库"/app/bash-simplify/"不处在relese分支，则退出
source <(curl http://giteaz:3000/bal/bash-simplify/raw/branch/release/repo_branch_eq_release.sh)
repo_branch_eq_release || exit $?



#以pwd和当前脚本路径名$0 结合 给出 当前脚本所在目录名、当前脚本名
#调用者应该在切换目录之前调用本函数, 即 尽可能早的调用本脚本.  
#   若 调用者 切换到其他目录后，调用本脚本 则结果肯定不对.
# 使用例子: getCurScriptDirName $0
# 使用例子: getCurScriptDirName /usr/include/utmp.h #则dire==/usr/include/,__fn==utmp.h
# 测试例子:  source /app/bash-simplify/getCurScriptDirName.sh ;   set -x; getCurScriptDirName /usr/include/utmp.h ; set +x
#返回: 当前脚本文件 绝对路径 fAbsPath, 当前脚本文件 名 __fn, 当前脚本文件 所在目录 绝对路径 __dire
function getCurScriptDirName(){

    #若函数参数少于1个，则退出（退出码为23）
    [ $# -lt 1 ] && return 23

    # echo $0,$1
    local fp=$1

    { { [[ $fp == /* ]] && fAbsPath=$fp ;} ||  fAbsPath=$(pwd)/$fp ;} && \

#当前脚本文件名, 此处 fAbsPath=build-linux-2.6.27.15-on-i386_ubuntu14.04.6LTS.sh
#fAbsPath为当前脚本的绝对路径
#若$0以/开头 (即 绝对路径) 返回$0, 否则 $0为 相对路径 返回  pwd/$0

    [ -f $fAbsPath ] && \
    __fn=$(basename $fAbsPath) && \
    __dire=$(dirname $fAbsPath)



}