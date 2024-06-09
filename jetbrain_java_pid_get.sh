#!/bin/sh


#【描述】  查找是否有jetbrains系列ide的jvm进程 并返回进程pid
#【依赖】   
#【术语】 
#【备注】  
#【例子用法】  
#   source /app/keyboard-skill/sxhkd_xdotool_script/jetbrain_java_pid_get.sh
# 查找是否有clion进程 若有则记下clion进程的pid
#  注意可能会有多个pid匹配，所以这只是例子。  虽然jetbrains的clion 即使开多个窗口 依然只有一个jvm进程
#   jetbrains_ide_process_find clion && clion_pid=$(jetbrains_ide_process_find clion) && echo "find_clion,clion_pid=$clion_pid"
# 输出举例
#   4130
#   find_clion,clion_pid=4130


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

export JAVA_HOME=/app/jdk8
export PATH=$JAVA_HOME/bin:$PATH
#which jcmd==/app/jdk8/bin/jcmd

function jetbrains_jvm_pid_is_x(){
local jetbrains_ide_name=$1
#jetbrains_ide_name := [clion, idea, pycharm, ...]
local pid=$2
jcmd $pid VM.system_properties 2>/dev/null | grep jb.vmOptionsFile | grep  "${jetbrains_ide_name}64.vmoptions\|${jetbrains_ide_name}.vmoptions" 1>/dev/null 2>/dev/null
}
#函数单元测试
# jetbrains_jvm_pid_is_x clion $pid && echo find_clion
# jb.vmOptionsFile=/app/clion-2022.3.3/bin/clion64.vmoptions
# find_clion

function jetbrains_ide_process_find(){
local jetbrains_ide_name=$1
#jetbrains_ide_name := [clion, idea, pycharm, ...]

local OK=0
local NO=1
local has=false

#匹配到的pid们
local -a fit_pid_arr=()

local pids=
# pidof java  可以替换 jps
mapfile -t pids < <(jps -q)

for pid_j in "${pids[@]}"; do
    jetbrains_jvm_pid_is_x "$jetbrains_ide_name" "$pid_j" && \
    has=true && \
    fit_pid_arr+=("$pid_j")
done


$has && echo $fit_pid_arr && return $OK
return $NO
}
#函数单元测试
#jetbrains_ide_process_find clion && echo find_clion
##find_clion
#jetbrains_ide_process_find pycharm && echo find_pycharm

#开发用语句:
# /app/jdk8/bin/jcmd  -l  #列出jvm进程 供给人工观看
# /app/jdk8/bin/jps  -q | while IFS= read -r pid_j ; do  echo -n "$pid_j:  " &&  /app/jdk8/bin/jcmd   $pid_j VM.system_properties  | grep -i sun.java.command; done
# 4130:  sun.java.command=com.intellij.idea.Main
# 12503:  sun.java.command=jdk.jshell.execution.RemoteExecutionControl 34013
# 14318:  java.io.IOException: 没有那个进程
# 12478:  sun.java.command=jdk.jshell/jdk.internal.jshell.tool.JShellToolProvider
