#!/bin/bash

#【描述】  elf工具（打印elf中所有函数名、打印elf依赖列表）,以字符串数组形式
#【依赖】   
#【备注】 输出可以直接作为数组粘贴到代码中  
#【使用】
#加载语句:  source /app/bash-simplify/elfUtil_printStrArr.sh
# elfFuncList_by_objdump /fridaAnlzAp/clang-var/runtime_c__vars_fn/build/CMakeFiles/clangPlgVar_runtime_c.dir/app/antirez--sds/sds.c.o  | head -n 3
#  输出如下,
#   "sdsReqType",
#   "sdsHdrSize",
#   "sdslen",
# elfFuncList_by_objdump  /app/jdk8/bin/java | grep __
#  输出如下
#    "__do_global_dtors_aux",
#    "__libc_csu_fini",
#    "__libc_csu_init",
#    "__cxa_finalize",
# elfDepList_by_ldd /app/jdk8/bin/java
#  输出如下
#   "linux-vdso.so.1",
#   "libpthread.so.0",
#   "libjli.so",
#   "libdl.so.2",
#   "libc.so.6",
#   "/lib64/ld-linux-x86-64.so.2",


source /app/bash-simplify/argCntEq1.sh

#bash允许alias展开
shopt -s expand_aliases

alias alias__fromPipe_rmRepeatBlank_getFieldK_rmBlank_LoopLineAdd2Quotes1comma='tr  --squeeze-repeats " " |tr  --squeeze-repeats "\t" | cut -d" " -f${_fieldK} | tr  --delete " " |tr  --delete "\t" | while IFS= read -r line; do echo "\"$line\","; done  '

function elfFuncList_by_objdump(){
    argCntEq1 $* || return $?
    local elfFP=$1

    local _fieldK=5;  
    objdump --syms $elfFP | grep " F"  | alias__fromPipe_rmRepeatBlank_getFieldK_rmBlank_LoopLineAdd2Quotes1comma
}

function elfDepList_by_ldd(){
    argCntEq1 $* || return $?
    local elfFP=$1

    local  _fieldK=1;
    ldd $elfFP  | alias__fromPipe_rmRepeatBlank_getFieldK_rmBlank_LoopLineAdd2Quotes1comma

}