#!/bin/bash


# https://learn.microsoft.com/en-us/sysinternals/downloads/junction
# https://download.sysinternals.com/files/Junction.zip

binD=/d/bin/
mkdir -p $binD

zipMd5F=/d/bash-simplify/nodejs_script/Junction.zip.md5sum.txt
exeMd5F=/d/bash-simplify/nodejs_script/junction.exe.md5sum.txt
zipF=Junction.zip
urlZipF=https://download.sysinternals.com/files/Junction.zip

cd $binD 
md5sum --check $zipMd5F ||  { rm -fv $zipF && wget   $urlZipF ;} 

junctionF=$binD/junction.exe

which unzip || pacman -S --noconfirm unzip
md5sum --check $exeMd5F  ||  unzip -o $zipF  -d . 
#'unzip -o'=='unzip --override' 

# $junctionF /? 