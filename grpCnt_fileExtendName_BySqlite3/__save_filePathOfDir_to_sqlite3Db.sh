#!/bin/sh


#【描述】  目录中文件列表写入sqlite3表格t_fpath_{prj_name}
#【依赖】   
#【术语】 
#【备注】  
#【例子用法】  
#   source /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/__save_filePathOfDir_to_sqlite3Db.sh ; __save_filePathOfDir_to_sqlite3Db /d2/Open-Cascade-SAS/OCCT-7_8_1 /tmp/sqlite3_db_filePath_OCCT-7_8_1.db


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u



#目录中文件列表写入sqlite3表格t_fpath_{prj_name}
function __save_filePathOfDir_to_sqlite3Db(){
local OK=0
local ERR=99
local fpathParsePy="/app/bash-simplify/grpCnt_fileExtendName_BySqlite3/_fpathParse_forBash.py"
local sh_echo_sqlInsertItem="/app/bash-simplify/grpCnt_fileExtendName_BySqlite3/__echo_sqlInsertItem.sh"

local prjDir=$1
# local prjDir=`pwd` #调试用
local sqlite3_db_path=$2
local now_ms=$(date +%s)
local SQL_tmpF=/tmp/sqlite3_sqlText_insert_tmp_file_${now_ms}.txt
local prj_name=$(basename $prjDir)
# local sqlite3_db_path="/tmp/sqlite3_db_filePath_${prj_name}.db" #调试用
local tab_name="'t_fpath_${prj_name}'"
local field_prjDir="prjDir"
local field_fpath="fpath"
local field_parentDir="parentDir"
local field_fname="fname"
local field_fExtendName="file_extend_name"

local SQL_CreateTab="create table if not exists  ${tab_name} (id INTEGER PRIMARY KEY AUTOINCREMENT,  ${field_fpath} text unique, ${field_prjDir} text, ${field_parentDir} text, ${field_fname} text, ${field_fExtendName} text )  ; "
local SQL_insert_Head="insert into ${tab_name}(   ${field_fpath}, ${field_prjDir}, ${field_parentDir}, ${field_fname}, ${field_fExtendName}) values "
local SQL_insert_END="('END_ROW','END_ROW','END_ROW','END_ROW','END_ROW');"
local SQL_SelectCnt="select count(*) from ${tab_name};"


echo $SQL_CreateTab | tee $SQL_tmpF 1>/dev/null
echo $SQL_insert_Head | tee -a $SQL_tmpF 1>/dev/null

#                             避免递归进入.git目录
( cd $prjDir && find .      -path '*/.git' -prune   -or      -type f | awk "NR<=400" | xargs -I@ bash -c "  source  <(python3 $fpathParsePy  @) ;   prjDir=$prjDir source $sh_echo_sqlInsertItem  " | tee -a $SQL_tmpF 1>/dev/null ;)
#'head -n 40' 调试用

# find .      -path '*/.git' -prune   -or      -type f | head -n 10 | xargs -I@ bash -c "set -x; source  <(python3 $fpathParsePy  @) ; set +x"   #调试用

echo $SQL_insert_END| tee -a $SQL_tmpF 1>/dev/null
echo $SQL_SelectCnt| tee -a $SQL_tmpF 1>/dev/null
# echo $SQL_tmpF; ls -lh $SQL_tmpF ; wc -l $SQL_tmpF ; head -n 5 $SQL_tmpF ; tail -n 5 $SQL_tmpF #调试用
# cat $SQL_tmpF #调试用
# set -x #调试用

[[ -e $sqlite3_db_path ]] && rm -v $sqlite3_db_path 
cat $SQL_tmpF | sqlite3 -batch $sqlite3_db_path

# echo $sqlite3_db_path ; ls -lh $sqlite3_db_path #调试用

return $OK

}
#函数单元测试
#source /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/__save_filePathOfDir_to_sqlite3Db.sh ; __save_filePathOfDir_to_sqlite3Db /d2/Open-Cascade-SAS/OCCT-7_8_1 /tmp/sqlite3_db_filePath_OCCT-7_8_1.db


