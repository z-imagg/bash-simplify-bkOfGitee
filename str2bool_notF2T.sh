#!/bin/bash

#【描述】  字符串转bool： 一切非‘false’的字符串都认为是true
#【依赖】   
#【术语】 str2bool_notF2T==str2bool_anyNotFalseStrAsTrue,  _s2b == _str2bool
#【备注】  【有eval的函数内局部变量必须加标识该函数的后缀 】 所有变量名都加了后缀_s2b， 理由是为了防止 eval中的变量名 即调用者函数中的变量名 和本函数变量名重复 而发生意料之外的情况


source <(curl --location --silent http://giteaz:3000/util/bash-simplify/raw/tag/tag_release/_importBSFn.sh)

_importBSFn "argCntEq2.sh"

#字符串转bool: 一切非'false'的字符串都认为是true
function str2bool_notF2T() {

#断言有两个参数
argCntEq2 $* || return $?

#输入bool值
local inStrVar_s2b=$1
#返回 全局变量名
local outBoolVarName_s2b=$2

#一切非'false'的字符串都认为是true
local boolVar_s2b=true; [[ "X$inStrVar_s2b" == "Xfalse" ]] && boolVar_s2b=false

#利用eval将结果局部变量赋值给入参指定的全局变量
eval "$outBoolVarName_s2b=$boolVar_s2b"

}

#使用举例
#source /app/bash-simplify/str2bool_notF2T.sh 
# _x='true' ; str2bool_notF2T $_x "x" ; echo $x
#   变量x为true
# _z='aaa' ; str2bool_notF2T $_z "z" ; echo $z
#   变量z为true
# _u='false' ; str2bool_notF2T $_u "u" ; echo $u
#   变量u为false

