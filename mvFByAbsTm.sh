#!/usr/bin/env bash



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

