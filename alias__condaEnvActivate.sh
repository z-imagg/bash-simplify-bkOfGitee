#!/bin/bash

#【描述】  miniconda激活环境(使用alias)
#【依赖】   
#【术语】 
#【用法举例】  
# source /app/bash-simplify/alias__condaEnvActivate.sh
# 以后使用 _CondaPy_alias 替代 python 、 _CondaPip_alias 替代 pip 


#bash允许alias展开
shopt -s expand_aliases

_CondaHome=/app/Miniconda3-py310_22.11.1-1
_CondaBin=$_CondaHome/bin
_CondaActv=$_CondaBin/activate
alias _CondaPip_alias="$_CondaBin/pip"
alias _CondaPy_alias="$_CondaBin/python"
set | grep _Conda
alias | grep _Conda
echo "激活conda_env :
_CondaPy_alias 替代 python 、 
_CondaPip_alias 替代 pip 
"

