#!/bin/python3

#【描述】  [用bash实现] 将一个完成文件路径 解析为 文件完整路径、父目录完整路径、文件名、文件扩展名
#【依赖】   
#【术语】 
#【备注】  输出bash变量有前缀_out4sh
#【例子用法】  
#   给人观看用的
#source /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/_fpathParse.sh ; _fpathParse "/d2/Open-Cascade-SAS/OCCT-7_8_1adm/cmake/bison.cmake" && echo ok
#     输出
#        _out4sh_fpathPy_ExecOk=true; _out4sh_fpath=''; _out4sh_parentDir='/d2/Open-Cascade-SAS/OCCT-7_8_1adm/cmake'; _out4sh_fname='bison.cmake'; _out4sh_fExtendName='cmake'
#        ok
#   给程序用的
#source /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/_fpathParse.sh ;bash_code=$(_fpathParse "/d2/Open-Cascade-SAS/OCCT-7_8_1adm/cmake/bison.cmake") && eval "$bash_code" && $_out4sh_fpathPy_ExecOk && echo $_out4sh_fExtendName
#     输出 
#       cmake

function _fpathParse() {
# print("sys.argv=",sys.argv)
# local fpath_text=$1
# fpath_text:str="/d2/Open-Cascade-SAS/OCCT-7_8_1adm/cmake/bison.cmake"
# fpath_text:str="/d2/Open-Cascade-SAS/OCCT-7_8_1xxx/.gitignore"
local fpath=$1
local parent_dir_text=$(dirname $fpath)
local _out4sh_fname=$(basename $fpath)
local _out4sh_fExtendName=$(echo $_out4sh_fname|rev|cut -d'.' -f1 |rev)
#如果文件名中没有点,  则扩展名为空
[[ $_out4sh_fname != *.* ]] && _out4sh_fExtendName=""

local bash_code="_out4sh_fpathPy_ExecOk=true; _out4sh_fpath='${fpath}'; _out4sh_parentDir='${parent_dir_text}'; _out4sh_fname='${_out4sh_fname}'; _out4sh_fExtendName='${_out4sh_fExtendName}'"
echo $bash_code
}

_fpathParse $*