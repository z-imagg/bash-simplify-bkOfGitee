
$URL_miniconda3="https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py310_22.11.1-1-Windows-x86_64.exe"
$URL_msys2="https://mirrors.tuna.tsinghua.edu.cn/msys2/distrib/msys2-x86_64-latest.exe"


$D_msys2="D:\msys64"
$F_msys2="${D_msys2}\msys2.exe"

$D_miniconda3="D:\app\Miniconda3-py310_22.11.1-1"
$F_miniconda3_py="${D_miniconda3}\python.exe"

$Err_noMsys2=15
$Err_noMsys2_msg="Err $Err_noMsys2,install $URL_msys2 to $D_msys2"

$Err_no_miniconda3=16
$Err_no_miniconda3_msg="Err $Err_no_miniconda3,install $URL_miniconda3 to $D_miniconda3"

$F_msys2_existed=(Test-Path $F_msys2 )
if( -not $F_msys2_existed){
echo $Err_noMsys2_msg
exit $Err_noMsys2
}

$F_miniconda3_py_existed=(Test-Path $F_miniconda3_py )
if( -not $F_miniconda3_py_existed){
echo $Err_no_miniconda3_msg
exit $Err_no_miniconda3
}

