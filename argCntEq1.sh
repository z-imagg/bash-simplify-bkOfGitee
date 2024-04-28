#!/bin/bash

#【描述】  参数个数是否为1个
#【依赖】   
#【术语】 
#【备注】  

# 参数个数是否为1个
function argCntEq1() {
    # echo "\$*=[$*],\$#=[$#]"

    #若函数参数不为1个 ， 则返回错误（退出码为23）
    [ $# -eq 1 ] || return 23

    #否则 返回正常（退出码为0）
    return 0

}

# #用法举例:
#  若函数参数不为1个 ， 则返回错误
# source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEq1.sh)
# argCntEq1 $* || return $?