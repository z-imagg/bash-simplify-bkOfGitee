#!/bin/bash

#【描述】  导入在标签tag_release上的给定脚本
#【依赖】   
#【术语】 scriptFN==scriptFileName
#【备注】  

function _importFn() {
local  tagName="tag_release"

#若函数参数不为1个 ， 则返回错误（退出码为23）
[ $# -eq 1 ] || return 23

local scriptFN=$1

#若文件名不以'.sh'结尾, 则补上
[[ $scriptFN = *.sh ]] || scriptFN="$scriptFN.sh"

source <(curl --silent "http://giteaz:3000/bal/bash-simplify/raw/tag/${tagName}/${scriptFN}")
#上一行带入实际值 后 举例如下:
# source <(curl --silent "http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/git__chkDir__get__repoDir__arg_gitDir.sh")
}

#使用举例
# source <(curl --silent "http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importFn.sh")
# _importFn git__chkDir__get__repoDir__arg_gitDir
#  等同于
# _importFn git__chkDir__get__repoDir__arg_gitDir.sh

