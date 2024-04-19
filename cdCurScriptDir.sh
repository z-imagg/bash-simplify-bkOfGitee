#!/usr/bin/env bash

#去此脚本所在目录
function cdCurScriptDir(){
#去此脚本所在目录
declare -r f=$(readlink -f ${BASH_SOURCE[0]})  ; declare -r d=$(dirname $f)
cd $d
}
