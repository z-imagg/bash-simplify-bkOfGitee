
#!/bin/bash

#【描述】  create-vite包裹
#【备注】    
#【依赖】   
#【术语】 
#【用法举例】 
#  bash /app/bash-simplify/nodejs_script/create_vite_wrap /app2/ncre/


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常;  
set -e -u 


source /app/bash-simplify/nodejs_script/const.sh 
#提供导出变量 OpFlow

source /app/bash-simplify/argCntEq1.sh

function create_vite_wrap(){

#用法文本
_usageTxt="[usage] create_vite_wrap  /nodejs_prj_home  "
_Err1=1
_Err1Msg="退出错误代码[$_Err1] $_usageTxt"

# 若函数参数不为1个 ， 则 显示用法 并 返回错误
argCntEq1 $* || { echo $_Err1Msg; return $_Err1 ;}

 _PrjHome=$1
# _PrjHome=/app2/ncre

_OpFlow="${OpFlow/_PrjHome/"$_PrjHome"}"
#检测是否有 项目nodejs环境激活文件 PrjNodeJsEnvActivate.sh
_prjNodeJsEnvActv_F=$_PrjHome/PrjNodeJsEnvActivate.sh
_err2Msg="错误, 无nodejs环境激活文件[$_prjNodeJsEnvActv_F],  
  请参照nodejs项目流程 : ${_OpFlow}"
_err2=2
[[ -f $_prjNodeJsEnvActv_F ]] || { echo "$_err2Msg" ; return $_err2 ;}

#激活  项目nodejs环境
source $_prjNodeJsEnvActv_F 1>/dev/null 2>/dev/null

_PrjName=$(basename $_PrjHome)

_tmpHome=$_PrjHome/.tmp
_tmpPrjHome=$_tmpHome/$_PrjName

#重建临时新项目目录
rm -fr $_tmpHome; mkdir $_tmpHome; cd $_tmpHome

#创建项目
# create-vite --template vue
create-vite

#强制 检测 create-vite交互中输入的项目名 必须为 真项目名
_err1Msg="错误, 项目名必须同名为[$_PrjName], 已删除目录[$_tmpHome]"
_err1=1
[[ -d $_tmpPrjHome ]] || { echo $_err1Msg; rm -fr $_tmpPrjHome; return $_err1 ;}

#删除create-vite产生的README.md
rm -fv $_tmpPrjHome/README.md

#移动内容.       新建的项目内容 从临时目录 移动到 上一层真项目目录
mv --verbose $_tmpPrjHome/* $_PrjHome/
#/app2/ncre/.tmp/ncre/* --> /app2/ncre

#删除临时目录
rm -fr $_tmpHome


#进入新项目.   安装依赖 并 运行
cd $_PrjHome/
yarn install
npm run dev

}

create_vite_wrap $*