#!/bin/sh


#【描述】  使用 '给定源码目录，用sqlite3进行 按文件扩展名分组统计'
#【依赖】   
#【术语】 
#【备注】  
#【例子用法】  

# https://codeload.github.com/postgres/postgres/zip/refs/tags/release-6-3
# https://codeload.github.com/FirebirdSQL/firebird/zip/refs/tags/v5.0.0
# https://codeload.github.com/sqlite/sqlite/zip/refs/tags/vesion-3.45.1
# https://codeload.github.com/FreeCAD/FreeCAD-library/zip/refs/heads/master
# https://codeload.github.com/FreeCAD/FreeCAD/zip/refs/tags/0.21.2
# https://codeload.github.com/chenshuo/old-minix/zip/refs/tags/v2.0.4
# https://codeload.github.com/mirror/vbox/zip/refs/heads/master
# https://codeload.github.com/git/git/zip/refs/tags/v2.45.2
# https://codeload.github.com/tensorflow/tensorflow/zip/refs/tags/v2.15.0
# https://codeload.github.com/pytorch/pytorch/zip/refs/tags/v2.3.0
# https://codeload.github.com/openjdk/jdk/zip/refs/tags/jdk8-b120
# https://codeload.github.com/Open-Cascade-SAS/OCCT/zip/refs/tags/V7_8_1

source /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/main.sh

cd /d2/

# grpCnt_fileExtendName_BySqlite3 Open-Cascade-SAS--OCCT-7_8_1
# grpCnt_fileExtendName_BySqlite3 firebird-5.0.0
# grpCnt_fileExtendName_BySqlite3 FreeCAD-0.21.2
# grpCnt_fileExtendName_BySqlite3 FreeCAD-library-master
# grpCnt_fileExtendName_BySqlite3 git-2.45.2
# grpCnt_fileExtendName_BySqlite3 LLVM-llvmorg-15.0.0
# grpCnt_fileExtendName_BySqlite3 old-minix-2.0.4
# grpCnt_fileExtendName_BySqlite3 openjdk-jdk8-b120
# grpCnt_fileExtendName_BySqlite3 postgres-release-6-3
# grpCnt_fileExtendName_BySqlite3 pytorch-2.3.0
# grpCnt_fileExtendName_BySqlite3 sqlite-vesion-3.45.1
# grpCnt_fileExtendName_BySqlite3 tensorflow-2.15.0
# grpCnt_fileExtendName_BySqlite3 vbox-master

#################


#生物信息
# wget https://github.com/bioSyntax/bioSyntax/archive/refs/tags/v1.0.0.zip
# bioSyntax-1.0.0.zip
# unzip  bioSyntax-1.0.0.zip -d .
# grpCnt_fileExtendName_BySqlite3 bioSyntax-1.0.0

# wget https://github.com/bionode/bionode/archive/refs/tags/1.0.1.zip
# bionode-1.0.1.zip
# unzip  bionode-1.0.1.zip -d .
# grpCnt_fileExtendName_BySqlite3 bionode-1.0.1

# wget https://github.com/rust-bio/rust-bio/archive/refs/tags/v1.6.0.zip
# rust-bio-1.6.0.zip
# unzip    rust-bio-1.6.0.zip  -d .
# grpCnt_fileExtendName_BySqlite3 rust-bio-1.6.0

# wget https://github.com/biopython/biopython/archive/refs/tags/biopython-183.zip
# biopython-biopython-183.zip
# unzip biopython-biopython-183.zip -d .
# grpCnt_fileExtendName_BySqlite3 biopython-biopython-183

# wget https://github.com/seqan/seqan3/archive/refs/tags/3.3.0.zip
# seqan3-3.3.0.zip
# unzip seqan3-3.3.0.zip -d .
# grpCnt_fileExtendName_BySqlite3 seqan3-3.3.0

#web服务器
# wget https://github.com/nginx/nginx/archive/refs/tags/release-1.27.0.zip
# nginx-release-1.27.0.zip
# unzip nginx-release-1.27.0.zip -d .
# grpCnt_fileExtendName_BySqlite3 nginx-release-1.27.0

#数据库
# wget https://github.com/ClickHouse/ClickHouse/archive/refs/tags/v24.5.1.1763-stable.zip
# ClickHouse-24.5.1.1763-stable.zip
# unzip ClickHouse-24.5.1.1763-stable.zip -d .
# grpCnt_fileExtendName_BySqlite3 ClickHouse-24.5.1.1763-stable

