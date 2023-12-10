#创建目录、设置该目录主人为 当前主组/当前用户 、进入该目录
#使用举例: 
#createDir_CurUsrOwn_EnterIt /app 
function createDir_CurUsrOwn_EnterIt(){
    
    
    #若函数参数少于1个，则退出（退出码为21）
    [ $# -lt 1 ] && return 21

    dire=$1
    mainGroup=$(id -gn) && \
    username=$(whoami) && \
    sudo mkdir $dire && \
    sudo chown -R $mainGroup.$username $dire && \
    cd $dire
}

#全路径文件 重命名： 加 当前绝对时间后缀
#用法举例: mvFile_AppendCurAbsTime /crk/xxx.txt
#则 文件/crk/xxx.txt 被重命名为 比如 /crk/xxx.txt-20231210132251_1702185771_452355256
function mvFile_AppendCurAbsTime(){
        
    #若函数参数少于1个，则退出（退出码为21）
    [ $# -lt 1 ] && return 22

    fileName=$1 && \
    # 比如 fileName==/crk/xxx.txt && \
    UniqueId="$fileName-$(date +'%Y%m%d%H%M%S_%s_%N')" && \
    [ -f $fileName ] && mv $fileName "$fileName_$UniqueId"
}