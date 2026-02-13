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
- **Alternative Frontend Ports**: 8081-8085, 3000-3005, 5173-5178

---

## 🖥️ Code-Server and Frontend Development

### Getting Started

#### 1. Start the Container
```bash
cd .devcontainer
docker-compose up -d --build
```

The container automatically:
- ✅ Configures code-server on port 9090
- ✅ Creates necessary directories with proper permissions
- ✅ Opens `/workspace/development` as the workspace
- ✅ Starts code-server in the background

#### 2. Access code-server
- **Browser**: http://localhost:9090
- **Password**: Set via `CODE_SERVER_PASSWORD` in `.env` file
- **First time setup** - create `.env` file:
  ```bash
  cp .env.example .env
  # Edit .env and set CODE_SERVER_PASSWORD=your-secure-password
  ```

**What you'll see**:
- Frappe bench structure in the VS Code file explorer
- All apps and sites accessible for editing
- Full VS Code functionality in your browser

#### 3. Frontend Development

**Option A: Manual**
```bash
docker-compose exec frappe bash
cd apps/kta_employee/frontend
yarn install
yarn dev
```

**Option B: Helper Script**
```bash
docker-compose exec frappe dev-frontend kta_employee
```

**Option C: Start All Services with Tmux**
```bash
docker-compose exec frappe bash
/workspace/development/dev-all.sh [app_name]
```

This command creates 3 tmux windows:
- **Backend**: Frappe backend server (bench start)
- **Frontend**: Vite development server (default: kta_employee, or specify custom app)
- **Shell**: General purpose command line

### Multi-Site Development
You can access different sites through Vite proxy routing:
- `http://site1.localhost:8080` → Site: site1
- `http://localhost:8080` → Site: localhost

### Helper Scripts

The development environment includes several helper scripts in `/workspace/development/`:

| Script | Purpose | Usage |
|--------|---------|-------|
| `start.sh` | Container startup script | Automatically runs on container start |
| `dev-frontend.sh` | Quick frontend dev setup | `dev-frontend <app_name>` |
| `dev-all.sh` | Multi-window tmux workflow | `/workspace/development/dev-all.sh [app_name]` |

**start.sh** automatically:
1. Creates/updates code-server config with port 9090
2. Ensures proper directory permissions
3. Starts code-server with `/workspace/development` workspace
4. Keeps container running

---

## 🔧 Troubleshooting

### code-server Issues

**Problem**: code-server shows "Please specify at least one file or folder"  
**Solution**: This is already fixed in the latest version. The workspace path is automatically configured.

**Problem**: code-server is on port 8080 instead of 9090  
**Solution**: Restart the container. The startup script automatically recreates the config:
```bash
docker compose restart frappe
```

**Problem**: Permission denied errors  
**Solution**: The startup script creates all necessary directories. If issues persist:
```bash
docker compose down
docker compose up -d --build
```

### Port Conflicts

If you see port conflicts:
- **Port 9090**: code-server (browser-based VS Code)
- **Port 8080**: Vite frontend dev server
- **Port 8000**: Frappe backend

Make sure these ports are not in use by other applications.

### Accessing code-server

1. Ensure container is running: `docker compose ps`
2. Check logs: `docker compose logs frappe`
3. Look for: `HTTP server listening on http://0.0.0.0:9090/`
4. Access: http://localhost:9090

### VS Code Extensions Not Persisting

Extensions are stored in the `code-server-extensions` volume. If they disappear:
```bash
# Check volume exists
docker volume ls | grep code-server-extensions

# If needed, recreate volume (warning: will lose extensions)
docker compose down -v
docker compose up -d
```

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
