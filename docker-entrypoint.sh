#!/bin/bash

# Configurar nginx para usar el puerto de Heroku
sed -i "s/80/$PORT/g" /etc/nginx/conf.d/default.conf

# Esperar a que MySQL esté listo
echo "Waiting for MySQL to be ready..."
while ! mysqladmin ping -h"$DB_HOST" --silent; do
    sleep 1
done

# Ejecutar migraciones
php artisan migrate --force

# Ejecutar seeders si es necesario
php artisan db:seed --force

# Iniciar nginx
nginx

# Iniciar PHP-FPM
php-fpm 