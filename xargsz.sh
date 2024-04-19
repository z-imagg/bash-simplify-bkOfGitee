#!/usr/bin/env bash

declare -r ____xargsz_example_usage_txt='''【语法】xargsz 自定义bash函数名 \n【用法举例】 function busyFunc1() {  [[ "X$Ln" = 'Xbin' ]] || echo "notBinDir:$Ln" ;}  ; ls /usr/ | xargsz busyFunc1'''
echo -e $____xargsz_example_usage_txt

#xargsz(等效于xargs的自定义普通bash函数)
xargsz() {
# set -x
# 参数个数大于1
if [ ! "$#" -eq 1 ]; then
    echo "错误,函数xargsz的参数个数【$#】必须为1" 
    echo $____xargsz_example_usage_txt
    return 22
fi

# echo "参数列表作为一个字符串\$*=【$*】"
# echo "（参数列表作为字符串数组,使用请看变量arg_arr）; ${arg_arr[0]}=xxx; \$@=【$@】"
local argLsAsTxt="$*"

# 循环读取输入
while IFS= read -r line; do
    eval "Ln=$line $argLsAsTxt"
done
}

