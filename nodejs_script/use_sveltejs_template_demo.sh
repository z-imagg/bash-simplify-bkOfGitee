
#!/bin/bash

#[描述] 使用sveltejs的模板项目(构建工具为rollup)

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

_gitRepo_url=https://gitee.com/imagg/sveltejs--template.git
#_gitRepo_url=https://github.com/sveltejs/template.git
_sveltejs_template=/app2/sveltejs_template
_sveltejs_template_cmtId=5b3da65ea310f98480c5258af97ff4d5c6f9d5b0

rm -fr $_sveltejs_template
git clone $_gitRepo_url $_sveltejs_template

( cd $_sveltejs_template ; git checkout $_sveltejs_template_cmtId ;)

( cd $_sveltejs_template ; rm -fr .git  README.md .gitignore   scripts/setupTypeScript.js ;)

rsync --progress --fsync --recursive  $_sveltejs_template/ /app2/ncre/

