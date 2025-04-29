FROM debian:bullseye

# Paketleri kur
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld

# Yapılandırma ve init script'lerini kopyala
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools /var/www/

# Veritabanını init eden script'i ayrı çalıştırmak yerine entrypoint'e al
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld"]
