# USER_DOC.md - User Documentation

Welcome to the Inception project documentation. This file explains how to start, use, and manage the project in simple terms.

## 1. Services Provided by the Stack
This project runs a complete, secure WordPress website. It uses three main services working together:
* **NGINX:** The web server. It handles secure connections (HTTPS) and displays the website to visitors.
* **WordPress:** The website platform itself, where content is managed and displayed.
* **MariaDB:** The database. It securely stores all the website's data (users, posts, settings).

## 2. Start and Stop the Project
Before starting, ensure your local domain name (usually `[login].42.fr`) points to your local machine in your hosts file.

**To start the project:**
Open your terminal in the folder containing the `Makefile` and run:
```bash
make
```
This will build and start all the necessary services in the background.

**To stop the project:**
To safely stop the services, run:
```bash
make down
```
*(You can also use `make fclean` to stop everything and completely wipe the data and containers if you want to start fresh).*

## 3. Access the Website and Administration Panel
Once the project is running, you can access the website through your web browser.

* **Website Access (Front-end):** Go to `https://[login].42.fr`
  *(Note: Your browser might show a security warning because the SSL certificate is self-signed for development. You can safely accept the risk to proceed).*
* **Admin Panel (Back-end):** Go to `https://[login].42.fr/wp-admin`
  Log in using the WordPress administrator credentials you configured.

## 4. Locate and Manage Credentials
For security reasons, passwords and sensitive information are not written directly into the code. Instead, they are stored in a hidden configuration file named `.env`.

* **Location:** This file must be placed inside the `srcs/` directory.
* **Management:** You must create and fill this file with your own passwords and usernames (for the database, WordPress admin, and standard WordPress user) before running `make` for the first time. 
* **Updating:** If you need to change a password, stop the project (`make down`), edit the `.env` file, and restart the project (`make`).

## 5. Check That the Services Are Running Correctly
To verify that the project is working properly, you can use the following command in your terminal:
```bash
docker ps
```
This will list the running services. You should see three containers (nginx, wordpress, mariadb) up and running.