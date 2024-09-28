#!/bin/bash

#[描述] msys2 下 以UAC 调用nodeenv.exe 安装 项目的nodejs 环境
#[用法举例] 
#  source /app/bash-simplify/nodejs_script/msys2__nodejs_install__func.sh && 函数名msys2__nodejs_install
#[功能描述] 提供函数 msys2__nodejs_install


source /app/bash-simplify/nodejs_script/util.sh
#提供函数 OsCheck, dos2unix_dir, msys2_unixStylePath_to_msWin, msys2_msWinStylePath_to_unix; 提供导出变量 powersh


#msys2 安装项目nodejs环境
function msys2__nodejs_install() {
    
OsName=(uname --operating-system)
isOs_Msys=false ; [[ $OsName=="Msys" ]] && isOs_Msys=true


if [[ $isOs_Msys ]] ; then 

fullPath_nodeenv_MsWinStyle=$(msys2_unixStylePath_to_msWin  $fullPath_nodeenv)
# 微软windows的powershell下的 '-Verb RunAs' 能从普通权限脚本中弹出UAC窗口(要求admin权限) 从而该普通权限脚本中可以有若干行以admin权限执行 
#     -Wait 参数 迫使 该进程执行完才返回

#微软win下 以 UAC启动nodejs安装
$powersh -Command "Start-Process $fullPath_nodeenv_MsWinStyle -ArgumentList '--mirror $_npmmirror_taobao --node $_NodeVer $_NodejsEnvName'  -Wait -Verb RunAs"

# 软连接: bin --> Scripts
$(msys2_msWinStylePath_to_unix " d:\\bin\\junction.exe") -nobanner  $(msys2_unixStylePath_to_msWin $_PrjNodeHome/bin)   $(msys2_unixStylePath_to_msWin $_PrjNodeHome/Scripts)


fi

}

export -f msys2__nodejs_install