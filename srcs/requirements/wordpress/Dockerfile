FROM	debian:bookworm
RUN	apt-get update -y && apt-get upgrade -y
RUN	apt-get install wget -y
RUN	apt-get install -y php php-fpm php-mysql mariadb-client
RUN	wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN	cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN	chown -R www-data:www-data /var/www/wordpress
RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	chmod +x wp-cli.phar
RUN	mv wp-cli.phar /usr/local/bin/wp
COPY	conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
RUN	mkdir -p /run/php
COPY	tools/auto_config.sh /tools/auto_config.sh
RUN	chmod +x /tools/auto_config.sh
CMD	["/tools/auto_config.sh"]
