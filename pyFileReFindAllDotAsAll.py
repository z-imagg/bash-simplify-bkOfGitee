#!/usr/bin/python3

#【描述】  py正则匹配文件内容,  指定re中的点表示任意一个字符( re默认时 点表示非换行的任意一个字符 )
#【依赖】   
#【术语】 
#【备注】  

import typing
class _LineFeed:
    MsWin:str="\r\n"
    Unix:str="\n"
    MacOs:str="\r"

    @staticmethod
    def _assert(lineFeed:str):
        assert lineFeed in [ _LineFeed.MsWin ,_LineFeed.Unix, _LineFeed.MacOs]

class LnDesc:
    def __init__(self,lineStartIdex:int,lineLen:int) -> None:
        self.lineStartIdex:int=lineStartIdex
        self.lineLen:int=lineLen
        return
    
#计算 '行下标行长度 们' LnIdxLnLen_Ls 
def __calc__LnIdxLnLen_Ls(fTxt:str,lineFeed:str):
    _LineFeed._assert(lineFeed)
    #行们
    lnLs=fTxt.split(lineFeed)
    # 行下标行长度 们
    LnIdxLnLen_Ls:typing.List[typing.Tuple[int,int]]=[]
    #行0 到 '行k-1' 的累计字符个数
    prevLnAccLen=0
    for lnK in lnLs:
        #第k行长度
        lnKLen=lnK.__len__()
        #             行首下标 行长度
        LnIdxLnLen_Ls.append( [prevLnAccLen,lnKLen] )
        #为 '行k+1' 计算 行0 到 行k 的累计字符个数
        prevLnAccLen+=lnKLen
        
    return LnIdxLnLen_Ls

def __calc_lineNum__(fTxt:str,subTxt:str):
    assert subTxt in fTxt
    __calc__LnIdxLnLen_Ls(fTxt,"\n")
    beginIdx:int=fTxt.index(subTxt)
    lineCnt:int=subTxt.count("\n")
    pass

def pyFileReFindAllDotAsAll(reExpr:str,txtFilePath:str):
    import re
    fStream=open(txtFilePath)
    fTxt=fStream.read()
    matchTxtLs=re.findall(reExpr, fTxt, re.DOTALL)
    __calc_lineNum__(fTxt,matchTxtLs[0])
    [ print(k) for k in matchTxtLs  ]

    fStream.close()
    
if __name__=="__main__":
    reExpr=r'#define STMT.{1,20}\n  bool Traverse##CLASS.{1,70}\n#include "clang/AST/StmtNodes.inc"\n'
    txtFilePath="/app/llvm_release_home/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4/include/clang/AST/RecursiveASTVisitor.h"
    pyFileReFindAllDotAsAll(reExpr,txtFilePath)

