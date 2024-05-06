#!/usr/bin/bash

set -e -u


function download_unpack_simple(){


#错误代码
declare -r ErrCode_UnpackFailed=3

declare -r OkCode=0

#若无axel,则安装
which axel 1>/dev/null || sudo apt install -y axel 

_importBSFn "arg1EqNMsg.sh"

# 断言参数个数为5个
arg1EqNMsg $# 5 '"命令用法:x.sh Url Md5sum FileName PackOutDir UnpackOutDir"' || return $?

Url=$1
Md5sum=$2
FileName=$3
PackOutDir=$4
UnpackOutDir=$5

#获取 url的host部分
local Url2Json_Py=/app/bash-simplify/Url2Json.py
python $Url2Json_Py "$Url" && local host=$(python $Url2Json_Py "$Url" | jq   .host) && host=${host//\"/}

#从github.com下载是很慢的，直接退出
local errCodeGithubSlow=71
local errMsgGithubSlow="从github下载很慢，直接退出，拒绝下载，请手工下载到给定目录,退出代码【$errCodeGithubSlow】"
[[ "$host" == "github.com" ]] && { echo $errMsgGithubSlow ; return $errCodeGithubSlow ;}
PackFPath=$PackOutDir/$FileName
md5_check_txt="$Md5sum  $PackFPath"
#  检查本地文件: 文件存在 且 md5校验符合
local localFileOk=false; {  test -f $PackFPath && echo "$md5_check_txt" | md5sum --check   ;} && localFileOk=true
# 无本地文件，则下载
 ( ! $localFileOk )  && (  axel  --quiet   --insecure  -n 8 --output=$PackFPath $Url ;)
# --percentage  --quiet --insecure 


#假设正常退出
exitCode=$OkCode


#判断包扩展名
isTarGz=false; [[ "$FileName" == *".tar.gz" ]] && isTarGz=true
isGzip=false; [[ "$FileName" == *".gzip" ]] && isGzip=true
#判断是否需要解压
NeedUnpack=false; ( $isTarGz || $isGzip ) && NeedUnpack=true

[[ -d $PackOutDir ]] || mkdir -p $PackOutDir
#若 解压目的目录 不存在 则： 若 需要解压 则创建 解压目的目录
[[ -d $UnpackOutDir ]] || { $NeedUnpack && mkdir -p $UnpackOutDir ;}

#若需要解压，则先假设解压失败
$NeedUnpack && exitCode=$ErrCode_UnpackFailed

$isTarGz && tar -zxf $PackFPath -C $UnpackOutDir && exitCode=$OkCode

echo "【exitCode=$exitCode】 $PackFPath, $(ls -lh $PackFPath)"
#set +x
return $exitCode
}

#用法举例
# source <(curl --silent http://10.0.4.9:3000/bal/bash-simplify/raw/branch/release/arg1EqNMsg.sh) #或 source /app/bash-simplify/_importBSFn.sh
# source /app/bash-simplify/download_unpack_simple.sh
#download_unpack_simple https://neo4j.com/artifact.php?name=neo4j-community-4.4.32-unix.tar.gz a88d5de65332d9a5acbe131f60893b55  neo4j-community-4.4.32-unix.tar.gz  /tmp/pack/  /tmp/

