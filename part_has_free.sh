#!/bin/bash

#【描述】  给定分区剩余空间是否大于给定尺寸
# 【用法举例】 
#  分区sdc3是否剩余超过1GB空间
#  用法1 
#    source /app/bash-simplify/partHasFree.sh && partHasFree /dev/sdc3 _1GB
#  用法2
#   source /app/bash-simplify/_importBSFn.sh #or:#  source <(curl --location --silent http://giteaz:3000/util/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
#   _importBSFn "partHasFree.sh" 
#    partHasFree /dev/sdc3 _1GB
#【术语】 
#【备注】 

_1KB=$((1*1024))
_1MB=$((1*1024*1024))
_1GB=$((1*1024*1024*1024))
usageTxt="part_has_free.sh usage: 'partHasFree /dev/sdc3 \$((1*1024*1024*1024)) ' or 'partHasFree /dev/sdc3 \$_1GB && echo enough' , unit var : \$_1KB \$_1MB \$_1GB"
echo $usageTxt

errExitCode_usage=30
errMsg_usage="$usageTxt ; exitCode==${errExitCode_usage}"

#给定分区剩余空间是否大于给定尺寸
function partHasFree(){
    [[ $# -eq 2 ]] || { echo $errMsg_usage && exit $errExitCode_usage ;}

    dev=$1
    freeLimitBytes=$2


# freeSize=$(df --block-size=1  --output=avail /dev/sdc3 | tail -n 1) && [[ $freeSize -gt $((1*1024*1024*1024)) ]] && echo ok

    freeSize=$(df --block-size=1  --output=avail $dev | tail -n 1) && \
    [[ $freeSize -gt $freeLimitBytes ]]
}

