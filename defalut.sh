#!/bin/bash

# ssh ポート番号
ssh_port=22

# チェインを作成する。
iptables -N TCP
iptables -N UDP

# FORWARD チェインを破棄する。
iptables -P FORWARD DROP

# INPUT チェインを破棄する。
iptables -P INPUT DROP

# OUTPUT チェインを許可する。
iptables -P OUTPUT ACCEPT

# 既存のパケットと関係のあるパケットを許可する。
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# ループバックを許可する。
iptables -A INPUT -i lo -j ACCEPT

# 無効状態のパケットを破棄する。
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

# ping を許可する。
# iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT

# 作成した UDP、TCP チェインへのジャンプ条件を設定する。
iptables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
iptables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP

# UDP、TCP のアクセスに対する拒否の条件を指定する。
iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p tcp -j REJECT --reject-with tcp-reset

# 他のプロトコルによるアクセスを拒否する。
iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable

# ssh 接続を許可する。
# iptables -A TCP -p tcp --dport $ssh_port -j ACCEPT

exit 0
