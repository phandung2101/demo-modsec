FROM owasp/modsecurity-crs:3.3.4-nginx-alpine-202301110601@sha256:46c78b60dff1c3767782d147657ff1058f99b3e538eeb6149b1ccd76bf582a34

# Cài đặt fail2ban và các gói phụ thuộc
RUN apk add --no-cache fail2ban python3 bash iptables

# Tạo thư mục log để lưu các file log của Nginx
RUN mkdir -p /var/log/nginx

# Copy Nginx configuration
COPY default.conf /etc/nginx/templates/conf.d/default.conf.template

# Tạo cấu trúc thư mục fail2ban
RUN mkdir -p /etc/fail2ban/filter.d

# Copy cấu hình fail2ban
COPY fail2ban/jail.local /etc/fail2ban/jail.local
COPY fail2ban/filter.d/juiceshop.conf /etc/fail2ban/filter.d/juiceshop.conf
COPY start.sh /start.sh

# Đảm bảo script có quyền thực thi
RUN chmod +x /start.sh

# Đảm bảo file cấu hình có quyền đúng
RUN chown -R root:root /etc/fail2ban && \
    chmod -R 644 /etc/fail2ban && \
    chmod 755 /etc/fail2ban/filter.d

# Khởi chạy cả nginx và fail2ban
ENTRYPOINT ["/start.sh"]