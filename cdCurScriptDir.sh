#!/usr/bin/env bash

source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/getCurScriptDirName.sh)

#去此脚本所在目录
function cdCurScriptDir(){
    getCurScriptDirName && cd $__dire
}
