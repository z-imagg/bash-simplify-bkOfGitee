#!/bin/bash


######{此脚本调试步骤:
###{1. 干运行（置空ifelse）以 确定参数行是否都被短路:
#PS4='Line ${LINENO}: '    bash -x   ./build-libfmt.sh   #bash调试执行 且 显示 行号
#使用 ifelse空函数
function ifelse(){
    :
}
###}


###2. 当 确定参数行都被短路 时, 再 使用 真实 ifelse 函数:
#加载 func.sh中的函数 ifelse
# source /app_spy/bash-simplify/func.sh
######}


#当前脚本文件名, 此处 CurScriptF=example.sh
#CurScriptF=$0       #若此脚本没有切换到其他目录, 则可以不加pwd
CurScriptF=$(pwd)/$0 #若此脚本切换到其他目录，则必须加pwd

#此脚本的业务内容:
#升级git到2.x版本
#  ubuntu14.04 自带git版本为1.9, lazygit目前主流版本最低支持git2.0, 因此要升级git版本

function _is_git_2x(){
which git && \
curGitVer=`git --version` && \
[[ "$curGitVer" > "git version 2._" ]]
#ascii码表中 '0'>'_' 从而决定了 :  "git version 2.0" > "git version 2._"
}

function _install_git_2x(){
echo "git版本($curGitVer)过低,现在升级git" && \
sudo add-apt-repository --yes ppa:git-core/ppa && \
sudo apt-get update 1>/dev/null && \
 { sudo apt-cache show  git | grep Version ; } && \
#Version: 1:2.29.0-0ppa1~ubuntu14.04.1
sudo apt-get install -y git && \
git --version && \
#git version 2.29.0
sudo add-apt-repository --yes --remove ppa:git-core/ppa && \
curGitVer=`git --version` && \
echo "git版本升级完成,已升级到版本($curGitVer)" ; 

}


{ \
ifelse  $CurScriptF $LINENO || true || { \
  _is_git_2x
    "git版本无需升级,已为2.x:$curGitVer"
    : 
  #else:
    _install_git_2x
      "安装git2x完成" 
} \
} && \


# 使用 赋值样式 _="消息" 而不是 值样式 "消息", 原因是：
#    赋值样式 _="消息" 是一个合法的bash语句，  而  值样式 "消息" 不是合法bash语句

#这个写法的好处： 
#1. 简化了if-else
#2. 业务代码可读性高（业务代码不需要放进""中, 可以让IDE充分检查业务代码 ）


#解释:

#{ \   #业务代码块 开始
#ifelse  $CurScriptF $LINENO || true || { \ #固定写法,  本脚本52行的 ifelse调用 翻译出来  是 ifelse example.sh 52, 即 ifelse会读出文件example.sh的52行开始的6行并按以下if-else样式执行
#  cmdA1                       #if cmdA1执行正常:
#    "$msgCmdA1Good"           #   echo $msgCmdA1Good
#    cmdA2                     #   执行cmdA2
#  #else:                           #else: 即cmdA1执行异常
#    cmdB1                     #   if cmdB1执行正常:
#      "$msgCmdB1Good"         #      echo $msgCmdB1Good
#} \  #参数行结束
#} && \  #业务代码块结束