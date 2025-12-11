FROM alpine:latest

# 1. Install Nginx
RUN apk add --no-cache nginx

# 2. Remove default configuration (optional, but clean)
RUN rm -f /etc/nginx/http.d/default.conf

# 3. Copy our custom configuration
COPY nginx/default.conf /etc/nginx/http.d/default.conf

# 4. Expose the standard web port
EXPOSE 80

# 5. Create directory for PID file (needed for Nginx on Alpine)
RUN mkdir -p /run/nginx

# 6. Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
