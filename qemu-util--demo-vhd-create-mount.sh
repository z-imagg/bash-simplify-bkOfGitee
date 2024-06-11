#!/bin/bash

#【描述】  qemu工具 创建、挂载 vhd磁盘镜像 例子 
#【依赖】   
#【术语】 
#【备注】  

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

source <(curl --location --silent http://giteaz:3000/util/bash-simplify/raw/tag/tag_release/_importBSFn.sh)

_importBSFn "ubuntu_version_check.sh"
_importBSFn "arg1EqNMsg.sh"
# 以 ‘trap...EXIT’ 指定 脚本退出时 执行 本exit_handler（ 打印调用栈、错误消息等） 
_importBSFn "bash_exit_handler.sh"


sudo apt install -y qemu-utils

#创建vhd虚拟磁盘
qemu-img create -f vpc    my_vhd.vhd  50M

ls -lh my_vhd.vhd

mkdir my_vhd_dir

#创建5个nbd设备
sudo modprobe nbd max_part=5
# /dev/nbd0 ... /dev/nbd4

#连接 该vhd虚拟磁盘 到 设备nbd0
sudo qemu-nbd --connect /dev/nbd0 my_vhd.vhd

#对该 虚拟磁盘 创建1个fat分区  , 该分区 为 设备 nbd0p1
sudo mkfs.fat /dev/nbd0
#/dev/nbd0p1

#卸载 分区
sudo umount my_vhd ; sudo umount /dev/nbd0p1

#挂载 分区
sudo mount /dev/nbd0p1 my_vhd_dir

#向该分区中写入一些文本文件
echo "abc123" | sudo tee my_vhd/note.txt
sudo mkdir  my_vhd/work/
echo "hello_world" | sudo tee my_vhd/work/log.txt
echo "000...999087777777777" | sudo tee my_vhd/work/output.txt
sudo rm -frv my_vhd/work

#卸载 分区
sudo umount my_vhd ; sudo umount /dev/nbd0p1

#断开 该vhd虚拟磁盘 和 设备nbd0
sudo qemu-nbd -disconnect /dev/nbd0
