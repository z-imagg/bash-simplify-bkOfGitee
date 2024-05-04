#!/bin/bash

#【描述】  参数个数是否为2个
#【依赖】   
#【术语】 
#【备注】  

# 参数个数是否为2个
function argCntEq2() {

alsDisDbgIfStackDepthGtN
    
    # echo "\$*=[$*],\$#=[$#]"

    #若函数参数不为2个 ， 则返回错误（退出码为23）
    [ $# -eq 2 ] || return 23

alsEnIfDisDbg

    #否则 返回正常（退出码为0）
    return 0

}

# #用法举例:
#  若函数参数不为2个 ， 则返回错误
# _importBSFn "argCntEq2.sh"
# argCntEq2 $* || return $?