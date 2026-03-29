#!/bin/bash

# Use environment variables if set, otherwise use config.json defaults
PASSWORD=${SS_PASSWORD:-YourStrongPassword123!}
PORT=${SS_PORT:-8388}
METHOD=${SS_METHOD:-aes-256-gcm}

echo "========================================="
echo "  Shadowsocks VPN Server Starting..."
echo "  Port:     $PORT"
echo "  Method:   $METHOD"
echo "========================================="

# Start shadowsocks server
exec ss-server \
    -s 0.0.0.0 \
    -p $PORT \
    -k $PASSWORD \
    -m $METHOD \
    -t 300 \
    --fast-open \
    -u \
    -v
