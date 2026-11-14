FROM	debian:bookworm
RUN	apt update -y
RUN	apt upgrade -y
RUN	apt install nginx -y
RUN	apt install vim -y
RUN	mkdir -p /etc/nginx/ssl
RUN	apt install openssl -y
RUN	openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=nofelten.42.fr/UID=nofelten"
RUN	mkdir -p /var/run/nginx
COPY	conf/nginx.conf /etc/nginx/nginx.conf
RUN	mkdir -p /var/www/wordpress
RUN	chmod 755 /var/www/wordpress
RUN	chown -R www-data:www-data /var/www/wordpress
CMD	[ "nginx", "-g", "daemon off;" ]

