#!/bin/bash

#【描述】  while休眠循环条件退出 分段别名，免去繁琐的记忆
#【依赖】   
#【术语】 LpSpCndEd == LoopSleepConditionEnd
#【使用】
#加载语句:  source /app/bash-simplify/alias__LoopSleepCondtionEnd.sh
# 可以使用本文中的alias了，  举例如下
#   LpSpCndEd_Begin LpSpCndEd_BuszDemo1 LpSpCndEd_IfBreak
#   LpSpCndEd_Begin LpSpCndEd_BuszDemo2 LpSpCndEd_IfContinue
#   注意 '{ ... ;}' 的样式是必须的, 否则语法错误
#   LpSpCndEd_Begin { pidof java && pidof python ;}  LpSpCndEd_IfContinue
#   LpSpCndEd_Begin { ls /FlagExit ;}  LpSpCndEd_IfBreak

#bash允许alias展开
shopt -s expand_aliases



#【IfBreak的命令原型】
#原型:  while true; do true;  { { ls /ifHasThisFileThenExitLoop >/dev/null && break ;} || sleep 2 ;};  done
#  其中 'ls /ifHasThisFileThenExitLoop >/dev/null' 为 业务指令.
#  当业务指令正常执行(返回代码为0)时, 循环退出.
#  当业务指令异常执行(范围代码非0)时, 休眠2秒后继续循环.

alias LpSpCndEd_Begin='while true; do true;  { {     '
alias LpSpCndEd_IfBreak='&& break ;} || sleep 2 ;};  done'
alias LpSpCndEd_BuszDemo1='  ls /ifHasThisFileThenExitLoop >/dev/null  '


#【IfContinue的命令原型】
#原型:  while true; do true;  { { ls /ifHasThisFileThenContinueLoop >/dev/null && sleep 2 ;} || break ;};  done
#  其中 'ls /ifHasThisFileThenContinueLoop >/dev/null' 为 业务指令.
#  当业务指令正常执行(返回代码为0)时, 休眠2秒后继续循环.
#  当业务指令异常执行(范围代码非0)时, 循环退出.

alias LpSpCndEd_IfContinue='&& sleep 2 ;} || break ;};  done'
alias LpSpCndEd_BuszDemo2='  ls /ifHasThisFileThenContinueLoop >/dev/null  '