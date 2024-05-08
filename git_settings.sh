#!/bin/bash

#【描述】  git设置
#【依赖】   
#【术语】 
#【备注】 

#设置git输出编码为utf8
#  比如 使得'git log'输出从<E6><89><93><E5>变为正常中文
export LANG="zh_CN.UTF-8"
git config --global i18n.commitencoding utf-8
git config --global i18n.logoutputencoding utf-8
export LESSCHARSET=utf-8