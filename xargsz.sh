#!/usr/bin/env bash

declare -r ____xargsz_example_usage_txt='''Usage example: function busyFunc1() {  [[ "X$Ln" = 'Xbin' ]] || echo "notBinDir:$Ln" ;}  ; ls /usr/ | xargsz busyFunc1'''
echo $____xargsz_example_usage_txt

#xargsz(等效于xargs的自定义普通bash函数)
xargsz() {
# set -x
# 参数个数大于1
if [ "$#" -lt 1 ]; then
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

# 示例用法：
# ls /usr | custom_xargs { [[ 'LINE=%' = 'X' ]] || echo bad }
# 报错，  '{ [[ 'LINE=%' = 'X' ]] || echo bad }' 无法作为 参数 传递给 custom_xargs ，  
#传递 给 custom_xargs 的参数 实际是  { [[ LINE=sbin = X ]]
# 可见， bash语法中    自定义名字 custom_xargs 无法 粘结 || 、 {  、 } 等 顶层语法元素
#解决办法，将业务命令写成一个函数即可：
# busyFunc1() {  [[ "X$Ln" = 'Xbin' ]] && echo "hasBinDir:$Ln" ;}
# ls /usr | custom_xargs busyFunc1
