FROM owasp/modsecurity-crs:3.3.4-nginx-alpine-202301110601@sha256:46c78b60dff1c3767782d147657ff1058f99b3e538eeb6149b1ccd76bf582a34

# Cài đặt fail2ban và các gói phụ thuộc
RUN apk add --no-cache fail2ban python3 bash

# Tạo thư mục log để lưu các file log của Nginx
RUN mkdir -p /var/log/nginx

# Copy Nginx configuration
COPY default.conf /etc/nginx/templates/conf.d/default.conf.template

# Copy cấu hình fail2ban
COPY fail2ban/jail.local /etc/fail2ban/jail.local
COPY fail2ban/filter.d/juiceshop.conf /etc/fail2ban/filter.d/juiceshop.conf
COPY start.sh /start.sh

RUN chmod +x /start.sh

# Khởi chạy cả nginx và fail2ban
ENTRYPOINT ["/start.sh"]