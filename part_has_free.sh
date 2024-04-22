#!/usr/bin/bash

usageTxt="part_has_free.sh usage: 'partHasFree /dev/sdc3 \$((1*1024*1024*1024)) '"
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

