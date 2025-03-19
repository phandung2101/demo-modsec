FROM owasp/modsecurity-crs:nginx-alpine

# Copy Nginx configuration
COPY default.conf /etc/nginx/templates/conf.d/default.conf.template

# Copy custom ModSecurity rules
COPY custom-rules.conf /etc/modsecurity.d/owasp-crs/rules/REQUEST-1001-BLOCKING-BRUTE-FORCE.conf