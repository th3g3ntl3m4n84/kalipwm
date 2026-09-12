#!/usr/bin/env bash
# Prints "<icon> <ip>" for a VPN interface, or nothing if it's down.
#
# polybar's internal/network module only detects an interface if it
# already exists when polybar starts, so it never notices a tun
# interface that appears later when a VPN connects. This script polls
# `ip` directly instead, so the module updates live on connect/disconnect.
#
# Usage: vpn-status.sh <interface> <icon> <hex-color>

iface="$1"
icon="$2"
color="$3"

ip=$(ip -4 -o addr show dev "$iface" 2>/dev/null | awk '{print $4}' | cut -d/ -f1)

if [[ -n "$ip" ]]; then
	echo "%{F${color}}${icon} %{F-}${ip}"
fi
