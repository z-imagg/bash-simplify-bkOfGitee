#!/bin/python3

#【描述】  [方便bash调用] 将一个完成文件路径 解析为 文件完整路径、父目录完整路径、文件名、文件扩展名
#【依赖】   
#【术语】 
#【备注】  
#【例子用法】  
#   给人观看用的
#python3 /app/bash-simplify/dirAggBySqlite3/_fpathParse_forBash.py "/d2/OCCT-master/adm/cmake/bison.cmake" && echo ok
#     输出
#        _fpathExecOk=true; fpath_text='/d2/OCCT-master/adm/cmake/bison.cmake'; parent_dir_text='/d2/OCCT-master/adm/cmake'; fname_text='bison.cmake'; fExtendName_text='.cmake'
#        ok
#   给程序用的
#bash_code=$(python3 /app/bash-simplify/dirAggBySqlite3/_fpathParse_forBash.py "/d2/OCCT-master/adm/cmake/bison.cmake") && eval "$bash_code" && $_fpathExecOk && echo $fExtendName_text
#     输出 
#       .cmake

from pathlib import Path
import sys

# print("sys.argv=",sys.argv)
if sys.argv.__len__() <=1 :
    bash_code:str=f"_fpathExecOk=false;"
    print(bash_code)
    exit(99)
fpath_text:str=sys.argv[1]
# fpath_text:str="/d2/OCCT-master/adm/cmake/bison.cmake"
fpath:Path=Path(fpath_text)
parent_dir_text:str=fpath.parent.as_posix()
fname_text:str=fpath.name
fExtendName_text:str=fpath.suffix
bash_code:str=f"_fpathExecOk=true; fpath_text='{fpath_text}'; parent_dir_text='{parent_dir_text}'; fname_text='{fname_text}'; fExtendName_text='{fExtendName_text}'"
print(bash_code)
end=True