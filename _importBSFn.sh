#!/bin/bash

#【描述】  导入在标签tag_release上的给定脚本
#【依赖】   
#【术语】 _importBSFn == import bash-simplify file name , scriptFN==scriptFileName
#【备注】  

function _importBSFn() {
local  tagName="tag_release"

#若函数参数不为1个 ， 则返回错误（退出码为23）
[ $# -eq 1 ] || return 23

local scriptFN=$1

#若文件名不以'.sh'结尾, 则补上
[[ $scriptFN = *.sh ]] || scriptFN="$scriptFN.sh"

#TODO 检查仓库 /app/bash-simplify/.git是否处于标签$tagName

F="/app/bash-simplify/${scriptFN}"
#若文件不存在，则返回错误
[[ ! -f $F ]] && return 51

source $F

# source /app/bash-simplify/${scriptFN}
#上一行带入实际值 后 举例如下:
# source /app/bash-simplify/git__chkDir__get__repoDir__arg_gitDir.sh
}

#使用举例
#1. 导入 _importBSFn.sh
# source <(curl --location --silent "http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh")
# 或
# source /app/bash-simplify/_importBSFn.sh
#2. _importBSFn 导入 目标脚本文件
# _importBSFn git__chkDir__get__repoDir__arg_gitDir
#  等同于
# _importBSFn git__chkDir__get__repoDir__arg_gitDir.sh

