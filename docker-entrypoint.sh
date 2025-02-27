#!/bin/bash

# Esperar a que MySQL esté listo
echo "Waiting for MySQL to be ready..."
while ! mysqladmin ping -h"$DB_HOST" --silent; do
    sleep 1
done

# Ejecutar migraciones y seeders
echo "Running migrations..."
php artisan migrate:fresh --force

echo "Running seeders..."
php artisan db:seed --force

# Iniciar el servidor
php artisan serve --host=0.0.0.0 --port=8000 