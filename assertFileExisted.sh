#!/bin/bash

#【描述】  断言文件存在，否则打印消息
#【依赖】   
#【术语】 
#【备注】  

source /app/bash-simplify/argCntEq2.sh

# 断言文件存在，否则打印消息
function assertFileExisted() {
    # echo "\$*=[$*],\$#=[$#]"

    #若本函数参数不为2个 ， 则返回错误
    argCntEq2 $* || return $?

    local filePath=$1
    local errMsg="【断言失败，文件不存在】【$filePath】【$2】"

    #若文件存在，则正常退出。 否则打印错误消息并返回错误（退出码为51）
    { [[ -f $filePath ]] && return 0 ;} || { echo $errMsg && return 51 ;}

}

# #用法举例:
#  断言文件存在，否则打印消息
# source /app/bash-simplify/_importBSFn.sh
# _importBSFn "assertFileExisted.sh"  #或 source /app/bash-simplify/assertFileExisted.sh
# assertFileExisted /tmp/f1.txt '失败' || exit $?