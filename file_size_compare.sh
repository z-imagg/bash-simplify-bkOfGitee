#!/bin/bash

#【描述】  给定路径（文件|目录）的总尺寸（字节个数）是否 ’等于|大于|小于‘ 给定限制值
#【依赖】   
#【术语】 
#【备注】  

source /app/bash-simplify/_importBSFn.sh
_importBSFn "argCntEq2.sh"
_importBSFn "argCntEq1.sh"



#给定路径（文件|目录）的总尺寸（字节个数）是否 等于 给定限制值
function path_size_compare__eq() {

#正常返回代码
local okCode=0

local negtiveCode=1

# 若函数参数不为2个 ， 则返回错误
argCntEq2 $* || return $?

local path=$1
local sizeLmt=$2

#输出变量 __path_size
_calc_path_size_ $path || return $?


{ [[ $__path_size -eq $sizeLmt ]] && return $okCode ;} || return $negtiveCode

}
#用法举例
# source /app/bash-simplify/file_size_compare.sh
#  给定文件尺寸是否等于给定值
# path_size_compare__eq  /app/pack/zulu11.70.15-ca-jdk11.0.22-linux_x64.tar.gz  200358460  && echo ok
#   ok
#  给定文件尺寸是否等于给定值
# path_size_compare__eq  /app/zulu11.70.15-ca-jdk11.0.22-linux_x64 330865555   && echo ok
#  ok


# 给定路径（文件|目录）的总尺寸（字节个数）是否 大于 给定限制值
function path_size_compare__gt() {

#正常返回代码
local okCode=0

local negtiveCode=1

# 若函数参数不为2个 ， 则返回错误
argCntEq2 $* || return $?

local path=$1
local sizeLmt=$2

#输出变量 __path_size
_calc_path_size_ $path || return $?


{ [[ $__path_size -gt $sizeLmt ]] && return $okCode ;} || return $negtiveCode

}
#用法举例
# source /app/bash-simplify/file_size_compare.sh
#  给定文件尺寸是否大于200MB
# path_size_compare__gt /app/pack/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4.tar.xz   $(xMB 200) && echo ok
#   ok
#  给定文件尺寸是否大于100MB
# path_size_compare__gt /app/firefox   $(xMB 100) && echo ok
#  ok
# 路径不支持管道文件
# 路径不支持socket文件
# 路径不支持字符设备文件
# 路径不支持块设备文件
# 路径不支持软链接文件
# path_size_compare__gt  /dev/nvme0n1     1024   && echo ok
#  [/dev/nvme0n1]路径不支持块设备文件,错误代码[44]


# 给定路径（文件|目录）的总尺寸（字节个数）是否 小于 给定限制值
function path_size_compare__lt() {

#正常返回代码
local okCode=0

local negtiveCode=1

# 若函数参数不为2个 ， 则返回错误
argCntEq2 $* || return $?

local path=$1
local sizeLmt=$2

#输出变量 __path_size
_calc_path_size_ $path || return $?


{ [[ $__path_size -lt $sizeLmt ]] && return $okCode ;} || return $negtiveCode

}
#用法举例
# source /app/bash-simplify/file_size_compare.sh
#  给定文件尺寸是否小于1GB
# path_size_compare__gt /app/pack/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4.tar.xz          $(xGB 1) && echo ok
#   ok
# path_size_compare__gt /app/llvm_release_home/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4/   $(xGB 3) && echo ok
#   ok




