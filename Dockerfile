FROM php:8.2-fpm

# Added nodejs and npm to the installation list
RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip nodejs npm
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www
COPY . /var/www

RUN composer install --no-interaction --prefer-dist --no-progress --ignore-platform-req=php

RUN cp .env.example .env
RUN php artisan key:generate
RUN touch database/database.sqlite
RUN php artisan migrate --force

# Install Node dependencies and compile frontend assets
RUN npm install
RUN npm run build

RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache database/database.sqlite

EXPOSE 8000
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
