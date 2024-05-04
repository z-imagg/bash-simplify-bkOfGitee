#!/bin/bash

#【描述】  bool取反
#【依赖】   
#【术语】 _bn == _bool_not
#【备注】   【有eval的函数内局部变量必须加标识该函数的后缀 】 所有变量名都加了后缀_bn， 理由是为了防止 eval中的变量名 即调用者函数中的变量名 和本函数变量名重复 而发生意料之外的情况


source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)

_importBSFn "argCntEq2.sh"

#bool取反
function bool_not() {

#断言有两个参数
argCntEq2 $* || return $?

#输入bool值
local inBoolVar_bn=$1
#返回 全局变量名
local outBoolVarName_bn=$2

#取反，放入变量notBoolVar中
local notBoolVar_bn=false; $inBoolVar_bn || notBoolVar_bn=true;

#利用eval将结果局部变量赋值给入参指定的全局变量
eval "$outBoolVarName_bn=$notBoolVar_bn"

}

#使用举例
#source /app/bash-simplify/bool_not.sh 
# x=true ; bool_not $x "not_x" ; echo $not_x
#   eval执行了 not_x=false
#   变量not_x为false
# y=false ; bool_not $y "not_y" ; echo $not_y
#   eval执行了 not_y=true
#   变量not_y为true

