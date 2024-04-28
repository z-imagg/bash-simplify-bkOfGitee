#!/usr/bin/env bash

#【描述】  参数个数是否为N个
#【依赖】   
#【术语】 
#【备注】  

# 参数个数是否为N个
function argCntEqN() {
    echo "\$*=[$*],\$#=[$#]"

    #从stdin读取参数N, 若1秒内没读取到, 则返回错误（退出码为22）
    local N
    read -t 1 N ; [[ "X$N" == "X" ]] && return 22

    #若函数参数不为N个 ， 则返回错误（退出码为23）
    [ $# -eq $N ] || return 23

    #否则 返回正常（退出码为0）
    return 0

}

# #用法举例:
#  若参数个数不为N个 ，则返回错误
# source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEqN.sh)
#  若参数个数不为4个 ，则返回错误
# set -x;   echo 4 | argCntEqN  aa xx yy zz && echo ok ; set +x
#     打印ok