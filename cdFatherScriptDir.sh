#!/bin/bash

#【描述】  进入父函数所在脚本所在目录(依据是bash函数调用栈)
#【依赖】   
#【术语】 
#【备注】  


alias parseFatherCaller='parseCallerN 1 || return $?'
# 注意alias必须在'#!/usr/bin/bash'的直接下方, 否则alias不生效

#bash允许alias展开
shopt -s expand_aliases   

_importBSFn "parseCallerN.sh"


#去此函数的调用者函数所在目录
function cdFatherScriptDir(){

#获取 cdFatherScriptDir的 上上级调用者（爷爷）
#  返回变量 _lnNum 、 _func 、 _file
parseFatherCaller

local dirPth=$(dirname $_file)
cd $dirPth
}


#运行举例
##例子脚本:
# cat  << 'EOF' > /tmp/f1.sh
# #!/usr/bin/bash
# function f1() { 
#     source /app/bash-simplify/cdFatherScriptDir.sh   ;  
#     set -x; cdFatherScriptDir ; set +x; 
# }
# EOF

# cat  << 'EOF' > /home/z/f2.sh
# #!/usr/bin/bash
# function f2() { 
#     source /tmp/f1.sh   ;  
#     f1
# }
# f2
# EOF
##运行:
# bash /home/z/f2.sh
##运行结果:
# ++ caller 2
# + local lnNum_func_file='4 f2 /home/z/f2.sh' #正好表示当前函数f1的直接调用者函数f2所在源文件/tmp/f2.sh
# + _file=//home/z/f2.sh
# ++ dirname /home/z/f2.sh
# + local dirPth=/home/z
# + cd /home/z