# wget https://github.com/mysql/mysql-server/archive/refs/tags/mysql-cluster-8.4.0.zip
# mysql-server-mysql-cluster-8.4.0.zip
# unzip mysql-server-mysql-cluster-8.4.0.zip -d .
# grpCnt_fileExtendName_BySqlite3 mysql-server-mysql-cluster-8.4.0
# wget https://github.com/mysql/mysql-server/archive/refs/tags/mysql-5.7.44.zip
# mysql-server-mysql-5.7.44.zip
# unzip mysql-server-mysql-5.7.44.zip -d .
# grpCnt_fileExtendName_BySqlite3 mysql-server-mysql-5.7.44

# wget https://github.com/MariaDB/server/archive/refs/tags/mariadb-10.9.8.zip
# server-mariadb-10.9.8.zip
# unzip server-mariadb-10.9.8.zip -d .
# grpCnt_fileExtendName_BySqlite3 server-mariadb-10.9.8

#执行切面
# wget https://github.com/frida/frida/archive/refs/tags/16.3.3.zip
# frida-16.3.3.zip
# unzip frida-16.3.3.zip -d .
# grpCnt_fileExtendName_BySqlite3 frida-16.3.3
# wget https://github.com/frida/frida-core/archive/refs/tags/16.3.3.zip
# frida-core-16.3.3.zip
# unzip frida-core-16.3.3.zip -d .
# grpCnt_fileExtendName_BySqlite3 frida-core-16.3.3
# wget https://github.com/frida/frida-gum/archive/refs/tags/16.3.3.zip
# frida-gum-16.3.3.zip
# unzip frida-gum-16.3.3.zip -d .
# grpCnt_fileExtendName_BySqlite3 frida-gum-16.3.3
# wget https://github.com/frida/frida-python/archive/refs/tags/16.3.3.zip
# frida-python-16.3.3.zip
# unzip frida-python-16.3.3.zip -d .
# grpCnt_fileExtendName_BySqlite3 frida-python-16.3.3
# wget https://github.com/frida/frida-node/archive/refs/tags/16.3.3.zip
# frida-node-16.3.3.zip
# unzip frida-node-16.3.3.zip -d .
# grpCnt_fileExtendName_BySqlite3 frida-node-16.3.3
# wget https://github.com/frida/frida-swift/archive/refs/tags/16.3.3.zip
# frida-swift-16.3.3.zip
# unzip frida-swift-16.3.3.zip -d .
# grpCnt_fileExtendName_BySqlite3 frida-swift-16.3.3

#化学
# wget https://github.com/Mariewelt/OpenChem/archive/refs/heads/master.zip
# OpenChem-master.zip
# unzip OpenChem-master.zip -d .
# grpCnt_fileExtendName_BySqlite3 OpenChem-master

#分子动力学模拟
# wget https://github.com/gromacs/gromacs/archive/refs/tags/v2024.2.zip
# gromacs-2024.2.zip
# unzip gromacs-2024.2.zip -d .
# grpCnt_fileExtendName_BySqlite3 gromacs-2024.2

# wget https://github.com/openmm/openmm/archive/refs/tags/8.1.1.zip
# openmm-8.1.1.zip
# unzip openmm-8.1.1.zip -d .
grpCnt_fileExtendName_BySqlite3 openmm-8.1.1

# https://ambermd.org/GetAmber.php
# wget https://ambermd.org/cgi-bin/AmberTools24-get.pl
# AmberTools24.tar.bz2
# tar -xjf AmberTools24.tar.bz2 -C .
grpCnt_fileExtendName_BySqlite3 amber24_src

# wget https://github.com/lammps/lammps/archive/refs/tags/stable_31Mar2017.zip
# lammps-stable_31Mar2017.zip
# unzip lammps-stable_31Mar2017.zip -d .
grpCnt_fileExtendName_BySqlite3 lammps-stable_31Mar2017

# wget https://github.com/nwchemgit/nwchem/archive/refs/tags/v7.2.2-release.zip
# nwchem-7.2.2-release.zip
# unzip nwchem-7.2.2-release.zip -d .
grpCnt_fileExtendName_BySqlite3 nwchem-7.2.2-release

# wget https://github.com/psi4/psi4/archive/refs/tags/v1.9.1.zip
# psi4-1.9.1.zip
# unzip psi4-1.9.1.zip -d .
grpCnt_fileExtendName_BySqlite3 psi4-1.9.1

# wget https://github.com/cp2k/cp2k/archive/refs/tags/v2024.1.zip
# cp2k-2024.1.zip
# unzip cp2k-2024.1.zip -d .
grpCnt_fileExtendName_BySqlite3 cp2k-2024.1

