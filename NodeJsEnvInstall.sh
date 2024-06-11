#!/bin/bash

#【描述】  nodejs环境安装
#【用法举例】   
#  用法1
#    source /app/bash-simplify/NodeJsEnvInstall.sh && NodeJsEnvInstall v0.39.5  v16.14.2  && source  ~/.nvm_profile
#  用法2
#   source /app/bash-simplify/_importBSFn.sh #or:#  source <(curl --location --silent http://giteaz:3000/util/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
#   _importBSFn "NodeJsEnvInstall.sh" 
#   NodeJsEnvInstall v0.39.5 v18.19.1
#【术语】 
#【备注】  

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

source <(curl --location --silent http://giteaz:3000/util/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
_importBSFn "version_cmp_gt.sh"
_importBSFn "arg1EqNMsg.sh"
_importBSFn "argCntEq1.sh"
_importBSFn "argCntEq2.sh"
_importBSFn "git_Clone_SwitchTag.sh"

# 以 ‘trap...EXIT’ 指定 脚本退出时 执行 本exit_handler（ 打印调用栈、错误消息等） 
_importBSFn "bash_exit_handler.sh"

function _prepare_nvm(){
# 若函数参数不为1个 ， 则返回错误
argCntEq1 $* || return $?

local nvmVer=$1

local ErrMsg01_NvmVerLow="断言 nvm --version >= 0.39.3, 下面 才使用 加前缀写法， 更低版本的nvm不支持加前缀写法。 前缀"NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist""

version_cmp_gt $nvmVer  0.39.3   || echo $ErrMsg01_NvmVerLow
# 断言 nvm --version >= 0.39.3, 因此加 前缀"NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist"

#  克隆 https://github.com/nvm-sh/nvm.git 的标签 v0.39.5 到 本地目录 /app/nvm/ 
git_Clone_SwitchTag https://gitclone.com/github.com/nvm-sh/nvm.git $nvmVer /app/nvm/ 

local NvmProfileF="$HOME/.nvm_profile"
local Load_NvmProfileF="source $HOME/.nvm_profile"
local BashRcF="$HOME/.bashrc"

#.bashrc 中是否已经加载 .nvm_profile
local BashRcHasNvmPrfF=false; grep $NvmProfileF $BashRcF && BashRcHasNvmPrfF=true

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
' | tee -a $NvmProfileF >/dev/null


## 使用nvm安装npm(v16.14.2)
# source  ~/.nvm_profile

}



function _install_node__by_nvm(){


# 若函数参数不为1个 ， 则返回错误
argCntEq1 $* || return $?


# nodeVer="v16.14.2"
local nodeVer=$1

## 使用nvm安装npm(v16.14.2)
source  ~/.nvm_profile

echo  "显示当前LTS（长期支持版本）的nodejs版本(近期前50版本) ："

#暂时禁止'set -e -u' ， 理由是 当 'set -e -u'时  脚本/app/nvm/nvm.sh 的 nvm ls-remote会以使用了未定义变量的错误'bash: PATTERN: unbound variable'而异常退出  
#        '-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set +e +u

echo "根据实际情况，哪个下载快用哪个. NVM_NODEJS_ORG_MIRROR=https://mirrors.ustc.edu.cn/node/ , NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist"

NVM_NODEJS_ORG_MIRROR=https://mirrors.ustc.edu.cn/node/ nvm ls-remote  | grep LTS | tail -n 50 

# 断言 nvm --version >= 0.39.3, 因此加 前缀"NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist": 
NVM_NODEJS_ORG_MIRROR=https://mirrors.ustc.edu.cn/node/ nvm ls-remote | grep $nodeVer #v16.14.2

NVM_NODEJS_ORG_MIRROR=https://mirrors.ustc.edu.cn/node/ nvm install $nodeVer #v16.14.2

#切换默认npm为v16.14.2
nvm alias default $nodeVer #v16.14.2  #全局生效


##  npm设置国内镜像
npm config -g get registry
npm config -g set registry=https://registry.npmmirror.com 
#  https://registry.npm.taobao.org 貌似废了
#npm config -g get registry

local npmVer="$(npm --version)"
local nodeVer_real="$(node --version)"
echo "已经安装nodejs. npmVer=$npmVer, nodeVer_real=$nodeVer_real"

#恢复'set -e -u'
#        '-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set +e +u

}



function NodeJsEnvInstall() {
local ExitCode_Ok=0

# 若函数参数不为2个 ， 则返回错误
arg1EqNMsg $# 2 '命令语法" NodeJsEnvInstall nvmVer nodeVer" 命令举例" NodeJsEnvInstall v0.39.5 v16.14.2"' || return $?

# nvmVer="0.39.7"|"v0.39.5"
local nvmVer=$1
# nodeVer="v16.14.2"
local nodeVer=$2

#是否需要安装nvm
local toInstlNvm=true;  which nvm &&  [ "$(nvm --version)" == "$nvmVer" ] &&  toInstlNvm=false

$toInstlNvm && _prepare_nvm $nvmVer
$toInstlNvm ||   echo "已正确安装nvm【$nvmVer】 ,无需处理"

#是否需要安装nodejs
local toInstlNodejs=true;  which node &&  [ "$(node --version)" == "$nodeVer" ] &&  toInstlNodejs=false

$toInstlNodejs && _install_node__by_nvm $nodeVer


local npmVer="$(npm --version)"
local nodeVer_real="$(node --version)"
$toInstlNodejs ||   echo "已正确安装 npm【$npmVer】、nodeVer_real【$nodeVer_real】,无需处理"


echo "执行以激活nodejs环境'source  ~/.nvm_profile'"

}


