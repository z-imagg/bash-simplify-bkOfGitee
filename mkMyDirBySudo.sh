#!/bin/bash


#在任意位置创建 属于当前用户的目录
#使用举例:  mkMyDirBySudo /app 
function mkMyDirBySudo(){
    #若函数参数少于1个，则退出（退出码为21）
    [ $# -lt 1 ] && return 21

    dire=$1
    mainGroup=$(id -gn) && \
    username=$(whoami) && \
    sudo mkdir $dire && \
    sudo chown -R $mainGroup.$username $dire
    # cd $dire
}
