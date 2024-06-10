#!/bin/sh


#【描述】  使用 '给定源码目录，用sqlite3进行各种统计'
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

grpCnt_fileExtendName_BySqlite3 Open-Cascade-SAS/OCCT-7_8_1
grpCnt_fileExtendName_BySqlite3 firebird-5.0.0
grpCnt_fileExtendName_BySqlite3 FreeCAD-0.21.2
grpCnt_fileExtendName_BySqlite3 FreeCAD-library-master
grpCnt_fileExtendName_BySqlite3 git-2.45.2
grpCnt_fileExtendName_BySqlite3 LLVM-llvmorg-15.0.0
grpCnt_fileExtendName_BySqlite3 old-minix-2.0.4
grpCnt_fileExtendName_BySqlite3 Open-Cascade-SAS
grpCnt_fileExtendName_BySqlite3 openjdk-jdk8-b120
grpCnt_fileExtendName_BySqlite3 postgres-release-6-3
grpCnt_fileExtendName_BySqlite3 pytorch-2.3.0
grpCnt_fileExtendName_BySqlite3 sqlite-vesion-3.45.1
grpCnt_fileExtendName_BySqlite3 tensorflow-2.15.0
grpCnt_fileExtendName_BySqlite3 vbox-master


