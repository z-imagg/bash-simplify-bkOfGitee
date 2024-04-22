#!/usr/bin/env bash


#若仓库"/app/bash-simplify/"不处在relese分支，则退出
source <(curl http://giteaz:3000/bal/bash-simplify/raw/branch/release/repo_branch_eq_release.sh)
repo_branch_eq_release || exit $?
Hm="/app/bash-simplify/"

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
