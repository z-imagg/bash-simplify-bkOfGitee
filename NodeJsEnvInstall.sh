#!/bin/bash

#【描述】  nodejs环境安装
#【用法举例】   
#    source /app/bash-simplify/NodeJsEnvInstall.sh && NodeJsEnvInstall 0.39.5   8.5.0  v16.14.2  && source  ~/.nvm_profile
#【术语】 
#【备注】  

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

source <(curl --location --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
_importBSFn "version_cmp_gt.sh"
_importBSFn "arg1EqNMsg.sh"
_importBSFn "argCntEq1.sh"
_importBSFn "argCntEq2.sh"
_importBSFn "git_Clone_SwitchTag.sh"

function _prepare_nvm(){
# 若函数参数不为1个 ， 则返回错误
argCntEq1 $* || return $?

local nvmVer=$1

local ErrMsg01_NvmVerLow="断言 nvm --version >= 0.39.3, 下面 才使用 加前缀写法， 更低版本的nvm不支持加前缀写法。 前缀"NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist""

version_cmp_gt $nvmVer  0.39.3   || echo $ErrMsg01_NvmVerLow
# 断言 nvm --version >= 0.39.3, 因此加 前缀"NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist"

#  克隆 https://github.com/nvm-sh/nvm.git 的标签 0.39.5 到 本地目录 /app/nvm/ 
git_Clone_SwitchTag https://gitclone.com/github.com/nvm-sh/nvm.git $nvmVer /app/nvm/ 

local NvmProfileF="~/.nvm_profile"
local Load_NvmProfileF="source ~/.nvm_profile"
local BashRcF="~/.bashrc"

#.bashrc 中是否已经加载 .nvm_profile
local BashRcHasNvmPrfF=false; grep $NvmProfileF ~/.bashrc && BashRcHasNvmPrfF=true

#加载 .nvm_profile到 .bashrc
$BashRcHasNvmPrfF || (echo "$Load_NvmProfileF" | tee -a $BashRcF)

#文件~/.bash_profile中新增以下内容:
echo '
#安装nvm
export NVM_DIR="/app/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

source /app/nvm/nvm.sh
#注意安装完nvm后， which nvm是没有的，因为nvm只是bash的一个函数而以，并不是一个linux可执行文件（这一点与windows nvm不同）
	
export NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node/
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node/
' | tee -a $NvmProfileF


## 使用nvm安装npm(v16.14.2)
# source  ~/.nvm_profile

}



function _install_node__by_nvm(){


# 若函数参数不为1个 ， 则返回错误
argCntEq1 $* || return $?


# nodeVer="v16.14.2"
local nodeVer=$2

## 使用nvm安装npm(v16.14.2)
source  ~/.nvm_profile

echo -n "显示当前LTS（长期支持版本）的nodejs版本(近期前50版本) ："
NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist nvm ls-remote  | grep LTS | tail -n 50 

# 断言 nvm --version >= 0.39.3, 因此加 前缀"NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist": 
NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist nvm ls-remote | grep $nodeVer #v16.14.2

NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist nvm install $nodeVer #v16.14.2

#切换默认npm为v16.14.2
nvm alias default $nodeVer #v16.14.2  #全局生效


##  npm设置国内镜像
npm config -g get registry
npm config -g set registry=https://registry.npmmirror.com 
#  https://registry.npm.taobao.org 貌似废了
#npm config -g get registry

source  ~/.nvm_profile
local npmVer="$(npm --version)"
local nodeVer_real="$(node --version)"
echo "已经安装nodejs. npmVer=$npmVer, nodeVer_real=$nodeVer_real"

}



function NodeJsEnvInstall() {
local ExitCode_Ok=0

# 若函数参数不为2个 ， 则返回错误
arg1EqNMsg $# 2 '命令语法" NodeJsEnvInstall nvmVer nodeVer" 命令举例" NodeJsEnvInstall 0.39.5 v16.14.2"' || return $?

# nvmVer="0.39.7"|"0.39.5"
local nvmVer=$1
# nodeVer="v16.14.2"
local nodeVer=$2


if which nvm || [ "$(nvm --version)" != "$nvmVer" ] ; then
  _install_nvm $nvmVer
else
  echo "已正确安装nvm【$nvmVer】 ,无需处理"
fi


if which node || [ "$(node --version)" != "$nodeVer" ]; then
  _install_node__by_nvm $nodeVer
else
  echo "已正确安装 npm【$npmVer】、node【$nodeVer】,无需处理"
fi


echo "执行以激活nodejs环境'source  ~/.nvm_profile'"

}


