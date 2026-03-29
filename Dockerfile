FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    curl \
    cron \
    wget \
    xz-utils \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Install shadowsocks-rust
RUN wget -q https://github.com/shadowsocks/shadowsocks-rust/releases/download/v1.20.4/shadowsocks-v1.20.4.x86_64-unknown-linux-gnu.tar.xz \
    && tar -xf shadowsocks-v1.20.4.x86_64-unknown-linux-gnu.tar.xz \
    && mv ssserver /usr/local/bin/ssserver \
    && chmod +x /usr/local/bin/ssserver \
    && rm -f *.tar.xz sslocal ssurl ssmanager ssservice

# Install v2ray-plugin (tunnels Shadowsocks through WebSocket/HTTPS)
RUN wget -q https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.3.2/v2ray-plugin-linux-amd64-v1.3.2.tar.gz \
    && tar -xzf v2ray-plugin-linux-amd64-v1.3.2.tar.gz \
    && mv v2ray-plugin_linux_amd64 /usr/local/bin/v2ray-plugin \
    && chmod +x /usr/local/bin/v2ray-plugin \
    && rm -f v2ray-plugin-linux-amd64-v1.3.2.tar.gz

COPY config.json /etc/shadowsocks/config.json
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8388
EXPOSE 10000

CMD ["/start.sh"]