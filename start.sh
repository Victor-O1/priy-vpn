#!/bin/bash

PASSWORD=${SS_PASSWORD:-YourStrongPassword123!}
PORT=${SS_PORT:-8388}
METHOD=${SS_METHOD:-aes-256-cfb}
RENDER_URL=${RENDER_URL:-http://localhost:8388}

echo "========================================="
echo "  Shadowsocks VPN Server Starting..."
echo "  Port:     $PORT"
echo "  Method:   $METHOD"
echo "  Self-ping URL: $RENDER_URL"
echo "========================================="

# Write config dynamically from env vars
cat > /etc/shadowsocks/config.json << CONF
{
    "server": "0.0.0.0",
    "server_port": $PORT,
    "password": "$PASSWORD",
    "timeout": 300,
    "method": "$METHOD"
}
CONF

# Setup cronjob to ping self every 5 minutes
echo "*/5 * * * * curl -s $RENDER_URL > /dev/null 2>&1" | crontab -
service cron start
echo "[✓] Cronjob started — pinging every 5 minutes"

# Start shadowsocks (python version — no special permissions needed)
exec ssserver -c /etc/shadowsocks/config.json -d start --log-file /dev/stdout --pid-file /tmp/ss.pid

# Keep container alive
tail -f /dev/null
