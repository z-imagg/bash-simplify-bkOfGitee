#!/bin/bash

#【描述】  字符串转bool: 一切非'false'的字符串都认为是true
#【依赖】   
#【术语】 str2bool_notF2T==str2bool_anyNotFalseStrAsTrue
#【备注】   


source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)

_importBSFn "argCntEq2.sh"

#字符串转bool: 一切非'false'的字符串都认为是true
function str2bool_notF2T() {

#断言有两个参数
argCntEq2 $* || return $?

#输入bool值
local inStrVar=$1
#返回 全局变量名
local outBoolVarName=$2

#一切非'false'的字符串都认为是true
local boolVar=true; [[ "X$inStrVar" == "Xfalse" ]] && boolVar=false

#利用eval将结果局部变量赋值给入参指定的全局变量
eval "$outBoolVarName=$boolVar"

}

#使用举例
#source /app/bash-simplify/str2bool_notF2T.sh 
# _x='true' ; str2bool_notF2T $_x "x" ; echo $x
#   变量x为true
# _z='aaa' ; str2bool_notF2T $_z "z" ; echo $z
#   变量z为true
# _u='false' ; str2bool_notF2T $_u "u" ; echo $u
#   变量u为false

