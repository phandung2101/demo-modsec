FROM owasp/modsecurity-crs:3.3.4-nginx-alpine-202301110601@sha256:46c78b60dff1c3767782d147657ff1058f99b3e538eeb6149b1ccd76bf582a34

# Copy Nginx configuration
COPY default.conf /etc/nginx/templates/conf.d/default.conf.template

# Copy custom ModSecurity rules
COPY custom-rules.conf /etc/modsecurity.d/owasp-crs/rules/REQUEST-1001-BLOCKING-BRUTE-FORCE.conf