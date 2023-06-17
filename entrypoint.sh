#!/bin/sh


sed -i "s/DB_HOST=/DB_HOST=$DATABASE_HOST/" /var/www/html/.env
sed -i "s/DB_PORT=/DB_PORT=$DB_PORT/" /var/www/html/.env
sed -i "s/DB_DATABASE=/DB_DATABASE=$DATABASE_DB/" /var/www/html/.env
sed -i "s/DB_USERNAME=/DB_USERNAME=$DB_USER/" /var/www/html/.env
sed -i "s/DB_PASSWORD=/DB_PASSWORD=$DB_PASS/" /var/www/html/.env



php artisan migrate 

