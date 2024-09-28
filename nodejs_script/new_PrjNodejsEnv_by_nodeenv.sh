
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

echo "[命令描述] 新建nodejs项目环境"

#_OpFlow的值只能用单引号包裹 以保持原样, 其被间接引用(2层引用)  ,若用双引号包裹 必须考虑展开时机 因而较复杂.
_OpFlow='[提醒] nodejs项目流程
ToolD=/app/bash-simplify/nodejs_script/
PrjD=/app2/ncre
nodejs项目流程:
新建nodejs项目环境                                             --> 激活nodejs项目环境                      --> 用nodejs项目模板填充此项目初始内容         --> 正常使用
bash $ToolD/new_PrjNodejsEnv_by_nodeenv.sh  $PrjD 20.15.1    --> bash $ToolD/create_vite_wrap.sh $PrjD   --> source  $PrjD/PrjNodeJsEnvActivate.sh   --> 正常执行yarn命令 
'
_Err15Code=15
_Err15Msg_OpFlow="$_OpFlow"

source /app/bash-simplify/nodejs_script/util.sh
#提供函数 OsCheck, dos2unix_dir, msys2_unixStylePath_to_msWin, msys2_msWinStylePath_to_unix, is_msWinStylePath
OsCheck #输出变量 OsName 、 isOs_Msys 、isLinux  、 isLinux_ubuntu


#若是windows下的msys2环境,则测试是否安装miniconda3、msys2, 并用软连接抹平安装路径差异
source /app/bash-simplify/nodejs_script/msys2_init_wrap.sh

#提供函数 msys2__nodejs_install 
source /app/bash-simplify/nodejs_script/msys2__nodejs_install__func.sh

source /app/bash-simplify/argCntEq2.sh

# git 提交、检出  都 不转换 换行符, 否则 在 微软windows、linux 之间切换 会导致 换行符 不一行
git config --global core.autocrlf false

#bash允许alias展开
shopt -s expand_aliases

#不用自带激活脚本,理由是若set -x会刷屏
# source /app/Miniconda3-py310_22.11.1-1/bin/activate 

# 激活conda_env 。 使用方法 :   $_CondaPy 替代 python 、   $_CondaPip 替代 pip 
source /app/bash-simplify/alias__condaEnvActivate.sh 1>/dev/null 2>/dev/null
alias Python=$_CondaPy
alias Pip=$_CondaPip

#安装nodeenv
# https://github.com/ekalinin/nodeenv.git
_nodeenv_ver="nodeenv==1.9.1"
Pip --quiet install $_nodeenv_ver
fullPath_nodeenv=$_CondaBin/nodeenv
alias Nodeenv=$fullPath_nodeenv
alias | grep Nodeenv 1>/dev/null 2>/dev/null #/app/Miniconda3-py310_22.11.1-1/bin/nodeenv
Nodeenv --version 1>/dev/null 2>/dev/null #1.9.1

#淘宝nodejs安装包下载镜像
_npmmirror_taobao=https://registry.npmmirror.com/-/binary/node

#用法文本
_usageTxt="[命令语法错误],正确语法为: 
new_PrjNodejsEnv_by_nodeenv.sh  /nodejs_prj_home  nodejs版本
以下通过nodeenv显示 nodejs版本 列表(后20行)..."

# 若函数参数不为2个 ， 则 打印nodejs版本列表 、打印用法 并 返回错误
argCntEq2 $* || {  exitCode=$?; echo "$_usageTxt";  Nodeenv --mirror $_npmmirror_taobao --list  2>&1  |tail -n 20 ;  exit $exitCode ;}

 _PrjHome=$1
# _PrjHome=/app2/ncre
 _NodeVer=$2
# _NodeVer=18.20.3

# 在linux下,不可能建立 微软windows风格路径 的项目路径
_Err41=41; _Err41Msg="Err${_Err41}, 在linux下,不可能建立 微软windows风格路径 的项目路径 ${_PrjHome}. 只有 在 win10下的msys2下 才能这样做."
( $isLinux  &&  is_msWinStylePath $_PrjHome ;) && { echo $_Err41Msg && exit $_Err41 ;}

# 必须存在目录 /app/bash-simplify
_bashSimplifyHome="/app/bash-simplify"
_Err42=42;
_Err42Msg="Err${_Err42} 工具目录 ${_bashSimplifyHome} 不存在
请在win10中cmd.exe下执行:(以修复此问题)
/app/mkdir d:\msys64\app
d:\bin\junction.exe d:\msys64\app\bash-simplify d:\bash-simplify"
#将 微软windows风格路径 对应到 msys2风格路径(/app2/目录名)
[[ ! -f "${_bashSimplifyHome}/.git/config" ]] && { echo $_Err42Msg && exit $_Err42 ;}

