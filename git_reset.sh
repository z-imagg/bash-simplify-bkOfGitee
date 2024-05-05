#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  

_importBSFn "argCntEq1.sh"
_importBSFn "git__chkDir__get__repoDir__arg_gitDir.sh"

# git仓库重置（丢弃工作区修改）
#  核心命令举例 'git clean --force -d ; git reset --hard ' 
#   git_reset  /bal/linux-stable  == 将git仓库'/bal/linux-stable' 重置
function git_reset() {
    #  若函数参数不为1个 ， 则返回错误
    argCntEq1 $* || return $?

    #若 该目录不是git仓库， 则返回错误
    # 返回变量为 repoDir 、 arg_gitDir
    git__chkDir__get__repoDir__arg_gitDir $* || return $?

    # git仓库中 当前已修改的文件个数
    local modify_file_cnt=$(git $arg_gitDir status --porcelain  | wc -l )
    # git仓库中 当前是否 有已修改文件
    local has_modify_file=true; [[ $modify_file_cnt -eq 0 ]] && has_modify_file=false
    
    #若当前提交无该标签， 则 切换到该标签
    #  否则 即已经切换到该标签 无需再切换
    resetMsg="press_enter_to_reset_repo(drop_modify:[$repoDir]):"
    #  'read -p $msg' 被.Dockerfile运行时 msg不显示, 因此改为 'echo $msg && read' 
    #     不想被重置的唯一办法是此时按ctrl+c中指执行
    #     若有已修改文件 则询问是否reset                    问或不问后 都会重置
    { $has_modify_file && echo -n "$resetMsg" && read ; true ;}  &&   ( sudo chown -R $(id --group --name).$(id --name --user) $repoDir  $repoDir/.git ;  git $arg_gitDir clean --force -d  ; git $arg_gitDir reset --hard   ;)




}