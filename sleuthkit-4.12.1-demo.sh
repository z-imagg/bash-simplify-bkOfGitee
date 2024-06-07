#!/bin/bash

#【描述】 创建裸磁盘镜像文件、 sleuthkit-4.12.1 编译、以sleuthkit对磁盘镜像执行文件恢复
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


#背景:
#1. 插入一个真实u盘 /dev/sda,  
#2. 对其新建fat分区/dev/sda1 120MB,  
#3. 挂载该分区到目录 ~/sda1
#4. 在目录 ~/sda1 新建一些目录结构、写入一些文件，再将这些文件和目录 全部删除
#5. 卸载 目录 ~/sda1

#本文:
#5. 用dd备份 分区/dev/sda1 为裸磁盘镜像文件
sudo dd if=/dev/sda1 of=~/sda1.dd.bs4M bs=4M  status=progress

#6.1 编译 sleuthkit
cd /fridaAnlzAp/
wget https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-4.12.1/sleuthkit-4.12.1.tar.gz
tar -zxvf sleuthkit-4.12.1.tar.gz
bash ./configure && make -j4

#6.2. 此次编译的sleuthkit支持的 镜像文件格式 只有 裸格式. 那么如何调整编译配置以支持其他 磁盘镜像文件格式?
/fridaAnlzAp/sleuthkit-4.12.1/tools/autotools/tsk_recover -i list
# Supported image format types:
# 	raw (Single or split raw file (dd))

#6.3 sleuthkit-4.12.1支持的磁盘镜像文件格式
#https://gitee.com/repok/sleuthkit-4.12.1/blob/master/tools/autotools/tsk_recover.cpp
#https://gitee.com/repok/sleuthkit-4.12.1/blob/master/tsk/img/tsk_img.h
#sleuthkit-4.12.1支持的磁盘镜像文件格式: Raw(裸格式) AFF AFD AFM AFFLIB EWF VMDK VHD Pool Logical_directory
"""
//file name  tsk/img/tsk_img.h
    typedef enum {
        TSK_IMG_TYPE_DETECT = 0x0000,   ///< Use autodetection methods

        TSK_IMG_TYPE_RAW = 0x0001,      ///< Raw(裸格式) disk image (single or split)
        TSK_IMG_TYPE_RAW_SING = TSK_IMG_TYPE_RAW,       ///< Raw single (backward compatibility) depreciated
        TSK_IMG_TYPE_RAW_SPLIT = TSK_IMG_TYPE_RAW,      ///< Raw single (backward compatibility) depreciated

        TSK_IMG_TYPE_AFF_AFF = 0x0004,  ///< AFF AFF Format
        TSK_IMG_TYPE_AFF_AFD = 0x0008,  ///< AFD AFF Format
        TSK_IMG_TYPE_AFF_AFM = 0x0010,  ///< AFM AFF Format
        TSK_IMG_TYPE_AFF_ANY = 0x0020,  ///< Any format supported by AFFLIB (including beta ones)

        TSK_IMG_TYPE_EWF_EWF = 0x0040,   ///< EWF version
        TSK_IMG_TYPE_VMDK_VMDK = 0x0080, ///< VMDK version
        TSK_IMG_TYPE_VHD_VHD = 0x0100,   ///< VHD version
        TSK_IMG_TYPE_EXTERNAL = 0x1000,  ///< external defined format which at least implements TSK_IMG_INFO, used by pytsk
        TSK_IMG_TYPE_POOL = 0x4000,      ///< Pool
		TSK_IMG_TYPE_LOGICAL = 0x8000,       ///< Logical directory

        TSK_IMG_TYPE_UNSUPP = 0xffff   ///< Unsupported disk image type
    } TSK_IMG_TYPE_ENUM;
"""

#6.4 以sleuthkit查看 裸磁盘镜像文件
/fridaAnlzAp/sleuthkit-4.12.1/tools/autotools/tsk_imageinfo ~/sda1.dd.bs4M
# Encryption: None
# Encryption Type: None
# TSK Support: Yes


