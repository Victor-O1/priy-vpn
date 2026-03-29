FROM python:3.11-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    cron \
    && rm -rf /var/lib/apt/lists/*

# Install shadowsocks python version (works without special Linux capabilities)
RUN pip install shadowsocks

# Copy files
COPY config.json /etc/shadowsocks/config.json
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8388

CMD ["/start.sh"]
