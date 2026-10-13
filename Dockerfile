FROM php:8.3-apache-bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng-dev libjpeg62-turbo-dev libfreetype6-dev libwebp-dev \
    libsqlite3-dev unzip \
 && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
 && docker-php-ext-install -j"$(nproc)" pdo_sqlite sqlite3 gd mbstring exif \
 && a2enmod rewrite headers \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html
COPY index.php /var/www/html/index.php
COPY railway-start.sh /usr/local/bin/railway-start.sh
RUN chmod +x /usr/local/bin/railway-start.sh \
 && mkdir -p /var/www/html/data/uploads /var/www/html/data/audio \
 && chown -R www-data:www-data /var/www/html

ENV APACHE_DOCUMENT_ROOT=/var/www/html
EXPOSE 8080
CMD ["/usr/local/bin/railway-start.sh"]
