# 🐳 Docker Setup & Testing Guide - PHP Native Dashboard

Complete guide untuk setup Docker environment dan testing aplikasi PHP Native Dashboard.

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Docker Setup](#docker-setup)
3. [Application Testing](#application-testing)
4. [Troubleshooting](#troubleshooting)
5. [Development Workflow](#development-workflow)

---

## 🔧 Prerequisites

### **Required Software**
- ✅ **Docker Desktop** (v20.10+)
- ✅ **Docker Compose** (v2.0+)
- ✅ **Git** (for cloning)
- ✅ **Modern Browser** (Chrome/Firefox/Safari)

### **Check Installation**
```bash
# Check Docker version
docker --version

# Check Docker Compose version
docker-compose --version

# Check if Docker is running
docker info
```

**Expected Output:**
```
Docker version 29.0.1, build eedd969
Docker Compose version v2.40.3-desktop.1
Client: Version: 29.0.1
Server: Running
```

---

## 🚀 Docker Setup

### **Step 1: Configure Docker Desktop File Sharing**

**CRITICAL for macOS Users:**

1. **Open Docker Desktop**
2. **Click Settings** (gear icon ⚙️)
3. **Navigate to Resources → File Sharing**
4. **Click "+" button** and add:
   ```
   /Applications/MAMP/htdocs
   ```
   ![Docker File Sharing](https://docs.docker.com/docker-for-mac/images/file-sharing.png)
5. **Click "Apply & Restart"**
6. **Wait for Docker to restart** (2-3 minutes)

### **Step 2: Navigate to Project Directory**
```bash
cd /Applications/MAMP/htdocs/php-native-dashboard
```

### **Step 3: Build and Start Containers**
```bash
# Build and start all services
docker-compose up -d --build
```

**What happens during this process:**
1. 📥 **Download base images** (nginx, php, mysql, phpmyadmin)
2. 🔨 **Build custom images** (PHP-FPM with extensions, Nginx config)
3. 📦 **Create containers** (4 containers total)
4. 🌐 **Setup networking** (internal Docker network)
5. 💾 **Setup volumes** (persistent data storage)
6. 🗃️ **Import database** (auto from database.sql)
7. 🚀 **Start all services**

**Expected Output:**
```
[+] Building 2.1s (12/12) FINISHED
[+] Running 8/8
 ✔ Network php-native-dashboard_dashboard-network  Created
 ✔ Volume php-native-dashboard_mysql_data          Created
 ✔ Container php-dashboard-mysql                   Started
 ✔ Container php-dashboard-php                     Started
 ✔ Container php-dashboard-nginx                   Started
 ✔ Container php-dashboard-phpmyadmin              Started
```

### **Step 4: Verify Services Status**
```bash
# Check all containers
docker-compose ps

# Check detailed status
docker ps
```

**Expected Output:**
```
NAME                           COMMAND                  SERVICE             STATUS              PORTS
php-dashboard-mysql             "docker-entrypoint.s…"   mysql               running             0.0.0.0:3306->3306/tcp
php-dashboard-nginx            "nginx -g 'daemon of…"   nginx               running             0.0.0.0:8080->80/tcp
php-dashboard-php              "docker-fpm"             php                 running             9000/tcp
php-dashboard-phpmyadmin       "/docker-entrypoint.s…"   phpmyadmin          running             0.0.0.0:8081->80/tcp
```

### **Step 5: Access Applications**

| Service | URL | Credentials |
|---------|-----|-------------|
| 📱 **Dashboard App** | http://localhost:8080 | admin/admin |
| 🗃️ **phpMyAdmin** | http://localhost:8081 | root/root_password |

---

## 🧪 Application Testing

### **1. Basic Connectivity Tests**

#### **Test Application Access**
```bash
# Test main application
curl -f http://localhost:8080 || echo "❌ Application not accessible"

# Test phpMyAdmin
curl -f http://localhost:8081 || echo "❌ phpMyAdmin not accessible"
```

#### **Test Database Connection**
```bash
# Test database connection from PHP container
docker-compose exec php php -r "
try {
    \$pdo = new PDO('mysql:host=mysql;dbname=stmik_ids', 'root', 'root_password');
    echo '✅ Database connection: SUCCESS\n';
    
    // Test if tables exist
    \$stmt = \$pdo->query('SHOW TABLES');
    \$tables = \$stmt->fetchAll(PDO::FETCH_COLUMN);
    echo '✅ Tables found: ' . implode(', ', \$tables) . '\n';
    
} catch (PDOException \$e) {
    echo '❌ Database connection: FAILED - ' . \$e->getMessage() . '\n';
    exit(1);
}
"
```

**Expected Output:**
```
✅ Database connection: SUCCESS
✅ Tables found: dosen, login, mahasiswa, matakuliah, nilai
```

### **2. Functional Testing**

#### **Test Login System**
```bash
# Test login page accessibility
curl -s http://localhost:8080/login.php | grep -q "username" && echo "✅ Login form accessible" || echo "❌ Login form not found"

# Test dashboard redirect (should redirect to login)
curl -I http://localhost:8080/dashboard/ | grep -E "HTTP/1\.1 302|HTTP/1\.1 200" && echo "✅ Dashboard redirect working" || echo "❌ Dashboard redirect failed"
```

#### **Test CRUD Operations**
```bash
# Test mahasiswa list page
curl -s http://localhost:8080/mahasiswa/ | grep -q "List Mahasiswa" && echo "✅ Mahasiswa list accessible" || echo "❌ Mahasiswa list failed"

# Test dosen list page
curl -s http://localhost:8080/dosen/ | grep -q "List Dosen" && echo "✅ Dosen list accessible" || echo "❌ Dosen list failed"

# Test matakuliah list page
curl -s http://localhost:8080/matakuliah/ | grep -q "List Mata Kuliah" && echo "✅ Matakuliah list accessible" || echo "❌ Matakuliah list failed"

# Test nilai list page
curl -s http://localhost:8080/nilai/ | grep -q "Nilai" && echo "✅ Nilai list accessible" || echo "❌ Nilai list failed"
```

### **3. PHP Syntax Validation**
```bash
# Check all PHP files for syntax errors
echo "🔍 Checking PHP syntax..."
find . -name "*.php" -not -path "./vendor/*" -exec php -l {} \; 2>&1 | grep -E "Parse error|Fatal error" && echo "❌ PHP syntax errors found" || echo "✅ All PHP files syntax OK"
```

### **4. Service Health Checks**
```bash
# Test Nginx configuration
docker-compose exec nginx nginx -t && echo "✅ Nginx configuration valid" || echo "❌ Nginx configuration error"

# Test PHP-FPM configuration
docker-compose exec php php-fpm -t && echo "✅ PHP-FPM configuration valid" || echo "❌ PHP-FPM configuration error"

# Test MySQL connectivity
docker-compose exec mysql mysqladmin ping -h localhost -u root -proot_password --silent && echo "✅ MySQL connectivity OK" || echo "❌ MySQL connectivity failed"
```

### **5. Database Content Verification**
```bash
# Verify database tables and data
docker-compose exec mysql mysql -u root -proot_password stmik_ids -e "
SELECT 'login' as table_name, COUNT(*) as record_count FROM login
UNION ALL
SELECT 'mahasiswa' as table_name, COUNT(*) as record_count FROM mahasiswa
UNION ALL
SELECT 'dosen' as table_name, COUNT(*) as record_count FROM dosen
UNION ALL
SELECT 'matakuliah' as table_name, COUNT(*) as record_count FROM matakuliah
UNION ALL
SELECT 'nilai' as table_name, COUNT(*) as record_count FROM nilai;
"
```

**Expected Output:**
```
+------------+--------------+
| table_name | record_count |
+------------+--------------+
| login      |            2 |
| mahasiswa  |            4 |
| dosen      |            3 |
| matakuliah |            8 |
| nilai      |           10 |
+------------+--------------+
```

### **6. Performance Testing**
```bash
# Test application response time
echo "🚀 Testing application performance..."
curl -o /dev/null -s -w "⏱️  Response time: %{time_total}s\n" http://localhost:8080

# Test concurrent connections (if ab is available)
if command -v ab &> /dev/null; then
    echo "🔄 Testing concurrent connections..."
    ab -n 100 -c 10 http://localhost:8080/ | grep "Requests per second"
fi
```

---

## 🔧 Troubleshooting

### **Common Issues & Solutions**

#### **❌ Issue: "mounts denied" Error**
```
Error response from daemon: mounts denied: The path /Applications/MAMP/htdocs/php-native-dashboard is not shared
```

**Solution:**
1. Open Docker Desktop → Settings → Resources → File Sharing
2. Add `/Applications/MAMP/htdocs` to shared paths
3. Click "Apply & Restart"
4. Run: `docker-compose down && docker-compose up -d`

#### **❌ Issue: Port Already in Use**
```
Error: Port 8080 is already allocated
```

**Solution:**
```bash
# Find process using port
lsof -i :8080
lsof -i :8081

# Kill process
sudo kill -9 <PID>

# Or change ports in docker-compose.yml
```

#### **❌ Issue: Container Won't Start**
```bash
# Check container logs
docker-compose logs [service-name]

# Common commands
docker-compose logs nginx
docker-compose logs php
docker-compose logs mysql
docker-compose logs phpmyadmin
```

#### **❌ Issue: Database Connection Failed**
```bash
# Restart MySQL container
docker-compose restart mysql

# Check MySQL logs
docker-compose logs mysql

# Test connection manually
docker-compose exec mysql mysql -u root -proot_password -e "SHOW DATABASES;"
```

#### **❌ Issue: Application Not Loading**
```bash
# Check Nginx configuration
docker-compose exec nginx nginx -t

# Check PHP-FPM status
docker-compose exec php php-fpm -t

# Check file permissions
docker-compose exec php ls -la /var/www/html/
```

### **Reset Commands**
```bash
# Complete reset (WARNING: This will delete all data)
docker-compose down -v
docker system prune -f
docker volume prune -f
docker-compose up -d --build
```

---

## 🔄 Development Workflow

### **Live Development Mode**
```bash
# Start containers
docker-compose up -d

# Edit files locally (any PHP/HTML/CSS/JS file)
vim helper/connection.php

# Refresh browser → Changes appear instantly!
# No rebuild required!
```

### **Monitoring Development**
```bash
# Watch logs in real-time
docker-compose logs -f

# Watch specific service logs
docker-compose logs -f nginx
docker-compose logs -f php

# Check resource usage
docker stats
```

### **Database Management**
```bash
# Access MySQL command line
docker-compose exec mysql mysql -u root -proot_password stmik_ids

# Export database
docker-compose exec mysql mysqldump -u root -proot_password stmik_ids > backup.sql

# Import database
docker-compose exec -T mysql mysql -u root -proot_password stmik_ids < import.sql
```

### **Updating Dependencies**
```bash
# Rebuild PHP container with new extensions
docker-compose build --no-cache php

# Rebuild all containers
docker-compose build --no-cache

# Restart services
docker-compose up -d
```

---

## 📊 Testing Checklist

### **✅ Pre-Launch Checklist**
- [ ] Docker Desktop running
- [ ] File sharing configured
- [ ] All containers started (`docker-compose ps`)
- [ ] No port conflicts
- [ ] Database imported successfully

### **✅ Functional Testing Checklist**
- [ ] Main application accessible (http://localhost:8080)
- [ ] phpMyAdmin accessible (http://localhost:8081)
- [ ] Login system working (admin/admin)
- [ ] All CRUD pages accessible
- [ ] Database connection working
- [ ] PHP syntax validation passed

### **✅ Performance Checklist**
- [ ] Application loads within 3 seconds
- [ ] All static files loading correctly
- [ ] No JavaScript errors in browser console
- [ ] No PHP errors in logs
- [ ] Database queries executing efficiently

---

## 🎯 Success Criteria

### **🎉 Setup Success Indicators**
```
✅ All 4 containers running
✅ Application accessible at http://localhost:8080
✅ phpMyAdmin accessible at http://localhost:8081
✅ Login with admin/admin successful
✅ All CRUD pages accessible
✅ Database tables imported with sample data
✅ No errors in container logs
```

### **🚀 Ready for Development**
```
✅ Live reload working (edit code → refresh browser)
✅ Database management via phpMyAdmin
✅ Container logs accessible for debugging
✅ Volume mounting working for file changes
✅ All services communicating properly
```

---

## 📞 Getting Help

### **Debug Commands**
```bash
# Full system status
docker-compose ps
docker-compose logs
docker stats

# Container shell access
docker-compose exec php sh
docker-compose exec nginx sh
docker-compose exec mysql bash

# Network diagnostics
docker-compose exec php ping mysql
docker-compose exec php ping nginx
```

### **Useful Resources**
- 📖 [Docker Documentation](https://docs.docker.com/)
- 📖 [Docker Compose Documentation](https://docs.docker.com/compose/)
- 🐛 [Docker Troubleshooting Guide](https://docs.docker.com/config/troubleshoot/)
- 💬 [GitHub Issues](https://github.com/your-repo/issues)

---

## 🎓 Learning Tips

### **Understanding Docker Architecture**
```
📱 Browser → 🌐 Nginx (8080) → ⚡ PHP-FPM (9000) → 🗃️ MySQL (3306)
                     ↓
              🎨 Static Files (CSS/JS/IMG)
              🔧 phpMyAdmin (8081)
```

### **Key Concepts to Master**
- **Containers**: Isolated application environments
- **Images**: Blueprints for containers
- **Volumes**: Persistent data storage
- **Networks**: Container communication
- **Compose**: Multi-container orchestration

---

**🎉 Congratulations!** If you've completed all steps successfully, your PHP Native Dashboard is now running with Docker! 

**Happy Coding! 🚀✨**