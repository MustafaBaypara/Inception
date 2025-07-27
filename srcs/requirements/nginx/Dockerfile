FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

EXPOSE 443

COPY ./conf/default.conf /etc/nginx/sites-enabled/default
COPY ./tools/mkcert.sh /var/www

RUN chmod +x /var/www/mkcert.sh

ENTRYPOINT ["var/www/mkcert.sh"] 

CMD ["nginx", "-g", "daemon off;"]

