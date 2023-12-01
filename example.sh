#!/bin/bash

source func.sh
CurScriptF=$0

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

ifelse  $CurScriptF $LINENO
  true || _is_git_2x && \
    true || "git版本无需升级,已为2.x:$curGitVer" && \
    true || : && \
  #else:
    true || _install_git_2x && \
      true || "" && \


#这个写法的好处： 
#1. 简化了if-else
#2. 业务代码可读性高（业务代码不需要放进""中, 可以让IDE充分检查业务代码 ）


#解释:
#ifelse  $CurScriptF $LINENO                #固定写法,  本脚本31行的 ifelse调用 翻译出来 意思是 ifelse example.sh 31, 即 ifelse会将文件example.sh的31行开始的6行作为5个参数（其中第4行'#else:'是注释，忽略了）
#  true || cmdA1 && \                       #if cmdA1执行正常:
#    true || "$msgCmdA1Good" && \           #   echo $msgCmdA1Good
#    true || cmdA2 && \                     #   执行cmdA2
#  #else:                                   #else: 即cmdA1执行异常
#    true || cmdB1 && \                     #   if cmdB1执行正常:
#      true || "$msgCmdB1Good" && \         #      echo $msgCmdB1Good
