@REM @echo off
rem 此文件为utf8编码
chcp 65001

set condaHome=D:\miniconda3
set condaScripts=%condaHome%\Scripts
set Pip=%condaScripts%\pip.exe
set Nodeenv=%condaScripts%\nodeenv.exe

set _PrjHome=h:\ncre_ts
set _NodeVer=20.15.1
set _NodejsEnvName=.node_env_MsWin_v%_NodeVer%
rem 例子 _PrjNodeHome == H:\ncre\.node_env_MsWin_v20.15.1
set _PrjNodeHome=%_PrjHome%\%_NodejsEnvName%
set _NodeBin=%_PrjNodeHome%\Scripts
set Node=%_NodeBin%\node.exe
set Npm=%_NodeBin%\npm.cmd
set Pnpm=%_NodeBin%\pnpm.cmd
set _prjNodeJsEnvActv_F=%_PrjHome%\PrjNodeJsEnvActivate.cmd

rem #清理现有环境, 目录形如 .node_env_MsWin_v20.15.1
del /q  /f /s  %_PrjNodeHome% 2>NUL 1>NUL

echo ^
set _PATH_init=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem^

set PNPM_HOME=%_PrjHome%\.pnpm_home^

set PATH=%%_NodeBin%%;%%PNPM_HOME%%;%%_PATH_init%%^

set NODEJS_ORG_MIRROR=https://registry.npmmirror.com/-/binary/node >  %_prjNodeJsEnvActv_F%

type %_prjNodeJsEnvActv_F%

REM 使用%_prjNodeJsEnvActv_F%中定义的变量们
call %_prjNodeJsEnvActv_F%
echo %PNPM_HOME%
echo %PATH%

%Pip% install nodeenv==1.9.1

cd /d %_PrjHome%

%Nodeenv%  --mirror https://registry.npmmirror.com/-/binary/node --node 20.15.1  %_NodejsEnvName%

REM  npm设置国内镜像
cmd /c %Npm% config -g get registry
cmd /c %Npm% config -g set registry=https://registry.npmmirror.com

REM 全局安装pnpm
cmd /c %Npm% install -g pnpm

REM 全局安装 create-vite
cmd /c %Pnpm% install -g create-vite




