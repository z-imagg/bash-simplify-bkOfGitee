
#!/bin/bash

#【描述】  以nodeenv(1.9.1)新建nodejs项目
#【备注】    
#【依赖】   
#【术语】 
#【用法举例】 
#  新建项目 /app2/ncre , 并在项目目录下新建nodejs-v18.20.3环境
#   bash /app/bash-simplify/nodejs_script/new_nodejsPrj_by_nodeenv.sh   /app2/ncre    18.20.3
#                              new_nodejsPrj_by_nodeenv.sh  nodejs项目目录 nodejs版本


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常;  
set -e -u 


source /app/bash-simplify/argCntEq2.sh


#bash允许alias展开
shopt -s expand_aliases

#不用自带激活脚本,理由是若set -x会刷屏
# source /app/Miniconda3-py310_22.11.1-1/bin/activate 

# 激活conda_env 。 使用方法 :   $_CondaPy 替代 python 、   $_CondaPip 替代 pip 
source /app/bash-simplify/alias__condaEnvActivate.sh 1>/dev/null
alias Python=$_CondaPy
alias Pip=$_CondaPip

#安装nodeenv
# https://github.com/ekalinin/nodeenv.git
_nodeenv_ver="nodeenv==1.9.1"
Pip install $_nodeenv_ver
alias Nodeenv=$_CondaBin/nodeenv
alias | grep Nodeenv  #/app/Miniconda3-py310_22.11.1-1/bin/nodeenv
Nodeenv --version #1.9.1

#用法文本
_usageTxt="[usage] new_PrjNodejsEnv_by_nodeenv.sh  /nodejs_prj_home  nodejs_version"

# 若函数参数不为2个 ， 则 打印nodejs版本列表 、打印用法 并 返回错误
argCntEq2 $* || {  exitCode=$?; Nodeenv --list ; echo $_usageTxt;  exit $exitCode ;}

 _PrjHome=$1
# _PrjHome=/app2/ncre
 _NodeVer=$2
# _NodeVer=18.20.3

#用到的一些变量
 _NodejsEnvName=.node_env_v$_NodeVer
_PrjNodeHome=$_PrjHome/$_NodejsEnvName
_node_modules=$_PrjHome/node_modules

#清理现有环境, 目录只为当前指定版本
rm -fr $_PrjNodeHome
#清理现有node_modules
rm -fr $_node_modules

#若项目目录不存在，则新建
[[ ! -e $_PrjHome ]] && mkdir $_PrjHome 

#若项目目录非目录，则报错退出
_Err3=3 ; _Err3Msg="错误代码[$_Err3], PrjHome非目录[$_PrjHome]"
[[ ! -d $_PrjHome ]] && {  echo $_Err3Msg ; exit $_Err3 ;}

#写py依赖文件
_pyReqF=$_PrjHome/requirements.txt
( grep $_nodeenv_ver $_pyReqF 2>/dev/null ;) || echo $_nodeenv_ver | tee -a $_pyReqF

#进入项目目录
cd $_PrjHome

#安装的nodejs环境
#先尝试淘宝镜像 若失败 再不使用镜像
_npmmirror_taobao=https://registry.npmmirror.com/-/binary/node
Nodeenv  --mirror $_npmmirror_taobao --node $_NodeVer $_NodejsEnvName || \
{ rm -fr $_NodejsEnvName ; Nodeenv   --node $_NodeVer $_NodejsEnvName ;}
#淘宝镜像 新域名  https://registry.npmmirror.com/binary.html?path=node/v18.20.3/
#淘宝镜像 旧域名 已经废弃 https://npm.taobao.org/mirrors/node/ 

#不用自带激活脚本
# source .node_env_v18.20.3/bin/activate

#激活nodejs环境
# _PrjNodeHome=/app2/ncre/.node_env_v18.20.3
 _NodeBin=$_PrjNodeHome/bin
alias Node=$_NodeBin/node
alias Npm=$_NodeBin/npm
alias Pnpm=$_NodeBin/pnpm
alias | grep  Node #/app2/ncre/.node_env_v18.20.3/bin/node
Node --version #v18.20.3

#修改PATH是方便其他命令从PATH中检测到本node .     单纯使用node,并不需要修改PATH
_prjNodeJsEnvActv_F=$_PrjHome/PrjNodeJsEnvActivate.sh
cat  << EOF > $_prjNodeJsEnvActv_F
#!/bin/bash

_PATH_init="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export PNPM_HOME="$_PrjHome/.pnpm_home"
export PATH=$_NodeBin:\$PNPM_HOME:\$_PATH_init
export NODEJS_ORG_MIRROR=https://registry.npmmirror.com/-/binary/node
#export NVM_NODEJS_ORG_MIRROR=https://registry.npmmirror.com/-/binary/node
EOF
source $_prjNodeJsEnvActv_F

#清理现有环境,  目录名为 .pnpm_home
rm -fr $PNPM_HOME


alias | grep  Npm #/app2/ncre/.node_env_v18.20.3/bin/npm
Npm --version #10.7.0

##  npm设置国内镜像
Npm config -g get registry #https://registry.npmjs.org/
Npm config -g set registry=https://registry.npmmirror.com 
#  https://registry.npm.taobao.org 貌似废了
#npm config -g get registry

#全局安装pnpm
# Npm install pnpm # 局部安装会写入package.json(要检测该文件是否存在,麻烦), 因此不局部安装
Npm install -g pnpm
#pnpm setup #会生成 'export PNPM_HOME="/home/z/.local/share/pnpm"'

#全局安装 create-vite
Pnpm install -g create-vite

#填写.gitignore
_gitignore_F=$_PrjHome/.gitignore
rm -f $_gitignore_F
echo """
node_modules/
dist/
public/build/
.node_env_*/
.pnpm_home/
.idea/
""" | tee -a $_gitignore_F

echo  "新建项目nodejs环境成功, 项目[$_PrjHome], node环境[$_NodeBin],  不改动[node_modules; package.json,package-lock.json], 全局工具[pnpm,create-vite]" ; 

