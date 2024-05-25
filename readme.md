### 准备

[_importBSFn.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/_importBSFn.sh)中的变量`MyGitSvr`修改为合适的当前git服务前缀 (若无该变量 则不用修改)


###  抽取 *.sh/【描述】转为 目录 追加到readme.md

执行 __gen_readme.md.sh生成readme

```shell
bash -x  /app/bash-simplify/__gen_readme.md.sh 
```


### toc

   docker免sudo ～ [docker_skip_sudo.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/docker_skip_sudo.sh)

   git 检查仓库目录 、 获取仓库目录 、 获取git目录参数 ～ [git__chkDir__get__repoDir__arg_gitDir.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/git__chkDir__get__repoDir__arg_gitDir.sh)

   断言参数1为N，否则打印消息 ～ [arg1EqNMsg.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/arg1EqNMsg.sh)

   参数个数是否为1个 ～ [argCntEq1.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/argCntEq1.sh)

   参数个数是否为2个 ～ [argCntEq2.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/argCntEq2.sh)

   参数个数是否为N个 ～ [argCntEqN.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/argCntEqN.sh)

   参数个数是否大于等于1个 ～ [argCntGe1.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/argCntGe1.sh)

   断言文件存在，否则打印消息 ～ [assertFileExisted.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/assertFileExisted.sh)

   建议 在 脚本中但非函数内 以 ‘trap...EXIT’ 指定 脚本退出时 执行 本exit_handler（若非正常返回码 则打印调用栈、错误消息等）  ～ [bash_exit_handler.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/bash_exit_handler.sh)

   bash学习、问题记录 ～ [bash__study__problem.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/bash__study__problem.sh)

   bool取反 ～ [bool_not.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/bool_not.sh)

   进入当前函数所在脚本所在目录(依据是bash函数调用栈) ～ [cdCurScriptDir.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/cdCurScriptDir.sh)

   进入父函数所在脚本所在目录(依据是bash函数调用栈) ～ [cdFatherScriptDir.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/cdFatherScriptDir.sh)

   cmake安装(ubuntu22.04下) ～ [cmakeInstall.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/cmakeInstall.sh)

   若该目录不存在,则git克隆仓库的给定分支或标签到给定目录 ～ [cpFPathToDir.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/cpFPathToDir.sh)

   为了兼容原dir_util.sh (不建议使用) ～ [dir_util.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/dir_util.sh)

   下载_解压(逻辑完备但较复杂) ～ [download_unpack.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/download_unpack.sh)

   下载_解包_简易版 ～ [download_unpack_simple.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/download_unpack_simple.sh)

   给定文件的最后修改时刻是否在当前时刻的N秒内 ～ [fileModifiedInNSeconds.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/fileModifiedInNSeconds.sh)

   给定路径（文件|目录）的总尺寸（字节个数）是否 ’等于|大于|小于‘ 给定限制值 ～ [file_size_compare.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/file_size_compare.sh)

   bash脚本提高可读性举例，“find|xargs bash -c ‘业务命令’ “  例子 ，  业务命令在vscode中获得人类高可读性 ～ [find_xargs_demo_human_readable.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/find_xargs_demo_human_readable.sh)

   遍历给定仓库目录下*.md 构造为链接 写入 给定readme.md ～ [gen_toc.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/gen_toc.sh)

   获得直接调用本函数的函数所在脚本所在目录 ～ [getCurScriptDirName.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/getCurScriptDirName.sh)

  调用者 是否启用调试 (开启调试‘bash -x’, 禁止调试‘“bash”|“bash +x”’) ～ [get_out_en_dbg.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/get_out_en_dbg.sh)

   git代理设置 、 git代理取消 ～ [gitproxy.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/gitproxy.sh)

   以westgw代理执行 git_Clone_SwitchTag ～ [gitproxy_Clone_SwitchTag.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/gitproxy_Clone_SwitchTag.sh)

   若该目录不存在,则git克隆仓库的给定分支或标签到给定目录 ～ [git_Clone_SwitchTag.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/git_Clone_SwitchTag.sh)

   git忽略 文件可执行权限变更 ～ [git_ignore_filemode.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/git_ignore_filemode.sh)

   git忽略 文件可执行权限变更 ～ [git_ignore_filemode_noCd.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/git_ignore_filemode_noCd.sh)

   git仓库目录重置（放弃所有修改，谨慎使用） ～ [git_reset.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/git_reset.sh)

   git设置 ～ [git_settings.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/git_settings.sh)

   git切换到远程标签 ～ [git_switch_to_remote_branch.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/git_switch_to_remote_branch.sh)

   git切换到远程标签 ～ [git_switch_to_remote_tag.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/git_switch_to_remote_tag.sh)

   判定当前是否运行在docker实例下 （判断特征‘findmnt...overlay’） ～ [isInDocker.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/isInDocker.sh)

 软链接目录c++项目内目录CppPrj_IncDir为给定软链接target_inc_dir ～ [link_CppPrj_includeDir_to.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/link_CppPrj_includeDir_to.sh)

   本地域名设置 ～ [local_domain_set.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/local_domain_set.sh)

   制作软链接 (旧写法) ～ [makLnk.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/makLnk.sh)

   bool变量映射为自定义文本 ～ [mapBool2Txt.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/mapBool2Txt.sh)

   miniconda3下载、解压、安装 ～ [miniconda3install.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/miniconda3install.sh)

   新建任意目录、主人设置为我自己 ～ [mkMyDirBySudo.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/mkMyDirBySudo.sh)

   以 当前绝对时间后缀 重命名 文件 ～ [mvFByAbsTm.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/mvFByAbsTm.sh)

   对 文件名 追加 当前绝对时间后缀 ～ [mvFile_AppendCurAbsTime.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/mvFile_AppendCurAbsTime.sh)

   对 文件名们 追加 当前绝对时间后缀 ～ [mvFile_AppendCurAbsTime_multi.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/mvFile_AppendCurAbsTime_multi.sh)

   以 当前绝对时间后缀 重命名 文件列表 ～ [mvFLsByAbsTm.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/mvFLsByAbsTm.sh)

   nodejs环境安装 ～ [NodeJsEnvInstall.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/NodeJsEnvInstall.sh)

  解析当前调用栈中第n个调用者 ～ [parseCallerN.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/parseCallerN.sh)

   给定分区剩余空间是否大于给定尺寸 ～ [part_has_free.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/part_has_free.sh)

   仓库“/app/bash-simplify/”是否在标签tag_release上 ～ [repo_BashSimplify__In_tag_release.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/repo_BashSimplify__In_tag_release.sh)

   字符串转bool： 一切非‘false’的字符串都认为是true ～ [str2bool_notF2T.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/str2bool_notF2T.sh)

   版本号比较 ～ [version_cmp_gt.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/version_cmp_gt.sh)

   xargsz（等效于xargs的自定义普通bash业务函数，但业务函数中不能有读取stdin） ～ [xargsz.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/xargsz.sh)

   导入在标签tag_release上的给定脚本 ～ [_importBSFn.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/_importBSFn.sh)

  caller 演示 (演示 bash函数调用栈) ～ [__demo_caller__stackTrace.sh](http://giteaz:3000/util/bash-simplify/src/tag/tag_release/__demo_caller__stackTrace.sh)
