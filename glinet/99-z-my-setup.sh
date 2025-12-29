#!/bin/sh

# 该脚本文件名为 glinet/99-z-my-setup.sh
# 它的运行顺序在原版 99-custom.sh 之后，用于补充差异化配置

# --- 1. 设置登录密码 (原版不包含) ---
echo -e "w95124578\nw95124578" | passwd root

# --- 2. IPv6 高级设置 (原版不包含) ---
# 开启服务器模式，确保内网设备获得 IPv6 公网地址
uci set dhcp.lan.ra='server'
uci set dhcp.lan.dhcpv6='server'
uci set dhcp.lan.ndp='server'
uci set dhcp.lan.ra_management='1'

# --- 3. 静态 IP 地址分配 (原版不包含) ---
# 这里的 IP 需要与你在 Workflow 中设置的网段 (192.168.6.x) 一致

# DXP4800_LAN1
uci add dhcp host
uci set "dhcp.@host[-1].name=DXP4800_LAN1"
uci set "dhcp.@host[-1].mac=6C:1F:F7:11:27:3E"
uci set "dhcp.@host[-1].ip=192.168.6.7"

# DXP4800_LAN2
uci add dhcp host
uci set "dhcp.@host[-1].name=DXP4800_LAN2"
uci set "dhcp.@host[-1].mac=6C:1F:F7:11:27:3F"
uci set "dhcp.@host[-1].ip=192.168.6.8"

# PVE
uci add dhcp host
uci set "dhcp.@host[-1].name=PVE"
uci set "dhcp.@host[-1].mac=7C:2B:E1:12:F6:5E"
uci set "dhcp.@host[-1].ip=192.168.6.2"

# app-host01
uci add dhcp host
uci set "dhcp.@host[-1].name=app-host01"
uci set "dhcp.@host[-1].mac=BC:24:11:98:BF:BA"
uci set "dhcp.@host[-1].ip=192.168.6.5"

# Debian-01
uci add dhcp host
uci set "dhcp.@host[-1].name=Debian-01"
uci set "dhcp.@host[-1].mac=BC:24:11:98:BF:BB"
uci set "dhcp.@host[-1].ip=192.168.6.6"

# --- 4. 提交更改 ---
uci commit dhcp
uci commit system

exit 0
