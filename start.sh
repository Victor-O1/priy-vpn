#!/bin/bash

PASSWORD=${SS_PASSWORD:-YourStrongPassword123!}
PORT=${SS_PORT:-8388}
METHOD=${SS_METHOD:-aes-256-gcm}
RENDER_URL=${RENDER_URL:-https://priy-vpn.onrender.com}

echo "========================================="
echo "  Shadowsocks-Rust VPN Server Starting..."
echo "  Port:     $PORT"
echo "  Method:   $METHOD"
echo "========================================="

# Write config
cat > /etc/shadowsocks/config.json << CONF
{
    "server": "0.0.0.0",
    "server_port": $PORT,
    "password": "$PASSWORD",
    "timeout": 300,
    "method": "$METHOD"
}
CONF

# Cronjob to keep Render awake
echo "*/5 * * * * curl -s $RENDER_URL > /dev/null 2>&1" | crontab -
service cron start
echo "[✓] Cronjob started"

# Start shadowsocks-rust
exec ssserver -c /etc/shadowsocks/config.json