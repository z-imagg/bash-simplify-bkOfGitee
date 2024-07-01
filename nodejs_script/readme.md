

### new_prj_nodejs

**新建nodejs项目**

```shell
mkdir -p /app2/ncre
#  新建项目 /app2/ncre , 并在项目目录下新建nodejs-v18.20.3环境
bash /app/bash-simplify/nodejs_script/new_nodejsPrj_by_nodeenv.sh   /app2/ncre    18.20.3

```

### prj_usual

**日常使用**

```shell
cd /app2/ncre/

source PrjNodeJsEnvActivate.sh

which npm #/app2/ncre/.node_env_v18.20.3/bin/npm
which node #/app2/ncre/.node_env_v18.20.3/bin/node
which pnpm #/app2/ncre/.node_env_v18.20.3/bin/pnpm

```


### 用vite创建vue3项目

```shell
cd /app2/ncre/

source PrjNodeJsEnvActivate.sh


```