# 🐳 ERPNext Geliştirme Ortamı (DevContainer)

Tamamen **Docker Compose** ve **VSCode Dev Containers** üzerinde çalışan bir **ERPNext + Frappe geliştirme ortamı**.  
Kurulum, Python tabanlı `installer.py` betiği ile otomatik olarak **bench** ve **site** oluşturur.

---

## 📦 Özellikler
- MariaDB + Redis (Cache + Queue)
- Frappe Bench imajı (`frappe/bench:latest`)
- VSCode **Dev Containers** desteği
- İsteğe bağlı Mailpit, PostgreSQL ve Cypress test desteği
- Çoklu port desteği (8000–8005 / 9000–9005)
- Kalıcı veritabanı depolaması (volume)

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
| frappe | Bench ortamı | 8000–9005 |

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

---

## 🧑‍💻 Geliştirici Notları
- **VSCode Remote Containers** ile tam uyumlu
- Portları isteğe göre değiştirebilirsiniz
- `installer.py` tüm kurulumu otomatikleştirir
- Manuel komutlar için:
  ```bash
  docker compose exec frappe bash
  bench start
  ```

---

## 🏷️ Lisans
MIT Lisansı © 2025 KTA Endüstri Sistemleri
