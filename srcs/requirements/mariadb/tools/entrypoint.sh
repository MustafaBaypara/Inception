#!/bin/bash
set -e

envsubst < /var/www/init.sql.template > /var/www/init.sql

service mariadb start

mysql < /var/www/init.sql

rm -f /var/www/init.sql

exec mysqld
