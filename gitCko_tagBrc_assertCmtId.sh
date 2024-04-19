#!/usr/bin/env bash





#gitCko_tagBrc_assertCmtId: gitCheckout_tagOrBranch_assertCmtId
#调用举例 : gitCko_tagBrc_assertCmtId GitDir tagOrBranch CmtId
function gitCko_tagBrc_assertCmtId() {
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
