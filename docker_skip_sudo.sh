#!/bin/bash

#【描述】  docker免sudo
#【依赖】   
#【术语】 
#【备注】  

# docker免sudo
function docker_skip_sudo() {

mainGroup=$(id -gn) && \
( sudo groupadd docker ; \
sudo gpasswd -a $mainGroup docker ; \
sudo service docker restart ; \
newgrp - docker ; \
sudo service docker restart ;)
}

#使用举例
# _importBSFn "docker_skip_sudo.sh"
# docker_skip_sudo
