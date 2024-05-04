#!/bin/bash

#【描述】  断言参数1为N，否则打印消息
#【依赖】   
#【术语】 
#【备注】  

# 断言参数1为N，否则打印消息
function arg1EqNMsg() {

alsDisDbgIfStackDepthGtN

    # echo "\$*=[$*],\$#=[$#]"

    #若本函数参数不为3个 ， 则返回错误（退出码为43）
    [ $# -eq 3 ] || return 43
    local arg1=$1
    local N=$2
    local msg=$3

    local regexInt='^[0-9]+$'
    #若参数1不为整数 ， 则返回错误（退出码为44）
    [[ $arg1 =~ $regexInt ]] || return 44
    #若参数2不为整数 ， 则返回错误（退出码为45）
    [[ $N =~ $regexInt ]] || return 45

    #若参数1为N ， 则返回正常（退出码为0）
    [ $arg1 -eq $N ] && return 0

alsEnIfDisDbg

    #否则返回错误（退出码为46）
    echo $msg && return 46


}

# #用法举例:
#  断言参数1为N，否则打印消息
# _importBSFn "arg1EqNMsg.sh"
# arg1EqNMsg $# 1 '"命令用法:x.sh arg1"' || return $?
#  #$*=[0 1 "命令用法:x.sh arg1"],$#=[3]
# 或
# arg1EqNMsg 2 2 '命令用法:y.sh name age' || return $?
#  #$*=[2 2 命令用法:y.sh name age],$#=[3]