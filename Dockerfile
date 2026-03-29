# Python 3.9 — shadowsocks is compatible with this version
FROM python:3.9-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    cron \
    && rm -rf /var/lib/apt/lists/*

# Install shadowsocks
RUN pip install shadowsocks

# Copy files
COPY config.json /etc/shadowsocks/config.json
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8388

CMD ["/start.sh"]
