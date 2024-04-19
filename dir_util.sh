#!/usr/bin/env bash

#去此脚本所在目录
function cdCurScriptDir(){
#去此脚本所在目录
declare -r f=$(readlink -f ${BASH_SOURCE[0]})  ; declare -r d=$(dirname $f)
cd $d
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
#用法举例: mvFile_AppendCurAbsTime /app_spy/xxx.txt
#则 文件/app_spy/xxx.txt 被重命名为 比如 /app_spy/xxx.txt-20231210132251_1702185771_452355256
function mvFile_AppendCurAbsTime(){
        
    #若函数参数少于1个，则退出（退出码为21）
    [ $# -lt 1 ] && return 22

    fileName=$1 && \
    # 比如 fileName==/app_spy/xxx.txt && \
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

function miniconda3install(){
(echo "安装miniconda3..." && \
cd /tmp/ && \
cat << 'EOF' > Miniconda3-py310_23.10.0-1-Linux-x86_64.sh.md5sum.txt
cefadd1cacd8e5b9a74b404df1f11016  Miniconda3-py310_23.10.0-1-Linux-x86_64.sh
EOF

{ md5sum --check Miniconda3-py310_23.10.0-1-Linux-x86_64.sh.md5sum.txt ||
 wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py310_23.10.0-1-Linux-x86_64.sh ;} && \

hm=/app/miniconda3 && \
sudo mkdir -p $hm && \
sudo chown -R $(id -gn).$(whoami) $hm && \
bash Miniconda3-py310_23.10.0-1-Linux-x86_64.sh -b -u -p $hm
)
}


function tsinghua_pypi_src(){
hm=/app/miniconda3 && \
source $hm/bin/activate && \
#pip源设为清华源: https://mirrors.tuna.tsinghua.edu.cn/help/pypi/
# python -m pip install --upgrade pip && \
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
conda deactivate
}

function miniconda3Activate(){
get_out_en_dbg && \
# echo "$_out_en_dbg,【$_out_dbg】" && \

#miniconda activate 不要开调试
CondaActvF=/app/miniconda3/bin/activate && \
{ [ -f  $CondaActvF ]  || miniconda3install   ;} && \
set +x && source $CondaActvF

#恢复可能的调试
{ { $_out_en_dbg && set -x && : ;} || : ;}

}

function cmakeInstall(){
    
{ cmake --version 1>/dev/null 2>/dev/null || sudo apt install cmake    -y ;} && \
{ g++ --version   1>/dev/null 2>/dev/null || sudo apt install build-essential -y ;}

}

function makLnk(){

#若函数参数少于2个，则退出（退出码为14）
[ $# -lt 2 ] && return 14
lnkSrc=$1  &&  lnkDest=$2 && \
{ [ -e $lnkDest ] || \
ln -s $lnkSrc $lnkDest ;}

}


#给定文件的最后修改时刻是否在当前时刻的N秒内
function fileModifiedInNSeconds(){
# fileModifiedInNSeconds "/app_spy/clang-funcSpy/build/lib/libClnFuncSpy.so" "5*60"

#若函数参数少于2个，则退出（退出码为14）
[ $# -lt 2 ] && return 14
filePath=$1  &&  limitSecondsExpr=$2 && \
{ [ -e $filePath ] || return 31 ;} && \
limitSeconds=$(($limitSecondsExpr)) && \
nowSeconds=$(date +%s) && \
fileEndModifySeconds=$(stat -c %Y  $filePath ) && \
deltaSeconds=$(( $nowSeconds -  $fileEndModifySeconds  )) && \
{ [  $deltaSeconds  -le $limitSeconds ] || return 1 ;} && \
return 0

}