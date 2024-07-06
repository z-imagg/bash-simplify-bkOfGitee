#!/bin/bash

#【描述】  临时启用coredump, （崩溃时生成coredump文件 以 协助调查问题）
#【依赖】   
#【术语】 
#【用法举例】   必须要source执行 否则 ulimit不生效
#             source /app/bash-simplify/coredump_enable_tmp.sh
#             coredump_enable_tmp




#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

function coredump_enable_tmp()  {
#关闭崩溃报告传递服务apport
sudo systemctl stop apport
sudo systemctl disable apport || true

#临时允许coredump
ulimit -c unlimited

#临时写入core_pattern为 /tmp/core_当前目录名
local core_pattern_F=/proc/sys/kernel/core_pattern
#  前缀rootDir是为了防止 pwd==/
local cur_dir_name="$(basename /rootDir/$(pwd))"
local coredumpDir="/tmp/coredumpHome/${cur_dir_name}"
#  新建该目录
mkdir -p $coredumpDir
local core_pattern_txt="${coredumpDir}/core"
#  向 /proc/sys/kernel/core_pattern 写入 /tmp/coredumpHome/${cur_dir_name}/core
echo "$core_pattern_txt" | sudo tee $core_pattern_F 1>/dev/null
#  展示文件/proc/.../core_pattern当前内容
echo "${core_pattern_F}==$(cat $core_pattern_F)"
}

