#!/usr/bin/env bash

#与此类似  http://g:3000/bal/bash-simplify/_edit/release/cdCurScriptDir.sh

#去此脚本所在目录
function getCurScriptDirName(){
#去此脚本所在目录
declare -r CurScriptNm=$(readlink -f ${BASH_SOURCE[0]})  ; declare -r CurScriptDir=$(dirname $f)
# cd $CurScriptDir
}
