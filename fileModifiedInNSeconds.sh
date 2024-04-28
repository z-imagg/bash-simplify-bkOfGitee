#!/bin/bash



#给定文件的最后修改时刻是否在当前时刻的N秒内
function fileModifiedInNSeconds(){
# fileModifiedInNSeconds "/app_spy/clang-funcSpy/build/lib/libClnFuncSpy.so" "5*60"

#若函数参数少于2个，则退出（退出码为14）
[ $# -lt 2 ] && return 14
filePath=$1  &&  limitSecondsExpr=$2 && \
{ [ -e $filePath ] || return 31 ;} && \
limitSeconds=$(($limitSecondsExpr)) && \
nowSeconds=$(date +%s) && \
fileEndModifySeconds=$(stat -c %Y  $filePath ) && \
deltaSeconds=$(( $nowSeconds -  $fileEndModifySeconds  )) && \
{ [  $deltaSeconds  -le $limitSeconds ] || return 1 ;} && \
return 0

}