#8. 以sleuthkit恢复 该 为裸磁盘镜像文件
/fridaAnlzAp/sleuthkit-4.12.1/tools/autotools/tsk_recover ~/sda1.dd.bs4M  ~/sda1_bs4M_recover_dir
# Error writing file: /home/z/sda1_bs4M_recover_dir//$OrphanFiles/_OUTPU~1
# Error recovering deleted file (Invalid address in run (too large): 233430)  #这里有报错, 对照下一个例子, 猜测此报错是由于 当前的磁盘尺寸太小(才40MB)
# Files Recovered: 16

#9. sleuthkit 恢复文件 结果
cd   ~/sda1_bs4M_recover_dir; find . 
# .
# ./$OrphanFiles
# ./$OrphanFiles/BRAVEB~1.EXE
# ./$OrphanFiles/WINDOW~1.EXE
# ./$OrphanFiles/_OUTPU~1
# ./$OrphanFiles/_LECTR~1.ZIP
# ./$OrphanFiles/FIREFO~1.EXE
# ./$OrphanFiles/INDEXE~1
# ./$OrphanFiles/GITEXT~1.ZIP
# ./$OrphanFiles/CONTEX~1.EXE
# ./$OrphanFiles/_.TXT
# ./$OrphanFiles/WPSETT~1.DAT
# ./$OrphanFiles/NOTEPA~1.ZIP
# ./$OrphanFiles/config
# ./$OrphanFiles/GITEXT~1.MSI
# ./$OrphanFiles/SYSTEM~1
# ./$OrphanFiles/SYSTEM~1/IndexerVolumeGuid
# ./$OrphanFiles/GIT-24~1.EXE
# ./$OrphanFiles/VENTOY~1.TXT
# ./System Volume Information
# ./System Volume Information/IndexerVolumeGuid



#############重新做一个例子
#1. /dev/sda7 是一个u盘的某分区 ，分区格式为fat32, 尺寸为256MB, 被挂载到目录/media/z/256M
#2. 在该分区中 新建目录data、home、person ，并加入一些文件, 如下:
# ./data/LICENSE
# ./data/CMakeLists.txt
# ./home/include/Var
# ./home/include/Var/FnVst.h
# ./home/include/Var/VarAstCnsm.h
# ./home/include/Var/RangeHasMacroAstVst.h
# ./home/include/Var/CollectIncMacro_PPCb.h
# ./home/include/Var/VarDeclVst.h
# ./home/include/Var/Constant.h
# ./home/include/Var/RetVst.h
# ./person/截图 2024-06-07 14-59-07.png
#3. 删除该分区中全部文件
rm -frv /media/z/256M/{*,.*}
#4. 卸载该分区
sudo umount /dev/sda7
#4. 以dd命令备份该分区
sudo dd if=/dev/sda7 of=~/256M_diskImage.dd.bs4M status=progress
#5. sleuthkit查看镜像文件
/fridaAnlzAp/sleuthkit-4.12.1/tools/autotools/tsk_imageinfo ~/256M_diskImage.dd.bs4M
#6. sleuthkit恢复镜像中被删除的文件
/fridaAnlzAp/sleuthkit-4.12.1/tools/autotools/tsk_recover ~/256M_diskImage.dd.bs4M  ~/256M_diskImage.dd.bs4M.recover_dir
#Files Recovered: 11   #这一次没有报错
#7. 查看sleuthkit恢复的文件们
cd ~/256M_diskImage.dd.bs4M.recover_dir/; find . -type f
# ./data/_ICENSE   #注意此文件名的一部分是错误的
# ./data/CMakeLists.txt
# ./.Trash-1000
# ./.Trash-1000/info
# ./.Trash-1000/info/work.trashinfo.KKZ5O2
# ./home/include/Var
# ./home/include/Var/FnVst.h
# ./home/include/Var/VarAstCnsm.h
# ./home/include/Var/RangeHasMacroAstVst.h
# ./home/include/Var/CollectIncMacro_PPCb.h
# ./home/include/Var/VarDeclVst.h
# ./home/include/Var/Constant.h
# ./home/include/Var/RetVst.h
# ./person/截图 2024-06-07 14-59-07.png
