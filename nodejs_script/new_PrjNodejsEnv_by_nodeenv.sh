
#!/bin/bash

#【描述】  以nodeenv(1.9.1)新建nodejs项目
#【备注】  支持的执行环境: ubuntu22.04 、win10下的msys2
#【依赖】   
#【术语】 
#【用法举例】 
#  新建项目 /app2/ncre , 并在项目目录下新建nodejs-v18.20.3环境
#   bash /app/bash-simplify/nodejs_script/new_PrjNodejsEnv_by_nodeenv.sh   /app2/ncre    18.20.3
#                              new_PrjNodejsEnv_by_nodeenv.sh  nodejs项目目录 nodejs版本


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常;  
set -e -u 

#若是windows下的msys2环境,则测试是否安装miniconda3、msys2, 并用软连接抹平安装路径差异
source /app/bash-simplify/nodejs_script/msys2_init.sh

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
fullPath_nodeenv=$_CondaBin/nodeenv
alias Nodeenv=$fullPath_nodeenv
alias | grep Nodeenv  #/app/Miniconda3-py310_22.11.1-1/bin/nodeenv
Nodeenv --version #1.9.1

#淘宝nodejs安装包下载镜像
_npmmirror_taobao=https://registry.npmmirror.com/-/binary/node

#用法文本
_usageTxt="[错误] [usage] new_PrjNodejsEnv_by_nodeenv.sh  /nodejs_prj_home  nodejs_version; 以下通过nodeenv显示nodejs版本列表(后20行)..."

# 若函数参数不为2个 ， 则 打印nodejs版本列表 、打印用法 并 返回错误
argCntEq2 $* || {  exitCode=$?; echo $_usageTxt;  Nodeenv --mirror $_npmmirror_taobao --list  2>&1  |tail -n 20 ;  exit $exitCode ;}

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
msys2__nodejs_install
if [[ ! $isOs_Msys ]] ; then 
#先尝试淘宝镜像 若失败 再不使用镜像
Nodeenv  --mirror $_npmmirror_taobao --node $_NodeVer $_NodejsEnvName || \
{ rm -fr $_NodejsEnvName ; Nodeenv   --node $_NodeVer $_NodejsEnvName ;}
fi

#淘宝镜像 新域名  https://registry.npmmirror.com/binary.html?path=node/v18.20.3/
#淘宝镜像 旧域名 已经废弃 https://npm.taobao.org/mirrors/node/ 

#不用自带激活脚本
# source .node_env_v18.20.3/bin/activate

#激活nodejs环境
# _PrjNodeHome=/app2/ncre/.node_env_v18.20.3
 _NodeBin=$_PrjNodeHome/bin
alias Node=$_NodeBin/node
alias Npm=$_NodeBin/npm
alias Yarn=$_NodeBin/yarn
alias | grep  Node #/app2/ncre/.node_env_v18.20.3/bin/node
Node --version #v18.20.3

#修改PATH是方便其他命令从PATH中检测到本node .     单纯使用node,并不需要修改PATH
_prjNodeJsEnvActv_F=$_PrjHome/PrjNodeJsEnvActivate.sh
cat  << EOF > $_prjNodeJsEnvActv_F
#!/bin/bash

_PrjHome=$_PrjHome
_NodeVer=$_NodeVer
_NodeBin=$_NodeBin

OsName=(uname --operating-system)
msg_softlink_prj_dir="c:\Windows\System32\cmd.exe /c mklink  -Dst  $_PrjHome  -Src 当前项目目录在windows下的路径"
[[ \$OsName=="Msys" ]] && echo \$msg_softlink_prj_dir

