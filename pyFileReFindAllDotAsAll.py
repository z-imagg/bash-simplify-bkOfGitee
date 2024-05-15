#!/usr/bin/python3

#【描述】  py正则匹配文件内容,  指定re中的点表示任意一个字符( re默认时 点表示非换行的任意一个字符 )
#【依赖】   
#【术语】 
#【备注】  


def pyFileReFindAllDotAsAll():
    import re
    reExpr=r'#define STMT.{1,20}\n  bool Traverse##CLASS.{1,70}\n#include "clang/AST/StmtNodes.inc"'
    fp="/app/llvm_release_home/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4/include/clang/AST/RecursiveASTVisitor.h"
    fStream=open(fp)
    fTxt=fStream.read()
    ls=re.findall(reExpr, fTxt, re.DOTALL)
    [ print(k) for k in ls  ]

    fStream.close()
    
if __name__=="__main__":
    pyFileReFindAllDotAsAll()

