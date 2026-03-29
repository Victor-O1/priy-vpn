# 🔒 Self-Hosted Shadowsocks VPN

A self-hosted Shadowsocks VPN server that bypasses DPI firewalls like Fortinet.
Includes a built-in cronjob that pings the server every 5 minutes to prevent
Render's free tier from spinning down.

## 📁 File Structure
```
shadowsocks-vpn/
├── Dockerfile          # Docker image recipe
├── config.json         # Shadowsocks configuration
├── start.sh            # Startup script + cronjob setup
├── docker-compose.yml  # For running locally
├── render.yaml         # For deploying to Render.com
└── README.md           # This file
```

## ⚠️ Before You Deploy — Change Your Password!

Edit these two files and replace `YourStrongPassword123!` with your own password:
- `config.json` → "password" field
- `render.yaml` → SS_PASSWORD value

## 🚀 Deploy to Render.com

1. Push this repo to GitHub
2. Go to render.com → New → Web Service
3. Connect your GitHub repo
4. Render auto-detects the Dockerfile and deploys
5. Copy your app URL (e.g. https://shadowsocks-vpn.onrender.com)
6. Paste it as the RENDER_URL value in render.yaml
7. Redeploy

## ⏰ Cronjob (Anti-Sleep)

The server automatically pings itself every 5 minutes:
```
*/5 * * * * curl -s $RENDER_URL > /dev/null 2>&1
```
This keeps Render's free tier awake 24/7 — no third party needed.

## 📱 Client Configuration

Use these settings in your Shadowsocks app:

| Setting    | Value                    |
|------------|--------------------------|
| Server     | YOUR_RENDER_IP           |
| Port       | 8388                     |
| Password   | YourStrongPassword123!   |
| Encryption | aes-256-gcm              |

## 📲 Client Apps

| Platform | App                    |
|----------|------------------------|
| Android  | Shadowsocks (Max Lv)   |
| iOS      | Potatso Lite (free)    |
| Windows  | Shadowsocks-Windows    |
| Linux    | shadowsocks-libev      |
| Mac      | ShadowsocksX-NG        |

## ⚙️ How It Works

```
Your Device
    ↓  (encrypted, looks like HTTPS)
Fortinet/ISP  ← sees nothing
    ↓
Render Server (always awake via cronjob)
    ↓
Open Internet 🌐
```

## 🔧 Cronjob Syntax Reference

```
*/5 * * * *  = every 5 minutes
0 * * * *    = every hour
0 0 * * *    = every midnight
```
