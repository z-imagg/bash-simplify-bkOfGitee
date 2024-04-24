#!/usr/bin/env bash


function miniconda3install(){
(echo "安装miniconda3..." && \
cd /tmp/ && \
cat << 'EOF' > Miniconda3-py310_23.10.0-1-Linux-x86_64.sh.md5sum.txt
cefadd1cacd8e5b9a74b404df1f11016  Miniconda3-py310_23.10.0-1-Linux-x86_64.sh
EOF

{ md5sum --check Miniconda3-py310_23.10.0-1-Linux-x86_64.sh.md5sum.txt ||
 wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py310_23.10.0-1-Linux-x86_64.sh ;} && \

hm=/app/miniconda3 && \
sudo mkdir -p $hm && \
sudo chown -R $(id -gn).$(whoami) $hm && \
bash Miniconda3-py310_23.10.0-1-Linux-x86_64.sh -b -u -p $hm
)
}




function tsinghua_pypi_src(){
hm=/app/miniconda3 && \
source $hm/bin/activate && \
#pip源设为清华源: https://mirrors.tuna.tsinghua.edu.cn/help/pypi/
# python -m pip install --upgrade pip && \
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
conda deactivate
}



function miniconda3Activate(){
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/get_out_en_dbg.sh) && \
get_out_en_dbg && \
# echo "$_out_en_dbg,【$_out_dbg】" && \

#miniconda activate 不要开调试
CondaActvF=/app/miniconda3/bin/activate && \
{ [ -f  $CondaActvF ]  || miniconda3install   ;} && \
set +x && source $CondaActvF

#恢复可能的调试
{ { $_out_en_dbg && set -x && : ;} || : ;}

}