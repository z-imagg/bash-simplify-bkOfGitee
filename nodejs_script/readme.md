

### new_PrjNodejsEnv

**新建项目nodejs环境**

```shell
mkdir -p /app2/ncre
#  新建nodejs项目环境 /app2/ncre/.node_env_v18.20.3/
bash /app/bash-simplify/nodejs_script/new_PrjNodejsEnv_by_nodeenv.sh   /app2/ncre    18.20.3

```

### prj_usual

**日常使用**

```shell
cd /app2/ncre/

source PrjNodeJsEnvActivate.sh

which npm #/app2/ncre/.node_env_v18.20.3/bin/npm
which node #/app2/ncre/.node_env_v18.20.3/bin/node
which pnpm #/app2/ncre/.node_env_v18.20.3/bin/pnpm
which create-vite #/app2/ncre/.prj_pnpm_home/create-vite

```


### create-vite-wrap

**用vite创建 vue3 、 JavaScript 项目**

```shell
bash /app/bash-simplify/nodejs_script/create-vite-wrap.sh  /app2/ncre/
```

```txt
✔ Project name:  输入ncre
✔ Select a framework: ›  选择Vue
✔ Select a variant: › 选择JavaScript

Scaffolding project in /app2/ncre/.tmp/ncre...

Done. Now run:

  cd ncre
  npm install
  npm run dev
```
