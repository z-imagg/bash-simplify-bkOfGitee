#!/bin/bash

#【描述】  ubuntu版本检测
#【依赖】   
#【术语】 
#【备注】  

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

#此脚本不需要外部依赖
# source <(curl --location --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
# _importBSFn "xxx.sh"



#ubuntu版本检测
function ubuntu_version_check(){
local OK_ExitCode=0
local Ok_Msg="ubuntu版本检测正常, 正常退出代码[$OK_ExitCode]"

local Err_notUbuntu=1
local ErrMsg_notUbuntu="非ubuntu, 错误退出代码[$Err_notUbuntu]"

local Err_VerNotFit=2
local ErrMsg_VerNotFit="ubuntu版本不合适, 错误退出代码[$Err_VerNotFit]"

#是否为ubuntu
local UbuntuVerF="/etc/issue"
[[ -f $UbuntuVerF ]] || { echo $ErrMsg_notUbuntu; return $Err_notUbuntu ;}

#获取ubuntu版本
local ubuntu_version=$(cat $UbuntuVerF)

#检测ubuntu版本是否合适
local ubuntu_ver_22_04_4="Ubuntu 22.04.4 LTS \n \l"

[[ "$ubuntu_version" == "$ubuntu_ver_22_04_4" ]] && { echo $Ok_Msg ; return $OK_ExitCode ;}



}