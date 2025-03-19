FROM owasp/modsecurity-crs:3.3.4-nginx-alpine-202301110601@sha256:46c78b60dff1c3767782d147657ff1058f99b3e538eeb6149b1ccd76bf582a34

# Cài đặt fail2ban và các gói phụ thuộc
RUN apk add --no-cache fail2ban python3 py3-pyinotify bash iptables procps

# Đảm bảo các thư mục cần thiết tồn tại
RUN mkdir -p /var/log/nginx /var/run/fail2ban /etc/fail2ban/filter.d

# Copy Nginx configuration
COPY default.conf /etc/nginx/templates/conf.d/default.conf.template

# Copy các file cấu hình fail2ban
COPY fail2ban/jail.d/juiceshop.conf /etc/fail2ban/jail.d/juiceshop.conf
COPY fail2ban/filter.d/juiceshop.conf /etc/fail2ban/filter.d/juiceshop.conf

# Tạo script khởi động và cài đặt quyền thực thi
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Khởi động cả fail2ban và nginx
ENTRYPOINT ["/start.sh"]