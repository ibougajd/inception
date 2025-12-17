# User Documentation

## Service Overview
This stack provides a fully functional WordPress website served over HTTPS.

- **NGINX**: The web server handling secure (SSL/TLS) connections.
- **WordPress**: The Content Management System (CMS).
- **MariaDB**: The database storing WordPress content.

## How to Start and Stop
The project is managed via a `Makefile` at the root of the repository.

### Start
To build and start all services in the background:
```bash
make
```

### Stop
To stop the running services:
```bash
make down
```

## Access the Services
### Website
Once the services are running, you can access the WordPress site at:
**[https://ibougajd.42.fr](https://ibougajd.42.fr)**

*Note: Since the SSL certificate is self-signed, your browser will display a security warning. You must accept the risk/proceed to access the site.*

### Administration Panel
To manage the WordPress site, access the admin dashboard at:
**[https://ibougajd.42.fr/wp-admin](https://ibougajd.42.fr/wp-admin)**

## Credentials
Credentials for the services are configured via the `.env` file in `srcs/.env` and secrets management.

- **Database Host**: `mariadb`
- **Database Name**: Configured in `.env` (`DB_NAME`)
- **Database User**: Configured in `.env` (`DB_USER`)
- **WordPress Admin**: Credentials are set during the initial installation via `wp core install` in `srcs/requirements/wordpress/tools/start.sh`.

## Verification
To check that the services are running correctly:

1.  **Check Container Status**:
    ```bash
    docker compose -f srcs/docker-compose.yml ps
    ```
    You should see three services (`nginx`, `wordpress`, `mariadb`) with status `Up`.

2.  **View Logs**:
    If a service is not behaving as expected, check the logs (e.g., for nginx):
    ```bash
    docker compose -f srcs/docker-compose.yml logs nginx
    ```
