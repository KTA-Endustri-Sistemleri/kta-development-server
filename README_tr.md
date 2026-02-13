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

Container otomatik olarak:
- ✅ code-server'ı 9090 portunda yapılandırır
- ✅ Gerekli dizinleri doğru izinlerle oluşturur
- ✅ `/workspace/development` dizinini workspace olarak açar
- ✅ code-server'ı arka planda başlatır

#### 2. code-server'a Erişim
- **Tarayıcı**: http://localhost:9090
- **Şifre**: `.env` dosyasındaki `CODE_SERVER_PASSWORD` değişkeni
- **İlk kulanım** - `.env` dosyası oluşturun:
  ```bash
  cp .env.example .env
  # .env dosyasını düzenleyin ve CODE_SERVER_PASSWORD=guvenli-sifreniz ayarlayın
  ```

**Göreceğiniz şeyler**:
- VS Code dosya gezgininde Frappe bench yapısı
- Düzenleme için erişilebilir tüm app'ler ve siteler
- Tarayıcınızda tam VS Code işlevselliği

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
/workspace/development/dev-all.sh [app_adi]
```

Bu komut 3 tmux penceresi oluşturur:
- **Backend**: Frappe backend server (bench start)
- **Frontend**: Vite development server (varsayılan: kta_employee, veya özel app belirtin)
- **Shell**: Genel amaçlı komut satırı

### Çoklu Site Geliştirme
Vite proxy routing sayesinde farklı sitelere erişebilirsiniz:
- `http://site1.localhost:8080` → Site: site1
- `http://localhost:8080` → Site: localhost

### Yardımcı Scriptler

Geliştirme ortamı `/workspace/development/` dizininde birkaç yardımcı script içerir:

| Script | Amaç | Kullanım |
|--------|------|----------|
| `start.sh` | Container başlatma scripti | Container başlangıcında otomatik çalışır |
| `dev-frontend.sh` | Hızlı frontend geliştirme kurulumu | `dev-frontend <app_adi>` |
| `dev-all.sh` | Çok pencereli tmux iş akışı | `/workspace/development/dev-all.sh [app_adi]` |

**start.sh** otomatik olarak:
1. code-server yapılandırmasını 9090 portu ile oluşturur/günceller
2. Doğru dizin izinlerini sağlar
3. code-server'ı `/workspace/development` workspace ile başlatır
4. Container'ı çalışır durumda tutar

---

## 🔧 Sorun Giderme

### code-server Sorunları

**Problem**: code-server "Please specify at least one file or folder" hatası gösteriyor  
**Çözüm**: Bu en son sürümde zaten düzeltilmiştir. Workspace yolu otomatik olarak yapılandırılır.

**Problem**: code-server 9090 yerine 8080 portunda  
**Çözüm**: Container'ı yeniden başlatın. Başlangıç scripti yapılandırmayı otomatik olarak yeniden oluşturur:
```bash
docker compose restart frappe
```

**Problem**: İzin reddedildi hataları  
**Çözüm**: Başlangıç scripti gerekli tüm dizinleri oluşturur. Sorun devam ederse:
```bash
docker compose down
docker compose up -d --build
```

### Port Çakışmaları

Port çakışması görürseniz:
- **Port 9090**: code-server (tarayıcı tabanlı VS Code)
- **Port 8080**: Vite frontend geliştirme sunucusu
- **Port 8000**: Frappe backend

Bu portların başka uygulamalar tarafından kullanılmadığından emin olun.

### code-server'a Erişim

1. Container'ın çalıştığından emin olun: `docker compose ps`
2. Logları kontrol edin: `docker compose logs frappe`
3. Şunu arayın: `HTTP server listening on http://0.0.0.0:9090/`
4. Erişim: http://localhost:9090

### VS Code Eklentileri Kalıcı Değil

Eklentiler `code-server-extensions` volume'ünde saklanır. Kaybolurlarsa:
```bash
# Volume'ün var olduğunu kontrol edin
docker volume ls | grep code-server-extensions

# Gerekirse volume'ü yeniden oluşturun (uyarı: eklentileri kaybedersiniz)
docker compose down -v
docker compose up -d
```

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
