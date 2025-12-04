# 🎓 PHP Native Dashboard - Aplikasi Akademik Keren! 🚀

Aplikasi dashboard akademik yang dibuat dengan **PHP native** dan **MySQL**, dilengkapi dengan **Docker** dan **CI/CD Pipeline** untuk development modern! Project ini cocok banget buat kalian yang mau belajar web development dengan teknologi yang keren dan professional!

## ✨ Fitur-Fitur Kece

- ✅ **CRUD Lengkap** - Management data Mahasiswa, Dosen, Mata Kuliah, dan Nilai
- ✅ **Authentication System** - Login/logout dengan session management
- ✅ **Responsive Design** - Pake Bootstrap, mobile-friendly banget!
- ✅ **Docker Ready** - Tinggal `docker-compose up` langsung jalan! 🐳
- ✅ **CI/CD Pipeline** - GitHub Actions untuk testing otomatis 🔄
- ✅ **Security Scanning** - CodeQL & DevSkim untuk keamanan kode 🔒
- ✅ **Database Management** - phpMyAdmin untuk manage database 🗃️
- ✅ **Development Friendly** - Live reload dengan volume mounting ⚡

## 🏗️ Struktur Project

```
php-native-dashboard/
├── 📄 index.php              # Halaman utama (redirect ke dashboard/login)
├── 📄 login.php              # Halaman login
├── 📄 logout.php             # Proses logout
├── 🗃️ database.sql           # Schema database + sample data
├── ⚙️ helper/
│   ├── connection.php        # Database connection (Docker + Local support)
│   └── auth.php              # Authentication helper
├── 📁 layout/                # Template components
│   ├── _header.php           # Header template
│   ├── _top.php              # Top navigation
│   ├── _sidenav.php          # Sidebar navigation
│   └── _bottom.php           # Footer template
├── 📁 dashboard/             # Dashboard pages
├── 📁 mahasiswa/             # Mahasiswa CRUD operations
├── 📁 dosen/                 # Dosen CRUD operations
├── 📁 matakuliah/            # Mata Kuliah CRUD operations
├── 📁 nilai/                 # Nilai CRUD operations
├── 🎨 assets/                # Static files (CSS, JS, images)
├── 🐳 Dockerfile             # Docker config untuk PHP-FPM
├── 🌐 Dockerfile.nginx       # Docker config untuk Nginx
├── ⚙️ nginx.conf             # Config Nginx
├── 🐳 docker-compose.yml     # Docker Compose configuration
└── 🔄 .github/workflows/     # CI/CD pipelines
    ├── ci-cd.yml            # Main CI/CD pipeline
    ├── codeql.yml           # Security analysis
    └── devskim.yml          # Additional security scanning
```

## 🛠️ Tech Stack

- **🌐 Web Server**: Nginx 1.25 (Alpine) - Fast & reliable
- **⚡ Backend**: PHP 8.1 dengan PHP-FPM - Modern & performant
- **🗃️ Database**: MySQL 8.0 - Robust & scalable
- **🎨 Frontend**: HTML5, CSS3, JavaScript, Bootstrap 5 - Modern UI
- **🐳 Containerization**: Docker & Docker Compose - Easy deployment
- **🚀 CI/CD**: GitHub Actions - Automated testing & deployment
- **🔧 Database Tools**: phpMyAdmin - Easy database management

## 🗃️ Schema Database

Aplikasi ini menggunakan 5 tabel utama:

### Tabel `login`
- `id` (INT, PRIMARY KEY) - ID unik user
- `username` (VARCHAR) - Username login
- `password` (VARCHAR) - Password user

### Tabel `mahasiswa`
- `nim` (VARCHAR, PRIMARY KEY) - Nomor Induk Mahasiswa
- `nama` (VARCHAR) - Nama lengkap
- `jenis_kelamin` (ENUM) - L/P
- `kota_kelahiran` (VARCHAR) - Kota lahir
- `tanggal_kelahiran` (DATE) - Tanggal lahir
- `alamat` (TEXT) - Alamat lengkap
- `program_studi` (VARCHAR) - Program studi
- `tahun_masuk` (YEAR) - Tahun masuk

### Tabel `dosen`
- `nidn` (VARCHAR, PRIMARY KEY) - Nomor Induk Dosen Nasional
- `nama_dosen` (VARCHAR) - Nama lengkap dosen
- `jenkel_dosen` (ENUM) - L/P
- `alamat_dosen` (TEXT) - Alamat dosen

