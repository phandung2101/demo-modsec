#!/bin/bash

# Hiển thị các thông báo debug
set -x

# Đảm bảo thư mục socket cho fail2ban tồn tại
mkdir -p /var/run/fail2ban

# Tạo file log cho fail2ban
touch /var/log/fail2ban.log

# Kiểm tra các file cấu hình
echo "Checking fail2ban configuration files..."
ls -la /etc/fail2ban/
ls -la /etc/fail2ban/filter.d/

# Khởi động fail2ban với verbose mode
echo "Starting fail2ban..."
fail2ban-client -x start

# Hiển thị trạng thái và kiểm tra xem fail2ban đã chạy chưa
sleep 2
fail2ban-client ping
fail2ban-client status

# Đảm bảo thư mục log Nginx tồn tại và có quyền truy cập đúng
mkdir -p /var/log/nginx
touch /var/log/nginx/juiceshop_login.log
chmod 644 /var/log/nginx/juiceshop_login.log

# Khởi động Nginx (dùng lệnh khởi động mặc định của container gốc)
echo "Starting Nginx..."
/docker-entrypoint.sh nginx -g "daemon off;"