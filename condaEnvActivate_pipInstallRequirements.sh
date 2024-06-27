#!/bin/bash

#【描述】  miniconda激活环境、pip安装项目目录下的requirements.txt依赖
#【依赖】   
#【术语】 
#【用法举例】  
#     source /app/bash-simplify/condaEnvActivate_pipInstallRequirements.sh
#     _condaEnvActivate_pipInstallRequirements  /app/Miniconda3-py310_22.11.1-1/  /fridaAnlzAp/analyze_by_graph/
#     一般构造以下命令, 作为后续使用, 比如 以 "$_CondaPy" 代替 "python"
# _CondaBin=$_CondaHome/bin
# _CondaPy=$_CondaBin/python

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常;  
set -e -u  

source /app/bash-simplify/argCntEq2.sh

# git切换到远程标签
#  核心命令举例 'git checkout -b linux-5.1.y --track origin/linux-5.1.y' 
function _condaEnvActivate_pipInstallRequirements() {
local localTmpBranch="tmp_branch_$(date +%s)"
local ExitCode_NoRemoteBranch=31

#  若函数参数不为2个 ， 则返回错误
argCntEq2 $* || return $?

# _CondaHome=/app/Miniconda3-py310_22.11.1-1
local _CondaHome=$1
# local _PrjHome=/fridaAnlzAp/analyze_by_graph/
local _PrjHome=$2

local _CondaBin=$_CondaHome/bin
local _CondaActv=$_CondaBin/activate
local _CondaPip=$_CondaBin/pip
local _CondaPy=$_CondaBin/python

#检测是否合法miniconda安装目录
local _Err1=1
local _Err1Txt="错误,无... _CondaBin=[${_CondaBin}],不是合法的miniconda安装目录, _CondaHome=[${_CondaHome}], 返回码=[${_Err1}]"
[[ -d $_CondaBin && -f $_CondaActv && -f $_CondaPip && -f $_CondaPy  ]] || { echo $_Err1Txt ; return $_Err1 ;}

#检测项目目录是否存在
local _Err2=2
local _Err2Txt="错误,项目目录不存在 _PrjHome=[${_PrjHome}],  返回码=[${_Err2}]"
[[ -d $_PrjHome   ]] || { echo $_Err2Txt ; return $_Err2 ;}

# 激活py环境(不再需要)
# source $_CondaActv ; 

#升级pip
$_CondaPy -m pip install --upgrade pip 1>/dev/null 
#pip清华镜像
$_CondaPip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple > /dev/null

local pip_reqF=$_PrjHome/requirements.txt
# 若存在requirements.txt, 则以pip安装之
[[ -f $pip_reqF ]] && $_CondaPip   install -r $_PrjHome/requirements.txt  1>/dev/null 

}




