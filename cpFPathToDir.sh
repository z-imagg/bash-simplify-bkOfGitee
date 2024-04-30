#!/bin/bash

#【描述】  若该目录不存在,则git克隆仓库的给定分支或标签到给定目录
#【依赖】   
#【术语】 
#【备注】  

_importFn "argCntEq2.sh"

#复制完整文件路径到给定目录
function cpFPathToDir(){

#  若函数参数不为2个 ， 则返回错误
argCntEq2 $* || return $?

local srcF=$1
local dstD=$2

rsync --no-implied-dirs   --relative  --archive --verbose $srcF $dstD
#  --no-implied-dirs 意思是 不包含 '.'  、  '..' 等目录,  如果没有此选项 ， 则:
#  'rsync ./d1/d2/d3/f1.txt  /tmp/' 将报错:  
#     rsync: [generator] chgrp "/tmp/." failed: Operation not permitted (1)
}


#运行举例
##例子脚本:
# mkdir -p ./d1/d2/d3/ ; touch ./d1/d2/d3/f1.txt ; cpWithPath ./d1/d2/d3/f1.txt  /tmp/
#  产生文件 /tmp/d1/d2/d3/f1.txt
# mkdir -p d1/d2/d3/ ; touch d1/d2/d3/f1.txt ;     cpWithPath d1/d2/d3/f1.txt  /tmp/
#  产生文件 /tmp/d1/d2/d3/f1.txt
