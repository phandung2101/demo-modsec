#!/bin/bash

# Khởi động fail2ban
fail2ban-client -x start

# Khởi động Nginx (dùng lệnh khởi động mặc định của container gốc)
/docker-entrypoint.sh nginx -g "daemon off;"