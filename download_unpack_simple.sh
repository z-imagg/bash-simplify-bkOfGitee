#!/usr/bin/bash

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u


function download_unpack_simple(){


#错误代码
declare -r ErrCode_UnpackFailed=3

declare -r OkCode=0

#若无axel,则安装
which axel 1>/dev/null || sudo apt install -y axel 
#若无jq,则安装
which jq 1>/dev/null || sudo apt install -y jq 

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
local errMsgGithubSlow="因慢而拒绝下载github文件，退出代码[$errCodeGithubSlow]。 请手工下载， Url=[$Url],Md5sum=[$Md5sum],FileName=[$FileName],PackOutDir=[$PackOutDir],UnpackOutDir=[$UnpackOutDir]"
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
# 导入依赖包
#  source <(curl --silent http://10.0.4.9:3000/bal/bash-simplify/raw/branch/release/arg1EqNMsg.sh) #或 source /app/bash-simplify/_importBSFn.sh
#  source /app/bash-simplify/download_unpack_simple.sh
# 正常下载例子
#  download_unpack_simple https://neo4j.com/artifact.php?name=neo4j-community-4.4.32-unix.tar.gz a88d5de65332d9a5acbe131f60893b55  neo4j-community-4.4.32-unix.tar.gz  /tmp/pack/  /tmp/

# 异常下载例子
# F="cytoscape-unix-3.10.2.tar.gz" ;   download_unpack_simple https://github.com/cytoscape/cytoscape/releases/download/3.10.2/$F a6b5638319b301bd25e0e6987b3e35fd  $F /tmp/pack/  /tmp/ || echo ERROR
#  打印ERROR
