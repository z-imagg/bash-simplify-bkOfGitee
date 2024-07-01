
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


# 若函数参数不为1个 ， 则 返回错误
argCntEq1 $* || { return $exitCode ;}

 _PrjHome=$1
# _PrjHome=/app2/ncre
_PrjName=$(basename $_PrjHome)

_tmpHome=$_PrjHome/.tmp
_tmpPrjHome=$_tmpHome/$_PrjName

mkdir $_tmpHome; cd $_tmpHome

#创建项目
# create-vite --template vue
create-vite

_err1Msg="错误, 请务必输入同名项目名, 项目名必须为[$_PrjName], 已删除目录[$_tmpPrjHome]"
_err1=1
[[ -d $_tmpPrjHome ]] || { echo $_err1Msg; rm -fr $_tmpPrjHome; return $_err1 ;}

#移动到上一层
mv --verbose $_tmpHome/* $_PrjHome/
#/app2/ncre/.tmp/ncre/* --> /app2/ncre

#删除临时目录
rm -fr $_tmpHome

