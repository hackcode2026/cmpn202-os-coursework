#!/bin/bash

echo "=============================="
echo "  SECURITY BASELINE CHECK"
echo "=============================="
echo

# 1. SSH service status
echo "[1] Checking SSH service status..."
systemctl is-active ssh && echo "SSH is running" || echo "SSH is NOT running"
echo

# 2. SSH hardening settings
echo "[2] Checking SSH hardening settings..."
grep -E "PermitRootLogin|PasswordAuthentication|PubkeyAuthentication" /etc/ssh/sshd_config | grep -v '^#'
echo

# 3. Firewall status
echo "[3] Checking UFW firewall status..."
ufw status verbose
echo

# 4. Fail2Ban status
echo "[4] Checking Fail2Ban service..."
systemctl is-active fail2ban && echo "Fail2Ban is running" || echo "Fail2Ban is NOT running"
echo

# 5. Fail2Ban SSH jail
echo "[5] Checking Fail2Ban SSH jail..."
fail2ban-client status sshd 2>/dev/null || echo "Fail2Ban SSH jail not accessible (run as root)"
echo

# 6. Automatic updates
echo "[6] Checking unattended-upgrades configuration..."
grep -R "Unattended-Upgrade" /etc/apt/apt.conf.d/20auto-upgrades
echo

# 7. AppArmor status
echo "[7] Checking AppArmor status..."
aa-status || echo "AppArmor not installed or not accessible"
echo

echo "=============================="
echo " SECURITY BASELINE CHECK DONE"
echo "=============================="
