FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    curl \
    cron \
    wget \
    xz-utils \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Install shadowsocks-rust (modern, works with OpenSSL 3)
RUN wget -q https://github.com/shadowsocks/shadowsocks-rust/releases/download/v1.20.4/shadowsocks-v1.20.4.x86_64-unknown-linux-gnu.tar.xz \
    && tar -xf shadowsocks-v1.20.4.x86_64-unknown-linux-gnu.tar.xz \
    && mv ssserver /usr/local/bin/ssserver \
    && chmod +x /usr/local/bin/ssserver \
    && rm -f *.tar.xz sslocal ssurl ssmanager ssservice

COPY config.json /etc/shadowsocks/config.json
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8388

CMD ["/start.sh"]