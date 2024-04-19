#!/usr/bin/env bash

#xargsz(等效于xargs的自定义普通bash函数)
source <(curl http://giteaz:3000/bal/bash-simplify/raw/tag/tag/release/xargsz.sh)
# 【语法】xargsz 自定义bash函数名 
# 【用法举例】 function busyFunc1() { [[ "X$Ln" = Xbin ]] || echo "notBinDir:$Ln" ;} ; ls /usr/ | xargsz busyFunc1

#去此脚本所在目录
declare -r f=$(readlink -f ${BASH_SOURCE[0]})  ; declare -r d=$(dirname $f)
cd $d

function to_markdown_href_func() {
shopt -s expand_aliases

alias urlencode_py='python3 -c "import sys, urllib.parse as ul;print(ul.quote(sys.argv[1]))"'

# 参数个数等于2
if [ ! "$#" -eq 2 ]; then
    local usageTxt="【用法举例】 to_markdown_href_func http://giteaz:3000/wiki/wiki/src/branch/main  xxx/你好.md"
    local errCode=45
    local errTxt="错误,函数to_markdown_href_func的参数个数【$#】必须为2,退出代码【$errCode】" 
    echo $usageTxt
    echo $errTxt
    return $errCode
fi

PREFIX=$1
fp=$2

#跳过非文件
[[ -f "$fp" ]] || return 1

#echo xx: $0, $1, $2

url_fp=$(urlencode_py  $fp)
#echo PREFIX=$PREFIX, fp=$fp, url_fp=$url_fp

echo -e "\n[${fp}](${PREFIX}/${url_fp})"
}

declare -r  ____usageTxt__gen_tableOfContent="【用法举例】 gen_tableOfContent  /app/wiki/ http://giteaz:3000/wiki/wiki/src/branch/main /app/wiki/readme.md"
echo "$____usageTxt__gen_tableOfContent"

function gen_tableOfContent() {
    # 参数个数等于3
if [ ! "$#" -eq 3 ]; then
    local errCode=46
    local errTxt="错误,函数gen_tableOfContent的参数个数【$#】必须为2,退出代码【$errCode】" 
    echo $____usageTxt__gen_tableOfContent
    echo $errTxt
    return $errCode
fi

local dir=$1
#dir == /app/wiki/
local PREFIX=$2
# PREFIX=="http://giteaz:3000/wiki/wiki/src/branch/main"; 
local readmeF=$3
# readmeF==/app/wiki/readme.md

cd $dir

#删除现有toc
# 【术语】 从'^#### toc' 到 '$'  == 从 行'#### toc' 到  文件末尾
#  从  行'#### toc' 到  文件末尾 全部删除
sed -i '/^#### toc/,$d' $readmeF

#生成新的toc
# 即 对readme.md追加 所有 .md 文件路径
#   readme.md 末尾追加 行 "#### toc"
echo -e "#### toc"| tee -a $readmeF

#   查找本目录下 所有 .md结尾文件路径， 追加到 readme.md  
function busyFunc1() { to_markdown_href_func $PREFIX  $Ln     ;}
find . -name "*.md" -or -name "*.md.*" -or -name "\.bash*" -type f |  xargsz busyFunc1 | tee -a $readmeF
}
