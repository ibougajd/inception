# Developer Documentation

## Environment Setup

### Prerequisites
Ensure the following are installed on your development machine (Linux VM):
- **Docker Engine**: [Install Guide](https://docs.docker.com/engine/install/)
- **Docker Compose**: [Install Guide](https://docs.docker.com/compose/install/)
- **Make**: Standard build tool.
- **Host entry**: Add `127.0.0.1 ibougajd.42.fr` to your `/etc/hosts` file to resolve the domain locally.

### Configuration
The main configuration file is `srcs/.env`. It contains environment variables for:
- Database credentials (`DB_USER`, `DB_PASSWORD`, `DB_ROOT_PASSWORD`)
- Domain name (`DOMAIN_NAME`)
- WordPress admin and user settings.

**Note**: Ensure the directory `/home/ibougajd/data` exists or modify the `srcs/docker-compose.yml` and `Makefile` to match your home directory if you are not user `ibougajd`.

## Build and Launch
The project uses a `Makefile` to simplify Docker commands.

- **Build images and start containers**:
  ```bash
  make build
  ```
  This runs `docker compose up -d --build`.

- **Start existing containers**:
  ```bash
  make up
  ```

- **Stop containers**:
  ```bash
  make down
  ```

## Architecture
The `docker-compose.yml` file defines the services:

- **nginx**: Built from `srcs/requirements/nginx`. Binds port `443` on host to `443` in container. Depends on `wordpress`.
- **wordpress**: Built from `srcs/requirements/wordpress`. Exposes port `9000` (internal). Depends on `mariadb`.
- **mariadb**: Built from `srcs/requirements/mariadb`. Exposes port `3306` (internal).

All services use the custom `debian:bullseye` base image.

## Persistence
Data persistence is handled via Docker volumes mapped to the host filesystem:

- **WordPress Files**: Stored in `wp_vol`.
  - Host Path: `/home/ibougajd/data/wordpress`
  - Container Path: `/var/www/html`

- **Database Files**: Stored in `db_vol`.
  - Host Path: `/home/ibougajd/data/mariadb`
  - Container Path: `/var/lib/mysql`

## Management Commands
- **Access a container shell** (e.g., WordPress):
  ```bash
  docker exec -it tests_wordpress bash
  ```

- **Clean up volumes** (WARNING: Deletes data):
  ```bash
  make clean
  ```

- **Full system prune**:
  ```bash
  make fclean
  ```
