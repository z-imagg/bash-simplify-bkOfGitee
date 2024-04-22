#!/usr/bin/env bash

Hm="/app/bash-simplify/"
GitHm="$Hm/.git/"
[[ -f $GitHm/config ]] && echo ok

branch=$(git --git-dir=$GitHm rev-parse --abbrev-ref HEAD)

errCode_branchBad=21
errMsg_branchBad="$GitHm 's branch is not release, exit code $errCode_branchBad"
[[ "_$branch" == "_release" ]] || { echo $errMsg_branchBad && exit  $errCode_branchBad ;}



source $Hm/cdCurScriptDir.sh

source $Hm/getCurScriptDirName.sh
source $Hm/mvFile_AppendCurAbsTime.sh
source $Hm/mvFile_AppendCurAbsTime_multi.sh
source $Hm/gitCko_tagBrc_asstCmtId.sh
source $Hm/get_out_en_dbg.sh
source $Hm/miniconda3install.sh #tsinghua_pypi_src miniconda3Activate
source $Hm/cmakeInstall.sh
source $Hm/makLnk.sh
source $Hm/fileModifiedInNSeconds.sh
