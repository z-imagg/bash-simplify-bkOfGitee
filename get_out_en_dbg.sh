#!/usr/bin/env bash






#获取调用者 是否开启了 bash -x  即 是否开启 bash 调试
#返回变量 _out_en_dbg, _out_dbg
function get_out_en_dbg(){
    { { [[ $- == *x* ]] && _out_en_dbg=true && _out_dbg="-x" ;} || { _out_en_dbg=false && _out_dbg="" ;}  ;}
    # echo $_out_en_dbg
}