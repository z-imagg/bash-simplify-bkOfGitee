#!/bin/bash

#【描述】  mkdiskimage命令包裹
#【依赖】   
#【术语】 
#【备注】  

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

source <(curl --location --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)

_importBSFn "ubuntu_version_check.sh"



#测试mkdiskimage 是否存在及正常运行
function _is_mkdiskimage_installed(){

#ubuntu版本检测
ubuntu_version_check || return $?

local OK_ExitCode=0
local Msg_1="已安装[mkdiskimage]"
local Msg_2="已安装[syslinux、syslinux-common、syslinux-efi]"
local Ok_Msg="$Msg_1 且 $Msg_2, 正常退出代码[$OK_ExitCode]"


#检测命令 mkdiskimage
mkdiskimage  __.img 10 8 32 2>/dev/null 1>/dev/null && \
echo $Msg_1 && \
#检测包 syslinux
dpkg -S syslinux 2>/dev/null 1>/dev/null  && \
#检测包 syslinux-common
dpkg -S syslinux-common 2>/dev/null 1>/dev/null && \
#检测包 syslinux-efi
dpkg -S syslinux-efi 2>/dev/null 1>/dev/null   && \
{ echo $OK_Msg ; return $OK_ExitCode ;}

#若无以上命令、包, 则执行安装
sudo apt install -y syslinux syslinux-common syslinux-efi syslinux-utils
}