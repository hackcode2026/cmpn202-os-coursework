#!/bin/bash

SERVER_IP="192.168.56.101"
USER="admin"

echo "=============================="
echo " REMOTE SERVER MONITORING"
echo "=============================="
echo

ssh ${USER}@${SERVER_IP} << EOF

echo "[1] Uptime:"
uptime
echo

echo "[2] CPU Load:"
top -bn1 | grep "load average"
echo

echo "[3] Memory Usage:"
free -h
echo

echo "[4] Disk Usage:"
df -h /
echo

echo "[5] Network Interfaces:"
ip addr show
echo

EOF

echo "=============================="
echo " MONITORING COMPLETE"
echo "=============================="
