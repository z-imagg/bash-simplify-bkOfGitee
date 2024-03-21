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



def helpTxt2BashCompleteScript(cmdName:str,FileExtName:str):
    helpTxt:str
    _,helpTxt,_,=local.get(cmdName).run(args=['--help'])


    ls1=[ k.strip() for k in helpTxt.splitlines() ]
    ls2=list(filter(lambda j:j.startswith("-"),  ls1))
    ls3=[ fetchLongOpt(k) for k in ls2]
    ls4=list(filter(lambda k:k is not None,  ls3))
    longOptTxt:str=" ".join(ls4)
    bsCTxt:str=Path("bash-complte.template").read_text()
    # tmpl.replace(r"%FileExtName%",".py")
    bsCTxt=bsCTxt.replace(r"%FileExtName%",FileExtName)
    bsCTxt=bsCTxt.replace(r"%FileName%",cmdName)
    bsCTxt=bsCTxt.replace(r"%LongOptionLs%",longOptTxt)

    bsCName:str=f"bash-complete-{cmdName}.sh"
    Path(bsCName).write_text(bsCTxt)


if __name__=="__main__":
    #根据  'frida --help' 生成其 bash-complete脚本
    helpTxt2BashCompleteScript("frida","")

    #举例:
    #根据  'xxx.py --help' 生成其 bash-complete脚本
    # helpTxt2BashCompleteScript("xxx",".py")