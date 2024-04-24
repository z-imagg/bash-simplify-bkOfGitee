#!/usr/bin/env bash

#若仓库"/app/bash-simplify/"不处在relese分支，则退出
source <(curl http://giteaz:3000/bal/bash-simplify/raw/branch/release/repo_branch_eq_release.sh)
repo_branch_eq_release || exit $?

#去此脚本所在目录
function cdCurScriptDir(){
local absFp="${BASH_SOURCE[0]}"

#错误代码定义
local err01_code=23
local err01_txt="x.sh  contains cdCurScriptDir, you should bash x.sh,  not source x.sh , exit $err01_code"

#x.sh  包含 cdCurScriptDir, 应该 bash x.sh,  而不是 source x.sh
[[ "$absFp" == /dev/fd/* ]] && { echo "$err01_txt" && exit $err01_code ;}

#去此脚本所在目录
declare -r f=$(readlink -f ${BASH_SOURCE[0]})  ; declare -r d=$(dirname $f)
cd $d
}
