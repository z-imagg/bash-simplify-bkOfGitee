#!/usr/bin/env bash

source <(curl http://giteaz:3000/bal/bash-simplify/raw/branch/release/cdCurScriptDir.sh)


source getCurScriptDirName.sh
source mvFile_AppendCurAbsTime.sh
source mvFile_AppendCurAbsTime_multi.sh
source gitCko_tagBrc_asstCmtId.sh
source get_out_en_dbg.sh
source miniconda3install.sh #tsinghua_pypi_src miniconda3Activate
source cmakeInstall.sh
source makLnk.sh
source fileModifiedInNSeconds.sh
