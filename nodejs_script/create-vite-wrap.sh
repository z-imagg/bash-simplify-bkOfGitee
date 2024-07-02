
#!/bin/bash

#【描述】  create-vite包裹
#【备注】    
#【依赖】   
#【术语】 
#【用法举例】 
#  bash /app/bash-simplify/nodejs_script/create-vite-wrap.sh /app2/ncre/


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常;  
set -e -u 


source /app/bash-simplify/argCntEq1.sh

function create_vite_wrap(){

# 若函数参数不为1个 ， 则 返回错误
argCntEq1 $* || { return $exitCode ;}

 _PrjHome=$1
# _PrjHome=/app2/ncre

#检测是否有 项目nodejs环境激活文件 PrjNodeJsEnvActivate.sh
_prjNodeJsEnvActv_F=$_PrjHome/PrjNodeJsEnvActivate.sh
_err2Msg="错误, 无nodejs环境激活文件[$_prjNodeJsEnvActv_F], 请先以此创建nodejs项目环境[/app/bash-simplify/nodejs_script/new_nodejsPrj_by_nodeenv.sh]"
_err2=2
[[ -f $_prjNodeJsEnvActv_F ]] || { echo $_err2Msg ; return $_err2 ;}

#激活  项目nodejs环境
source $_prjNodeJsEnvActv_F

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
pnpm install
pnpm run dev

}

create_vite_wrap $*