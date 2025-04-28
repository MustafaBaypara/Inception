#!/bin/bash

# MariaDB ilk kez başlıyorsa database'i oluştur
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql

    echo "Starting temporary MariaDB server..."
    mysqld_safe --skip-networking &

    sleep 5  # MariaDB başlatmak için biraz bekle

    echo "Creating database and user..."
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'mbaypara'@'%' IDENTIFIED BY 'mbaypara123';
GRANT ALL PRIVILEGES ON wordpress.* TO 'mbaypara'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root123';
EOF

    echo "Stopping temporary MariaDB server..."
    mysqladmin -uroot -proot123 shutdown
fi

# MariaDB başlat
exec mysqld
