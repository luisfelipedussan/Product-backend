FROM php:8.2-fpm

<<<<<<< HEAD
<<<<<<< HEAD
WORKDIR /var/www/html

=======
>>>>>>> 7634fdd94be1416cc55777d4e176f1cfff421b09
=======
>>>>>>> 7634fdd94be1416cc55777d4e176f1cfff421b09
# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
<<<<<<< HEAD
<<<<<<< HEAD
    unzip \
    default-mysql-client
=======
    unzip
>>>>>>> 7634fdd94be1416cc55777d4e176f1cfff421b09
=======
    unzip
>>>>>>> 7634fdd94be1416cc55777d4e176f1cfff421b09

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

<<<<<<< HEAD
<<<<<<< HEAD
# Copy composer files first to leverage Docker cache
COPY composer.json composer.lock ./

# Install dependencies
RUN composer install --no-scripts --no-autoloader --prefer-dist \
    --no-interaction --no-progress \
    --optimize-autoloader

# Copy the rest of the application
COPY . .

# Copy .env.example to .env
RUN cp .env.example .env

# Generate key and optimize
RUN composer dump-autoload --optimize
RUN php artisan key:generate
RUN php artisan config:cache
RUN php artisan route:cache
RUN php artisan view:cache

# Copy and set permissions for the entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage

EXPOSE 8000
CMD ["docker-entrypoint.sh"] 
=======
=======
>>>>>>> 7634fdd94be1416cc55777d4e176f1cfff421b09
# Set working directory
WORKDIR /var/www

# Copy existing application directory
COPY . .

# Install dependencies
RUN composer install

# Set permissions
<<<<<<< HEAD
RUN chown -R www-data:www-data /var/www 
>>>>>>> 7634fdd94be1416cc55777d4e176f1cfff421b09
=======
RUN chown -R www-data:www-data /var/www 
>>>>>>> 7634fdd94be1416cc55777d4e176f1cfff421b09
