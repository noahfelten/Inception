*This project has been created as part of the 42 curriculum by nfelten.*

# Inception

## Description
Inception is a system administration project that aims to broaden your knowledge of system administration by using Docker. The goal is to set up a small, fully functional, and secure infrastructure composed of several interconnected services, entirely containerized.

This project deploys a LEMP-like stack using Docker. The infrastructure includes:
* **NGINX:** The web server, acting as the only entry point to the infrastructure, strictly over HTTPS (TLSv1.2 or TLSv1.3).
* **WordPress + PHP-FPM:** The content management system.
* **MariaDB:** The database storing the website's data.

### Use of Docker and Sources
The project is built entirely using Docker. Every service is built from a custom `Dockerfile` based on Alpine Linux (or Debian, depending on the implementation). No pre-built images (like `nginx:latest` or `mariadb:latest`) are used directly without being built from the OS base image. This ensures a deep understanding of how the services are installed and configured from scratch.

### Main Design Choices
* **One Container, One Service:** Each container runs a single main process to follow Docker's best practices.
* **Network Isolation:** Services communicate over a dedicated internal Docker network. The database is never exposed to the host network.
* **Data Persistence:** Data is stored outside the containers to ensure it survives container restarts and rebuilds.

### Architecture Comparisons

#### Virtual Machines vs Docker
* **Virtual Machines (VMs):** Virtualize the entire hardware layer. Each VM runs a full guest Operating System, making them resource-heavy and slow to boot, but offering total isolation.
* **Docker (Containers):** Virtualize the OS layer. Containers share the host machine's OS kernel, making them incredibly lightweight, fast to start, and efficient, though slightly less isolated than VMs.

#### Secrets vs Environment Variables
* **Environment Variables:** Easy to configure (e.g., via a `.env` file) and useful for general configuration. However, they can be exposed in crash dumps, logs, or by child processes.
* **Docker Secrets:** Designed specifically for sensitive data (passwords, certificates). They are encrypted at rest and mounted into containers as in-memory files (tmpfs), making them much more secure for production environments.

#### Docker Network vs Host Network
* **Docker Network (Bridge):** Creates an isolated network for containers. Containers can resolve each other by name (e.g., `ping mariadb`) without exposing their ports to the outside world. This is highly secure.
* **Host Network:** The container shares the host's networking namespace. It uses the host's IP address and ports directly, removing network isolation and increasing the risk of port conflicts and security breaches.

#### Docker Volumes vs Bind Mounts
* **Docker Volumes:** Managed entirely by Docker (usually stored in `/var/lib/docker/volumes`). They are independent of the host system's file structure, easier to back up, and are the recommended way to persist data.
* **Bind Mounts:** Mount a specific path on the host machine (e.g., `/home/nfelten/data`) into the container. They rely on the host's filesystem structure and permissions. This project uses bind mounts as required by the 42 subject to store data in the user's home directory.

## Instructions

### Prerequisites
* Docker and Docker Compose installed.
* `make` utility installed.
* Ensure your local domain points to your local machine. Add the following to your `/etc/hosts` file (requires sudo):
  `127.0.0.1 nfelten.42.fr`

### Configuration
1. Navigate to the `srcs` directory.
2. Create a `.env` file and fill it with your credentials:
   ```env
   SQL_DATABASE=wordpress
   SQL_USER=wp_user
   SQL_PASSWORD=wp_password
   SQL_ROOT_PASSWORD=root_password
   SQL_HOST=mariadb:3306
   DOMAIN_NAME=nfelten.42.fr
   WP_ADMIN_USER=wp_admin
   WP_ADMIN_PASSWORD=admin_password
   WP_ADMIN_EMAIL=admin@example.com
   WP_USER=wp_user
   WP_USER_PASSWORD=user_password
   WP_USER_EMAIL=user@example.com
   ```

### Execution
* **To build and start the infrastructure:** Run `make` at the root of the repository.
* **To stop the infrastructure:** Run `make down`.
* **To completely clean the project (remove containers, images, and data):** Run `make fclean`.

Once running, access the site at `https://nfelten.42.fr`.

## Resources
* **Official Documentation:**
  * [Inception Documentation](https://tuto.grademe.fr/inception/)
  * [Docker Documentation](https://docs.docker.com/)
  * [NGINX Documentation](https://nginx.org/en/docs/)
  * [MariaDB Documentation](https://mariadb.com/kb/en/)
  * [WordPress WP-CLI](https://make.wordpress.org/cli/handbook/)
* **AI Usage:** Artificial Intelligence was used during the development of this project to generate the boilerplate for the documentation files (`README.md`, `USER_DOC.md`, `DEV_DOC.md`), format the Markdown structure, and refine the technical explanations in the architectural comparison section.