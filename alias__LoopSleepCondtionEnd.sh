#!/bin/bash

#【描述】  while休眠循环条件退出 分段别名，免去繁琐的记忆
#【依赖】   
#【术语】 LpSpCndEd == LoopSleepConditionEnd
#【使用】
#加载语句:  source /app/bash-simplify/alias__LoopSleepCondtionEnd.sh
# 可以使用本文中的alias了，  举例如下
#   LpSpCndEd_Begin LpSpCndEd_BuszDemoContinue LpSpCndEd_IfContinueSleep LpSpCndEd_BuszDemoBreak LpSpCndEd_ElseIfBreak
#   注意 '{ ... ;}' 的样式是必须的, 否则语法错误
#   LpSpCndEd_Begin { pidof java && pidof python ;}  LpSpCndEd_IfContinueSleep { echo poweroff ;} LpSpCndEd_ElseIfBreak
#   如果 有进程java 且 有 进程python 则休眠2秒并继续循环， 否则 关机 并退出循环 ，  如果二者都不成立 则休眠5秒并继续循环

#bash允许alias展开
shopt -s expand_aliases


#【命令原型】
#原型:  
# 
# while true; do true;  { { ls /ContinueSleepCondition   && sleep 2 ;} || { ls /BreakCondition && break ;} ;} || sleep 5;  done
#  其中 'ls /ContinueSleepCondition >/dev/null' 为 continue业务指令.
#  其中 'ls /BreakCondition >/dev/null'         为 break业务指令.
#  当 continue业务指令 正常执行(返回代码为0)时, 休眠2秒并继续循环.
#  当 break业务指令    异常执行(范围代码非0)时, 循环退出.
#  当 两者都           异常执行            , 休眠5秒并继续循环.

alias LpSpCndEd_Begin='while true; do true;  { {     '
alias LpSpCndEd_IfContinueSleep=' && sleep 2 ;} || { '
alias LpSpCndEd_ElseIfBreak=' && break ;} ;} || sleep 5;  done '

alias LpSpCndEd_BuszDemoContinue='  ls /tmp >/dev/null    '
alias LpSpCndEd_BuszDemoBreak='  ls /FlagExit     '
