#!/usr/bin/env python
# -*- coding: utf-8 -*-

#【文件作用】 'xxx --help' 提取命令xxx的帮助文本中的长选项，写入bash-complete模板 以制作出该命令的bash-complete脚本。 这里写死了是 'frida --help'

#【术语】bsCTxt == bashComplteText == bash自动完成脚本内容

from pathlib import Path
from plumbum import local
from plumbum.machines.local import LocalCommand

def plumbum_example():
    exitCode:int
    stdOut:str
    stdErr:str
    cmd:LocalCommand=local.get("which")
    exitCode,stdOut,stdErr=cmd.run(args=["ls"])

    local.get("which").run(args=["ls"])

def fetchLongOpt(ln:str):
    import re
    import typing
    mth:re.Match=re.match(".*(--[\w-]+) .*",ln)
    if mth is not None:
        groups=mth.groups()
        if groups is not None and len(groups)>=1:
            return groups[0]
    return None



def helpTxt2BashCompleteScript():
    helpTxt:str
    _,helpTxt,_,=local.get("frida").run(args=['--help'])


    ls1=[ k.strip() for k in helpTxt.splitlines() ]
    ls2=list(filter(lambda j:j.startswith("-"),  ls1))
    ls3=[ fetchLongOpt(k) for k in ls2]
    ls4=list(filter(lambda k:k is not None,  ls3))
    longOptTxt:str=" ".join(ls4)
    bsCTxt:str=Path("bash-complte.template").read_text()
    # tmpl.replace(r"%FileExtName%",".py")#扩展名距离
    bsCTxt=bsCTxt.replace(r"%FileExtName%","")
    bsCTxt=bsCTxt.replace(r"%FileName%","frida")
    bsCTxt=bsCTxt.replace(r"%LongOptionLs%",longOptTxt)

    Path("xxx").write_text(bsCTxt)


if __name__=="__main__":
    helpTxt2BashCompleteScript()