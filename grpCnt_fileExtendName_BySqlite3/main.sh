#!/bin/sh


#【描述】  给定源码目录，用sqlite3进行各种统计
#【依赖】   
#【术语】 
#【备注】  
#【例子用法】  
#  分组统计给定目录下文件扩展名个数 Open-Cascade-SAS/OCCT-7_8_1  (开发模式)
#     开发模式==只看该目录下的前400个文件 
#       开发模式 目的是 快速执行完成
#    source /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/main.sh ; DevMode__grpCnt_fileExtendName_BySqlite3=true grpCnt_fileExtendName_BySqlite3 /d2/Open-Cascade-SAS/OCCT-7_8_1/
#  分组统计给定目录下文件扩展名个数 Open-Cascade-SAS/OCCT-7_8_1  (默认为生产模式)
#     生产模式==非开发模式==看该目录下的前2**32次方个文件 约等于 看该目录下的全部文件
#    source /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/main.sh ;  grpCnt_fileExtendName_BySqlite3 /d2/Open-Cascade-SAS/OCCT-7_8_1/
#  目录来源 /d2/Open-Cascade-SAS/OCCT-7_8_1 
#    cd /d2/Open-Cascade-SAS/ &&  wget https://github.com/Open-Cascade-SAS/OCCT/archive/refs/tags/V7_8_1.zip && unzip OCCT-7_8_1.zip  -d . && ls /d2/Open-Cascade-SAS/OCCT-7_8_1/

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u


#main函数
function grpCnt_fileExtendName_BySqlite3(){
local OK=0
local ERR=99

#依赖检测
local Err_2=82
local ErrMsg_2="需要[sqlite3], ubuntu22下安装命令为 [ sudo apt install -y sqlite3 ], 错误代码[$Err_2]"
local Err_3=83
local ErrMsg_3="需要[sqlitebrowser], ubuntu22下安装命令为 [ sudo apt install -y sqlitebrowser ], 错误代码[$Err_3]"
sqlite3  --version 1>/dev/null 2>/dev/null || { echo $ErrMsg_2 && return $Err_2 ;}
sqlitebrowser  --version 1>/dev/null 2>/dev/null || { echo $ErrMsg_2 && return $Err_2 ;}

local sqlF_createTab_fillTab__t_grpCnt_file_extend_name="/app/bash-simplify/grpCnt_fileExtendName_BySqlite3/createTab_fillTab__t_grpCnt_file_extend_name.sql"
local sqlTmpF_createFillTab__extend_name="$sqlF_createTab_fillTab__t_grpCnt_file_extend_name.ignore_me"


local prjDir=$1
# local prjDir=`pwd`
local prj_name=$(basename $prjDir)
local sqlite3_db_path="/tmp/sqlite3_db_filePath_${prj_name}.db"


# 目录中文件列表写入sqlite3表格t_fpath_{prj_name}
source /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/__save_filePathOfDir_to_sqlite3Db.sh ; __save_filePathOfDir_to_sqlite3Db $prjDir $sqlite3_db_path

# 创建、填充 分组统计表  文件扩展名 file_extend_name
cp $sqlF_createTab_fillTab__t_grpCnt_file_extend_name $sqlTmpF_createFillTab__extend_name
sed -i "s/PRJ_NAME/$prj_name/g" $sqlTmpF_createFillTab__extend_name 
cat  $sqlTmpF_createFillTab__extend_name  | sqlite3 $sqlite3_db_path

# 向用户展示结果
echo "文件扩展名统计结果表名 为 t_grpCnt_file_extend_name"
( sqlitebrowser --read-only $sqlite3_db_path & )

return $OK

}
#函数单元测试
#source /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/main.sh ;  set -x;    grpCnt_fileExtendName_BySqlite3  /d2/Open-Cascade-SAS/OCCT-7_8_1  ; set +x