### Tabel `matakuliah`
- `kode_matkul` (VARCHAR, PRIMARY KEY) - Kode mata kuliah
- `nama_matkul` (VARCHAR) - Nama mata kuliah
- `sks` (INT) - Satuan Kredit Semester

### Tabel `nilai`
- `id` (INT, PRIMARY KEY) - ID unik
- `nim` (VARCHAR) - Foreign key ke mahasiswa
- `kode_matkul` (VARCHAR) - Foreign key ke matakuliah
- `semester` (INT) - Semester
- `nilai` (VARCHAR) - Nilai huruf

## 🚀 Quick Start - Super Gampang!

### 🐳 Pakai Docker (Recommended - 1 Command!)

**Prerequisites:**
- Docker & Docker Compose installed
- Git installed

**Steps:**

1. **Clone repository:**
   ```bash
   git clone <repository-url>
   cd php-native-dashboard
   ```

2. **Jalanin aplikasi (cuma satu command!):**
   ```bash
   docker-compose up -d
   ```

3. **Akses aplikasi:**
   - 📱 **Dashboard App**: http://localhost:8080
   - 🗃️ **phpMyAdmin**: http://localhost:8081
     - Username: `root`
     - Password: `root_password`

4. **Login ke aplikasi:**
   - Username: `admin`
   - Password: `admin`

5. **🔥 Development Mode - Edit & Langsung Keliatan!**
   ```bash
   # Edit file PHP/CSS apa aja
   vim helper/connection.php
   
   # Refresh browser -> langsung update! 🚀
   # TIDAK PERLU rebuild container!
   ```

6. **Stop aplikasi:**
   ```bash
   docker-compose down
   ```

### 💻 Manual Installation (Advanced)

**Requirements:**
- PHP 8.1+ dengan extension MySQLi
- MySQL 8.0+
- Web server (Apache/Nginx)

**Steps:**

1. **Clone repository:**
   ```bash
   git clone <repository-url>
   cd php-native-dashboard
   ```

2. **Setup database:**
   ```bash
   mysql -u root -p < database.sql
   ```

3. **Konfigurasi koneksi database** di `helper/connection.php`:
   ```php
   $dbhost = "localhost";
   $dbusername = "root";
   $dbpassword = "your_mysql_password";
   $dbname = "stmik_ids";
   ```

4. **Jalanin lewat web server** dan akses aplikasi

## 🧪 Testing & CI/CD

### Automated Testing (GitHub Actions)

Project ini dilengkapi dengan automated testing yang komprehensif:

#### **Main CI/CD Pipeline** (`.github/workflows/ci-cd.yml`)
- ✅ **Docker Build Testing** - Build & test semua containers
- ✅ **Service Health Check** - Verifikasi semua services jalan
- ✅ **Database Connection Testing** - Test koneksi ke MySQL
- ✅ **Application Endpoint Testing** - Test semua URL endpoints
- ✅ **PHP Syntax Validation** - Cek syntax semua file PHP
- ✅ **CRUD Operations Testing** - Test functionality aplikasi
- ✅ **Security Scanning** - Basic security checks

#### **Advanced Security Analysis** (`.github/workflows/codeql.yml`)
- ✅ **CodeQL Analysis** - Static code analysis yang advanced
- ✅ **Multi-Language Support** - PHP & JavaScript
- ✅ **Security Queries** - Detect vulnerabilities
- ✅ **SARIF Reports** - Integration dengan GitHub Security

#### **Additional Security Scanning** (`.github/workflows/devskim.yml`)
- ✅ **Microsoft DevSkim** - Complementary security scanning
- ✅ **Scheduled Scans** - Weekly automated analysis
- ✅ **SARIF Integration** - Centralized security reporting

### Manual Testing

```bash
# Test PHP syntax
find . -name "*.php" -exec php -l {} \;

# Test dengan Docker
docker-compose up -d
curl -f http://localhost:8080 || echo "Application failed"
curl -f http://localhost:8081 || echo "phpMyAdmin failed"
docker-compose down
```

## 📖 Cara Pakai Aplikasi

