#!/usr/bin/env bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  

# git忽略 文件可执行权限变更
function git_ignore_filemode() {
    (  git config --unset-all core.filemode  ; git config core.filemode false ; true ;)
}