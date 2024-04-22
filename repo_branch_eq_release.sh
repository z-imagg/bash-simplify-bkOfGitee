#!/usr/bin/env bash

function repo_branch_eq_release() {
local Hm="/app/bash-simplify/"
local GitHm="$Hm/.git/"
[[ -f $GitHm/config ]] && echo ok

local branch=$(git --git-dir=$GitHm rev-parse --abbrev-ref HEAD)

# local errCode_branchBad=21
# local errMsg_branchBad="$GitHm 's branch is not release, exit code $errCode_branchBad"
[[ "_$branch" == "_release" ]]
# || { echo $errMsg_branchBad && exit  $errCode_branchBad ;}

}
