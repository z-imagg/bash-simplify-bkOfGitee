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
}

