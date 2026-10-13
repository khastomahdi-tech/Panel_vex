#!/bin/sh
set -eu
PORT_VALUE="${PORT:-8080}"
# Railway assigns PORT dynamically; configure Apache to listen on that port.
sed -i "s/^Listen 80$/Listen ${PORT_VALUE}/" /etc/apache2/ports.conf
sed -i "s/<VirtualHost \*:80>/<VirtualHost *:${PORT_VALUE}>/" /etc/apache2/sites-available/000-default.conf
mkdir -p /var/www/html/data/uploads /var/www/html/data/audio
chown -R www-data:www-data /var/www/html/data
exec apache2-foreground