### 🔐 Login System
1. Buka http://localhost:8080
2. Akan di-redirect ke halaman login
3. Masukkan username & password:
   - **Admin**: `admin` / `admin`
   - **User**: `user` / `user`

### 👨‍🎓 Management Mahasiswa
- **View**: Dashboard → Mahasiswa → List semua data
- **Add**: Klik "Tambah Data" → Isi form → Save
- **Edit**: Klik icon edit → Ubah data → Update
- **Delete**: Klik icon trash → Konfirmasi → Hapus

### 👨‍🏫 Management Dosen
- **View**: Dashboard → Dosen → List semua data
- **Add**: Klik "Tambah Data" → Isi form → Save
- **Edit**: Klik icon edit → Ubah data → Update
- **Delete**: Klik icon trash → Konfirmasi → Hapus

### 📚 Management Mata Kuliah
- **View**: Dashboard → Mata Kuliah → List semua data
- **Add**: Klik "Tambah Data" → Isi form → Save
- **Edit**: Klik icon edit → Ubah data → Update
- **Delete**: Klik icon trash → Konfirmasi → Hapus

### 📊 Management Nilai
- **View**: Dashboard → Nilai → List semua data
- **Add**: Klik "Tambah Data" → Pilih mahasiswa & matkul → Isi nilai → Save
- **Edit**: Klik icon edit → Ubah data → Update
- **Delete**: Klik icon trash → Konfirmasi → Hapus

## 🔒 Fitur Keamanan

- ✅ **SQL Injection Prevention** - Pake prepared statements
- ✅ **XSS Protection** - HTML escaping di semua output
- ✅ **Input Validation** - Input divalidasi dan disanitasi
- ✅ **Session Management** - Secure session handling
- ✅ **Environment Variables** - Sensitive data di env vars
- ✅ **Container Security** - Non-root user, minimal base images
- ✅ **Network Isolation** - Internal Docker network
- ✅ **Automated Security Scanning** - CodeQL & DevSkim

## 🐳 Docker Deep Dive

### Architecture Overview
```
📱 User Request → 🌐 Nginx (Port 8080) → ⚡ PHP-FPM → 🗃️ MySQL
                     ↓
              🎨 Static Files (CSS/JS/IMG)
              🔧 phpMyAdmin (Port 8081)
```

### Container Details

#### **🌐 Nginx Container**
- **Base Image**: `nginx:1.25-alpine` (lightweight & secure)
- **Port**: 8080:80 (host:container)
- **Features**: Static file serving, PHP proxy, security headers
- **Health Check**: HTTP endpoint testing

#### **⚡ PHP-FPM Container**
- **Base Image**: `php:8.1-fpm` (stable & performant)
- **Extensions**: `pdo_mysql`, `mbstring`, `gd`
- **Features**: PHP processing, database connection
- **Health Check**: PHP-FPM configuration testing

#### **🗃️ MySQL Container**
- **Base Image**: `mysql:8.0` (official & robust)
- **Port**: 3306:3306 (optional external access)
- **Features**: Auto database creation, data persistence
- **Health Check**: MySQL connectivity testing

#### **🔧 phpMyAdmin Container**
- **Base Image**: `phpmyadmin/phpmyadmin:latest`
- **Port**: 8081:80 (host:container)
- **Features**: Web-based database management
- **Integration**: Auto-connect ke MySQL container

### Volume Mounting Benefits
- **🔥 Live Reload**: Edit code → refresh browser → instant changes
- **⚡ Faster Development**: No rebuild needed for code changes
- **🛠️ Easy Debugging**: Direct file access for troubleshooting
- **📚 Educational**: Perfect untuk learning environment

## 🔄 CI/CD Pipeline Details

### **Build & Test Stage**
1. **Code Checkout** - Get latest code
2. **Docker Build** - Build all images without cache
3. **Service Startup** - Start all containers
4. **Health Verification** - Wait for services to be ready
5. **Application Testing** - Test all functionality
6. **Security Scanning** - Basic security checks
7. **Report Generation** - Create deployment reports

### **Security Analysis Stage**
1. **CodeQL Analysis** - Advanced static analysis
2. **DevSkim Scanning** - Additional security checks
3. **SARIF Upload** - Upload results to GitHub Security

### **Deployment Stage** (Main branch only)
1. **Staging Deploy** - Deploy to staging environment
2. **Health Verification** - Verify deployment success
3. **Notification** - Send deployment status

