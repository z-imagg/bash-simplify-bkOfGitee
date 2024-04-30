#!/bin/bash

#【描述】  docker免sudo
#【依赖】   
#【术语】 
#【备注】  

# docker免sudo
function docker_skip_sudo() {

#若当前用户已加入docker组，则正常返回
groups | grep docker && return 0

mainGroup=$(id -gn) && \
( sudo groupadd docker || true ; \
sudo gpasswd -a $mainGroup docker ; \
sudo systemctl  restart docker || true ; \
sudo systemctl  start docker || true ;) \
#newgrp会启动新shell, 不适合脚本用
# newgrp - docker ; \
read -p "已添加当前用户$(whomai)到docker组,请按ctrl+c结束本次脚本,并新开ssh连接运行以使得docker组生效:"


}

#使用举例
# _importBSFn "docker_skip_sudo.sh"
# docker_skip_sudo
