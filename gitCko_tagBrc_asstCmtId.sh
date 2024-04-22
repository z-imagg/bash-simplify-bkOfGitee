#!/usr/bin/env bash

source <(curl http://giteaz:3000/bal/bash-simplify/raw/branch/release/gitCko_tagBrc_assertCmtId.sh)


#gitCko_tagBrc_asstCmtId: gitCheckout_tagOrBranch_assertCmtId
#调用举例 : gitCko_tagBrc_asstCmtId GitDir tagOrBranch CmtId
function gitCko_tagBrc_asstCmtId(){
gitCko_tagBrc_assertCmtId $*
}
