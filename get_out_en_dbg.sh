#!/bin/bash

#【描述】 调用者 是否启用调试 (开启调试‘bash -x’, 禁止调试‘“bash”|“bash +x”’)
# 【用法举例】 
#  用法1 
#    source /app/bash-simplify/get_out_en_dbg.sh && get_out_en_dbg
#  用法2
#   source /app/bash-simplify/_importBSFn.sh #or:#  source <(curl --location --silent http://giteaz:3000/util/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
#   _importBSFn "get_out_en_dbg.sh" 
#   get_out_en_dbg
#【术语】 
#【备注】 




#调用者 是否启用调试 (开启调试'bash -x', 禁止调试'"bash"|"bash +x"')
#返回变量 _out_en_dbg, _out_dbg
function get_out_en_dbg(){
    { { [[ $- == *x* ]] && _out_en_dbg=true && _out_dbg="-x" ;} || { _out_en_dbg=false && _out_dbg="" ;}  ;}
    # echo $_out_en_dbg
}