#!/bin/bash

#【描述】  制作磁盘镜像文件 
#         mkdiskimage命令包裹
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

#usage中用中文空格
local usage="[disk_image.sh][命令用法][制作磁盘映像文件]　disk_image_mk　HdImgF　HdImg_C　HdImg_H　HdImg_S　[命令举例][200C==200个圆柱面　16H==16个磁头　32S==单个环型磁道有32个扇区]　disk_image_mk　_a_hd.img　200　16　32"
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

echo "磁盘镜像文件创建成功 $HdImgF" && ls -lh $HdImgF && md5sum $HdImgF && \
{ echo $Ok_Msg; return $OK_ExitCode ;}

}


#3. 断言 磁盘映像几何参数
#xxd -seek +0X1C3 -len 3 $HdImgF
#0X1C3:HdImg_H -1 : 0X0F:15:即16H:即16个磁头,  0X1C4: HdImg_S : 0X20:32:即32S:即每磁道有32个扇区, 0X1C3:HdImg_C -1 : 0XC7:199:即200C:即200个柱面

#0f20C7 即  用010editor打开 磁盘映像文件  偏移0X1C3到偏移0X1C3+2 的3个字节
 
function disk_image__check_hdimgF_geometry_param_HSC(){

local OK_ExitCode=0
local Ok_Msg="磁盘镜像文件参数符合, 正常退出代码[$OK_ExitCode]"

#usage中用中文空格
local usage="[disk_image.sh][命令用法][制作磁盘映像文件]　disk_image__check_hdimgF_geometry_param_HSC　HdImgF　HdImg_C　HdImg_H　HdImg_S　[命令举例][200C==200个圆柱面　16H==16个磁头　32S==单个环型磁道有32个扇区]　disk_image__check_hdimgF_geometry_param_HSC　hd.img　200　16　32"
#若参数个数不为4个 ，则返回错误
arg1EqNMsg $# 4  $usage  || return $?
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


##工具函数 开始
function _hdImg_list_loopX(){
    sudo losetup   --raw   --associated  $HdImgF
}

#用losetup 找出上一行mount命令形成的链条中的 loopX
function _hdImg_list_loopX_f1(){
    #此函数的输出 要作为变量loopX的值 因此一定不能放开调试 即 不能加 'set -x'
    sudo losetup   --raw   --associated  $HdImgF | cut -d: -f1
}

function _hdImg_detach_all_loopX(){
    sudo losetup   --raw   --associated  $HdImgF | cut -d: -f1  |   xargs -I%  sudo losetup --detach %
}


function _hdImg_umount(){
    _hdImg_detach_all_loopX  && { { sudo umount $HdImgF ; sudo umount $hd_img_dir ;} || : ;}
}


function _hdImgDir_rm(){
    rm -frv $hd_img_dir ; mkdir $hd_img_dir
}
##工具函数 结束

function disk_image__mount(){

local OK_ExitCode=0
local Ok_Msg="磁盘镜像文件挂载正常, 正常退出代码[$OK_ExitCode]"

local Err_2=2
local ErrMsg_2="断言失败, 断言 必须只有一个 回环设备 指向 HdImgF, 错误退出代码[$Err_2],"


#usage中用中文空格
local usage="[disk_image.sh][命令用法][磁盘镜像文件挂载]{参数HdImg_S是为了确定变量Part1stByteIdx}　disk_image__mount　HdImgF　HdImg_S　[命令举例][32S==单个环型磁道有32个扇区]　disk_image__mount　/tmp/my_hd.img　32"
#若参数个数不为3个 ，则返回错误
arg1EqNMsg $# 3  $usage  || return $?
#磁盘镜像文件路径
local HdImgF=$1
#磁盘镜像文件 sectorPerTrack 每个圆环中的扇区个数 (圆环==磁道)
local HdImg_S=$2
#挂载目标目录
local hd_img_dir=$3

Part1stByteIdx=$((HdImg_S*512))
# Part1stByteIdx == $((32*512)) == 16384 == 0X4000 == 32个扇区 == SectsPerTrk个扇区 == 1个Track

#删除目标目录
_hdImgDir_rm

#卸载现有挂载
_hdImg_umount

#若目标目录不存在，则新建之
[[ ! -d $hd_img_dir ]] && mkdir -p $hd_img_dir

#mount形成链条:  $HdImgF --> /dev/loopX --> $hd_img_dir/
sudo mount --verbose --options loop,offset=$Part1stByteIdx $HdImgF $hd_img_dir && \

#用losetup 找出上一行mount命令形成的链条中的 loopX
loopX=$( _hdImg_list_loopX_f1 ) && \
#断言 必须只有一个 回环设备 指向 $HdImgF
{ { [ "X$loopX" != "X" ] &&  [ $(echo   $loopX | wc -l) == 1 ] ;} || { eval "${ErrMsg_2} HdImgF=$HdImgF" && return $Err_2  ;} ;}

#打印loopX
lsblk $loopX && { echo $Ok_Msg ; return $OK_ExitCode ;}
#  NAME  MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
#  loop1   7:1    0  50M  0 loop $hd_img_dir

}

#  制作磁盘镜像文件
# 用法举例:
#  导包方法1:
#source <(curl --location --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
#_importBSFn "disk_image.sh"
#  导包方法2:
#source /app/bash-simplify/disk_image.sh
#  调用:
#disk_image_mk  /tmp/my_hd.img 200 16 32
#  创建磁盘镜像文件my_hd.img  几何尺寸为 200C 16H 32S
#disk_image__mount  /tmp/my_hd.img 32 /tmp/my_hd_dir
#  挂载磁盘镜像到目录my_hd_dir, 挂载时 必须提供 几何参数 xxS 比如 32S==单个环型磁道有32个扇区 ,为了从xxS计算出变量Part1stByteIdx 
#     Part1stByteIdx==1号分区在磁盘镜像文件中的下标