FROM php:8.1-fpm-alpine

RUN addgroup -g 1000 --system laravel
RUN adduser -G laravel --system -D -s /bin/sh -u 1000 laravel
RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www/html/
COPY ./php/www.conf /usr/local/etc/php-fpm.d/
COPY ./test-app/ /var/www/html
COPY ./entrypoint.sh .
RUN chown -R laravel: /var/www/html && chmod +x entrypoint.sh


EXPOSE 9000

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer install --no-dev
CMD php-fpm -y /usr/local/etc/php-fpm.conf -R
