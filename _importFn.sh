#!/bin/bash

#【描述】  导入在标签tag_release上的给定函数
#【依赖】   
#【术语】 Fn==function
#【备注】  

function _importFn__tag_release() {

#若函数参数不为1个 ， 则返回错误（退出码为23）
[ $# -eq 1 ] || return 23

#函数名functionName==脚本文件名scriptFileName
local scriptFileName=$1

source <(curl --silent "http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/${scriptFileName}.sh")
#上一行带入实际值 后 举例如下:
# source <(curl --silent "http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/git__chkDir__get__repoDir__arg_gitDir.sh")

}

#使用举例
# source <(curl --silent "http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importFn__tag_release.sh")
# _importFn__tag_release git__chkDir__get__repoDir__arg_gitDir

