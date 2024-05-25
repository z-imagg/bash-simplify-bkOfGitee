#!/bin/bash

#【描述】  "find|xargs bash -c '业务命令' "  例子 ，  业务命令在vscode中获得人类高可读性
# 【用法举例】 
#  分区sdc3是否剩余超过1GB空间
#  用法1 
#    source /app/bash-simplify/partHasFree.sh && partHasFree /dev/sdc3 _1GB
#  用法2
#   source /app/bash-simplify/_importBSFn.sh #or:#  source <(curl --location --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)
#   _importBSFn "partHasFree.sh" 
#    partHasFree /dev/sdc3 _1GB
#【术语】 
#【备注】 



alias Begin="bash -c '"
Begin ls    ' #End'
#以上两行等价于: bash -c 'ls  ' #'
#以此 骗过vscode 使得vscode觉得 这一串命令不在''中, 从而获得人类可读性.  
# 同时 由于 #End 前面的井号 导致 交给bash也能正常执行 
# 当然由于 ls 被 vscode当成了 参数 而不是命令, 其实可读性还是不高, 稍微改一下即可 获得更高可读性:
Begin true && ls    ' #End'
#再复杂一点:
Begin true && ls && touch /tmp/f1   ' #End'


alias Bgn="xargs -0 -I@ bash -c '"
find $(pwd) -name "*.sh" -not -path "*bash-complete-gen-from-help*" -print0 | Bgn true && grep "#【描述】" "@" | sed "s/#【描述】//g" | while read -r title; do F="@"; echo "$F:$title"; done ' #End'
#以下是此命令的原始命令:
# find $(pwd) -name "*.sh" -not -path "*bash-complete-gen-from-help*" -print0 | xargs -0 -I@ bash -c 'grep "#【描述】" "@" | sed "s/#【描述】//g" | while read -r title; do F="@"; echo "$F:$title"; done'
#其中 'find ... -print0' 使得行末尾符号为null（即使\0） 从而防止干扰,  而  'xargs ... -0' 是告诉xargs分割符号为null , 从而使得xargs和find正常配合
