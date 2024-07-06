set condaHome=D:\miniconda3
set condaScripts=%condaHome%\Scripts
set Pip=%condaScripts%\pip.exe
set Nodeenv=%condaScripts%\nodeenv.exe

set _PrjHome=h:\ncre
set _NodeBin=%_PrjHome%\.node_envMsWin_v22.2.0\Scripts
set Npm=%_NodeBin%\npm.cmd
set Node==%_NodeBin%\node
set Npm==%_NodeBin%\npm
set Pnpm==%_NodeBin%\pnpm
set _prjNodeJsEnvActv_F=%_PrjHome%\PrjNodeJsEnvActivate.bat

echo 
set _PATH_init=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem ^
set PNPM_HOME=%_PrjHome%\.pnpm_home" ^
set PATH=%_NodeBin%;^%PNPM_HOME^%:^%_PATH_init^% ^
set NODEJS_ORG_MIRROR=https://registry.npmmirror.com/-/binary/node >>  %_prjNodeJsEnvActv_F%

%_prjNodeJsEnvActv_F%

set PATH=%condaHome%;%condaScripts%;%_PATH_init%

REM where pip
REM where nodeenv

%Pip% install nodeenv==1.9.1

cd /d %_PrjHome%

%Nodeenv%  --mirror https://registry.npmmirror.com/-/binary/node --node 22.2.0  .node_envMsWin_v22.2.0

REM  npm设置国内镜像
%Npm% config -g get registry 
%Npm% config -g set registry=https://registry.npmmirror.com 

REM 全局安装pnpm
%Npm% install -g pnpm

REM 全局安装 create-vite
%Pnpm% install -g create-vite




