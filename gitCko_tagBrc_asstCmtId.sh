#!/bin/bash

#若仓库"/app/bash-simplify/"不处在relese分支，则退出
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/repo_BashSimplify__In_tag_release.sh)
repo_BashSimplify__In_tag_release || exit $?
Hm="/app/bash-simplify/"

source $Hm/gitCko_tagBrc_assertCmtId.sh

#gitCko_tagBrc_asstCmtId: gitCheckout_tagOrBranch_assertCmtId
#调用举例 : gitCko_tagBrc_asstCmtId GitDir tagOrBranch CmtId
function gitCko_tagBrc_asstCmtId(){
gitCko_tagBrc_assertCmtId $*
}
