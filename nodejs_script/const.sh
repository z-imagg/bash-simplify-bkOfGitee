#!/bin/bash

#[用法举例] 
#  source /app/bash-simplify/nodejs_script/const.sh 
#[功能描述]  提供导出变量 _OpFlow

#OpFlow的值只能用单引号包裹 以保持原样, 其被间接引用(2层引用)  ,若用双引号包裹 必须考虑展开时机 因而较复杂.
export OpFlow='[提醒] nodejs项目流程
ubuntu22下 或 微软win10中的msys2下 执行:
ToolD=/app/bash-simplify/nodejs_script/
PrjD=_PrjHome
nodejs项目流程:
新建nodejs项目环境                                             --> 激活nodejs项目环境                      --> 用nodejs项目模板填充此项目初始内容         --> 正常使用
bash $ToolD/new_PrjNodejsEnv_by_nodeenv.sh  $PrjD 20.15.1    --> bash $ToolD/create_vite_wrap.sh $PrjD   --> source  $PrjD/PrjNodeJsEnvActivate.sh   --> 正常执行yarn命令 

微软win10中的msys2下 PrjD举例:
PrjD=d:\\tmp\\myprj #正确1
PrjD="d:\tmp\myprj" #正确2
PrjD=d:\tmp\myprj   #错误3
'