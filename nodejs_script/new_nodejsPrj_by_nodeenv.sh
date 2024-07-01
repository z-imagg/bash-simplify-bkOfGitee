
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


# 若函数参数不为2个 ， 则 打印nodejs版本列表 并 返回错误
argCntEq2 $* || {  exitCode=$?; Nodeenv --list ; return $exitCode ;}

 _PrjHome=$1
# _PrjHome=/app2/ncre
 _NodeVer=$2
# _NodeVer=18.20.3

#写py依赖文件
_pyReqF=$_PrjHome/requirements.txt
( grep $_nodeenv_ver $_pyReqF 2>/dev/null ;) || echo $_nodeenv_ver | tee -a $_pyReqF

#用到的一些变量
 _NodejsEnvName=.node_env_v$_NodeVer
_PrjNodeHome=$_PrjHome/$_NodejsEnvName
_node_modules=$_PrjHome/node_modules

#清理现有环境
rm -fr $_PrjNodeHome
rm -fr $_node_modules
rm -fr $_PrjHome/{package*,*.yaml}

#安装的nodejs环境
cd $_PrjHome
#没有设置镜像也能下载
Nodeenv  --node $_NodeVer $_NodejsEnvName
#设置淘宝镜像报ssl错
#$Nodeenv --without-ssl  --mirror https://npm.taobao.org/mirrors/node/ --node 18.20.3 .node_env_v18.20.3
#报错ssl:  urllib.error.URLError: <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: Hostname mismatch, certificate is not valid for 'npm.taobao.org'. (_ssl.c:997)>

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
export PNPM_HOME="$_PrjHome/.prj_pnpm_home"
export PATH=$_NodeBin:\$PNPM_HOME:\$_PATH_init
EOF
source $_prjNodeJsEnvActv_F


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
# Npm install pnpm
Npm install -g pnpm
#pnpm setup #会生成 'export PNPM_HOME="/home/z/.local/share/pnpm"'

Pnpm install -g create-vite

#填写.gitignore
_gitignore_F=$_PrjHome/.gitignore
rm -f $_gitignore_F
echo """
node_modules/
.node_env_*/
.prj_pnpm_home/
""" | tee -a $_gitignore_F

 _packageJsonF_Ls=$(ls $_PrjHome/package* 2>/dev/null)
echo  "新建nodejs项目[$_PrjHome]成功,项目node环境[$_NodeBin], node_modules[$_node_modules], package.json[$_packageJsonF_Ls], 工具[pnpm,create-vite]" ; 

