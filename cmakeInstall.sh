#!/usr/bin/env bash










function cmakeInstall(){
    
{ cmake --version 1>/dev/null 2>/dev/null || sudo apt install cmake    -y ;} && \
{ g++ --version   1>/dev/null 2>/dev/null || sudo apt install build-essential -y ;}

}