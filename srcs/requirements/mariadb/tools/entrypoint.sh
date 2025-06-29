#!/bin/bash

# Eğer veritabanı daha önce kurulmamışsa:
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Veritabanı başlatılıyor..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql

    echo "Geçici MariaDB sunucusu başlatılıyor..."
    mysqld_safe --skip-networking &
    sleep 5

    echo "Kullanıcılar ve veritabanı oluşturuluyor..."
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
    mysql -e "FLUSH PRIVILEGES;"

    echo "Kurulum tamamlandı."
    
    # Geçici mysqld'yi kapat
    mysqladmin shutdown
    sleep 
fi

# Ana mysqld'yi başlat (sadece bir tane)
echo "mysqld başlatılıyor..."
exec mysqld_safe