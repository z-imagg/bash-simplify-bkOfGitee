#!/bin/sh


#【描述】  给定源码目录，用sqlite3进行各种统计
#【依赖】   
#【术语】 
#【备注】  
#【例子用法】  
#   source /app/bash-simplify/dirAggBySqlite3/main.sh ; dirAggBySqlite3 /d2/OCCT-master/


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u


#导入函数
source /app/bash-simplify/dirAggBySqlite3/__save_filePathOfDir_to_sqlite3Db.sh

#main函数
function dirAggBySqlite3(){
local OK=0
local ERR=99

local prj_dir=$1
# local prj_dir=`pwd`
local prj_name=$(basename $prj_dir)
local sqlite3_db_path="/tmp/sqlite3_db_filePath_${prj_name}.db"

# 目录中文件列表写入sqlite3表格t_fpath_{prj_name}
__save_filePathOfDir_to_sqlite3Db $prj_dir $sqlite3_db_path

return $OK

}
#函数单元测试
#source /app/bash-simplify/dirAggBySqlite3/main.sh ;  set -x;    dirAggBySqlite3  /d2/OCCT-master/  ; set +x



