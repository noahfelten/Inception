#!/bin/bash

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# On vérifie si la base de données de WordPress existe déjà
if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then
    echo "Initialisation de la base de données..."
    
    # Lancement de MariaDB en arrière-plan
    mysqld_safe &
    
    # Attente que MariaDB soit prêt à recevoir des commandes
    while ! mysqladmin ping --silent; do
        sleep 1
    done
    
    echo "Création de la base et des utilisateurs..."
    # Configuration SQL
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    mysql -u root -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
    mysql -u root -e "FLUSH PRIVILEGES;"
    
    # On éteint MariaDB proprement en utilisant le NOUVEAU mot de passe root
    mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown
else
    echo "La base de données existe déjà, démarrage normal."
fi

echo "Lancement de MariaDB..."
exec mysqld_safe
