#!/usr/bin/bash

#【描述】  本地域名设置
#【依赖】   
#【术语】 
#【备注】

function local_domain_set() {
    grep "giteaz" /etc/hosts ||  ( echo "10.0.4.9 westgw giteaz g" | tee -a /etc/hosts || true )
}

#用法举例:
#方法1:  通过ip引入
#   若设置本地域名失败，则退出代码27.  一般放在脚本靠前, 因为这句正常执行后 本地域名giteaz才能用
# { source <(curl --location --silent http://10.0.4.9:3000/util/bash-simplify/raw/tag/tag_release/local_domain_set.sh)  && local_domain_set ;} || exit 27

#方法2: 通过本地路径引入
#   若设置本地域名失败，则退出代码27.  一般放在脚本靠前, 因为这句正常执行后 本地域名giteaz才能用
# ( source  /app/bash-simplify/local_domain_set.sh && local_domain_set ;) || exit 27
