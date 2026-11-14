#!/bin/bash

sleep 10

cd /var/www/wordpress

if [ ! -e wp-config.php ]; then
    echo "Configuration de WordPress..."
    
    wp config create    --allow-root \
                        --dbname=$SQL_DATABASE \
                        --dbuser=$SQL_USER \
                        --dbpass=$SQL_PASSWORD \
                        --dbhost=mariadb:3306 \
                        --path='/var/www/wordpress'

    wp core install     --allow-root \
                        --url=$DOMAIN_NAME \
                        --title="Mon Super Site" \
                        --admin_user=$WP_ADMIN_USER \
                        --admin_password=$WP_ADMIN_PASSWORD \
                        --admin_email=$WP_ADMIN_EMAIL

    wp user create      --allow-root \
                        $WP_USER_LOGIN $WP_USER_EMAIL \
                        --user_pass=$WP_USER_PASSWORD \
                        --role=author
fi

echo "Démarrage de PHP-FPM..."
exec php-fpm8.2 -F
