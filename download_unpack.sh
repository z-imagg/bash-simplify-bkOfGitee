#!/usr/bin/bash


#例子用法: download_unpack https://neo4j.com/artifact.php?name=neo4j-community-4.4.32-unix.tar.gz a88d5de65332d9a5acbe131f60893b55  neo4j-community-4.4.32-unix.tar.gz  /app/pack/  /app/ http://172.17.0.1:2111/neo4j-community-4.4.32-unix.tar.gz



#错误代码
declare -r ErrCode_UnpackFailed=3
declare -r ErrCode_NoPython=4
declare -r errTxt_NoPython="ErrCode_NoPython=$ErrCode_NoPython"

declare -r errCode_badUsage=14
declare -r errTxt_badUsage="bad syntax; usage: download_unpack Url Md5sum FileName PackOutDir UnpackOutDir [LocalUrl]"

declare -r OkCode=0

declare -r usage_demo="download_unpack https://neo4j.com/artifact.php?name=neo4j-community-4.4.32-unix.tar.gz a88d5de65332d9a5acbe131f60893b55  neo4j-community-4.4.32-unix.tar.gz /app/pack/ /app/  http://172.17.0.1:2111/neo4j-community-4.4.32-unix.tar.gz"


#获取给定url的 url主要部分
nowMs=$(date +%s)
pyF_getUrlMainPart=/tmp/_urlGetMainPart__${nowMs}.py
cat  << 'EOF' > $pyF_getUrlMainPart
import sys
from urllib3.util.url import parse_url
from urllib.parse import unquote
assert len(sys.argv)>=2
#只有一个参数为url
encoded_url = sys.argv[1]
#解码url
u = parse_url(encoded_url)
#组装 url主要部分
portTxt="" if u.port is None else f":{u.port}"
mainPart=f"{u.scheme}://{u.host}{portTxt}"
#输出给外围的'$()'
print(mainPart)
EOF



#若无axel,则安装
which axel 1>/dev/null || sudo apt install -y axel 

#获得python命令名 可能是python 可能是python3
which python && Py=python
which python3 && Py=python3
#若无python,则报错退出
[[ "X" == "X$Py" ]] && { echo $errTxt_NoPython && exit $ErrCode_NoPython ;}

function download_unpack(){

#【术语】 url主要部分 == 'http://xxx:port'



argCnt=$#
# echo argCnt=$argCnt
#参数个数小于等于5
[[ $argCnt -ge 5 ]] || { echo -e "$errTxt_badUsage \n example: $usage_demo" ; exit $errCode_badUsage ;}
#set -x
Url=$1
Md5sum=$2
FileName=$3
PackOutDir=$4
UnpackOutDir=$5
#参数LocalUrl是可选的，前面5个参数是必填的
LocalUrl=$6

#判断包扩展名
isTarGz=false; [[ "$FileName" == *".tar.gz" ]] && isTarGz=true
isGzip=false; [[ "$FileName" == *".gzip" ]] && isGzip=true
#判断是否需要解压
NeedUnpack=false; ( $isTarGz || $isGzip ) && NeedUnpack=true

[[ -d $PackOutDir ]] || mkdir -p $PackOutDir
#若 解压目的目录 不存在 则： 若 需要解压 则创建 解压目的目录
[[ -d $UnpackOutDir ]] || { $NeedUnpack && mkdir -p $UnpackOutDir ;}

#获取 url主要部分
[[ "X$LocalUrl" == "X" ]] || LocalUrlMainPart=$( $Py $pyF_getUrlMainPart "$LocalUrl")

PackFPath=$PackOutDir/$FileName
md5_check_txt="$Md5sum  $PackFPath"
#  文件不存在 或 md5校验不通过 则下载
FStatus="has"
(  test -f $PackFPath && echo "$md5_check_txt" | md5sum --check && FStatus="newDownload" ;) ||  { \
#    优先从本地文件下载服务下载
( [[ "X" != "X$LocalUrlMainPart" ]] && curl --silent ${LocalUrlMainPart} 2>/dev/null &&   wget --quiet --output-document=$PackFPath ${LocalUrl} :) || \
#    其次才从外网文件下载
axel --quiet --insecure  -n 8 --output=$PackFPath $Url ;}
# --percentage 


#假设正常退出
exitCode=$OkCode
#若需要解压，则先假设解压失败
$NeedUnpack && exitCode=$ErrCode_UnpackFailed

$isTarGz && tar -zxf $PackFPath -C $UnpackOutDir && exitCode=$OkCode

echo "$FStatus: $PackFPath, $(ls -lh $PackFPath)"
#set +x
return $exitCode
}

#参数字符串数组$@  参考 :  http://giteaz:3000/wiki/wiki/src/branch/main/computer/bash__special_val__suchAs_args__example.md.sh
#参数字符串数组$@ 给到函数download_unpack
download_unpack $@
