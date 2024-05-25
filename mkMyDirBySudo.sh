#!/bin/bash

#【描述】  新建任意目录、主人设置为我自己
# 【用法举例】 
#  用法1 
#    source /app/bash-simplify/mkMyDirBySudo.sh && mkMyDirBySudo /my_dir
#  用法2
#   source /app/bash-simplify/_importBSFn.sh #or:#  source <(curl --location --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
#   _importBSFn "mkMyDirBySudo.sh" 
#   mkMyDirBySudo /my_dir
#【术语】 
#【备注】 


#在任意位置创建 属于当前用户的目录
#使用举例:  mkMyDirBySudo /app 
function mkMyDirBySudo(){
    #若函数参数少于1个，则退出（退出码为21）
    [ $# -lt 1 ] && return 21

    dire=$1
    mainGroup=$(id -gn) && \
    username=$(whoami) && \
    ( [[ -e $dire ]] || sudo mkdir $dire ;) && \
    sudo chown -R $mainGroup.$username $dire
    # cd $dire
}
