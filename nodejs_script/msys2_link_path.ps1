# set-executionpolicy remotesigned
# chcp 65001

$Err_psNotAllowExecScript=17
$Err_psNotAllowExecScript_msg="Err $Err_psNotAllowExecScript, powershell not allow execute script, fix: admin execute 'set-executionpolicy remotesigned' "

#判断是否powershell当前是否允许执行脚本，若不允许 则提醒并退出
# get-executionpolicy == Restricted
$cur_executionpolicy=( get-executionpolicy )
$ps_allow_exec_script=( $cur_executionpolicy -eq "remotesigned" )
if( -not $ps_allow_exec_script){
echo $Err_psNotAllowExecScript_msg
exit $Err_psNotAllowExecScript
}

#在msys2下, 将windows环境下路径盘符与linux的差异 利用windows的软链接命令mklink 抹平
# bin --> Scripts  
mklink  /D d:\Miniconda3-py310_22.11.1-1\bin d:\Miniconda3-py310_22.11.1-1\Scripts
# d:\ --> d:\msys64\app\
mklink  /D  d:\msys64\app\Miniconda3-py310_22.11.1-1   d:\Miniconda3-py310_22.11.1-1
# d:\ --> d:\msys64\app\
mklink  /D  d:\msys64\app\bash-simplify   d:\bash-simplify