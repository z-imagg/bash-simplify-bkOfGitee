#!/usr/bin/env bash

#若仓库"/app/bash-simplify/"不处在relese分支，则退出
source <(curl http://giteaz:3000/bal/bash-simplify/raw/branch/release/repo_branch_eq_release.sh)
repo_branch_eq_release || exit $?
Hm="/app/bash-simplify/"

source $Hm/mvFByAbsTm.sh

#全路径文件 重命名： 加 当前绝对时间后缀
#用法举例: mvFile_AppendCurAbsTime /bal/xxx.txt
#则 文件/bal/xxx.txt 被重命名为 比如 /bal/xxx.txt-20231210132251_1702185771_452355256
function mvFile_AppendCurAbsTime(){
mvFByAbsTm $*
}
