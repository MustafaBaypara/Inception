-- Veritabanı oluşturma
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- Kullanıcı oluşturma
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

-- Kullanıcıya tüm ayrıcalıkları verme
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

-- İzinlerin etkinleştirilmesi
FLUSH PRIVILEGES;

-- Root şifresini değiştirme
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
