#!/bin/bash

#【描述】  参数个数是否为1个
#【依赖】   
#【术语】 
#【备注】  

# 参数个数是否为1个
function argCntEq1() {

#本函数开头: 若启用调试 但 调用深度大于3 则临时关调试
alsDisDbgIfStackDepthGtN

    # echo "\$*=[$*],\$#=[$#]"

    #若函数参数不为1个 ， 则返回错误（退出码为23）
    [ $# -eq 1 ] || return 23

#本函数次尾(真末尾影响返回码): 若临时关了调试 则启用
alsEnIfDisDbg

    #否则 返回正常（退出码为0）
    return 0

}

# #用法举例:
#  若函数参数不为1个 ， 则返回错误
# _importBSFn "argCntEq1.sh"
# argCntEq1 $* || return $?