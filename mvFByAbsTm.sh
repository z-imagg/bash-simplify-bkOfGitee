#!/bin/bash

#【描述】  以 当前绝对时间后缀 重命名 文件
# 【用法举例】 
#  用法1 
#    source /app/bash-simplify/mvFByAbsTm.sh && mvFByAbsTm /my_file
#  用法2
#   source /app/bash-simplify/_importBSFn.sh #or:#  source <(curl --location --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
#   _importBSFn "mvFByAbsTm.sh" 
#    mvFByAbsTm /my_file
#【术语】 
#【备注】 


#以 当前绝对时间后缀 重命名 文件
#用法举例: mvFByAbsTm /app_spy/xxx.txt
function mvFByAbsTm(){
        
    #若函数参数少于1个，则退出（退出码为21）
    [ $# -lt 1 ] && return 22

    fileName=$1 && \
    # 比如 fileName==/app_spy/xxx.txt && \
    UniqueId="$fileName-$(date +'%Y%m%d%H%M%S_%s_%N')" && \
    { { [ -f $fileName ] && mv -v $fileName "$UniqueId" ;} || : ;}
    #fix bug
}

