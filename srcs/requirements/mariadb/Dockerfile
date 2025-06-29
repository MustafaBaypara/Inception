FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Konfigürasyon dosyasını kopyala
COPY conf/50-server.cnf /etc/mysql/50-server.cnf

# Başlangıç scriptini kopyala ve çalıştırılabilir yap
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

CMD ["/usr/local/bin/entrypoint.sh"]
