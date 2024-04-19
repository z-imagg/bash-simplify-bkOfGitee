#!/usr/bin/env bash










function makLnk(){

#若函数参数少于2个，则退出（退出码为14）
[ $# -lt 2 ] && return 14
lnkSrc=$1  &&  lnkDest=$2 && \
{ [ -e $lnkDest ] || \
ln -s $lnkSrc $lnkDest ;}

}