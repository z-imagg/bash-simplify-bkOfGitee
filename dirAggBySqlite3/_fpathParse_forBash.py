#!/bin/python3

#【描述】  [方便bash调用] 将一个完成文件路径 解析为 文件完整路径、父目录完整路径、文件名、文件扩展名
#【依赖】   
#【术语】 
#【备注】  输出bash变量有前缀_out4sh
#【例子用法】  
#   给人观看用的
#python3 /app/bash-simplify/dirAggBySqlite3/_fpathParse_forBash.py "/d2/OCCT-master/adm/cmake/bison.cmake" && echo ok
#     输出
#        _out4sh_fpathPy_ExecOk=true; _out4sh_fpath='/d2/OCCT-master/adm/cmake/bison.cmake'; _out4sh_parentDir='/d2/OCCT-master/adm/cmake'; _out4sh_fname='bison.cmake'; _out4sh_fExtendName='.cmake'
#        ok
#   给程序用的
#bash_code=$(python3 /app/bash-simplify/dirAggBySqlite3/_fpathParse_forBash.py "/d2/OCCT-master/adm/cmake/bison.cmake") && eval "$bash_code" && $_out4sh_fpathPy_ExecOk && echo $_out4sh_fExtendName
#     输出 
#       .cmake

from pathlib import Path
import sys

# print("sys.argv=",sys.argv)
if sys.argv.__len__() <=1 :
    bash_code:str=f"_out4sh_fpathPy_ExecOk=false;"
    print(bash_code)
    exit(99)
fpath_text:str=sys.argv[1]
# fpath_text:str="/d2/OCCT-master/adm/cmake/bison.cmake"
fpath:Path=Path(fpath_text)
parent_dir_text:str=fpath.parent.as_posix()
_out4sh_fname:str=fpath.name
_out4sh_fExtendName:str=fpath.suffix
bash_code:str=f"_out4sh_fpathPy_ExecOk=true; _out4sh_fpath='{fpath_text}'; _out4sh_parentDir='{parent_dir_text}'; _out4sh_fname='{_out4sh_fname}'; _out4sh_fExtendName='{_out4sh_fExtendName}'"
print(bash_code)
end=True