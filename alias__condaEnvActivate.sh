#!/bin/bash

#【描述】  miniconda激活环境(使用alias)
#【依赖】   
#【术语】 
#【用法举例】  
# source /app/bash-simplify/alias__condaEnvActivate.sh
# 以后使用 $_CondaPy 替代 python


#bash允许alias展开
shopt -s expand_aliases

alias condaEnvActviate_alias=' \
_CondaHome=/app/Miniconda3-py310_22.11.1-1 ; \
_CondaBin=$_CondaHome/bin ; \
_CondaActv=$_CondaBin/activate ; \
_CondaPip=$_CondaBin/pip ; \
_CondaPy=$_CondaBin/python ; \
set | grep _Conda ; \
echo "使用 \$_CondaPy 替代 python 即 相当于 激活了conda_env"
'

