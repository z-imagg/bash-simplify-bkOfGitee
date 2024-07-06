set condaHome=D:\miniconda3
set PATH=%condaHome%;%condaHome%\Scripts;%PATH%

where pip

pip install nodeenv==1.9.1

where nodeenv

nodeenv  --mirror https://registry.npmmirror.com/-/binary/node --node 22.2.0  .node_envMsWin_v22.2.0


