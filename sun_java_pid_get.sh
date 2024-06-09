#!/bin/sh


#【描述】  以sun.java.command查找是否有sun_jvm进程 并返回进程pid
#【依赖】   
#【术语】 
#【备注】  
#【例子用法】  
#   source /app/keyboard-skill/sxhkd_xdotool_script/sun_java_pid_get.sh
# 查找是否有jetbrains_ide进程 若有则记下这些进程的pid
#  注意可能会有多个pid匹配，所以这只是例子。   
#   sun_jvm_process_find com.intellij.idea.Main && jetbrain_ide_pids=$(sun_jvm_process_find com.intellij.idea.Main) && echo "find_jetbrain_ide_pids=$jetbrain_ide_pids"
# 输出举例
#   4130
#   find_jetbrain_ide_pids=4130


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

export JAVA_HOME=/app/jdk8
export PATH=$JAVA_HOME/bin:$PATH
#which jcmd==/app/jdk8/bin/jcmd

#sun_jvm按照sun.java.command查找pid
function sun_jvm_pid__sun_java_command__contains_word(){
local word=$1
local pid=$2
jcmd $pid VM.system_properties 2>/dev/null | grep sun.java.command | grep $word  1>/dev/null 2>/dev/null
}
#函数单元测试
#/app/jdk17/bin/jshell #人工启动jshell
#jshell_pid_1=$(/app/jdk8/bin/jps  -l  | grep jdk.jshell | cut -d' ' -f 1|head -n 1)
#sun_jvm_pid__sun_java_command__contains_word jdk.jshell $jshell_pid_1


function sun_jvm_process_find(){
local jetbrains_ide_name=$1

local OK=0
local NO=1
local has=false

#匹配到的pid们
local -a fit_pid_arr=()

local pids=
# pidof java  可以替换 jps
mapfile -t pids < <(jps -q)

for pid_j in "${pids[@]}"; do
    sun_jvm_pid__sun_java_command__contains_word "$jetbrains_ide_name" "$pid_j" && \
    has=true && \
    fit_pid_arr+=("$pid_j")
done


$has && echo $fit_pid_arr && return $OK
return $NO
}
#函数单元测试
#sun_jvm_process_find jdk.jshell && echo find_jshell
##find_clion
#sun_jvm_process_find com.intellij.idea.Main && echo find_jetbrains_ide

#开发用语句:
# /app/jdk8/bin/jcmd  -l  #列出jvm进程 供给人工观看
# /app/jdk8/bin/jps  -q | while IFS= read -r pid_j ; do  echo -n "$pid_j:  " &&  /app/jdk8/bin/jcmd   $pid_j VM.system_properties  | grep -i sun.java.command; done
# 4130:  sun.java.command=com.intellij.idea.Main
# 12503:  sun.java.command=jdk.jshell.execution.RemoteExecutionControl 34013
# 14318:  java.io.IOException: 没有那个进程
# 12478:  sun.java.command=jdk.jshell/jdk.internal.jshell.tool.JShellToolProvider
