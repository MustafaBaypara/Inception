#!/bin/sh

cd /var/www/html

# Veritabanı hazır olana kadar bekle
until mysqladmin ping -h"$MYSQL_HOSTNAME" --silent; do
    echo "Waiting for MySQL..."
    sleep 2
done

if [ ! -f ./wp-config.php ]; then
    echo "Downloading WordPress..."
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    mv wordpress/* .
    rm -rf wordpress latest.tar.gz

    echo "Creating wp-config.php..."
    wp config create --allow-root \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="$MYSQL_HOSTNAME"

    echo "Installing WordPress core..."
    wp core install --allow-root \
        --url="$DOMAIN_NAME" \
        --title="Inception WordPress" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"
fi

exec "$@"
