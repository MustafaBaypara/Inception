#!/bin/bash

# MariaDB'yi ilk kez başlatmak için init db dizinini kontrol et
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql > /dev/null

    # mysqld'yi arka planda başlat
    mysqld_safe --skip-networking &
    sleep 5

    echo "Running initial SQL script..."
    mysql < /var/www/initial_db.sql

    # mysqld'yi durdur
    mysqladmin shutdown
fi

# Son olarak gerçek mysqld başlatılır
exec mysqld
