#!/bin/bash

_importBSFn "git__chkDir__get__repoDir__arg_gitDir.sh"

#仓库"/app/bash-simplify/"是否在标签tag_release上
function repo_BashSimplify__In_tag_release() {
local errCode_branchNotRelease=13
local Ok=0

local Hm="/app/bash-simplify/"

#若 该目录不是git仓库， 则返回错误
# git 检查仓库目录 、 获取仓库目录 、 获取git目录参数 , 返回变量为 repoDir 、 arg_gitDir
git__chkDir__get__repoDir__arg_gitDir $Hm || return $?

#HEAD是否在tag_release标签上
local HeadIn__tag_release=false; [[ $(git $arg_gitDir  tag   --points-at HEAD  --list "tag_release" | wc -l) == 1 ]] && HeadIn__tag_release=true

#若否定, 则返回错误
$HeadIn__tag_release || return $errCode_branchNotRelease

#否则即肯定，则返回正常
return  $Ok
}

#使用举例
# _importBSFn "repo_BashSimplify__In_tag_release.sh"
# repo_BashSimplify__In_tag_release && echo '仓库"/app/bash-simplify/"是否在标签tag_release上'
