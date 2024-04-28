#!/bin/bash

function repo_branch_eq_release() {
local errCode_notGitRepo=12
local errCode_branchNotRelease=13
local Ok=0

local Hm="/app/bash-simplify/"
local GitHm="$Hm/.git/"
[[ -f $GitHm/config ]] || return $errCode_notGitRepo

local branch=$(git --git-dir=$GitHm rev-parse --abbrev-ref HEAD)

[[ "_$branch" == "_release" ]] || return $errCode_branchNotRelease

return  $Ok
}
