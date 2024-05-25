#!/bin/bash


DocF=/app/bash-simplify/readme.md

find    $(pwd) -name "*.sh" -not -path  "*bash-complete-gen-from-help*" -print0   | \
xargs -0  -I@ bash    -c """ echo -n @:  ; egrep    '^#【描述】'   @   """    | \
python3   -c '
import sys; 
x=sys.stdin.read(); 
gitRepoUrlPrefix="http://giteaz:3000/util/bash-simplify/src/tag/tag_release/"; 
q=chr(39); 
True or print(f"[{x}]"); 
Ls=x.split("\n"); 
True or print(Ls[1]); 
Ls2=[ [*k.split(":"), ""] for k in Ls] ; 
[ print(f"\n[{k[1]}]({gitRepoUrlPrefix}{k[0]})") for k in Ls2]
' | \
tee -a $DocF