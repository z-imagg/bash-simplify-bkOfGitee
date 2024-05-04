#!/bin/bash

#【描述】  xargs的等效品
#【依赖】   
#【术语】 _xgz == _xargsz
#【备注】   【有eval的函数内局部变量必须加标识该函数的后缀 】 所有变量名都加了后缀_xgz， 理由是为了防止 eval中的变量名 即调用者函数中的变量名 和本函数变量名重复 而发生意料之外的情况


declare -r ____xargsz_example_usage_txt__xgz='''【语法】xargsz 自定义bash函数名 \n【用法举例】 function busyFunc1() {  [[ "X$Ln" = 'Xbin' ]] || echo "notBinDir:$Ln" ;}  ; ls /usr/ | xargsz busyFunc1'''
echo -e $____xargsz_example_usage_txt__xgz

#xargsz(等效于xargs的自定义普通bash函数)
xargsz() {
# set -x
# 参数个数等于1
if [ ! "$#" -eq 1 ]; then
    local errCode_xgz=45
    local errTxt_xgz="错误,函数xargsz的参数个数【$#】必须为1,退出代码【$errCode】" 
    echo $____xargsz_example_usage_txt__xgz
    echo $errTxt_xgz
    return $errCode_xgz
fi

# echo "参数列表作为一个字符串\$*=【$*】"
# echo "（参数列表作为字符串数组,使用请看变量arg_arr）; ${arg_arr[0]}=xxx; \$@=【$@】"
local busyFuncName_xgz="$1"

# 循环读取输入
while IFS= read -r line_xgz; do
#eval内再包裹函数的目的是为了让变量Ln以local修饰，从而名字Ln只是一个局部名字，对外层名字没有影响。
    eval """
function __func__wrap() { local Ln=$line_xgz ; $busyFuncName_xgz ;} ;
__func__wrap ; 
unset __func__wrap; 
"""
done
}