# 计算给定路径的（文件|目录）占据的尺寸（字节数）
function _calc_path_size_() {
    
    #正常返回代码
    local okCode=0

    #各种错误返回代码
    local errCode_sizeLmtInvalid=41
    local errMsg_sizeLmtInvalid="尺寸上限不合法,错误代码[$errCode_sizeLmtInvalid]"

    local errCode_PathNotExisted=42
    local errMsg_PathNotExisted="路径不存在,错误代码[$errCode_PathNotExisted]"

    local errCode_PathNotSupport_SoftLink=43
    local errMsg_PathNotSupport_SoftLink="路径不支持软链接文件,错误代码[$errCode_PathNotSupport_SoftLink]"

    local errCode_PathNotSupport_BlockDevice=44
    local errMsg_PathNotSupport_BlockDevice="路径不支持块设备文件,错误代码[$errCode_PathNotSupport_BlockDevice]"

    local errCode_PathNotSupport_CharDevice=45
    local errMsg_PathNotSupport_CharDevice="路径不支持字符设备文件,错误代码[$errCode_PathNotSupport_CharDevice]"

    local errCode_PathNotSupport_SocketDevice=46
    local errMsg_PathNotSupport_SocketDevice="路径不支持socket文件,错误代码[$errCode_PathNotSupport_SocketDevice]"

    local errCode_PathNotSupport_PipeDevice=47
    local errMsg_PathNotSupport_PipeDevice="路径不支持管道文件,错误代码[$errCode_PathNotSupport_PipeDevice]"

    # 若函数参数不为1个 ， 则返回错误
    argCntEq1 $* || return $?

    local path=$1
    local sizeLmt=$2

#若尺寸上限不合法（比如为负数、为非数字）， 则返回错误
[[ $sizeLmt -lt 0 ]] && { echo "[$sizeLmt]$errMsg_sizeLmtInvalid";  return $errCode_sizeLmtInvalid ;}

#若路径不存在，则返回错误
[[ ! -e  $path ]] && { echo "[$path]$errMsg_PathNotExisted" ; return $errCode_PathNotExisted ;}
#路径不支持软链接文件
[[ -L $path ]] &&  { echo "[$path]$errMsg_PathNotSupport_SoftLink" ; return $errCode_PathNotSupport_SoftLink;}
#路径不支持块设备文件
[[ -b $path ]] &&  { echo "[$path]$errMsg_PathNotSupport_BlockDevice" ; return $errCode_PathNotSupport_BlockDevice ;}
#路径不支持字符设备文件
[[ -c $path ]] &&  { echo "[$path]$errMsg_PathNotSupport_CharDevice" ; return $errCode_PathNotSupport_CharDevice ;}
#路径不支持socket文件
[[ -S $path ]] &&  { echo "[$path]$errMsg_PathNotSupport_SocketDevice" ; return $errCode_PathNotSupport_SocketDevice ;}
#路径不支持管道文件
[[ -p $path ]] &&  { echo "[$path]$errMsg_PathNotSupport_PipeDevice" ; return $errCode_PathNotSupport_PipeDevice ;}



local _size=-1

#若是文件, 计算文件尺寸
[[ -f $path ]] && local fPath=$path && _size=$(stat -c %s $fPath) 
#若是目录, 计算目录中所有内容的总尺寸
[[ -d $path ]] && local dPath=$path && _size=$(du  --bytes  -s $dPath | cut -f1)

#输出变量 __path_size
__path_size=$_size

}
#使用举例
# _calc_path_size_ /app/pack/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4.tar.xz && echo $__path_size
#   724366380
#_calc_path_size_ /app/gitkraken/ && echo $__path_size
#   439568120

#x个KB
function xKB() {
# 若函数参数不为1个 ， 则返回错误
argCntEq1 $* || return $?

local x=$1
local _KB=1024 ; local    _xKB=$((x*_KB))

echo $_xKB
}
#用法举例:
# _10KB=$(xKB 10)  ;  echo $_10KB
# 10240

#x个MB
function xMB() {
# 若函数参数不为1个 ， 则返回错误
argCntEq1 $* || return $?

local x=$1
local _KB=1024 ; local   _MB=$((_KB*_KB)) ; local  _xMB=$((x*_MB))

echo $_xMB
}
#用法举例:
# _2MB=$(xMB 2)  ;  echo $_2MB
# 2097152

#x个GB
function xGB() {
# 若函数参数不为1个 ， 则返回错误
argCntEq1 $* || return $?

local x=$1
local _KB=1024 ; local   _GB=$((_KB*_KB*_KB)) ; local  _xGB=$((x*_GB))

echo $_xGB
}
#用法举例:
# set -x; _2GB=$(xGB 2)  ;  echo $_2GB ; set +x
# 2147483648
