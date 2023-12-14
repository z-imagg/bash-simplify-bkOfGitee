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
    { { [ -f $fileName ] && mv -v $fileName "$UniqueId" ;} || : ;}
    #fix bug
}

function mvFile_AppendCurAbsTime_multi(){
        
    #若函数参数少于1个，则退出（退出码为21）
    [ $# -lt 1 ] && return 22


    UniqueDateTime="$(date +'%Y%m%d%H%M%S_%s_%N')" && \

    for fileNameK in "$@"; do
        UniqueId="${fileNameK}-${UniqueDateTime}" && \
        { { [ -f $fileNameK ] && mv -v $fileNameK "$UniqueId" ;} || : ;}
    done

}

#gitCko_tagBrc_asstCmtId: gitCheckout_tagOrBranch_assertCmtId
#调用举例 : gitCko_tagBrc_asstCmtId GitDir tagOrBranch CmtId
function gitCko_tagBrc_asstCmtId() {
#若函数参数少于3个，则退出（退出码为14）
[ $# -lt 3 ] && return 14
GitWorkTreeDir=$1  &&  tagOrBranch=$2  CmtId=$3 && \

GitWorkTreeDirBaseName=$(basename ${GitWorkTreeDir} ) && \

ErrMsg1="错误, $Ver 的commitId不是 $CmtId, 退出码13" && \
OkMsg="git仓库验证通过:git仓库目录${GitWorkTreeDirBaseName}的分支或标签${tagOrBranch}确实位于提交id${CmtId}" && \

#子模块 用 --git-dir=$GitDir  比较麻烦 , 因此 不用
_pwd=$(pwd) &&
cd $GitWorkTreeDir && \
git checkout $tagOrBranch && \
CurHeadCmtId=$(git  rev-parse HEAD) && \
{ { [ "X$CurHeadCmtId" == "X$CmtId" ] && echo $OkMsg ;} || { echo $ErrMsg1 && exit 13 ;} ;} && \

cd $_pwd
_=end

}