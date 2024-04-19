#!/usr/bin/env bash



#以 当前绝对时间后缀 重命名 文件列表
#用法举例: mvFLsByAbsTm /app_spy/xxx.txt
function mvFLsByAbsTm(){
        
    #若函数参数少于1个，则退出（退出码为21）
    [ $# -lt 1 ] && return 22


    UniqueDateTime="$(date +'%Y%m%d%H%M%S_%s_%N')" && \

    for fileNameK in "$@"; do
        UniqueId="${fileNameK}-${UniqueDateTime}" && \
        { { [ -f $fileNameK ] && mv -v $fileNameK "$UniqueId" ;} || : ;}
    done

}