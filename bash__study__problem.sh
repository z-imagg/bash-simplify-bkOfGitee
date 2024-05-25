#!/bin/bash

#【描述】  bash学习、问题记录
#【依赖】   
#【术语】 
#【备注】  


# '数值表达式n1 -eq 数值表达式n2'  、 '字符串s1 == 字符串s2' 
x=9; [[ $x == '9*2/2' ]] && echo eq  #not eq
x=9; [[ $x -eq '9*2/2' ]] && echo eq #eq
#bash问题1: [[ '任意字符串' -eq '任意字符串' ]] 正确的反应应该是报语法错误, 因为 eq是比较数值的，但是这条语句结果居然是true.
[[ "xx" -eq 'vv' ]] && echo ok #eq #这居然是相等的,服了
[ "xx" -eq 'vv' ] && echo ok #语法错误，这才是正确的反应


# [[ 条件1 && 条件2 && ( 条件3 || 条件4 ) ]]
[[ 9 -eq 3*3 && "a" == "a" ]] && echo eq #eq
[[ 9 -eq 3*3 && "a" == "a" && ( -d /tmp/ || -e /usr ) ]] && echo fit #eq

#[ 单条件 ]
[ -d /home ] && echo ok #ok
[ -d /home || -e /var ] && echo ok #语法错误