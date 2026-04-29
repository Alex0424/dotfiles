#!/bin/bash

IFACE=$(ip route | awk '/default/ {print $5; exit}')
PRIVATE_IP=$(ip -4 addr show "$IFACE" | awk '/inet / {print $2}' | cut -d/ -f1)
PUBLIC_IP=$(curl -s --max-time 2 https://api.ipify.org || echo "N/A")
VPN_STATUS=$(nmcli con show --active | grep -w vpn >/dev/null && echo 'ON' || echo 'OFF')
LINK_SPEED=$(ethtool "$IFACE" 2>/dev/null | awk '/Speed:/ {print $2}')
INTERFACE_STATE=$(cat /sys/class/net/"$IFACE"/operstate)
GATEWAY=$(ip route | awk '/default/ {print $3}')
LATENCY=$(ping -c 1 1.1.1.1 | awk -F'=' '/time=/{print $4}')
DNS=$(resolvectl dns | awk '{for(i=3;i<=NF;i++) print $i}')

echo Routing:
ip route
echo
echo -e "DNS Servers:\n$DNS"
echo
echo Packet errors:
echo recieved: $(cat /sys/class/net/"$IFACE"/statistics/rx_errors)
echo transmit: $(cat /sys/class/net/"$IFACE"/statistics/tx_errors)
echo
echo "Main interface: $IFACE ($INTERFACE_STATE)"
echo "Link speed: $LINK_SPEED"
echo "Latency: $LATENCY"
echo "VPN: $VPN_STATUS"
echo "Gateway: $GATEWAY"
echo "Private IP: $PRIVATE_IP"
echo "Public IP: $PUBLIC_IP"
