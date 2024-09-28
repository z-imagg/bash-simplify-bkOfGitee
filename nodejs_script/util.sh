#!/bin/bash

function OsCheck() {
OsName=(uname --operating-system)
isOs_Msys=false ; [[ $OsName=="Msys" ]] && isOs_Msys=true
# isLinux == ! isOs_Msys
isLinux=false; $isOs_Msys || isLinux=true

isLinux_ubuntu=false; $isLinux &&    [[  -f /etc/isssue ]] && grep -i "Ubuntu" /etc/isssue  && isLinux_ubuntu=true
}

#[用法举例] dos2unix_dir /.../nodejs_script/
#[功能描述] 将  目录 /.../nodejs_script/ 下的 *.sh 、 *.txt 全部调用 dos2unix
function dos2unix_dir() {
    
    local dir="$1"
    
    local Err3=3
    local Err3Msg="[Err${Err3}],arg1 dir is empty"
    [[ -z "$dir" ]] && { echo $Err3Msg ; exit $Err3 ;}

    local Err4=4
    local Err4Msg="[Err${Err4}],arg1 is not a dir"
    [[ ! -d "$dir" ]] && { echo $Err4Msg ; exit $Err4 ;}

    OsCheck
    dos2unix --help 1>/dev/null 2>/dev/null || { ( $isOs_Msys && pacman -S --noconfirm dos2unix ) || ( $isLinux_ubuntu && apt install -y dos2unix ) ;}
    find "$dir" -type f \( -name "*.sh" -o -name "*.txt" \) | xargs -I@ dos2unix @

}
