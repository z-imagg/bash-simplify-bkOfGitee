#!/bin/bash

source /app/bash-simplify/nodejs_script/util.sh
#提供函数 OsCheck, dos2unix_dir, msys2_unixStylePath_to_msWin, msys2_msWinStylePath_to_unix

which git || pacman -S --noconfirm unzip git

export powersh=$(msys2_msWinStylePath_to_unix  "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe")


Err31=31
Err31Msg="错误代码${Err31},msys2环境不完整,请按照错误提示安装好环境再执行此脚本"

OsName=(uname --operating-system)
isOs_Msys=false ; [[ $OsName=="Msys" ]] && isOs_Msys=true

if [[ $isOs_Msys ]]; then 


bash /d/bash-simplify/nodejs_script/download_unpack_junction.sh

MsWinNoteMsg="[提醒]切换操作系统请 清空 nodejs项目环境(rm -fr  .node_env_v20.15.1 node_modules) 后 重建. 
  当前在微软windows操作系统下,因不同操作系统的nodejs环境目录名相同,若不清空,则相互覆盖,结果不可预料."

{ echo "$MsWinNoteMsg"; ( cd  /app/bash-simplify/nodejs_script &&  $powersh ./test-pack-install.ps1 && $powersh ./msys2_link_path.ps1 ;) || ( echo $Err31Msg ; exit $Err31 ;) ;}

fi


function msys2__nodejs_install() {
if [[ $isOs_Msys ]] ; then 

fullPath_nodeenv_MsWinStyle=$(msys2_unixStylePath_to_msWin  $fullPath_nodeenv)
# 微软windows的powershell下的 '-Verb RunAs' 能从普通权限脚本中弹出UAC窗口(要求admin权限) 从而该普通权限脚本中可以有若干行以admin权限执行 
#     -Wait 参数 迫使 该进程执行完才返回
$powersh -Command "Start-Process $fullPath_nodeenv_MsWinStyle -ArgumentList '--mirror $_npmmirror_taobao --node $_NodeVer $_NodejsEnvName'  -Wait -Verb RunAs"
# 软连接: bin --> Scripts
$(msys2_msWinStylePath_to_unix " d:\\bin\\junction.exe") -nobanner  $(msys2_unixStylePath_to_msWin $_PrjNodeHome/bin)   $(msys2_unixStylePath_to_msWin $_PrjNodeHome/Scripts)

fi

}

export -f msys2__nodejs_install