## 🛠️ Development Guide

### **Code Style Standards**
- **PHP**: PSR-12 coding standards
- **HTML**: Semantic HTML5 markup
- **CSS**: Bootstrap 5 components + custom styles
- **JavaScript**: Vanilla JS with modern ES6+ features

### **Development Workflow**
1. **Fork & Clone** repository
2. **Create Feature Branch**: `git checkout -b feature/new-feature`
3. **Start Development**: `docker-compose up -d`
4. **Make Changes**: Edit files with live reload
5. **Test Changes**: Verify functionality works
6. **Commit Changes**: `git commit -m "Add new feature"`
7. **Push Branch**: `git push origin feature/new-feature`
8. **Create Pull Request**: Submit PR for review
9. **CI/CD Testing**: Automated testing runs
10. **Merge**: After approval, merge to main

### **Debugging Tips**
```bash
# Check container logs
docker-compose logs nginx
docker-compose logs php
docker-compose logs mysql

# Access container shell
docker-compose exec php sh
docker-compose exec mysql mysql -u root -p

# Restart specific service
docker-compose restart php

# Rebuild specific service
docker-compose build --no-cache php
```

## 📚 Learning Resources

### **Docker Documentation**
- [Official Docker Docs](https://docs.docker.com/)
- [Docker Compose Guide](https://docs.docker.com/compose/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)

### **PHP Resources**
- [PHP Official Documentation](https://www.php.net/docs.php)
- [PHP Best Practices](https://phptherightway.com/)
- [PSR Standards](https://www.php-fig.org/psr/)

### **Security Resources**
- [OWASP PHP Security](https://owasp.org/www-project-cheat-sheets/cheatsheets/PHP_Security_Cheat_Sheet.html)
- [CodeQL Documentation](https://codeql.github.com/)
- [DevSkim Documentation](https://github.com/microsoft/DevSkim)

## 🔧 Troubleshooting

### **Common Issues & Solutions**

#### **Container Won't Start**
```bash
# Check Docker status
docker --version
docker-compose --version

# Check port conflicts
lsof -i :8080
lsof -i :8081

# Clean up Docker
docker system prune -f
docker-compose down -v
```

#### **Database Connection Issues**
```bash
# Check MySQL container
docker-compose logs mysql

# Test database connection
docker-compose exec php php -r "
try {
    \$pdo = new PDO('mysql:host=mysql;dbname=stmik_ids', 'root', 'root_password');
    echo 'Database connection: SUCCESS\n';
} catch (PDOException \$e) {
    echo 'Database connection: FAILED - ' . \$e->getMessage() . '\n';
}
"
```

#### **Application Not Loading**
```bash
# Check Nginx configuration
docker-compose exec nginx nginx -t

# Check PHP-FPM status
docker-compose exec php php-fpm -t

# Check file permissions
docker-compose exec php ls -la /var/www/html/
```

### **Getting Help**
1. **Check logs**: `docker-compose logs [service-name]`
2. **Verify configuration**: Check all config files
3. **Check GitHub Issues**: Look for similar problems
4. **Create New Issue**: Provide detailed error information

## 🤝 Contributing

We welcome contributions! Here's how to get started:

1. **Fork** the repository
2. **Create** a feature branch
3. **Make** your changes
4. **Test** thoroughly with Docker
5. **Commit** your changes with clear messages
6. **Push** to your fork
7. **Create** a Pull Request
8. **Wait** for code review

### **Contribution Guidelines**
- Follow PSR-12 coding standards
- Write clear commit messages
- Test all functionality
- Update documentation as needed
- Ensure CI/CD pipeline passes

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Bootstrap Team** - For the awesome UI framework
- **Docker Team** - For containerization technology
- **GitHub Actions Team** - For CI/CD platform
- **PHP Community** - For the amazing language
- **MySQL Team** - For the reliable database

---

<div align="center">
  <p font="bold">🔥🔥 Let Him Cook 🔥🔥 </p>
  <img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExMDgybnVxMHZ1bXJhN2NzaGthcjhudWwzZXA1em9yZ3V4M2JrMHY4bCZlcD12MV9naWZzX3NlYXJjaCZjdD1n/mSmDzUMlxKTVDB1TFV/giphy.gif" alt="Contoh Gambar" style="width:100%; object-fit:cover">
</div>
