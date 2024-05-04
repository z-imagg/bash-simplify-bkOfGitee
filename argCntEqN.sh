#!/bin/bash

#【描述】  参数个数是否为N个
#【依赖】   
#【术语】 
#【备注】  

# 参数个数是否为N个
function argCntEqN() {

alsDisDbgIfStackDepthGtN

    # echo "\$*=[$*],\$#=[$#]"

    #从stdin读取参数N, 若1秒内没读取到, 则返回错误（退出码为22）
    local N
    read -t 1 N ; [[ "X$N" == "X" ]] && { local rtd=22; alsEnIfDisDbg_return ;}

    #若函数参数不为N个 ， 则返回错误（退出码为23）
    [ $# -eq $N ] || { local rtd=23; alsEnIfDisDbg_return ;}

    #否则 返回正常（退出码为0）
    { local rtd=0; alsEnIfDisDbg_return ;}

}

# #用法举例:
#  若参数个数不为N个 ，则返回错误
# _importBSFn "argCntEqN.sh"
#  若参数个数不为4个 ，则返回错误
# set -x;   echo 4 | argCntEqN  aa xx yy zz && echo ok ; set +x
#     打印ok
# 断言参数个数为3个
# echo 3 | argCntEqN $* || return $?