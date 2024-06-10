#!/bin/sh


#【描述】  给定源码目录，用sqlite3进行各种统计
#【依赖】   
#【术语】 
#【备注】  
#【例子用法】  
#   source /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/main.sh ; grpCnt_fileExtendName_BySqlite3 /d2/OCCT-master/


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u


#main函数
function grpCnt_fileExtendName_BySqlite3(){
local OK=0
local ERR=99

local prjDir=$1
# local prjDir=`pwd`
local prj_name=$(basename $prjDir)
local sqlite3_db_path="/tmp/sqlite3_db_filePath_${prj_name}.db"


# 目录中文件列表写入sqlite3表格t_fpath_{prj_name}
source /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/__save_filePathOfDir_to_sqlite3Db.sh ; __save_filePathOfDir_to_sqlite3Db $prjDir $sqlite3_db_path

# 创建、填充 分组统计表  文件扩展名 file_extend_name
cat  /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/createTab_fillTab__t_grpCnt_file_extend_name.sql | sqlite3 $sqlite3_db_path

return $OK

}
#函数单元测试
#source /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/main.sh ;  set -x;    grpCnt_fileExtendName_BySqlite3  /d2/OCCT-master/  ; set +x



