#!/usr/bin/env bash

#去此脚本所在目录
function cdCurScriptDir(){
#函数 cdCurScriptDir 处于 源文件cdCurScriptDir.sh中, 则 此函数中的 变量BASH_SOURCE[0]为常量cdCurScriptDir.sh
local f=$(readlink -f ${BASH_SOURCE[0]})  ; local d=$(dirname $f)
cd $d
}



function __cdCurScriptDir__demo() {
cat  << 'EOF' > /tmp/f1.txt
echo f1.txt, \${BASH_SOURCE[0]}=${BASH_SOURCE[0]} #同理, f1.txt中的BASH_SOURCE[0] 为常量f1.txt
source /app/bash-simplify/cdCurScriptDir.sh
cdCurScriptDir
EOF

bash -x /tmp/f1.txt
}

#错误的cdCurScriptDir实现，总是进入 目录 /app/bash-simplify/ ，原因是 BASH_SOURCE 表示当前源代码所属于的源文件 而不是调用当前源码的源文件

#运行举例
# source /app/bash-simplify/cdCurScriptDir.sh 
# __cdCurScriptDir__demo 
# + echo f1.txt, '${BASH_SOURCE[0]}=/tmp/f1.txt'
# f1.txt, ${BASH_SOURCE[0]}=/tmp/f1.txt
# + source /app/bash-simplify/cdCurScriptDir.sh
# + cdCurScriptDir
# ++ readlink -f /app/bash-simplify/cdCurScriptDir.sh
# + local f=/app/bash-simplify/cdCurScriptDir.sh
# ++ dirname /app/bash-simplify/cdCurScriptDir.sh
# + local d=/app/bash-simplify
# + cd /app/bash-simplify
