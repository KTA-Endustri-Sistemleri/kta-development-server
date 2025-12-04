# 🐳 ERPNext DevContainer Setup

A fully containerized **ERPNext + Frappe development environment** powered by **Docker Compose** and **VSCode Dev Containers**.  
This setup automatically provisions a complete bench and site using a Python installer script.

---

## 📦 Features
- MariaDB + Redis (Cache + Queue)
- Frappe Bench image (`frappe/bench:latest`)
- Ready for VSCode **Dev Containers** integration
- Optional Mailpit, PostgreSQL, and Cypress UI testing
- Supports multi-port development (8000–8005 / 9000–9005)
- Persistent MariaDB volume

---

## ⚙️ Folder Structure
```
project-root/
│
├── development/
│   ├── installer.py
│   ├── sites/
│   └── apps/
│
└── .devcontainer/
    └── devcontainer.json
    ├── docker-compose.yml
```

---

## 🚀 Quick Start

1. **Launch Dev Container**
   ```bash
   # Open project in VSCode and select:
   # "Reopen in Container"
   ```

2. **Run Docker Compose**
   ```bash
   docker compose up -d
   ```

3. **Install Bench and Create Site**
   ```bash
   python installer.py -v -s kta-dev.localhost -b kta-dev -d mariadb -a admin
   ```

4. **Access your site**
   ```
   http://kta-dev.localhost:8000
   ```

---

## 🔧 Environment Overview
| Service | Description | Ports |
|----------|--------------|--------|
| mariadb | Database | internal |
| redis-cache | Frappe cache backend | internal |
| redis-queue | Frappe background jobs | internal |
| frappe | Bench environment | 8000–9005 |

---

## 🧰 Optional Components
Uncomment in `docker-compose.yml` if needed:
- `mailpit` → for testing outgoing emails
- `postgresql` → alternate database backend
- `ui-tester` → for Cypress E2E testing

---

## 🪣 Volumes
| Volume | Purpose |
|--------|----------|
| mariadb-data | Persistent database storage |

---

## 🧑‍💻 Development Notes
- Works seamlessly with **VSCode Remote Containers**
- Modify ports as needed (e.g. 8080–8085)
- Bench and site setup automated via `installer.py`
- Use `frappe` service shell for manual commands:
  ```bash
  docker compose exec frappe bash
  bench start
  ```

---

## 🏷️ License
MIT License © 2025 KTA Endüstri Sistemleri
