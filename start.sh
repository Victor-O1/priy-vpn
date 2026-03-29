#!/bin/bash

# Use environment variables if set, otherwise use defaults
PASSWORD=${SS_PASSWORD:-YourStrongPassword123!}
PORT=${SS_PORT:-8388}
METHOD=${SS_METHOD:-aes-256-gcm}
RENDER_URL=${RENDER_URL:-http://localhost:8388}

echo "========================================="
echo "  Shadowsocks VPN Server Starting..."
echo "  Port:     $PORT"
echo "  Method:   $METHOD"
echo "  Self-ping URL: $RENDER_URL"
echo "========================================="

# Create cronjob to ping self every 5 minutes (prevents Render sleep)
echo "*/5 * * * * curl -s $RENDER_URL > /dev/null 2>&1" | crontab -

# Start cron daemon in background
service cron start
echo "[✓] Cronjob started — server will self-ping every 5 minutes"

# Start shadowsocks server (foreground)
exec ss-server \
    -s 0.0.0.0 \
    -p $PORT \
    -k $PASSWORD \
    -m $METHOD \
    -t 300 \
    --fast-open \
    -u \
    -v
