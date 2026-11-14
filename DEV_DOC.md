# DEV_DOC.md - Developer Documentation

This document provides technical instructions for developers to set up, build, and manage the Inception infrastructure.

## 1. Environment Setup

### Prerequisites
Ensure the following tools are installed on your host machine:
* Docker
* Docker Compose
* Make

### Domain Configuration
You must route the project's domain to your localhost. Edit your `/etc/hosts` file (requires root privileges) and add:
```text
127.0.0.1 nfelten.42.fr
```

### Secrets and Configuration Files
The project relies on a `.env` file for all sensitive credentials. This file must never be committed to version control.
1. Create a file named `.env` in the `srcs/` directory.
2. Add the following variables (replace placeholder values with strong passwords):

```env
# MySQL Setup
SQL_DATABASE=wordpress
SQL_USER=wp_user
SQL_PASSWORD=wp_password
SQL_ROOT_PASSWORD=root_password
SQL_HOST=mariadb:3306

# WordPress Setup
DOMAIN_NAME=nfelten.42.fr
WP_ADMIN_USER=wp_admin
WP_ADMIN_PASSWORD=admin_password
WP_ADMIN_EMAIL=admin@nfelten.42.fr
WP_USER=wp_user
WP_USER_PASSWORD=user_password
WP_USER_EMAIL=user@nfelten.42.fr
```

## 2. Build and Launch the Project

The project is managed via a `Makefile` located at the root of the repository.

* **Build and start all services in the background:**
  ```bash
  make
  ```
  *Under the hood, this executes:* `docker-compose -f srcs/docker-compose.yml up -d --build`

* **Stop the services safely:**
  ```bash
  make down
  ```

## 3. Container and Volume Management

Here are the essential commands for debugging and managing the Docker environment:

* **Check running containers:**
  ```bash
  docker ps
  ```
* **View service logs:**
  ```bash
  docker logs <container_name> # e.g., docker logs mariadb
  ```
* **Open a shell inside a running container (useful for debugging):**
  ```bash
  docker exec -it <container_name> sh
  ```
* **Full clean-up (Remove containers, networks, images, and volumes):**
  ```bash
  make fclean
  ```

## 4. Data Storage and Persistence

To ensure that website content and database entries are not lost when containers are stopped or removed, the project uses Docker volumes bound to the host machine.

* **Host Paths:** The data is persistently stored in the host machine's home directory.
  * **WordPress Data:** `/home/nfelten/data/wordpress` (Contains core WP files, themes, and plugins)
  * **MariaDB Data:** `/home/nfelten/data/mariadb` (Contains the raw database files)
  
* **Docker Volumes:** These host directories are mounted to the containers via the `docker-compose.yml` file. This architecture ensures that even if the `mariadb` or `wordpress` containers are completely rebuilt, the data remains intact and persistent across sessions.