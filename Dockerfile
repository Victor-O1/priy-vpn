FROM debian:bullseye-slim

# Install shadowsocks-libev, cron, and curl
RUN apt-get update && apt-get install -y \
    shadowsocks-libev \
    wget \
    curl \
    cron \
    && rm -rf /var/lib/apt/lists/*

# Download v2ray-plugin for obfuscation (makes traffic look like HTTPS)
RUN wget -q https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.3.2/v2ray-plugin-linux-amd64-v1.3.2.tar.gz \
    && tar -xzf v2ray-plugin-linux-amd64-v1.3.2.tar.gz \
    && mv v2ray-plugin_linux_amd64 /usr/local/bin/v2ray-plugin \
    && chmod +x /usr/local/bin/v2ray-plugin \
    && rm v2ray-plugin-linux-amd64-v1.3.2.tar.gz

# Copy config and scripts
COPY config.json /etc/shadowsocks-libev/config.json
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose port
EXPOSE 8388

CMD ["/start.sh"]
