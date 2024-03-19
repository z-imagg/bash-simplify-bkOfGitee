#!/usr/bin/env bash

#source me.sh 或 bash me.sh 均能获取当前脚本完整路径的写法（且引入的变量都是必须要的），完全可以取代dir_util.sh 中相关函数 getCurScriptDirName、 getCurScriptDirByConcat 

alias getCurScriptFullPath='f=$(readlink -f ${BASH_SOURCE[0]})  ; d=$(dirname $f) '

#调用例子:
#source cur_script_full_path.sh
#getCurScriptFullPath
#echo $d,$f  #f为当前脚本完整路径， d为当前脚本所在目录的绝对路径



#如果你想直接在你的脚本中写出来，并理解使用，而不是引用此文件，则可以如下这样写
# # source <(echo 'alias zls="ls"')
# #上一行 中 echo替换为cat，则得到如下行, 好处是 cat不用处理引号转义问题，而echo则必须处理引号转义问题
# source <(cat << 'EOF'  
# alias getCurScriptFullPath='f=$(readlink -f ${BASH_SOURCE[0]})  ; d=$(dirname $f) '
# EOF
# )
# getCurScriptFullPath