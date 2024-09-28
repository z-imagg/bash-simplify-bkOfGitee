#!/bin/bash

#[用法举例] 
#  source /app/bash-simplify/nodejs_script/msys2_init_wrap.sh 
#[功能描述] 若是windows下的msys2环境,则测试是否安装miniconda3、msys2, 并用软连接抹平安装路径差异


source /app/bash-simplify/nodejs_script/util.sh
#提供函数 OsCheck, dos2unix_dir, msys2_unixStylePath_to_msWin, msys2_msWinStylePath_to_unix; 提供导出变量 powersh

which git 1>/dev/null 2>/dev/null || pacman -S --noconfirm unzip git

Err31=31
Err31Msg="错误代码${Err31},msys2环境不完整,请按照错误提示安装好环境再执行此脚本"

OsName=(uname --operating-system)
isOs_Msys=false ; [[ $OsName=="Msys" ]] && isOs_Msys=true

if [[ $isOs_Msys ]]; then 


bash /d/bash-simplify/nodejs_script/download_unpack_junction.sh

#当前在微软windows操作系统下,因不同操作系统的nodejs环境目录名相同,若不清空,则相互覆盖,结果不可预料. 但是  new_PrjNodejsEnv_by_nodeenv.sh 一进来就删除了 现有nodejs环境， 因此这里是多虑了.

 ( cd  /app/bash-simplify/nodejs_script &&  $powersh ./test-pack-install.ps1 && $powersh ./msys2_link_path.ps1 ;) || ( echo $Err31Msg ; exit $Err31 ;)  

fi
