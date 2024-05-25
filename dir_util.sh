#!/bin/bash

#【描述】  为了兼容原dir_util.sh (不建议使用)
#【依赖】   
#【术语】 
#【备注】  



#若仓库"/app/bash-simplify/"不处在relese分支，则退出
_importBSFn "repo_BashSimplify__In_tag_release.sh"
repo_BashSimplify__In_tag_release || exit $?
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
