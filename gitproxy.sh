#!/bin/bash

#【描述】  git代理设置 、 git代理取消
#【依赖】   
#【术语】 
#【备注】  

#通过ip引入
#   若设置本地域名失败，则退出代码27.  一般放在脚本靠前, 因为这句正常执行后 本地域名giteaz才能用
{ source <(curl --silent http://10.0.4.9:3000/bal/bash-simplify/raw/branch/release/local_domain_set.sh)  && local_domain_set ;} || exit 27


function gitproxy_set() {
git config --global http.proxy socks5://westgw:7890 ; 
git config --global https.proxy socks5://westgw:7890  ; 
}

function gitproxy_unset(){
git config --global --unset http.proxy ; 
git config --global --unset https.proxy  
}

#用法举例: 
# _importFn "gitproxy.sh"
# git设置代理, 执行git命令, git取消代理
# gitproxy_set ; git clone https://github.com/x.git /x;  git --git-dir=/x/.git/  submodule    update --recursive --init;   gitproxy_unset
