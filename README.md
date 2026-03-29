# 🔒 Self-Hosted Shadowsocks VPN

A self-hosted Shadowsocks VPN server that bypasses DPI firewalls like Fortinet.

## 📁 File Structure
```
shadowsocks-vpn/
├── Dockerfile          # Docker image recipe
├── config.json         # Shadowsocks configuration
├── start.sh            # Server startup script
├── docker-compose.yml  # For running locally
├── render.yaml         # For deploying to Render.com
└── README.md           # This file
```

## 🚀 Deploy to Render.com

1. Push this repo to GitHub
2. Go to render.com → New → Web Service
3. Connect your GitHub repo
4. Render auto-detects the Dockerfile and deploys
5. Note your server IP from the Render dashboard

## 📱 Client Configuration

Use these settings in your Shadowsocks app:

| Setting    | Value                    |
|------------|--------------------------|
| Server     | YOUR_RENDER_IP           |
| Port       | 8388                     |
| Password   | YourStrongPassword123!   |
| Encryption | aes-256-gcm              |

## 🔧 Change Your Password

Edit the `SS_PASSWORD` value in `render.yaml` and `config.json`
Then redeploy on Render.

## 📲 Client Apps

| Platform | App              |
|----------|------------------|
| Android  | Shadowsocks      |
| iOS      | Potatso Lite     |
| Windows  | Shadowsocks-Windows |
| Linux    | shadowsocks-libev |
| Mac      | ShadowsocksX-NG  |

## ⚙️ How It Works

```
Your Device
    ↓  (encrypted, looks like HTTPS)
Fortinet/ISP  ← sees nothing
    ↓
Render Server
    ↓
Open Internet 🌐
```
