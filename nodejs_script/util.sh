#!/bin/bash

#[用法举例] 
#  source /app/bash-simplify/nodejs_script/util.sh && 函数名比如OsCheck、dos2unix_dir、msys2_unixStylePath_to_msWin、msys2_msWinStylePath_to_unix 函数参数
#[功能描述] 提供工具函数 OsCheck, dos2unix_dir, msys2_unixStylePath_to_msWin, msys2_msWinStylePath_to_unix, is_msWinStylePath; 提供导出变量 powersh


#[用法举例] OsCheck
#[功能描述] 检查操作系统名, 输出变量 OsName 、isOs_Msys  、 isOs_Msys 、isLinux  、 isLinux_ubuntu
function OsCheck() {
OsName=$(uname --operating-system)
isOs_Msys=false ; [[ $OsName=="Msys" ]] && isOs_Msys=true
# isLinux == ! isOs_Msys
isLinux=false; $isOs_Msys || isLinux=true

isLinux_ubuntu=false; $isLinux &&    [[  -f /etc/isssue ]] && grep -i "Ubuntu" /etc/isssue  && isLinux_ubuntu=true

true
}

#[用法举例] dos2unix_dir /.../nodejs_script/
#[功能描述] 将  目录 /.../nodejs_script/ 下的 *.sh 、 *.txt 全部调用 dos2unix
function dos2unix_dir() {
    
    local dir="$1"
    
    local Err3=3
    local Err3Msg="[Err${Err3}],arg1 dir is empty"
    [[ -z "$dir" ]] && { echo $Err3Msg ; return $Err3 ;}

    local Err4=4
    local Err4Msg="[Err${Err4}],arg1 is not a dir"
    [[ ! -d "$dir" ]] && { echo $Err4Msg ; return $Err4 ;}

    OsCheck #输出变量 OsName 、 isOs_Msys 、isLinux  、 isLinux_ubuntu
    dos2unix --help 1>/dev/null 2>/dev/null || { ( $isOs_Msys && pacman -S --noconfirm dos2unix ) || ( $isLinux_ubuntu && apt install -y dos2unix ) ;}
    find "$dir" -type f \( -name "*.sh" -o -name "*.txt" \) | xargs -I@ dos2unix  --quiet  @

}

#[用法举例]  msWinStylePath=$(msys2_unixStylePath_to_msWin "/d/app2")
#[功能描述]  在msys2下 将 unix风格的路径 "/d/app2" 转为 微软windows风格路径 "D:\app2"
function msys2_unixStylePath_to_msWin() {
    local unixPath="$1"

    local Err5=5 ; local Err5Msg="[Err${Err5}],arg1 unixPath is empty"
    [[ -z "$unixPath" ]] && { echo $Err5Msg >&2 ; return $Err5 ;}

    local msWinPath="$(cygpath   --windows $unixPath)"
    echo $msWinPath
}

#[用法举例]  unixStylePath=$(msys2_msWinStylePath_to_unix "D:\app2")
#[功能描述]  在msys2下 将 微软windows风格路径 "D:\app2" 转为 unix风格的路径 "/d/app2"
function msys2_msWinStylePath_to_unix() {
    local msWinPath="$1"

    local Err5=5 ; local Err5Msg="[Err${Err5}],arg1 msWinPath is empty"
    [[ -z "$msWinPath" ]] && { echo $Err5Msg >&2 ; return $Err5 ;}

    local unixPath="$(cygpath   --unix $msWinPath)"
    echo $unixPath
}

#[用法举例]  is_msWinStylePath "D:\app2" && echo "是 微软windows风格路径"
#[功能描述]  判断给定路径 是否 微软windows风格路径 
#[内部逻辑]  windows风格路径   以 '字母 冒号 反斜线' 开头 ,  比如 "C:\" 
function is_msWinStylePath() {
    local path="$1"

    local Err5=5 ; local Err5Msg="[Err${Err5}],参数1 $path 的反斜线(转义符) 被吃了 请将一个反斜线换成两个 或 用双引号包裹 为 比如 “C:\app2” ? "

    local Err6=6 ; local Err6Msg="[Err${Err6}],参数1 path 为空"
    [[ -z "$path" ]] && { echo $Err6Msg >&2 ; return $Err6 ;}

    local TRUE=0; local FALSE=1
    
    #windows风格路径   以 '字母 冒号 反斜线' 开头 ,  比如 "C:\"
    local startWithLetterColonBacklash=$FALSE; [[ "$path" =~ ^[a-zA-Z]:\\ ]] && startWithLetterColonBacklash=$TRUE

    #若遇到 比如 "C:app2" ,这可能是 输入参数是 C:\app2 导致的, 提醒写作 C:\\app2 或者加引号 "C:\app2"
    # 以 "C:" 开头 但不以 "C:\" 开头 == 以 "C:字母" 开头 
    [[ $startWithLetterColonBacklash -eq $FALSE ]]  &&  [[ "$path" =~ ^[a-zA-Z]: ]] && { echo $Err5Msg && exit $Err5 ;}
    
    return $startWithLetterColonBacklash
}


export powersh=$(msys2_msWinStylePath_to_unix  "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe")

