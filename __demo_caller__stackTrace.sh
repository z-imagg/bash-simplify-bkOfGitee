#!/bin/bash

#【描述】 caller 演示 (演示 bash函数调用栈)
# 【用法举例】 
#  用法1 
#    source /app/bash-simplify/__demo_caller__stackTrace.sh && __demo
#  用法2
#   source /app/bash-simplify/_importBSFn.sh #or:#  source <(curl --location --silent http://giteaz:3000/util/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
#   _importBSFn "__demo_caller__stackTrace.sh" 
#   __demo
#【术语】 
#【备注】 

# caller 演示

#运行举例

function __demo() {
mkdir -p /tmp/my/
cat  << 'EOF' > /tmp/my/f2.txt
source /app/bash-simplify/cdCurScriptDir.sh
function f2(){
funcLsInCallStack="${FUNCNAME[@]}"
callStackLen="${#FUNCNAME[@]}"
caller 0
caller 1
caller 2
}
EOF

cat  << 'EOF' > /tmp/my/f1.txt
source /tmp/my/f2.txt
function f1(){
f2
}
f1
EOF

bash -x /tmp/my/f1.txt
}

# source '/app/bash-simplify/__demo_caller__stackTrace.sh' ; __demo
# + source /tmp/my/f2.txt
# ++ source /app/bash-simplify/cdCurScriptDir.sh
# + f1
# + f2
# + funcLsInCallStack='f2 f1 main'  #f2的 调用栈中的函数们
# + callStackLen=3 #f2的调用栈长度
# + caller 0 == 3 f1 /tmp/my/f1.txt #f2的 直接调用者（爸爸）
# + caller 1 == 5 main /tmp/my/f1.txt #f2的 爷爷
# + caller 2 == 空                    #f2的 爷爷的爸爸
