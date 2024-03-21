#!/usr/bin/env bash

#【文件作用】 统揽整个项目的环境准备、命令准备工作
#【使用说明】 source me.sh

# 获取当前脚本完整路径的写法
#   若将以下这段脚本 写如文件f.sh , 
#       则 在调用者脚本中 书写 " source f.sh ( 或 bash f.sh  ) ; getCurScriptFullPath " 即可获得调用者脚本的完整路径
shopt -s expand_aliases
alias getCurScriptFullPath='f=$(readlink -f ${BASH_SOURCE[0]})  ; d=$(dirname $f) '

#取当前脚本完整路径
getCurScriptFullPath
#d==/fridaAnlzAp/cmd-wrap/script/

######脚本正文开始

export PATH=$PATH:/app/bash-simplify/bash-complete-gen-from-help/bin/
source /app/bash-simplify/bash-complete-gen-from-help/script/bash-complte--helpTxt2bashComplete.sh

bash /app/bash-simplify/bash-complete-gen-from-help/script/env_prepare.sh >/dev/null

# set +x
source //app/bash-simplify/bash-complete-gen-from-help/.venv/bin/activate
# set -x

