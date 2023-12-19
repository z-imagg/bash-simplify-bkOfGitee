#!/usr/bin/env bash

source /bal/bash-simplify/dir_util.sh

#测试_get_arg:
#debug__get_arg=true; x=$(_get_arg example.sh 37 "true ||") ; echo $x
#_is_git_2x

function _get_arg(){
##若变量debug__get_arg为空，则设置其为false
# [ "x"  == "x$debug__get_arg"  ] && debug__get_arg=false

# $debug__get_arg && set -x  #若 调试本函数 则 set -x

scriptF=$1
lnK=$2
retF=$3
lnText=$(awk -v line="$lnK" 'NR==line' $scriptF)

_trimLn=$(echo "$lnText" | sed 's/^[[:space:]]*//')  #1. 用正则删除前导空格
argText=$(echo "$_trimLn" | awk '{sub(/&& \\/,"")}1')  #3.  在 禁用正则(-literal) 时  删除 后缀"&& \"

# argText=$(echo "$_trimLn" | sed 's/^ *true ||//')  #以上 '#2.' 写死 的样式

echo  -n "$argText" > $retF
#echo 不换行

# { $debug__get_arg  &&  set +x ;}  ; unset debug__get_arg  # { 若 调试本函数 则 set +x ;} ; 设置 变量debug__get_arg 为空

}

function ifelse(){
#此函数 即 ifelse 实现 如下伪码 ： 
#cmdA1ExitCode=cmdA1()
#if cmdA1ExitCode == 0: #cmdA1正常执行
#   echo $msgCmdA1Good
#   cmdA2()
#else: # 此else 即 cmdA1ExitCode != 0 即 cmdA1异常执行
#   if cmdB1():
#       echo $msgCmdB1Good
##############函数ifelseif伪码结束#################


##保存外部调用这是否 启用了 bash调试
#获取调用者 是否开启了 bash -x  即 是否开启 bash 调试
#返回变量 _out_en_dbg, _out_dbg
get_out_en_dbg && \
echo $_out_en_dbg
##{取参数这一段不显示命令
set +x && \

scriptF=$1
lnNum=$2

# debug__get_arg=true  #调试函数_get_arg
_x="/tmp/_get_arg__retF_"
_retF="${_x}$(date +%s%N)"
_get_arg $scriptF   $((lnNum+1))   $_retF  #忽略$3
cmdA1=$(cat $_retF)

# debug__get_arg=false #不再调试函数_get_arg

_retF="${_x}$(date +%s%N)"
_get_arg $scriptF   $((lnNum+2))   $_retF   #忽略$4
msgCmdA1Good=$(cat $_retF)

_retF="${_x}$(date +%s%N)"
_get_arg $scriptF   $((lnNum+3))   $_retF   #忽略$5
cmdA2=$(cat $_retF)

#$((lnNum+4)) , 跳过 第4行 ，因为第4行是 注释 #else:

_retF="${_x}$(date +%s%N)"
_get_arg $scriptF   $((lnNum+5))   $_retF   #忽略$6
cmdB1=$(cat $_retF)

_retF="${_x}$(date +%s%N)"
_get_arg $scriptF   $((lnNum+6))   $_retF   #忽略$7
msgCmdB1Good=$(cat $_retF)

[ "X$_ifelse_echo_args" != "X" ] &&  echo "cmdA1:$cmdA1, msgCmdA1Good:$msgCmdA1Good, cmdA2:$cmdA2, cmdB1:$cmdB1, msgCmdB1Good:$msgCmdB1Good"

##取参数这一段不显示命令}
##如果外部调用者启用了 bash调试, 则恢复调试
$_out_en_dbg && set -x && \

{ \
#执行 cmdA1
eval $cmdA1 &&  \
#则 先 显示 msgCmdA1Good 再 执行 cmdA2
{ eval "echo $msgCmdA1Good" ; eval $cmdA2  ;} \
; } ; if [ $? != 0 ]; then  \
#若 cmdA1.返回码 != 正常返回码0 :
{ \
#则 执行 cmdB1 并 显示 msgCmdB1Good
eval $cmdB1 &&   \
eval "echo $msgCmdB1Good" \
; }
fi

}