FROM php:8.1-fpm-alpine


WORKDIR /var/www/html/

RUN docker-php-ext-install pdo pdo_mysql sockets
RUN curl -sS https://getcomposer.org/installer​ | php -- \
     --install-dir=/usr/local/bin --filename=composer

COPY . .
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev --no-scripts --no-progress --prefer-dist

RUN apk update && apk add --no-cache nginx
EXPOSE 80
COPY ./nginx/default.conf /etc/nginx/conf.d/
COPY ./nginx/nginx.conf /etc/nginx/

RUN addgroup -g 1000 --system laravel
RUN adduser -G laravel --system -D -s /bin/sh -u 1000 laravel

RUN sed -i "s/user = www-data/user = laravel/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = laravel/g" /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf



CMD sh -c nginx && php-fpm -y /usr/local/etc/php-fpm.conf -R
