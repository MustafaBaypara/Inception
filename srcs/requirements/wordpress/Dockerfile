FROM debian:bullseye

# Gerekli paketleri yükle
RUN apt-get update && apt-get install -y \
    wget curl lsb-release ca-certificates apt-transport-https gnupg2 unzip mariadb-client \
    && wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt-get update && apt-get install -y \
    php8.0 php8.0-fpm php8.0-mysql php8.0-cli php8.0-mbstring php8.0-curl php8.0-xml php8.0-zip php8.0-gd php8.0-redis \
    && rm -rf /var/lib/apt/lists/*

# WP-CLI yükle
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# php-fpm çalışabilsin diye
RUN mkdir -p /run/php

# Nginx veya başka bir şey koymazsak, sadece PHP-FPM çalıştıracağız
WORKDIR /var/www/html

# config dosyalarını ve scriptleri koy (senin ayarlarına göre)
COPY ./conf/www.conf /etc/php/8.0/fpm/pool.d/www.conf
COPY ./tools/create_wordpress.sh /usr/local/bin/create_wordpress.sh

RUN chmod +x /usr/local/bin/create_wordpress.sh

# Port aç (php-fpm 9000'de çalışır)
EXPOSE 9000

# Önce WordPress kurulacak, sonra php-fpm başlatılacak
ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]

CMD ["php-fpm8.0", "-F"]
