@REM @echo off
@REM usage example: 
@REM d:\app\bash-simplify\win10_nodeenv_demo.cmd h:\ncre 20.15.1
@REM d:\app\bash-simplify\win10_nodeenv_demo.cmd h:\ncre_ts 20.15.1

rem 此文件为utf8编码
chcp 65001

echo arg1=%1
echo arg2=%2
IF "%~1"=="" GOTO EndLabel
IF "%~2"=="" GOTO EndLabel

@REM set _PrjHome=h:\ncre
set _PrjHome=%1
@REM set _NodeVer=20.15.1
set _NodeVer=%2

set condaHome=D:\miniconda3
set condaScripts=%condaHome%\Scripts
set Pip=%condaScripts%\pip.exe
set Nodeenv=%condaScripts%\nodeenv.exe

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
rd /s /q    %_NodejsEnvName%
rd /s /q    %_PrjHome%\node_modules  2>NUL 1>NUL

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

rem #清理现有环境, 目录形如 .pnpm_home
rd /s /q    %PNPM_HOME%  2>NUL 1>NUL

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


@REM echo "即将安装依赖、rollup编译、运行nwjs,ctrl+c可强制结束"
@REM pause
@REM pnpm install
@REM pnpm install -g typescript rollup svelte sirv-cli
@REM rollup --config rollup.config.js
@REM D:\app\nwjs-sdk-v0.89.0-win-x64\nw .\public\



:EndLabel
echo "endLabel"