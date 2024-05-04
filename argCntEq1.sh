#!/bin/bash

#【描述】  参数个数是否为1个
#【依赖】   
#【术语】 
#【备注】  

# 参数个数是否为1个
function argCntEq1() {

#本函数开头: 若启用调试 但 调用深度大于3 则临时关闭调试
alias__dis_bsDbg__ifStackDepthGt3

    # echo "\$*=[$*],\$#=[$#]"

    #若函数参数不为1个 ， 则返回错误（退出码为23）
    [ $# -eq 1 ] || return 23

#本函数次末尾(不要到真末尾，否则可能影响本函数返回代码): 若本函数开头 临时关闭了调试 则现在启用调试
alias__en__if_disable_bsDbg

    #否则 返回正常（退出码为0）
    return 0

}

# #用法举例:
#  若函数参数不为1个 ， 则返回错误
# _importBSFn "argCntEq1.sh"
# argCntEq1 $* || return $?