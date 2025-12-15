#!/bin/sh

WP_PATH="/var/www/wordpress"  # change to your WordPress folder

# Check if wp-config.php exists and is valid; if not, copy from sample
if [ ! -f "$WP_PATH/wp-config.php" ] || ! php -l "$WP_PATH/wp-config.php" >/dev/null 2>&1; then
    echo "Creating/regenerating wp-config.php from sample..."
    cp "$WP_PATH/wp-config-sample.php" "$WP_PATH/wp-config.php"
fi

# Replace DB settings with getenv (Alpine BusyBox sed needs empty backup '')
# Match the complete define statement including define( and closing );
sed -i'' "s/define( 'DB_NAME', '[^']*' );/define( 'DB_NAME', getenv('DB_NAME') );/g" "$WP_PATH/wp-config.php"
sed -i'' "s/define( 'DB_USER', '[^']*' );/define( 'DB_USER', getenv('DB_USER') );/g" "$WP_PATH/wp-config.php"
sed -i'' "s/define( 'DB_PASSWORD', '[^']*' );/define( 'DB_PASSWORD', getenv('DB_PASSWORD') );/g" "$WP_PATH/wp-config.php"
sed -i'' "s/define( 'DB_HOST', '[^']*' );/define( 'DB_HOST', getenv('DB_HOST') );/g" "$WP_PATH/wp-config.php"

echo "wp-config.php updated to use environment variables!"