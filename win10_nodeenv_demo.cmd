@REM @echo off
rem 此文件为utf8编码
chcp 65001

set condaHome=D:\miniconda3
set condaScripts=%condaHome%\Scripts
set Pip=%condaScripts%\pip.exe
set Nodeenv=%condaScripts%\nodeenv.exe

set _PrjHome=h:\ncre
set _NodeVer=22.2.0
set _NodejsEnvName=.node_env_MsWin_v%_NodeVer%
rem 例子 _PrjNodeHome == H:\ncre\.node_env_MsWin_v22.2.0
set _PrjNodeHome=%_PrjHome%\%_NodejsEnvName%
set _NodeBin=%_PrjNodeHome%\Scripts
set Node=%_NodeBin%\node.exe
set Npm=%_NodeBin%\npm.cmd
set Pnpm=%_NodeBin%\pnpm.cmd
set _prjNodeJsEnvActv_F=%_PrjHome%\PrjNodeJsEnvActivate.cmd

rem #清理现有环境, 目录形如 .node_env_MsWin_v22.2.0
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

REM 覆盖%_prjNodeJsEnvActv_F%中定义的PATH
set PATH=%condaHome%;%condaScripts%;%_PATH_init%
echo %PATH%

REM where pip
REM where nodeenv

%Pip% install nodeenv==1.9.1

cd /d %_PrjHome%

%Nodeenv%  --mirror https://registry.npmmirror.com/-/binary/node --node 22.2.0  %_NodejsEnvName%

REM  npm设置国内镜像
%Npm% config -g get registry
%Npm% config -g set registry=https://registry.npmmirror.com

REM 全局安装pnpm
%Npm% install -g pnpm

REM 全局安装 create-vite
%Pnpm% install -g create-vite




