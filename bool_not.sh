#!/bin/bash

#【描述】  bool取反
#【依赖】   
#【术语】 
#【备注】   


source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)

_importBSFn "argCntEq2.sh"

#bool取反
function bool_not() {

#断言有两个参数
argCntEq2 $* || return $?

#输入bool值
local inBoolVar=$1
#返回 全局变量名
local outBoolVarName=$2

#取反，放入变量notBoolVar中
local notBoolVar=false; $inBoolVar || notBoolVar=true;

#利用eval将结果局部变量赋值给入参指定的全局变量
eval "$outBoolVarName=$notBoolVar"

}

#使用举例
#source /fridaAnlzAp/app_qemu/app_bld/util/bool_not.sh 
# x=true ; bool_not $x "not_x" ; echo $not_x
#   eval执行了 not_x=false
#   变量not_x为false
# y=false ; bool_not $y "not_y" ; echo $not_y
#   eval执行了 not_y=true
#   变量not_y为true

