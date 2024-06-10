#!/bin/sh


#【描述】  给定源码目录，用sqlite3进行各种统计
#【依赖】   
#【术语】 
#【备注】  
#【例子用法】  
#   source /app/bash-simplify/dirAggBySqlite3.sh ; __save_filePath_to_sqlite3Db /d2/OCCT-master/
#   fileCntGroupByExtendName /d2/OCCT-master/ 0


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

#目录中文件列表写入sqlite3表格t_fpath_{prj_name}
function __save_filePath_to_sqlite3Db(){
local OK=0
local ERR=99

local now_ms=$(date +%s)
local SQL_tmpF=/tmp/sqlite3_sqlText_insert_tmp_file_${now_ms}.txt
local prj_dir=$1
# local prj_dir=`pwd`
local prj_name=$(basename $prj_dir)
local sqlite3_db_path="/tmp/sqlite3_db_filePath_${prj_name}.db"
local tab_name="'t_fpath_${prj_name}'"
local field_name="fpath"

local SQL_CreateTab="create table if not exists  ${tab_name} ( ${field_name} text )  ; "
local SQL_insert_Head="insert into ${tab_name}(${field_name}) values "
local SQL_insert_END="('END_ROW');"
local SQL_SelectCnt="select count(*) from ${tab_name};"

echo $SQL_CreateTab | tee $SQL_tmpF 1>/dev/null
echo $SQL_insert_Head | tee -a $SQL_tmpF 1>/dev/null
#                      避免递归进入.git目录
find $prj_dir      -path '*/.git' -prune   -or      -type f | head -n 40 | xargs -I@ echo " ('@'), "  | tee -a $SQL_tmpF 1>/dev/null

echo $SQL_insert_END| tee -a $SQL_tmpF 1>/dev/null
echo $SQL_SelectCnt| tee -a $SQL_tmpF 1>/dev/null
echo $SQL_tmpF; ls -lh $SQL_tmpF ; wc -l $SQL_tmpF ; head -n 5 $SQL_tmpF ; tail -n 5 $SQL_tmpF
# set -x

[[ -e $sqlite3_db_path ]] && rm -v $sqlite3_db_path 
cat $SQL_tmpF | sqlite3 -batch $sqlite3_db_path

echo $sqlite3_db_path ; ls -lh $sqlite3_db_path

return $OK

}
#函数单元测试
#source /app/bash-simplify/dirAggBySqlite3.sh ; __save_filePath_to_sqlite3Db /d2/OCCT-master/


