#!/bin/bash

# Ortam değişkeni DOMAIN_NAME'i doğrudan kullan
if [ -z "$DOMAIN_NAME" ]; then
    echo "❌ DOMAIN_NAME ortam değişkeni bulunamadı!"
    exit 1
fi

CERT_PATH="/etc/ssl/certs/nginx.crt"
KEY_PATH="/etc/ssl/private/nginx.key"

if [ ! -f "$CERT_PATH" ] || [ ! -f "$KEY_PATH" ]; then
    echo "🔐 Sertifika ve key oluşturuluyor..."

    mkdir -p /etc/ssl/certs /etc/ssl/private

    openssl req -x509 -newkey rsa:2048 \
        -sha256 \
        -nodes \
        -keyout "$KEY_PATH" \
        -out "$CERT_PATH" \
        -days 365 \
        -subj "/C=TR/ST=KOCAELI/L=GEBZE/O=42Kocaeli/CN=${DOMAIN_NAME}"

    echo "✅ Sertifika ve anahtar üretildi."
else
    echo "🔎 Sertifika zaten var, yeniden oluşturulmadı."
fi

exec "$@"
