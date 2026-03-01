<div align="center">

# 🐳 Inception

### *A Dockerized Microservices Infrastructure*

[![42 Project](https://img.shields.io/badge/42-Project-blue?style=for-the-badge)](https://42.fr)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![NGINX](https://img.shields.io/badge/NGINX-TLS%201.3-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://nginx.org/)
[![WordPress](https://img.shields.io/badge/WordPress-CMS-21759B?style=for-the-badge&logo=wordpress&logoColor=white)](https://wordpress.org/)
[![MariaDB](https://img.shields.io/badge/MariaDB-Database-003545?style=for-the-badge&logo=mariadb&logoColor=white)](https://mariadb.org/)

<br>

<img src="https://media.giphy.com/media/6AFldi5xA3uU0/giphy.gif" alt="Docker Whale" width="300">

*Because why set up one server when you can orchestrate five containers instead?* 🚀

</div>

---

## 📖 Table of Contents

- [About the Project](#-about-the-project)
- [Architecture](#-architecture)
- [What I Built](#-what-i-built)
- [What I Learned](#-what-i-learned)
- [Getting Started](#-getting-started)
- [Usage](#-usage)
- [Key Concepts](#-key-concepts)
- [Docker Humor Corner](#-docker-humor-corner)
- [Resources](#-resources)

---

## 🎯 About the Project

**Inception** is a system administration project from the [42 curriculum](https://42.fr) that challenged me to build a complete web infrastructure from scratch using **Docker** and **Docker Compose**. No pre-built images from Docker Hub — every service is hand-crafted from a minimal Debian base image.

The result is a fully functional, containerized WordPress website served over **HTTPS**, backed by a **MariaDB** database, and fronted by an **NGINX** reverse proxy — all communicating through an isolated Docker network.

<div align="center">
<img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbW1kMjZqOHZuYnZtYm96ZGp4NjBhZmd0cnJlNXdtMG40aWoyMDlyeCZlcD12MV9naWZzX3NlYXJjaCZjdD1n/jTNG3RF6EIXZGkImuX/giphy.gif" alt="Containers" width="350">
</div>

---

## 🏗 Architecture

```
                    ┌─────────────────────────────────────────┐
                    │            Docker Network (n1)          │
                    │                                         │
   Internet         │  ┌─────────┐    ┌────────────┐         │
   (HTTPS:443) ────────▶  NGINX  │───▶│ WordPress  │         │
                    │  │ TLS 1.3 │    │  PHP-FPM   │         │
                    │  └─────────┘    └─────┬──────┘         │
                    │                       │                 │
                    │                 ┌─────▼──────┐         │
                    │                 │  MariaDB   │         │
                    │                 │  Database  │         │
                    │                 └────────────┘         │
                    │                                         │
                    │  ┌──────────────────────────────────┐   │
                    │  │     Bonus Services (Optional)    │   │
                    │  │  Redis · FTP · Adminer · cAdvisor│   │
                    │  └──────────────────────────────────┘   │
                    │                                         │
                    └─────────────────────────────────────────┘
                         │                    │
                    ┌────▼─────┐        ┌─────▼────┐
                    │  wp_vol  │        │  db_vol  │
                    │ (persist)│        │ (persist)│
                    └──────────┘        └──────────┘
```

---

## 🔨 What I Built

<div align="center">
<img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYXlkcjF0bDI0cHBjdmc1aGQ2aWI3N2N5YnM2OXRkdWU3NnBhZHN1cSZlcD12MV9naWZzX3NlYXJjaCZjdD1n/f3iwJFOVOwuy7K6FFw/giphy.gif" alt="Building" width="280">
</div>

### Core Services

| Service | Description | Port |
|---------|-------------|------|
| 🔒 **NGINX** | Reverse proxy with TLSv1.2/1.3 encryption | `443` (exposed) |
| 📝 **WordPress** | CMS with PHP-FPM 7.4 (no built-in web server) | `9000` (internal) |
| 🗄️ **MariaDB** | Relational database for WordPress data | `3306` (internal) |

### Bonus Services

| Service | Description | Port |
|---------|-------------|------|
| ⚡ **Redis** | In-memory caching for WordPress performance | `6379` (internal) |
| 📁 **FTP Server** | File transfer access to WordPress files | `21` (exposed) |
| 🔧 **Adminer** | Lightweight database management UI | `8080` (exposed) |
| 🌐 **Custom Website** | A personal static website | `1337` (exposed) |
| 📊 **cAdvisor** | Real-time container monitoring dashboard | `8081` (exposed) |

### Key Implementation Details

- ✅ Each service built from **Debian Bullseye** base image (no pulling ready-made images)
- ✅ Custom **entrypoint scripts** to initialize and configure each service at runtime
- ✅ **SSL/TLS certificates** generated and configured for NGINX
- ✅ **Docker volumes** for persistent data storage (WordPress files + database)
- ✅ **Docker network** for secure inter-container communication
- ✅ **Makefile** automation for build, start, stop, and cleanup operations

---

## 🧠 What I Learned

<div align="center">
<img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExcDR6OTRvcWIzZzE5aDF2anF5YjA5MXl4YmxhemNsdHBqYmJqdWJhcSZlcD12MV9naWZzX3NlYXJjaCZjdD1n/IPbS5R4fSUl5S/giphy.gif" alt="Learning" width="250">
</div>

This project was a deep dive into real-world DevOps practices. Here's what I took away:

### 🐳 Docker & Containerization
- How to write **production-quality Dockerfiles** from scratch — no shortcuts, no `latest` tags from Docker Hub.
- The difference between **containers and virtual machines** and *why containers changed the game*.
- How Docker **layers, caching, and multi-stage builds** work under the hood.

### 🌐 Networking & Security
- Configuring **TLS/SSL certificates** for HTTPS — and why self-signed certs make browsers angry.
- How **Docker networks** provide isolation and enable service discovery by container name.
- The principle of **least exposure** — only NGINX talks to the outside world.

### 💾 Data Persistence
- The crucial difference between **Docker volumes** and **bind mounts**, and when to use each.
- How to ensure data **survives container restarts and rebuilds**.

### 🔧 System Administration
- Writing **shell scripts** that gracefully initialize services (database users, WordPress configs).
- Managing **environment variables and secrets** securely.
- Understanding **process management** inside containers (PID 1, signal handling).

### 🤝 DevOps Mindset
- **Infrastructure as Code**: every piece of the stack is version-controlled and reproducible.
- The importance of **idempotent scripts** — running `make re` should always produce the same result.
- **Debugging containerized applications** — because `docker logs` became my best friend.

---

## 🚀 Getting Started

### Prerequisites

| Tool | Minimum Version |
|------|----------------|
| [Docker](https://docs.docker.com/engine/install/) | 20.10+ |
| [Docker Compose](https://docs.docker.com/compose/install/) | 2.0+ |
| [Make](https://www.gnu.org/software/make/) | 4.0+ |

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/ibougajd/inception.git
cd inception

# 2. Add the domain to your hosts file
echo "127.0.0.1 ibougajd.42.fr" | sudo tee -a /etc/hosts

# 3. Build and launch the infrastructure
make
```

> 💡 **Tip:** The first build may take a few minutes as Docker downloads base images and installs packages.

---

## 🎮 Usage

### Commands

```bash
# 🟢 Start the infrastructure
make

# 🔴 Stop all services
make down

# 🔄 Rebuild everything from scratch
make re

# 🧹 Full cleanup (containers, images, volumes, networks)
make fclean
```

### Accessing Services

| Service | URL |
|---------|-----|
| 🌐 WordPress | [https://ibougajd.42.fr](https://ibougajd.42.fr) |
| 🔐 WordPress Admin | [https://ibougajd.42.fr/wp-admin](https://ibougajd.42.fr/wp-admin) |
| 🔧 Adminer | [http://ibougajd.42.fr:8080](http://ibougajd.42.fr:8080) |
| 📊 cAdvisor | [http://ibougajd.42.fr:8081](http://ibougajd.42.fr:8081) |

> ⚠️ **Note:** Since the SSL certificate is self-signed, your browser will display a security warning. Accept the risk to proceed.

---

## 📚 Key Concepts

<details>
<summary><b>🐳 Docker vs Virtual Machines</b></summary>
<br>

| Feature | Docker Containers | Virtual Machines |
|---------|------------------|-----------------|
| Startup Time | Seconds | Minutes |
| Resource Usage | Lightweight (shared kernel) | Heavy (full OS per VM) |
| Isolation | Process-level | Hardware-level |
| Portability | Excellent | Good |
| Use Case | Microservices, CI/CD | Legacy apps, full OS needs |

</details>

<details>
<summary><b>🔐 Secrets vs Environment Variables</b></summary>
<br>

- **Environment Variables**: Great for non-sensitive config (paths, feature flags). Can be visible in process listings or logs.
- **Secrets**: Purpose-built for sensitive data (passwords, API keys, certificates). Stored in files and injected securely at runtime.

</details>

<details>
<summary><b>🌐 Docker Network vs Host Network</b></summary>
<br>

- **Host Network**: Container shares the host's network stack. Simple but risky — port conflicts are common.
- **Docker Network**: Isolated bridge network where containers communicate by service name. Only explicitly exposed ports reach the host.

</details>

<details>
<summary><b>💾 Docker Volumes vs Bind Mounts</b></summary>
<br>

- **Bind Mounts**: Direct mapping of host paths to container paths. Ideal for development.
- **Docker Volumes**: Managed by Docker, stored in `/var/lib/docker/volumes/`. Better for production — easier to back up and migrate.

</details>

---

## 😂 Docker Humor Corner

<div align="center">
<img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExOGJxOXo5dnl5dG9pZW93dzQxb2s5ZXIwZm1sZHFydzI0OWE5OGthcyZlcD12MV9naWZzX3NlYXJjaCZjdD1n/641arBi22PAty/giphy.gif" alt="Laughing" width="250">
</div>

> 🐳 *"It works on my machine!"*
> — Then we'll ship your machine. **That's basically what Docker does.**

> 🐳 *Why do Docker containers never get lost?*
> — Because they always follow the **compose** instructions!

> 🐳 *A Docker container walks into a bar...*
> — The bartender says, "You look isolated." The container replies, "That's by design."

> 🐳 *What's Docker's favorite music genre?*
> — **Container-porary!** 🎵

> 🐳 *Why did the developer break up with their VM?*
> — Too much baggage. They found a **lighter container** relationship.

> 🐳 *Docker's motto:*
> — "Friends don't let friends deploy on bare metal." 🤝

<div align="center">
<img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExOXRjM3RiODlra2hoMjU4ZGtlbG1ldmtxdWN2cHdtcHhlOWxhajk2ZiZlcD12MV9naWZzX3NlYXJjaCZjdD1n/3oKIPnAiaMCws8nOsE/giphy.gif" alt="Docker Fun" width="300">

*Me debugging why my container won't start at 3 AM* ☝️
</div>

---

## 📚 Resources

| Resource | Link |
|----------|------|
| Docker Documentation | [docs.docker.com](https://docs.docker.com/) |
| Docker Compose Docs | [docs.docker.com/compose](https://docs.docker.com/compose/) |
| NGINX Documentation | [nginx.org/en/docs](https://nginx.org/en/docs/) |
| WordPress Developer | [developer.wordpress.org](https://developer.wordpress.org/) |
| MariaDB Knowledge Base | [mariadb.com/kb](https://mariadb.com/kb/en/) |
| 42 Curriculum | [42.fr](https://42.fr) |

### AI Disclosure

Artificial Intelligence tools were utilized in this project for the following tasks:
- **Code Auditing**: Automated analysis of configuration files (`Dockerfile`, `docker-compose.yml`) to ensure compliance with project requirements.
- **Documentation**: Generating and refining documentation based on the project structure and subject requirements.

---

<div align="center">

### Made with 🐳 and ☕ by [ibougajd](https://github.com/ibougajd)

*42 Network — Because sleep is overrated when you have containers to debug.*

<img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExOHZ3dXVtZGQ5OWx4NmZtOXhiM3h2NzF0N25nYzQ2ZHlhNnNvbnljaiZlcD12MV9naWZzX3NlYXJjaCZjdD1n/13HgwGsXF0aiGY/giphy.gif" alt="Coding" width="250">

</div>
