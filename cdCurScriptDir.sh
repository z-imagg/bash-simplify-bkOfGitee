#!/bin/bash
alias parseDirectCaller='parseCallerN 0'
# 注意alias必须在'#!/usr/bin/bash'的直接下方, 否则alias不生效

#bash允许alias展开
shopt -s expand_aliases   

_importBSFn "parseCallerN.sh"


#去此脚本所在目录
function cdCurScriptDir(){

#获取 cdCurScriptDir的 直接调用者（爸爸）
#  返回变量 _lnNum 、 _func 、 _file
parseDirectCaller

local dirPth=$(dirname $_file)
cd $dirPth
}


#运行举例
##例子脚本:
# cat  << 'EOF' > /tmp/f4.sh
# #!/usr/bin/bash
# source /app/bash-simplify/_importBSFn.sh
# source /app/bash-simplify/cdCurScriptDir.sh   ;  
# cdCurScriptDir    # 本行执行时，其内部关键变量值记录 "str_arr=('4' 'main' '/tmp/f4.sh')  ;...; cd /tmp"
# function f4() { 
# set -x; 
# cdCurScriptDir ;  # 本行执行时，其内部关键变量值记录 "str_arr=('6' 'f4' '/tmp/f4.sh')  ;...; cd /tmp"
# set +x; 
# }
# f4
# EOF
##运行:
# bash -x /tmp/f4.sh
##运行结果: 进入目录/tmp/
