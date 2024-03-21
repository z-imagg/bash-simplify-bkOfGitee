#!/usr/bin/env python
# -*- coding: utf-8 -*-

#【文件作用】 'xxx --help' 提取命令xxx的帮助文本中的长选项，写入bash-complete模板 以制作出该命令的bash-complete脚本。 这里写死了是 'frida --help'

#【术语】bsCTxt == bashComplteText == bash自动完成脚本内容

from pathlib import Path
from plumbum import local
from plumbum.machines.local import LocalCommand

###{plumbum执行本地命令举例
def plumbum_example():
    exitCode:int
    stdOut:str
    stdErr:str
    cmd:LocalCommand=local.get("which")
    exitCode,stdOut,stdErr=cmd.run(args=["ls"])

    local.get("which").run(args=["ls"])
###}

def fetchLongOpt(ln:str):
    import re
    import typing
    mth:re.Match=re.match(".*(--[\w-]+) .*",ln)
    if mth is not None:
        groups=mth.groups()
        if groups is not None and len(groups)>=1:
            return groups[0]
    return None



def helpTxt2BashCompleteScript(progName:str,FileExtName:str):
    exitCode:int ; stdOut:str
    exitCode,stdOut,stdErr,=local.get(progName).run(args=['--help'])
    
    cmdForHuman=f"{progName} --help"
    if exitCode != 0:
        print(f"执行命令帮助【{progName} --help】失败,退出代码【{exitCode}】,标准输出【{stdOut}】,错误输出【{stdErr}】")
        exit(3)
    print(f"执行帮助命令{cmdForHuman}成功")
    
    helpTxt:str=stdOut

    # 帮助文本helpTxt 转为 bash-complete文本
    # 去掉行左右两侧空格
    ls1=[ k.strip() for k in helpTxt.splitlines() ]
    # 保留中划线开头的行
    ls2=list(filter(lambda j:j.startswith("-"),  ls1))
    # 提取行中形如"--xxx"的部分
    ls3=[ fetchLongOpt(k) for k in ls2]
    # 保留非空元素
    ls4=list(filter(lambda k:k is not None,  ls3))
    # 用空格串起来
    longOptTxt:str=" ".join(ls4)
    
    #读取bash-complete模板文件
    bsCTxt:str=Path("/app/bash-simplify/bash-complete-gen-from-help/bin/bash-complte.template").read_text()
    # 替换模板中的字段们
    bsCTxt=bsCTxt.replace(r"%FileExtName%",FileExtName)
    bsCTxt=bsCTxt.replace(r"%FileName%",progName)
    bsCTxt=bsCTxt.replace(r"%LongOptionLs%",longOptTxt)

    #写 bash-complete文本 到文件
    bsCName:str=f"bash-complete--{progName}.sh"
    Path(bsCName).write_text(bsCTxt)



import argparse

import sys
from pathlib import Path

def main_cmd():
    parser = argparse.ArgumentParser(
    prog=f'helpTxt2bashComplete.py',
    description='【命令帮助转bash-complete脚本】')

    parser.add_argument('-f', '--progFile',required=True,type=str,help="【命令文件名（含扩展名，不含路径）】『比如xxx.py』",metavar='')
    args=parser.parse_args()
    
    
    progFile:str=args.progFile
    progName:str=None
    extName:str=None
    if progFile.__contains__("."):
        progName,extName=progFile.split(".")
        extName=".{extName}"
    else:
        progName=progFile
        extName=""

    #根据  'progName --help' 生成其 bash-complete脚本
    helpTxt2BashCompleteScript(progName,extName)

    #举例:
    #根据  'frida --help' 生成其 bash-complete脚本
    # helpTxt2BashCompleteScript("frida","")
    #根据  'xxx.py --help' 生成其 bash-complete脚本
    # helpTxt2BashCompleteScript("xxx",".py")

if __name__=="__main__":
    main_cmd()