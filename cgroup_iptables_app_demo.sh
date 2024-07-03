
#!/bin/bash

#【描述】  （草稿例子,不稳定,成功过一次）cgroup+iptabls 转发 给定pid进程的 github流程 到 外部clash代理机
#【备注】    
#【依赖】   
#【术语】 
#【用法举例】 


#iptabls的几个表:, 表 又叫 chain?
#mangle: 修饰
#filter: 过滤
#nat:    转换

####工具
function iptablesLs(){ sudo iptables -t $1 -L $2 --line-numbers; }
function iptablesDel(){ sudo iptables -t $1 -D $2 $3; }
function iptablesDelAllInGrp(){
local OK=0
local tab=$1 #mangle  filter  nat
local cond=$2 #POSTROUTING PREROUTING
local lineCnt=$(iptablesLs $tab $cond | tail -n +3 | wc -l)
[[ $lineCnt -eq '0' ]] && return $OK

iptablesLs nat POSTROUTING  | tail -n +3 | tr --squeeze-repeats " " | cut --fields=1 --delimiter=" " | while IFS= read -r LineK; do echo "del LineK=$LineK"; iptablesDel $tab $cond $LineK ; done
}


#1.建立cgroup
sudo mkdir /sys/fs/cgroup/net_cls
sudo mount -t cgroup2 net_cls /sys/fs/cgroup/net_cls

sudo mkdir /sys/fs/cgroup/net_cls/github

# sudo iptables -t mangle -A PREROUTING -p tcp --dport 443 -d github.com -j TPROXY --on-port 7890 --tproxy-mark 0x1/0x1
# sudo iptables -t mangle -L PREROUTING --line-numbers


# sudo ip rule add fwmark 0x1 table 100
# sudo ip route add local 0.0.0.0/0 dev lo table 100


#2. 转发去github的到代理机
# ProxyHostIpPort=10.0.4.9:7890
# MyHostIp=10.0.4.230
sudo iptables -t nat -A PREROUTING -p tcp --dport 443 -d github.com -j DNAT --to-destination 10.0.4.9:7890
sudo iptables -t nat -A POSTROUTING -p tcp --dport 7890 -j SNAT --to-source 10.0.4.230
sudo iptables -A INPUT -p udp --dport 53 -j ACCEPT
sudo iptables -t mangle -I PREROUTING -p udp --dport 53 -j ACCEPT
sudo iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
sudo iptables -t nat -I PREROUTING -p udp --dport 53 -j ACCEPT
sudo iptables -t nat -I POSTROUTING -p udp --dport 53 -j ACCEPT
sudo systemctl restart systemd-networkd


#尝试调试iptables
# sudo iptables -t raw -A OUTPUT -p icmp -j TRACE 
# sudo iptables -t raw -A PREROUTING -p icmp -j TRACE
# sudo iptables -t raw -A INPUT -p udp --dport 53 -j TRACE
# 报错: iptables: No chain/target/match by that name.
# sudo iptables -t raw -A OUTPUT -p udp --dport 53 -j TRACE

# iptablesLs nat POSTROUTING
# iptablesLs nat PREROUTING
# iptablesLs mangle POSTROUTING
# iptablesLs mangle PREROUTING
# iptablesLs filter INPUT ; iptablesDel filter INPUT 1
# iptablesLs filter OUTPUT; iptablesDel filter OUTPUT 1

# iptablesDel nat POSTROUTING 2; iptablesDel nat POSTROUTING 1
# iptablesDel nat PREROUTING  1
# iptablesDel mangle PREROUTING 1


#不带编号的查看全部规则
# sudo iptables-save
#查看规则编号
sudo iptables -t nat -L PREROUTING --line-numbers #nat 且 PREROUTING
#删除指定编号的规则
# sudo iptables -t nat -D PREROUTING 指定编号
sudo iptables -t nat -L POSTROUTING --line-numbers #nat 且 POSTROUTING

#4. 目标应用进程pid加入 刚建立的cgroup
target_pid=$(pidof Obsidian-1.6.5.AppImage)
echo $target_pid | sudo tee -a /sys/fs/cgroup/net_cls/github/cgroup.procs

#当前bash进程加入
echo $$ | sudo tee -a /sys/fs/cgroup/net_cls/github/cgroup.procs


#5. 使用

nohup /app/pack/Obsidian-1.6.5.AppImage  &
# 设置 --> 第三方插件 --> 安全模式:关闭 , 安全模式:开启,  安全模式:关闭  (为了强迫重新请求github域名?) -->     社区插件市场:浏览  --> Excalidraw : 安装 : 启用

#6. 卸载
sudo unmount  net_cls 