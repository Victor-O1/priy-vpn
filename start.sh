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
    "server_port": 10000,
    "password": "$PASSWORD",
    "timeout": 300,
    "method": "$METHOD"
}
CONF

# Cronjob to keep Render awake
echo "*/5 * * * * curl -s $RENDER_URL > /dev/null 2>&1" | crontab -
service cron start
echo "[✓] Cronjob started"

# Start tiny HTTP health check server on port 10000 (Render needs this)
while true; do
    echo -e "HTTP/1.1 200 OK\r\nContent-Length: 2\r\n\r\nOK" | nc -l -p 10000 -q 1
done &
echo "[✓] Health check server started on port 10000"

# Start shadowsocks-rust
exec ssserver -c /etc/shadowsocks/config.json