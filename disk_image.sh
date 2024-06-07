#!/bin/bash

#【描述】  mkdiskimage命令包裹
#【依赖】   
#【术语】 
#【备注】  

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

source <(curl --location --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)

_importBSFn "ubuntu_version_check.sh"
_importBSFn "arg1EqNMsg.sh"
# 以 ‘trap...EXIT’ 指定 脚本退出时 执行 本exit_handler（ 打印调用栈、错误消息等） 
_importBSFn "bash_exit_handler.sh"


#测试mkdiskimage 是否存在及正常运行
function mkdiskimage_is_installed(){

#ubuntu版本检测
ubuntu_version_check || return $?

local Ok_ExitCode=0
local Msg_1="已安装[mkdiskimage]"
local Msg_2="已安装[syslinux、syslinux-common、syslinux-efi]"
local Ok_Msg="$Msg_1 且 $Msg_2, 正常退出代码[$Ok_ExitCode]"


#检测命令 mkdiskimage
mkdiskimage  __.img 10 8 32 2>/dev/null 1>/dev/null && \
echo $Msg_1 && \
#检测包 syslinux
dpkg -S syslinux 2>/dev/null 1>/dev/null  && \
#检测包 syslinux-common
dpkg -S syslinux-common 2>/dev/null 1>/dev/null && \
#检测包 syslinux-efi
dpkg -S syslinux-efi 2>/dev/null 1>/dev/null   && \
{ echo $Ok_Msg ; return $Ok_ExitCode ;}

#若无以上命令、包, 则执行安装
sudo apt install -y syslinux syslinux-common syslinux-efi syslinux-utils
}


#2. 制作磁盘映像、注意磁盘几何参数得符合bochs要求、仅1个fat16分区
function disk_image_mk(){

local OK_ExitCode=0
local Ok_Msg="磁盘镜像文件创建成功, 正常退出代码[$OK_ExitCode]"

local Err_9=1
local ErrMsg_9="mkdiskimage返回的Part1stByteIdx 不是预期值 $((32*512)), 请人工排查问题, 错误退出代码[$Err_9],"

local usage='[disk_image.sh][命令用法][制作磁盘映像文件] disk_image_mk HdImgF HdImg_C HdImg_H HdImg_S [命令举例][200C 16H 32S] disk_image_mk _a_hd.img 200 16 32'
# 断言参数个数为5个
arg1EqNMsg $# 5 \'$usage\' || return $?

#若参数个数不为4个 ，则返回错误
arg1EqNMsg $# 4  \'$usage\'  || return $?
#磁盘镜像文件路径
local HdImgF=$1
#磁盘镜像文件 cylind 柱面个数 (柱面==圆柱)
local HdImg_C=$2
#磁盘镜像文件 head 磁头个数
local HdImg_H=$3
#磁盘镜像文件 sectorPerTrack 每个圆环中的扇区个数 (圆环==磁道)
local HdImg_S=$4

#  Part1stByteIdx : Partition First Byte Offset : 分区的第一个字节偏移量 ： 相对于 磁盘映像文件hd.img的开头, hd.img内的唯一的分区的第一个字节偏移量

#Part1stByteIdx : PartitionFirstByteOffset: 分区第一个字节在hd.img磁盘映像文件中的位置
local Part1stByteIdx=$(mkdiskimage  -F  -o   $HdImgF $HdImg_C $HdImg_H $HdImg_S) && \
#  当只安装syslinux而没安装syslinux-common syslinux-efi时, mkdiskimage可以制作出磁盘映像文件，但 该 磁盘映像文件  的几何尺寸参数 并不是 给定的  参数 200C 16H 32S
#  所以 应该 同时安装了 syslinux syslinux-common syslinux-efi， "步骤1." 已有这样的检测了
# Part1stByteIdx == $((32*512)) == 16384 == 0X4000 == 32个扇区 == SectsPerTrk个扇区 == 1个Track

#测试 mkdiskimage返回的Part1stByteIdx是否为 '预期值 即 $((32*512)) 即 16384', 其中 32 是 HdImg_S
[ $Part1stByteIdx == $((HdImg_S*512)) ] ||  { rm -v $HdImgF && echo "$ErrMsg_9,Part1stByteIdx=$Part1stByteIdx" && exit $Err_9 ;}

echo "磁盘镜像文件创建成功 $HdImgF" && ls -lh $HdImgF && \
{ echo $Ok_Msg; return $OK_ExitCode ;}

}


#3. 断言 磁盘映像几何参数
#xxd -seek +0X1C3 -len 3 $HdImgF
#0X1C3:HdImg_H -1 : 0X0F:15:即16H:即16个磁头,  0X1C4: HdImg_S : 0X20:32:即32S:即每磁道有32个扇区, 0X1C3:HdImg_C -1 : 0XC7:199:即200C:即200个柱面

#0f20C7 即  用010editor打开 磁盘映像文件  偏移0X1C3到偏移0X1C3+2 的3个字节
 
function disk_image__check_hdimgF_geometry_param_HSC(){

local OK_ExitCode=0
local Ok_Msg="磁盘镜像文件参数符合, 正常退出代码[$OK_ExitCode]"

local usage='[disk_image.sh][命令用法][制作磁盘映像文件] disk_image__check_hdimgF_geometry_param_HSC HdImgF HdImg_C HdImg_H HdImg_S [命令举例][200C 16H 32S] disk_image__check_hdimgF_geometry_param_HSC hd.img 200 16 32'
#若参数个数不为4个 ，则返回错误
arg1EqNMsg $# 4  \'$usage\'  || return $?
#磁盘镜像文件路径
local HdImgF=$1
#磁盘镜像文件 cylind 柱面个数 (柱面==圆柱)
local HdImg_C=$2
#磁盘镜像文件 head 磁头个数
local HdImg_H=$3
#磁盘镜像文件 sectorPerTrack 每个圆环中的扇区个数 (圆环==磁道)
local HdImg_S=$4

#测试mkdiskimage 是否存在及正常运行
HdImg_C_sub1_hex=$( printf "%02x" $((HdImg_C-1)) ) && \
HdImg_H_hex=$(printf "%02x" $((HdImg_H-1)) ) && \
HdImg_S_hex=$(printf "%02x" $HdImg_S ) && \
_HSC_hex_calc="${HdImg_H_hex}${HdImg_S_hex}${HdImg_C_sub1_hex}" && \
_HSC_hex_xxdRdFromHdImgF="$(xxd -seek +0X1C3 -len 3  -plain  $HdImgF)" && \
test "$_HSC_hex_xxdRdFromHdImgF" == "${_HSC_hex_calc}"  && { echo $Ok_Msg; return $OK_ExitCode ;}
}



####