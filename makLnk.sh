#!/bin/bash

#【描述】  制作软链接 (旧写法)
# 【用法举例】 
#  用法1 
#    source /app/bash-simplify/makLnk.sh && makLnk  已有物件 软链接名称
#  用法2
#   source /app/bash-simplify/_importBSFn.sh #or:#  source <(curl --location --silent http://giteaz:3000/util/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
#   _importBSFn "makLnk.sh" 
#   makLnk  已有物件 软链接名称
#【术语】 
#【备注】 








#制作软链接
function makLnk(){

#若函数参数少于2个，则退出（退出码为14）
[ $# -lt 2 ] && return 14
lnkSrc=$1  &&  lnkDest=$2 && \
{ [ -e $lnkDest ] || \
ln -s $lnkSrc $lnkDest ;}

}