#!/bin/bash


msg_softlink_prj_dir="[提醒] 微软windows下新建项目 第一步是 将项目目录 软连接到 msys2 的正确路径, 比如 cmd.exe下执行 : 'd:\bin\junction.exe   d:\msys64\<你的项目路径 比如 \app2\ncre>   <当前项目目录在windows下的路径 比如e:\ncre>'"

Err31=31
Err31Msg="错误代码${Err31},msys2环境不完整,请按照错误提示安装好环境再执行此脚本"

OsName=(uname --operating-system)
isOs_Msys=false ; [[ $OsName=="Msys" ]] && isOs_Msys=true

if [[ $isOs_Msys ]]; then 

#打印提醒消息
echo $msg_softlink_prj_dir

bash /d/bash-simplify/nodejs_script/download_unpack_junction.sh

MsWinNoteMsg="[提醒]切换操作系统请 清空 nodejs项目环境(rm -fr  .node_env_v20.15.1 node_modules) 后 重建. 当前在微软windows操作系统下,因不同操作系统的nodejs环境目录名相同,若不清空,则相互覆盖,结果不可预料."

{ echo $MsWinNoteMsg; ( cd  /app/bash-simplify/nodejs_script &&  powershell ./test-pack-install.ps1 && powershell ./msys2_link_path.ps1 ;) || ( echo $Err31Msg ; exit $Err31 ;) ;}

fi


function msys2__nodejs_install() {
if [[ $isOs_Msys ]] ; then 

#微软win风格 文件路径 、 unix风格 文件路径互相转换
#$(cygpath   --unix  $fullPath_nodeenv_MsWinStyle)==fullPath_nodeenv
fullPath_nodeenv_MsWinStyle=$(cygpath   --windows  $fullPath_nodeenv)
# 微软windows的powershell下的 '-Verb RunAs' 能从普通权限脚本中弹出UAC窗口(要求admin权限) 从而该普通权限脚本中可以有若干行以admin权限执行 
#     -Wait 参数 迫使 该进程执行完才返回
PowerShell -Command "Start-Process $fullPath_nodeenv_MsWinStyle -ArgumentList '--mirror $_npmmirror_taobao --node $_NodeVer $_NodejsEnvName'  -Wait -Verb RunAs"
# 软连接: bin --> Scripts
$(cygpath --unix " d:\\bin\\junction.exe")  $(cygpath   --windows $_PrjNodeHome/bin)   $(cygpath   --windows $_PrjNodeHome/Scripts)

fi

}

export -f msys2__nodejs_install