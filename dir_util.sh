#!/usr/bin/env bash

#以pwd和当前脚本路径名$0 结合 给出 当前脚本所在目录名、当前脚本名
#调用者应该在切换目录之前调用本函数, 即 尽可能早的调用本脚本.  
#   若 调用者 切换到其他目录后，调用本脚本 则结果肯定不对.
# 使用例子: getCurScriptDirName $0
#返回: 当前脚本文件 绝对路径 CurScriptF, 当前脚本文件 名 CurScriptNm, 当前脚本文件 所在目录 绝对路径 CurScriptNm
function getCurScriptDirName(){

    #若函数参数少于1个，则退出（退出码为23）
    [ $# -lt 1 ] && return 23

    { { [[ $0 == /* ]] && CurScriptF=$0 ;} ||  CurScriptF=$(pwd)/$0 ;} && \

#当前脚本文件名, 此处 CurScriptF=build-linux-2.6.27.15-on-i386_ubuntu14.04.6LTS.sh
#CurScriptF为当前脚本的绝对路径
#若$0以/开头 (即 绝对路径) 返回$0, 否则 $0为 相对路径 返回  pwd/$0

    [ -f $CurScriptF ] && \
    CurScriptNm=$(basename $CurScriptF) && \
    CurScriptDir=$(dirname $CurScriptF)



}

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

#获取调用者 是否开启了 bash -x  即 是否开启 bash 调试
#返回变量 _out_en_dbg, _out_dbg
function get_out_en_dbg(){
    { { [[ $- == *x* ]] && _out_en_dbg=true && _out_dbg="-x" ;} || { _out_en_dbg=false && _out_dbg="" ;}  ;}
    # echo $_out_en_dbg
}

function miniconda3Activate(){
get_out_en_dbg && \
# echo "$_out_en_dbg,【$_out_dbg】" && \

#miniconda activate 不要开调试
CondaActvF=/app/miniconda3/bin/activate && \
{ [ -f  $CondaActvF ] || \
  { echo "错误,无miniconda3,请手工安装miniconda3形如${CondaActvF}，退出码51" && exit 51 ;} ;} && \
set +x && source $CondaActvF

#恢复可能的调试
{ { $_out_en_dbg && set -x && : ;} || : ;}

}

function cmakeInstall(){
    
{ cmake --version 1&>2 /dev/null || sudo apt install cmake  build-essential -y ;}

}