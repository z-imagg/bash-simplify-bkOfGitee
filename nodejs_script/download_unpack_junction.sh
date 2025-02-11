#!/bin/bash


source /app/bash-simplify/nodejs_script/util.sh
dos2unix_dir /app/bash-simplify/nodejs_script

# https://learn.microsoft.com/en-us/sysinternals/downloads/junction
# https://download.sysinternals.com/files/Junction.zip

binD=/d/bin/
mkdir -p $binD

zipMd5F=/d/bash-simplify/nodejs_script/Junction.zip.md5sum.txt
exeMd5F=/d/bash-simplify/nodejs_script/junction.exe.md5sum.txt
zipF=Junction.zip
urlZipF=https://download.sysinternals.com/files/Junction.zip

cd $binD 
md5sum --quiet --check $zipMd5F ||  { rm -fv $zipF && wget -q  $urlZipF ;} 

junctionF=$binD/junction.exe

which unzip 1>/dev/null 2>/dev/null || pacman -S --noconfirm unzip
md5sum --quiet --check $exeMd5F  ||  unzip -o $zipF  -d . 
#'unzip -o'=='unzip --override' 

# $junctionF /? 