#!/usr/bin/env bash

Hm="/app/bash-simplify/"
[[ -f $Hm/.git/config ]] && echo ok


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
