#!/usr/bin/env bash
alias parseDirectCaller='parseCallerN 0'
# 注意alias必须在'#!/usr/bin/bash'的直接下方, 否则alias不生效

#bash允许alias展开
shopt -s expand_aliases   

source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/parseCallerN.sh)


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
# function f4() { 
#     source /app/bash-simplify/cdCurScriptDir.sh   ;  
#     set -x; cdCurScriptDir ; set +x; 
# }
# f4
# EOF
##运行:
# bash /tmp/f4.sh
##运行结果:
# ++ caller 1
# + local lnNum_func_file='4 f4 /tmp/f4.sh' #正好表示当前函数f4所在源文件/tmp/f4.sh
# + _file=/tmp/f4.sh
# ++ dirname /tmp/f4.sh
# + local dirPth=/tmp
# + cd /tmp #进入了当前脚本/tmp/f4.sh所在目录/tmp/
