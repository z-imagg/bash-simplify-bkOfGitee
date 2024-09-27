#!/bin/bash


# https://learn.microsoft.com/en-us/sysinternals/downloads/junction
# https://download.sysinternals.com/files/Junction.zip

binD=/d/bin/
mkdir -Force $binD

zipMd5F=/d/bash-simplify/nodejs_script/Junction.zip.md5sum.txt
zipF=Junction.zip
urlZipF=https://download.sysinternals.com/files/Junction.zip

cd $binD 
md5sum --check $zipMd5F ||  { rm -fv $zipF && wget   $urlZipF ;} 

which unzip || pacman -S --noconfirm unzip
unzip $zipF -d . -o

echo "junctionF=$binD/junction.exe" | tee /junctionF_path.sh

source  /junctionF_path.sh
# $junctionF /? 