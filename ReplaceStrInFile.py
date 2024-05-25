#!/usr/bin/env python

#【描述】 py替换文件中字符串
import sys
from pathlib import Path

def ReplaceStrInFile(fp:str,originStr:str,newStr:str)->bool:
    txt=Path(fp).read_text()
    if not txt.__contains__(originStr):
        return False
    
    newTxt=txt.replace(originStr, newStr)

    Path(fp).write_text(newTxt)
    return True


if __name__ == "__main__":
    ArgCnt=3
    # print(sys.argv)
    assert len(sys.argv) == 1+ArgCnt

    fp=sys.argv[1]
    # fp="/fridaAnlzAp/frida_js/InterceptFnSym.js"
    originStr=sys.argv[2]
    newStr=sys.argv[3]
    
    if not ReplaceStrInFile(fp,originStr,newStr):
        exitCode_Err=21
        errMsg=f"文件【{fp}】无匹配字符串【${originStr}】,退出代码【{exitCode_Err}】"
        print(errMsg,file=sys.stderr)
        exit(exitCode_Err)
       
    exitCode_ok=0
    exit(exitCode_ok)
    
    
#用法举例
# 替换文件 ubuntu2204_linux5build.Dockerfile.sh 中的 $pdir 为 /app/app_env
# python3 /app/bash-simplify/ReplaceStrInFile.py /app/app_env/ubuntu2204_linux5build.Dockerfile.sh '$pdir' "/app/app_env"