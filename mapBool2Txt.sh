#!/bin/bash

#【描述】  bool变量映射为自定义文本
#【依赖】   
#【术语】 _mb2t == mapBool2Txt, tmp_dis_bash_dbg==tmp_disable_bash_debug
#【备注】   【有eval的函数内局部变量必须加标识该函数的后缀 】 所有变量名都加了后缀_mb2t， 理由是为了防止 eval中的变量名 即调用者函数中的变量名 和本函数变量名重复 而发生意料之外的情况


source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)

_importBSFn "argCntEqN.sh"
_importBSFn "str2bool_notF2T.sh"

#bool变量映射为自定义文本
function mapBool2Txt() {

#本函数开头: 若启用调试 但 调用深度大于3 则临时关闭调试
alias__dis_bsDbg__ifStackDepthGt3

#  若参数个数不为4个 ，则返回错误
echo 4 | argCntEqN $* || return $?

#输入bool值
local _boolVar_mb2t=$1
local trueTxt_mb2t=$2
local falseTxt_mb2t=$3
local outTxtVarName_mb2t=$4

local boolVar_mb2t=""
#字符串转为bool变量
# echo "=====:\$-=$-"
str2bool_notF2T $_boolVar_mb2t "boolVar_mb2t"
# echo "====="
# echo "$boolVar_mb2t"

local outTxt_mb2t
$boolVar_mb2t && outTxt_mb2t=$trueTxt_mb2t
$boolVar_mb2t || outTxt_mb2t=$falseTxt_mb2t

#本函数次末尾(不要到真末尾，否则可能影响本函数返回代码): 若本函数开头 临时关闭了调试 则现在启用调试
alias__en__if_disable_bsDbg

#利用eval将结果局部变量赋值给入参指定的全局变量
eval "$outTxtVarName_mb2t=$outTxt_mb2t"

}

#使用举例
#source /app/bash-simplify/mapBool2Txt.sh 
# fail=true ; mapBool2Txt $fail "ok" "false" "fail_txt" ; echo $fail_txt
#   变量fail_txt为"ok"
# done='true' ; mapBool2Txt $done "hello" "bad" "done_txt" ; echo $done_txt
#   变量done_txt为"hello"
# isTarget=false ; mapBool2Txt $isTarget "是" "否" "text" ; echo $text
#   变量u为"否"

