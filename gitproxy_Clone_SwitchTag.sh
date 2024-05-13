#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出

source /app/bash-simplify/_importBSFn.sh
_importBSFn "git_Clone_SwitchTag.sh"
_importBSFn "gitproxy.sh"

#以westgw代理执行 git_Clone_SwitchTag
function gitproxy_Clone_SwitchTag() {

#设置git代理westgw
gitproxy_set

#执行git_Clone_SwitchTag, 并记录其退出代码
git_Clone_SwitchTag $* ; local retCode=$?

#不管是否失败,   删除git代理
gitproxy_unset

#返回git_Clone_SwitchTag的退出代码
return $retCode

}


# #用法举例:
#  git克隆仓库的给定分支或标签到给定目录
# _importBSFn "gitproxy_Clone_SwitchTag.sh" #或# source /app/bash-simplify/gitproxy_Clone_SwitchTag.sh
#  克隆 WebKit.git 的标签 Safari-533.9 到 本地目录 /app/WebKit/ 
# git_Clone_SwitchTag https://github.com/WebKit/WebKit.git Safari-533.9  /app/WebKit/ 