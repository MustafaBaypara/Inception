# Dockerfile

FROM debian:bullseye

# Paketleri yükle
RUN apt-get update && apt-get install -y \
    php \
    php-mysqli \
    php-pdo \
    php-pgsql \
    php-sqlite3 \
    php-xml \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Adminer'i indir
RUN mkdir -p /var/www/html
RUN wget -O /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

# Çalışma dizinini ayarla
WORKDIR /var/www/html

# Port aç
EXPOSE 8080

# Basit bir PHP server başlat
CMD ["php", "-S", "0.0.0.0:8080"]
