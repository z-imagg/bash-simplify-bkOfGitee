
#!/bin/bash

#【描述】  以nodeenv新建nodejs项目
#【备注】  bash 
#【依赖】   
#【术语】 
#【用法举例】 
# bash /app/bash-simplify/new_nodejsPrj_by_nodeenv.sh


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常;  
set -e -u 

#bash允许alias展开
shopt -s expand_aliases

source /app/bash-simplify/argCntEq2.sh

function new_nodejsPrj_by_nodeenv() {

#不用自带激活脚本,理由是若set -x会刷屏
# source /app/Miniconda3-py310_22.11.1-1/bin/activate 

# 激活conda_env 。 使用方法 :   $_CondaPy 替代 python 、   $_CondaPip 替代 pip 
source /app/bash-simplify/alias__condaEnvActivate.sh
alias Python=$_CondaPy
alias Pip=$_CondaPip

#安装nodeenv
# https://github.com/ekalinin/nodeenv.git
Pip install nodeenv
alias Nodeenv=$_CondaBin/nodeenv
alias | grep Nodeenv  #/app/Miniconda3-py310_22.11.1-1/bin/nodeenv
Nodeenv --version #1.9.1


# 若函数参数不为2个 ， 则 打印nodejs版本列表 并 返回错误
argCntEq2 $* || { local exitCode=$?; Nodeenv --list ; return $exitCode ;}

local PrjHome=$1
# PrjHome=/app2/ncre
local NodeVer=$2
# NodeVer=18.20.3



local PrjNodejsEnvName=.node_env_v$NodeVer
local _PrjNodeHome=$PrjHome/$PrjNodejsEnvName
local _node_modules=$PrjHome/node_modules

#清理现有环境
rm -fr $PrjNodejsEnvName
rm -fr $_node_modules

#安装的nodejs环境
cd $PrjHome
#没有设置镜像也能下载
Nodeenv  --node $NodeVer $PrjNodejsEnvName
#设置淘宝镜像报ssl错
#$Nodeenv --without-ssl  --mirror https://npm.taobao.org/mirrors/node/ --node 18.20.3 .node_env_v18.20.3
#报错ssl:  urllib.error.URLError: <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: Hostname mismatch, certificate is not valid for 'npm.taobao.org'. (_ssl.c:997)>

#不用自带激活脚本
# source .node_env_v18.20.3/bin/activate

#激活nodejs环境
# _PrjNodeHome=/app2/ncre/.node_env_v18.20.3
local _NodeBin=$_PrjNodeHome/bin
alias Node=$_NodeBin/node
alias Npm=$_NodeBin/npm
alias | grep  Node #/app2/ncre/.node_env_v18.20.3/bin/node
Node --version #v18.20.3

alias | grep  Npm #/app2/ncre/.node_env_v18.20.3/bin/npm
Npm --version #10.7.0

##  npm设置国内镜像
Npm config -g get registry #https://registry.npmjs.org/
Npm config -g set registry=https://registry.npmmirror.com 
#  https://registry.npm.taobao.org 貌似废了
#npm config -g get registry

#若遇到stylelint-config-prettier版本报错,
#  删除  package.json中的 "stylelint-config-prettier": "9.0.5",
#  或者 改为 npm install pnpm --legacy-peer-deps
Npm install pnpm

local _packageJsonF_Ls=$(ls $PrjHome/package*)
echo  "新建nodejs项目[$PrjHome]成功,项目node环境[$_NodeBin], node_modules[$_node_modules], package.json[$_packageJsonF_Ls]" ; 


}