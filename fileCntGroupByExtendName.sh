#!/bin/sh


#【描述】  给定源码目录，按扩展名分组统计个数
#【依赖】   
#【术语】 
#【备注】  
#【例子用法】  
#   source /app/bash-simplify/fileCntGroupByExtendName.sh
# 按文件扩展名分组统计目录/d2/OCCT-master中文件个数, 只关注前500个文件
#   fileCntGroupByExtendName /d2/OCCT-master/ 500
# 按文件扩展名分组统计目录/d2/OCCT-master中文件个数, 只关注前500个文件; 排除只有1次且含有路径前缀的（约等于 排除无扩展名的文件）
#   fileCntGroupByExtendName /d2/OCCT-master/ 500  | grep -v "^ *1 */"
# 按文件扩展名分组统计目录/d2/OCCT-master中文件个数, 只关注全部文件
#       第二个参数为0  表示关注全部文件
#   fileCntGroupByExtendName /d2/OCCT-master/ 0

echo -e "[用法] \n source /app/bash-simplify/fileCntGroupByExtendName.sh ; fileCntGroupByExtendName /d2/OCCT-master/ 500  | grep -v '^ *1 */' ; \n [参数说明] \n fileCntGroupByExtendName 源码目录 只关注前N个文件(N为0表示关注全部文件) | 此处grep是辅助 排除只有1次且含有路径前缀的 （约等于 排除无扩展名的文件）"

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

function fileCntGroupByExtendName(){
local OK=0
local ERR=99

local prj_dir=$1
local top_n_file=$2

cd $prj_dir

#全部文件个数
local all_file_cnt=$(find . -type f | wc -l)

local msg1="全部文件个数为 ${all_file_cnt}"
local msg2="只关注前 ${top_n_file} 个文件"

#top_n_file为0 表示全部
[[ $top_n_file -eq 0 ]] && top_n_file=${all_file_cnt} && msg1="关注全部文件"

local msg="目录[ ${prj_dir} ] , ${msg1}, ${msg2}, 按扩展名分组统计文件个数结果如下"
echo $msg

find . -type f |head -n $top_n_file    |    xargs -I@ bash -c "echo @ | rev      |  cut  -d'.'  -f1  |  rev"   |  sort | uniq -c | sort -nr
#                                                                       倒置         按'.'切开取首字段     再倒置     '分      组      统     计'
return $OK
}
#函数单元测试
#fileCntGroupByExtendName /d2/OCCT-master 500
#fileCntGroupByExtendName /d2/OCCT-master 0
