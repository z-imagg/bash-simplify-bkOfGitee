#!/bin/bash

#【描述】  cmake安装(ubuntu22.04下)
#【依赖】   
#【术语】 
#【备注】  











function cmakeInstall(){
    
{ cmake --version 1>/dev/null 2>/dev/null || sudo apt install cmake    -y ;} && \
{ g++ --version   1>/dev/null 2>/dev/null || sudo apt install build-essential -y ;}

}