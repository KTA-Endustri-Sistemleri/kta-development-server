# 🐳 ERPNext DevContainer Setup

A fully containerized **ERPNext + Frappe development environment** powered by **Docker Compose** and **VSCode Dev Containers**.  
This setup automatically provisions a complete bench and site using a Python installer script, and includes **code-server** integration for browser-based development and **frontend development tools** for modern JavaScript/TypeScript workflows.

---

## 📦 Features
- MariaDB + Redis (Cache + Queue)
- Frappe Bench image (`frappe/bench:latest`)
- **code-server** integrated for browser-based VS Code experience
- **Frontend development tools** (Node.js 18, Yarn, Vite support)
- Ready for VSCode **Dev Containers** integration
- Optional Mailpit, PostgreSQL, and Cypress UI testing
- Supports multi-port development (8000–8005 / 9000–9005)
- **Frontend ports exposed** (8080, 8081-8085, 3000-3005, 5173-5178)
- Persistent MariaDB volume + code-server configuration
- **Helper scripts** for streamlined frontend development workflow

---

## ⚙️ Folder Structure
```
project-root/
│
├── development/
│   └── installer.py
│
└── .devcontainer/
    └── devcontainer.json
    └── docker-compose.yml
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
| frappe | Bench environment + code-server | 8000–9005, 9090, 8080–8085 |

### Port Mapping
- **code-server (VS Code)**: http://localhost:9090
- **Frappe Backend**: http://localhost:8000
- **Frontend Dev (Vite)**: http://localhost:8080
- **Alternatif Frontend Portları**: 8081-8085, 3000-3005, 5173-5178

---

## 🖥️ Code-Server ve Frontend Geliştirme

### Başlangıç

#### 1. Container'ı Başlat
```bash
cd .devcontainer
docker-compose up -d --build
```

#### 2. code-server'a Erişim
- Tarayıcıda: http://localhost:9090
- Şifre: `.env` dosyasındaki `CODE_SERVER_PASSWORD` değişkeni (varsayılan: `changeme`)
- İlk kullanımda `.env` dosyası oluşturun:
  ```bash
  cp .env.example .env
  # Edit .env and set CODE_SERVER_PASSWORD
  ```

#### 3. Frontend Geliştirme

**Seçenek A: Manuel**
```bash
docker-compose exec frappe bash
cd apps/kta_employee/frontend
yarn install
yarn dev
```

**Seçenek B: Helper Script**
```bash
docker-compose exec frappe dev-frontend kta_employee
```

**Seçenek C: Tmux ile Tüm Servisleri Başlat**
```bash
docker-compose exec frappe bash
/workspace/development/dev-all.sh
```

Bu komut 3 tmux penceresi oluşturur:
- **Backend**: Frappe backend server (bench start)
- **Frontend**: Vite development server
- **Shell**: Genel amaçlı komut satırı

### Multi-Site Geliştirme
Vite proxy routing sayesinde farklı sitelere erişebilirsiniz:
- `http://site1.localhost:8080` → Site: site1
- `http://localhost:8080` → Site: localhost

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
| code-server-data | code-server configuration |
| code-server-extensions | VS Code extensions |
| node-modules-cache | Node.js modules cache for faster builds |

---

## 🧑‍💻 Development Notes
- Works seamlessly with **VSCode Remote Containers** and **code-server**
- Modify ports as needed (e.g. 8080–8085)
- Bench and site setup automated via `installer.py`
- Use `frappe` service shell for manual commands:
  ```bash
  docker compose exec frappe bash
  bench start
  ```
- **Frontend hot reload** works automatically with Vite dev server
- **PWA development** supported out of the box
- Node modules are cached in a Docker volume for faster builds

### Development Tools Included
- **code-server**: Browser-based VS Code
- **tmux**: Terminal multiplexer for managing multiple sessions
- **yarn**: Fast package manager for JavaScript
- **Node.js 18.x**: Modern JavaScript runtime
- **jq**: JSON processor for command-line operations
- **vim, htop**: Essential development utilities

---

## 🏷️ License
MIT License © 2025 KTA Endüstri Sistemleri
