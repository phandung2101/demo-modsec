#!/bin/bash

# Debug mode
set -x

echo "Configuring fail2ban..."

# Đảm bảo các thư mục tồn tại
mkdir -p /var/log/nginx /var/run/fail2ban

# Tạo các file log nếu chưa tồn tại
touch /var/log/fail2ban.log
touch /var/log/nginx/juiceshop_login.log

# Kiểm tra cấu hình fail2ban
echo "Checking fail2ban configuration..."
fail2ban-client -t || true

# Đảm bảo fail2ban có quyền truy cập vào file log
chmod 644 /var/log/nginx/juiceshop_login.log

# Khởi động fail2ban
echo "Starting fail2ban..."
/usr/bin/fail2ban-client start || true

# Hiển thị trạng thái fail2ban
sleep 2
echo "Fail2ban status:"
/usr/bin/fail2ban-client status || true

# Khởi động jail
echo "Reloading juiceshop jail..."
/usr/bin/fail2ban-client reload || true
/usr/bin/fail2ban-client reload juiceshop || true

# Kiểm tra xem jail juiceshop đã được định nghĩa chưa
echo "Checking juiceshop jail:"
/usr/bin/fail2ban-client status juiceshop || true

# Để fail2ban chạy nền và khởi động nginx
echo "Starting nginx in foreground..."
exec /docker-entrypoint.sh nginx -g "daemon off;"