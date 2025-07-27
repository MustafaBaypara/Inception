FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server gettext-base

COPY ./tools /var/www/
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE 3306

ENTRYPOINT ["/var/www/entrypoint.sh"]
CMD ["mysqld"]