#将 微软windows风格路径 对应到 msys2风格路径(/app2/目录名)
$isOs_Msys &&  is_msWinStylePath $_PrjHome && \
_arg_PrjHome=$_PrjHome && \
_dirName=$(basename $(msys2_msWinStylePath_to_unix $_arg_PrjHome)) && \
_app2Home="/app2" && mkdir -p $_app2Home && \
_PrjHome="${_app2Home}/$_dirName" && \
_msg09="(微软win路径) ${_arg_PrjHome} 对应 (msys2路径) ${_PrjHome}" && \
{ ( [[ -f "${_PrjHome}/.git/config" ]] && echo "[现存项目] ${_msg09}" ;) || echo "[无项目] ${_msg09}"   ;}
#把 微软windows风格路径 对应到 msys2路径

#用到的一些变量
 _NodejsEnvName=.node_env_v$_NodeVer
_PrjNodeHome=$_PrjHome/$_NodejsEnvName
_node_modules=$_PrjHome/node_modules

_msg10="删除现有NodeJs项目环境 [$_PrjNodeHome]  [$_node_modules]:"
#清理现有环境, 目录只为当前指定版本
echo "${_msg10}"
rm -frv $_PrjNodeHome | wc -l 
#清理现有node_modules
rm -frv $_node_modules | wc -l

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
# 试淘宝镜像 
Nodeenv  --mirror $_npmmirror_taobao --node $_NodeVer $_NodejsEnvName 
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

OsName=(uname --operating-system)
isOs_Msys=false ; [[ \$OsName=="Msys" ]] && isOs_Msys=true

_PrjHome=$_PrjHome
_NodeVer=$_NodeVer
_NodeBin=$_NodeBin

_Err15Code=$_Err15Code
#注意用单引号包裹 以保持原样,若用双引号包裹 必须考虑展开时机 因而较复杂.
_Err15Msg_OpFlow='$_Err15Msg_OpFlow'

#若没有初始化 项目nodejs环境,则提醒完整操作流程
[[ ! -f \$_NodeBin/node ]] && echo  "\$_Err15Msg_OpFlow" && exit \$_Err15Code


#将 项目nodejs环境引入 当前shell
_PATH_init="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export PATH=\$_NodeBin:\$_PATH_init #A
yarnHomeGlobal=\$(yarn global bin) #B
\$isOs_Msys && yarnHomeGlobal=\$(cygpath.exe --unix \$yarnHomeGlobal )
export YARN_HOME_Global=\$yarnHomeGlobal
#A 、B 顺序不能变, A 设置PATH后才能找得到B中的命令yarn
export PATH=\$YARN_HOME_Global:\$PATH
export NODEJS_ORG_MIRROR=https://registry.npmmirror.com/-/binary/node
#export NVM_NODEJS_ORG_MIRROR=https://registry.npmmirror.com/-/binary/node

_Msg_NextOperation="提醒,下一步估计是:安装项目依赖 == cd $_PrjHome && yarn install"
echo \$_Msg_NextOperation
EOF


alias | grep  Npm #/app2/ncre/.node_env_v18.20.3/bin/npm
Npm --version #10.7.0

# NpmMirrorTaobaoOld=https://registry.npm.taobao.org/ #淘宝旧地址，已废弃
NpmMirrorTaobaoNew=https://registry.npmmirror.com/ #淘宝新地址

##  npm设置国内镜像
# npm config set registry $NpmMirrorTaobaoOld   #淘宝旧地址，已废弃
Npm config -g set registry $NpmMirrorTaobaoNew  #淘宝新地址
#npm config -g get registry

#全局安装yarn
# Npm install yarn # 局部安装会写入package.json(要检测该文件是否存在,麻烦), 因此不局部安装
Npm install -g yarn #J

#$_prjNodeJsEnvActv_F 将 新安装yarn进入PATH, 因此以下不再需要全路径命令
source $_prjNodeJsEnvActv_F 1>/dev/null 2>/dev/null #K
#J、K 顺序不能变. J全局安装了yarn后 , K才能用yarn
#全局家目录路径为 ~/.yarn/
echo  "yarn 全局家目录路径为 $YARN_HOME_Global"

yarn --silent config set network-timeout 20000 --global #超时时间设置为20秒  
# yarn config set registry $NpmMirrorTaobaoOld     #淘宝旧地址，已废弃
yarn --silent config set registry $NpmMirrorTaobaoNew
yarn --silent config set registry $NpmMirrorTaobaoNew  --global     #淘宝新地址
# yarn config set registry https://registry.yarnpkg.com   #yarn官方原始镜像
yarn --silent config get registry --global  
yarn --silent config list --global  
#查看yarn的全局bin目录
yarn --silent global bin
#win10x64 msys2 下  `yarn global bin` == 'C:\Users\z\AppData\Local\Yarn\bin'

yarn --silent config delete proxy --global  
yarn --silent config get proxy --global  

#全局安装 create-vite
yarn --silent global add  create-vite

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

echo  "新建项目nodejs环境成功, 项目[$_PrjHome], nodejs环境[$_NodeBin],  不改动[ package.json,package-lock.json], 已安装全局工具[yarn,create-vite]. 
$_OpFlow
"

