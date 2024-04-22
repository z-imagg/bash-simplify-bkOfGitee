#!/usr/bin/env bash

#若仓库"/app/bash-simplify/"不处在relese分支，则退出
source <(curl http://giteaz:3000/bal/bash-simplify/raw/branch/release/repo_branch_eq_release.sh)
repo_branch_eq_release || exit $?

#去此脚本所在目录
function cdCurScriptDir(){
#去此脚本所在目录
declare -r f=$(readlink -f ${BASH_SOURCE[0]})  ; declare -r d=$(dirname $f)
cd $d
}
