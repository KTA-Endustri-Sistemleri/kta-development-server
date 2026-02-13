# 🐳 ERPNext Geliştirme Ortamı (DevContainer)

Tamamen **Docker Compose** ve **VSCode Dev Containers** üzerinde çalışan bir **ERPNext + Frappe geliştirme ortamı**.  
Kurulum, Python tabanlı `installer.py` betiği ile otomatik olarak **bench** ve **site** oluşturur. **code-server** entegrasyonu ve **frontend geliştirme araçları** ile modern JavaScript/TypeScript iş akışları desteklenir.

---

## 📦 Özellikler
- MariaDB + Redis (Cache + Queue)
- Frappe Bench imajı (`frappe/bench:latest`)
- Tarayıcı tabanlı VS Code deneyimi için **code-server** entegrasyonu
- **Frontend geliştirme araçları** (Node.js 18, Yarn, Vite desteği)
- VSCode **Dev Containers** desteği
- İsteğe bağlı Mailpit, PostgreSQL ve Cypress test desteği
- Çoklu port desteği (8000–8005 / 9000–9005)
- **Frontend portları açık** (8080, 8081-8085, 3000-3005, 5173-5178)
- Kalıcı veritabanı depolaması + code-server konfigürasyonu
- Kolay frontend geliştirme iş akışı için **yardımcı scriptler**

---

## ⚙️ Klasör Yapısı
```
proje-kök/
│
├── development/
│   ├── installer.py
│   ├── docker-compose.yml
│   ├── sites/
│   └── apps/
│
└── .devcontainer/
    └── devcontainer.json
```

---

## 🚀 Hızlı Başlangıç

1. **Dev Container’ı başlat**
   ```bash
   # VSCode içinde:
   # "Reopen in Container" seçeneğini kullan
   ```

2. **Docker Compose’u çalıştır**
   ```bash
   docker compose up -d
   ```

3. **Bench ve Site Kurulumu**
   ```bash
   python installer.py -v -s kta-dev.localhost -b kta-dev -d mariadb -a admin
   ```

4. **Siteye erişim**
   ```
   http://kta-dev.localhost:8000
   ```

---

## 🔧 Servis Özeti
| Servis | Açıklama | Portlar |
|---------|-----------|----------|
| mariadb | Veritabanı | internal |
| redis-cache | Frappe önbellek servisi | internal |
| redis-queue | Frappe arka plan işleri | internal |
| frappe | Bench ortamı + code-server | 8000–9005, 9090, 8080–8085 |

### Port Eşleştirmeleri
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
  # .env dosyasını düzenleyin ve CODE_SERVER_PASSWORD'ü ayarlayın
  ```

#### 3. Frontend Geliştirme

**Seçenek A: Manuel**
```bash
docker-compose exec frappe bash
cd apps/kta_employee/frontend
yarn install
yarn dev
```

**Seçenek B: Yardımcı Script**
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

### Çoklu Site Geliştirme
Vite proxy routing sayesinde farklı sitelere erişebilirsiniz:
- `http://site1.localhost:8080` → Site: site1
- `http://localhost:8080` → Site: localhost

---

## 🧰 Opsiyonel Bileşenler
İhtiyaç halinde `docker-compose.yml` içinden aktif edilebilir:
- `mailpit` → E-posta testleri
- `postgresql` → Alternatif veritabanı
- `ui-tester` → Cypress E2E testleri

---

## 🪣 Volümler
| Volume | Amaç |
|--------|-------|
| mariadb-data | Kalıcı veritabanı depolaması |
| code-server-data | code-server konfigürasyonu |
| code-server-extensions | VS Code eklentileri |
| node-modules-cache | Daha hızlı build'ler için Node.js modül önbelleği |

---

## 🧑‍💻 Geliştirici Notları
- **VSCode Remote Containers** ve **code-server** ile tam uyumlu
- Portları isteğe göre değiştirebilirsiniz
- `installer.py` tüm kurulumu otomatikleştirir
- Manuel komutlar için:
  ```bash
  docker compose exec frappe bash
  bench start
  ```
- Vite dev server ile **frontend hot reload** otomatik çalışır
- **PWA geliştirme** hazır şekilde desteklenir
- Node modülleri hızlı build'ler için Docker volume'de önbelleğe alınır

### Dahil Edilen Geliştirme Araçları
- **code-server**: Tarayıcı tabanlı VS Code
- **tmux**: Çoklu terminal oturumları için terminal çoğullayıcı
- **yarn**: JavaScript için hızlı paket yöneticisi
- **Node.js 18.x**: Modern JavaScript runtime
- **jq**: Komut satırı JSON işleyici
- **vim, htop**: Temel geliştirme araçları

---

## 🏷️ Lisans
MIT Lisansı © 2025 KTA Endüstri Sistemleri
