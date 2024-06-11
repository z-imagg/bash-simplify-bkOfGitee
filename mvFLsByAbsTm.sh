#!/bin/bash

#【描述】  以 当前绝对时间后缀 重命名 文件列表
# 【用法举例】 
#  用法1 
#    source /app/bash-simplify/mvFLsByAbsTm.sh && mvFLsByAbsTm /my_file1 /my_file2
#  用法2
#   source /app/bash-simplify/_importBSFn.sh #or:#  source <(curl --location --silent http://giteaz:3000/util/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
#   _importBSFn "mvFLsByAbsTm.sh" 
#    mvFLsByAbsTm /my_file1 /my_file2
#【术语】 
#【备注】 

#以 当前绝对时间后缀 重命名 文件列表
#用法举例: mvFLsByAbsTm /app_spy/xxx.txt /my_file2
function mvFLsByAbsTm(){
        
    #若函数参数少于1个，则退出（退出码为21）
    [ $# -lt 1 ] && return 22


    UniqueDateTime="$(date +'%Y%m%d%H%M%S_%s_%N')" && \

    for fileNameK in "$@"; do
        UniqueId="${fileNameK}-${UniqueDateTime}" && \
        { { [ -f $fileNameK ] && mv -v $fileNameK "$UniqueId" ;} || : ;}
    done

}