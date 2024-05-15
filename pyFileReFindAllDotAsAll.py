#!/usr/bin/python3

#【描述】  py正则匹配文件内容,  (?:.*\n){N,M} : 匹配N行到M行 
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


_usingLnFeed=_LineFeed.Unix

class LnDesc:
    def __init__(self,lineStartIdex:int,lineLen:int) -> None:
        self.lineStartIdex:int=lineStartIdex
        self.lineLen:int=lineLen
        return
    def __repr__(self) -> str:
        return f"si={self.lineStartIdex},L={self.lineLen}"

#计算 '行下标行长度 们' LnIdxLnLen_Ls 
def __calc__LnDescLs(fTxt:str,lineFeed:str):
    _LineFeed._assert(lineFeed)
    _lineFeedLen:int=lineFeed.__len__()
    #行们
    lnLs=fTxt.split(lineFeed)
    #  开发调试变量
    _LnLen_Ls:typing.List[int]=[]
    # 行下标行长度 们
    LnDescLs:typing.List[LnDesc]=[]
    #行0 到 '行k-1' 的累计字符个数
    prevLnAccLen=0
    for lnK in lnLs:
        #第k行长度
        lnKLen=lnK.__len__()+_lineFeedLen
        #  开发调试变量
        _LnLen_Ls.append(lnKLen)
        #             行首下标 行长度
        LnDescLs.append( LnDesc( prevLnAccLen,lnKLen) )
        #为 '行k+1' 计算 行0 到 行k 的累计字符个数
        prevLnAccLen+=lnKLen
        
    return LnDescLs

#二分查找行号
def __bisect_lineNum(LnDescLs:typing.List[LnDesc],subTxt_beginIdx:int)->int:
    import bisect
    lineStartIdex_ls:typing.List[int]=list(map(lambda x: x.lineStartIdex, LnDescLs))
    if subTxt_beginIdx > max(lineStartIdex_ls) or subTxt_beginIdx< min(lineStartIdex_ls):
        errMsg1=f"[1]字符下标{subTxt_beginIdx}不在有序数组lineStartIdex_ls最小值～最大值范围内"
        raise Exception(errMsg1)
    lineNum:int=bisect.bisect_left(lineStartIdex_ls,subTxt_beginIdx)
    if lineNum <=0 or lineNum>=len(lineStartIdex_ls):
        errMsg2=f"[2]字符下标{subTxt_beginIdx}不在有序数组lineStartIdex_ls最小值～最大值范围内"
        raise Exception(errMsg2)
    
    return lineNum

#在文本文件内容fTxt中查找子字符串subTxt的行号
def __calc_lineNumText(fTxt:str,subTxt:str)->str:
    assert subTxt in fTxt
    LnDescLs:typing.List[LnDesc]=__calc__LnDescLs(fTxt,_usingLnFeed)
    subTxt_beginIdx:int=fTxt.index(subTxt)
    beginLineNum:int=__bisect_lineNum(LnDescLs,subTxt_beginIdx)
    lineCnt:int=subTxt.count(_usingLnFeed)
    endLineNum:int=beginLineNum+lineCnt
    return f"行{beginLineNum}～行{endLineNum}\n"

#py正则匹配文件内容,  指定re中的点表示任意一个字符
def pyFileReFindAllDotAsAll(reExpr:str,txtFilePath:str):
    import re
    fStream=open(txtFilePath)
    fTxt=fStream.read()
    matchTxtLs=re.findall(reExpr, fTxt )
    
    [ print(f'文件{txtFilePath} 匹配行号 {__calc_lineNumText(fTxt,matchTxtLs[0])}', k) for k in matchTxtLs  ]

    fStream.close()
    
if __name__=="__main__":
    import sys
    # print(sys.argv)
    assert sys.argv.__len__() >= 1+2, "[命令用法] me.py 'reExpr' txtFilePath"
    reExpr=sys.argv[1]
    # reExpr=r'#define STMT.{1,20}\n  bool Traverse##CLASS.{1,70}\n#include "clang/AST/StmtNodes.inc"\n'
    txtFilePath=sys.argv[2]
    # txtFilePath="/app/llvm_release_home/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4/include/clang/AST/RecursiveASTVisitor.h"
    
    pyFileReFindAllDotAsAll(reExpr,txtFilePath)

#用法举例
#md5sum /app/llvm_release_home/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4/include/clang/AST/RecursiveASTVisitor.h
# 2f7355511698bf3cc08b07a2989ced5d  /app/llvm_release_home/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4/include/clang/AST/RecursiveASTVisitor.h


#python /app/bash-simplify/pyFileReFindAllDotAsAll.py  '#define STMT(?:.*\n){1}  bool Traverse##CLASS(?:.*\n)#include "clang/AST/StmtNodes.inc"\n'  "/app/llvm_release_home/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4/include/clang/AST/RecursiveASTVisitor.h"
# 输出
# 文件/app/llvm_release_home/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4/include/clang/AST/RecursiveASTVisitor.h 匹配行号 行372～行375
#  #define STMT(CLASS, PARENT) \
#   bool Traverse##CLASS(CLASS *S, DataRecursionQueue *Queue = nullptr);
# #include "clang/AST/StmtNodes.inc"

#  (?:xxx)  : 匹配xxx的非捕获组
#  (?:.*\n) : 匹配.*\n的非捕获组
#  (?:.*\n){N,M} : 匹配N行到M行
#python /app/bash-simplify/pyFileReFindAllDotAsAll.py  '#define STMT(?:.*\n){6}  bool Visit##CLASS(?:.*\n){1}#include "clang/AST/StmtNodes.inc"\n'  "/app/llvm_release_home/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4/include/clang/AST/RecursiveASTVisitor.h"
# 输出
# 文件/app/llvm_release_home/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4/include/clang/AST/RecursiveASTVisitor.h 匹配行号 行380～行388
#  #define STMT(CLASS, PARENT)                                                    \
#   bool WalkUpFrom##CLASS(CLASS *S) {                                           \
#     TRY_TO(WalkUpFrom##PARENT(S));                                             \
#     TRY_TO(Visit##CLASS(S));                                                   \
#     return true;                                                               \
#   }                                                                            \
#   bool Visit##CLASS(CLASS *S) { return true; }
# #include "clang/AST/StmtNodes.inc"
