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