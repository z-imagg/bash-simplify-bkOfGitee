#!/usr/bin/env bash

#此行必须有，否则alias x后，x不会被当成命令 （会说找不到x）
shopt -s expand_aliases

#source me.sh 或 bash me.sh 均能获取当前脚本完整路径的写法（且引入的变量都是必须要的），完全可以取代dir_util.sh 中相关函数 getCurScriptDirName、 getCurScriptDirByConcat 
alias getCurScriptFullPath='f=$(readlink -f ${BASH_SOURCE[0]})  ; d=$(dirname $f) '

#调用例子:
#source cur_script_full_path.sh
#getCurScriptFullPath
#echo $d,$f  #f为当前脚本完整路径， d为当前脚本所在目录的绝对路径

