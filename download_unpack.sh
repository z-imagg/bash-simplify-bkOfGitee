#!/usr/bin/bash


#例子用法: download_unpack https://neo4j.com/artifact.php?name=neo4j-community-4.4.32-unix.tar.gz a88d5de65332d9a5acbe131f60893b55  neo4j-community-4.4.32-unix.tar.gz  /app/pack/  /app/ http://172.17.0.1:2111/neo4j-community-4.4.32-unix.tar.gz


function download_unpack(){

#【术语】 url主要部分 == 'http://xxx:port'
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

usage_demo="download_unpack https://neo4j.com/artifact.php?name=neo4j-community-4.4.32-unix.tar.gz a88d5de65332d9a5acbe131f60893b55  neo4j-community-4.4.32-unix.tar.gz /app/pack/ /app/  http://172.17.0.1:2111/neo4j-community-4.4.32-unix.tar.gz"
errCode_badUsage=14; errTxt_badUsage="bad syntax; usage: download_unpack Url Md5sum FileName PackOutDir UnpackOutDir [LocalUrl]"

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

#获取 url主要部分
[[ "X$LocalUrl" == "X" ]] || LocalUrlMainPart=$(python3 $pyF_getUrlMainPart "$LocalUrl")

PackFPath=$PackOutDir/$FileName
md5_check_txt="$Md5sum  $PackFPath"
#  文件不存在 或 md5校验不通过 则下载
(  test -f $PackFPath && echo "$md5_check_txt" | md5sum --check ;) ||  { \
#    优先从本地文件下载服务下载
( curl ${LocalUrlMainPart} 1>/dev/null &&   wget --quiet --output-document=$PackFPath ${LocalUrl} :) || \
#    其次才从外网文件下载
axel --insecure --quiet -n 8 --output=$PackFPath $Url ;}

[[ "$FileName" == *".tar.gz" ]] && tar -zxf $PackFPath -C $UnpackOutDir && return 0

#set +x
return 3
}

#参数字符串数组$@  参考 :  http://giteaz:3000/wiki/wiki/src/branch/main/computer/bash__special_val__suchAs_args__example.md.sh
#参数字符串数组$@ 给到函数download_unpack
download_unpack $@