# wget https://github.com/openmopac/mopac/archive/refs/tags/v22.1.1.zip
# mopac-22.1.1.zip
# unzip mopac-22.1.1.zip -d .
grpCnt_fileExtendName_BySqlite3 mopac-22.1.1

# wget https://github.com/madbosun/acesiii/archive/refs/heads/master.zip
# acesiii-master.zip
# unzip acesiii-master.zip -d .
grpCnt_fileExtendName_BySqlite3 acesiii-master

# wget https://github.com/Molcas/OpenMolcas/archive/refs/tags/v24.02.zip
# OpenMolcas-24.02.zip
# unzip OpenMolcas-24.02.zip -d .
grpCnt_fileExtendName_BySqlite3 OpenMolcas-24.02

#开发工具
#wget https://github.com/JetBrains/intellij-community/archive/refs/tags/clion/183.2635.14.zip
# intellij-community-clion-183.2635.14.zip
# unzip intellij-community-clion-183.2635.14.zip -d .
grpCnt_fileExtendName_BySqlite3 xxx

#编程语言
# wget https://github.com/scala/scala3/archive/refs/heads/release-3.1.2.zip
# unzip scala3-release-3.1.2.zip -d .
grpCnt_fileExtendName_BySqlite3 xxx

# wget https://github.com/scala/scala-lang/archive/refs/heads/main.zip
# unzip scala-lang-main.zip -d .
grpCnt_fileExtendName_BySqlite3 xxx

# wget https://github.com/JetBrains/kotlin/archive/refs/tags/v2.0.0.zip
# unzip kotlin-2.0.0.zip -d .
grpCnt_fileExtendName_BySqlite3 xxx

#模拟可执行环境
# https://valgrind.org/downloads/current.html#current
#wget https://sourceware.org/pub/valgrind/valgrind-3.23.0.tar.bz2
# tar -jxf valgrind-3.23.0.tar.bz2 -C .
grpCnt_fileExtendName_BySqlite3 xxx

#符号计算
# wget https://github.com/Z3Prover/z3/archive/refs/tags/z3-4.13.0.zip
# unzip z3-z3-4.13.0.zip -d .
grpCnt_fileExtendName_BySqlite3 xxx

#浏览器内核
# wget https://github.com/WebKit/WebKit/archive/refs/tags/wpewebkit-2.45.3.zip
# unzip WebKit-wpewebkit-2.45.3.zip -d .
grpCnt_fileExtendName_BySqlite3 WebKit-wpewebkit-2.45.3

#机器人
#https://github.com/peng-zhihui/Dummy-Robot
unzip Dummy-Robot-main.zip -d .

# wget https://github.com/reactos/reactos/archive/refs/tags/v0.4.7.zip
# unzip reactos-0.4.7.zip -d .
grpCnt_fileExtendName_BySqlite3 xxx

#几何
#https://www.geometrictools.com/Downloads/Downloads.html
# wget https://www.geometrictools.com/Downloads/GeometricToolsEngine7p0.zip
unzip GeometricToolsEngine7p0.zip -d .

wget https://github.com/libgeos/geos/archive/refs/tags/3.12.2.zip
unzip geos-3.12.2.zip -d .

#密码学库
wget https://github.com/openssl/openssl/archive/refs/tags/openssl-3.3.1.zip
unzip openssl-openssl-3.3.1.zip -d .

wget https://github.com/gnutls/gnutls/archive/refs/tags/gnutls-3_0_12.zip
unzip gnutls-gnutls-3_0_12.zip -d .

#图像处理库
wget https://github.com/opencv/opencv/archive/refs/tags/4.10.0.zip 
unzip opencv-4.10.0.zip -d .

#操作系统
wget https://github.com/openbsd/src/archive/refs/heads/master.zip
unzip openbsd-master.zip -d .

# https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.3/official/
# wget https://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.3/official/FD13-FloppyEdition.zip
unzip FD13-FloppyEdition.zip -d .

#数学软件
wget https://github.com/gnu-octave/octave/archive/refs/tags/ss-3-7-7.zip
unzip octave-ss-3-7-7.zip -d .

#软件无线电
wget https://github.com/gnuradio/gnuradio/archive/refs/tags/v3.10.10.0.zip
unzip gnuradio-3.10.10.0.zip -d .

#计算代数系统
wget https://github.com/grzegorzmazur/yacas/archive/refs/tags/v1.9.1.zip
unzip yacas-1.9.1.zip -d .