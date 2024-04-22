#!/usr/bin/bash

_1KB=$((1*1024))
_1MB=$((1*1024*1024))
_1GB=$((1*1024*1024*1024))
usageTxt="part_has_free.sh usage: 'partHasFree /dev/sdc3 \$((1*1024*1024*1024)) ' or 'partHasFree /dev/sdc3 $_1GB' , unit var : \$_1KB \$_1MB \$_1GB"
echo $usageTxt

errExitCode_usage=30
errMsg_usage="$usageTxt ; exitCode==${errExitCode_usage}"


function partHasFree(){
    [[ $# -eq 2 ]] || { echo $errMsg_usage && exit $errExitCode_usage ;}

    dev=$1
    freeLimitBytes=$2


# freeSize=$(df --block-size=1  --output=avail /dev/sdc3 | tail -n 1) && [[ $freeSize -gt $((1*1024*1024*1024)) ]] && echo ok

    freeSize=$(df --block-size=1  --output=avail $dev | tail -n 1) && \
    [[ $freeSize -gt $freeLimitBytes ]]
}

