#!/bin/bash

#【描述】  抽取 *.sh/【描述】转为 目录 追加到readme.md
#【依赖】   
#【术语】  
#【备注】  

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

#bash允许alias展开
shopt -s expand_aliases   

# bash -c """被 alias、 #""" 代替，骗过vscode 但bash正常执行 
alias Bgn='  xargs -0  -I@ bash    -c """  '

RepoHome=/app/bash-simplify
DocF=$RepoHome/readme.md

find    $RepoHome -type f -name "*.sh" -not -name "__gen_readme.md.sh"  -not -path  "*bash-complete-gen-from-help*" -print0 | sort   | \
Bgn true &&  echo -n @:  ; egrep    '^#【描述】'   @   #"""    | \
#到此,结果为多行,其中单行举例如下
#/app/bash-simplify/download_unpack.sh:#【描述】  下载_解压(逻辑完备但较复杂)
python3   -c '
import sys; 
x=sys.stdin.read();
x=x.strip(); 
gitRepoUrlPrefix="http://giteaz:3000/util/bash-simplify/src/tag/tag_release"; 
q=chr(39); 
blank="";
s1="#【描述】"; 
s2="/app/bash-simplify/";
True or print(f"[{x}]"); 
Ls=x.split("\n"); 
True or print(Ls[1]); 
Ls2=[ [*k.split(":"), ""] for k in Ls] ; 
for k in Ls2:
  Desc=k[1].replace(s1,blank)
  FName=k[0].replace(s2,blank)
  FUrl=f"{gitRepoUrlPrefix}/{FName}"
  markdown_line=f"\n {Desc} ～ [{FName}]({FUrl})"
  print(markdown_line)
' | \
tee -a $DocF
