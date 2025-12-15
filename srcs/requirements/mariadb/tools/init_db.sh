#!/bin/sh

# Wait for MariaDB to be ready (try without password first, then with password)
MAX_ATTEMPTS=30
ATTEMPT=0
while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
  if mysqladmin ping -h localhost --silent 2>/dev/null; then
    break
  fi
  sleep 1
  ATTEMPT=$((ATTEMPT + 1))
done

if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
  echo "ERROR: MariaDB did not become ready in time"
  exit 1
fi

# Try to connect without password first (fresh install)
if mysql -u root -e "SELECT 1" 2>/dev/null; then
  ROOT_AUTH=""
  # Set root password if provided
  if [ -n "$DB_ROOT_PASSWORD" ]; then
    mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
    ROOT_AUTH="-p${DB_ROOT_PASSWORD}"
  fi
else
  # Already has password, use it
  if [ -n "$DB_ROOT_PASSWORD" ]; then
    ROOT_AUTH="-p${DB_ROOT_PASSWORD}"
  else
    echo "ERROR: MariaDB requires root password but DB_ROOT_PASSWORD not set"
    exit 1
  fi
fi

# Create database and user from environment variables
mysql -u root $ROOT_AUTH <<EOF
CREATE DATABASE IF NOT EXISTS \`\${DB_NAME}\`;
CREATE USER IF NOT EXISTS '\${DB_USER}'@'%' IDENTIFIED BY '\${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`\${DB_NAME}\`.* TO '\${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "Database and user created successfully!"
