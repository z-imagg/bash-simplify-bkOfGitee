#!/bin/bash

#【描述】  用alias简化find命令的非.git目录条件，免去繁琐的记忆
#【依赖】   
#【术语】 
#【使用】
#请将以下source语句加入 ~/.bashrc 中, 再重新登陆终端, 以迫使alias生效
#   source /app/bash-simplify/alias__find.sh
#重新登陆终端后，可以使用本文中的alias了，  举例如下
#   find /app2/jdk-jdk-24-0/  findCondNotGirDir_alias  -type f -name "*.cpp"



#bash允许alias展开
shopt -s expand_aliases

alias findCondNotGirDir_alias='  -not \( -type d -name  .git \) -and '