_Err15Code=15
_Err15Msg_newPrjEnv="错误代码 \$_Err15Code,人工执行下一行命令 以 初始化nodejs项目环境 后 再执行 此脚本PrjNodeJsEnvActivate.sh: 
bash /app/bash-simplify/nodejs_script/new_PrjNodejsEnv_by_nodeenv.sh   \$_PrjHome    \$_NodeVer 
不在new_PrjEnv.sh 生成的Activ.sh 中 帮你调用 new_PrjEnv.sh 理由:
  new_PrjNodejsEnv_by_nodeenv.sh简称 new_PrjEnv.sh , PrjNodeJsEnvActivate.sh简称 Activ.sh. 
  new_PrjEnv.sh 中若调用 Activ.sh 则形成脚本调用环, 因 开发调试时 一般 已存在 Activ.sh , 则 该 Activ.sh 和 new_PrjEnv.sh 新写入的 Activ.sh 不一致 而形成脚本内容变化 , 则报错且该报错难以排查, 因此不在 new_PrjEnv.sh 中调用 Activ.sh "

#若没有初始化 项目nodejs环境,则提醒初始化并退出此脚本
[[ ! -f \$_NodeBin/node ]] && echo  "\$_Err15Msg_newPrjEnv" && exit \$_Err15Code
#echo \$_Err15Msg_newPrjEnv 会导致文本中换行不显示,用引号包裹写作 "\$_Err15Msg_newPrjEnv" 则 文本中换行显示


#将 项目nodejs环境引入 当前shell
_PATH_init="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export PATH=\$_NodeBin:\$_PATH_init
export YARN_HOME_Global="\$HOME/.yarn"
export PATH=\$_NodeBin:\$YARN_HOME_Global/bin:\$_PATH_init
export NODEJS_ORG_MIRROR=https://registry.npmmirror.com/-/binary/node
#export NVM_NODEJS_ORG_MIRROR=https://registry.npmmirror.com/-/binary/node

_Msg_NextOperation="提醒,下一步估计是:安装项目依赖 == cd $_PrjHome && yarn install"
echo \$_Msg_NextOperation
EOF
source $_prjNodeJsEnvActv_F

#全局家目录路径为 ~/.yarn/
echo  "yarn 全局家目录路径为 $YARN_HOME_Global"


alias | grep  Npm #/app2/ncre/.node_env_v18.20.3/bin/npm
Npm --version #10.7.0

# NpmMirrorTaobaoOld=https://registry.npm.taobao.org/ #淘宝旧地址，已废弃
NpmMirrorTaobaoNew=https://registry.npmmirror.com/ #淘宝新地址

##  npm设置国内镜像
# npm config set registry $NpmMirrorTaobaoOld   #淘宝旧地址，已废弃
Npm config -g set registry $NpmMirrorTaobaoNew  #淘宝新地址
#npm config -g get registry

#全局安装pnpm
# Npm install pnpm # 局部安装会写入package.json(要检测该文件是否存在,麻烦), 因此不局部安装
Npm install -g yarn

# yarn config set registry $NpmMirrorTaobaoOld     #淘宝旧地址，已废弃
yarn config set registry $NpmMirrorTaobaoNew  --global     #淘宝新地址
# yarn config set registry https://registry.yarnpkg.com   #yarn官方原始镜像
yarn config get registry --global  
yarn config list --global  

yarn config delete proxy --global  
yarn config get proxy --global  

#全局安装 create-vite
Yarn global add  create-vite

#填写.gitignore
_gitignore_F=$_PrjHome/.gitignore
rm -f $_gitignore_F
echo """
node_modules/
dist/
public/build/
.node_env_*/
.idea/
""" | tee -a $_gitignore_F

echo  "新建项目nodejs环境成功, 项目[$_PrjHome], node环境[$_NodeBin],  不改动[node_modules; package.json,package-lock.json], 全局工具[yarn,create-vite]. 
提醒, 后续步骤为:
步骤1. (若已填充项目,请跳过此步骤) 用nodejs项目模板填充此项目初始内容
  /app/bash-simplify/nodejs_script/create_vite_wrap.sh $_PrjHome
     项目初始内容 == 脚手架
步骤2. 激活此项目nodejs环境
  cd $_PrjHome && source PrjNodeJsEnvActivate.sh
"

