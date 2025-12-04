# Security Testing Guide - PHP Native Dashboard

Complete guide untuk security testing workflows yang sudah dikonfigurasi untuk PHP dan JavaScript.

## 📋 Overview

Project ini sekarang memiliki **3 security workflows** yang memberikan coverage lengkap:

1. **CodeQL Security Analysis** - JavaScript advanced analysis
2. **PHP Security Analysis** - PHP comprehensive scanning  
3. **DevSkim Security Scanning** - Multi-language additional scanning

## 🔍 Security Workflows Breakdown

### **1. CodeQL Security Analysis (JavaScript Only)**
**File**: `.github/workflows/codeql.yml`

**Coverage**:
- ✅ **JavaScript/TypeScript** files
- ✅ **Advanced static analysis**
- ✅ **Security-extended queries**
- ✅ **GitHub Security integration**

**What it scans**:
- `assets/js/` directory
- Inline JavaScript di PHP files
- Frontend vulnerabilities

**Triggers**:
- Push ke main/master branch
- Pull requests ke main/master
- Weekly schedule (Thursday 23:30 UTC)

### **2. PHP Security Analysis (Comprehensive)**
**File**: `.github/workflows/php-security.yml`

**Coverage**:
- ✅ **Semgrep** - PHP + JavaScript security rules
- ✅ **PHPStan** - PHP static analysis & type checking
- ✅ **Basic Security Scan** - Custom vulnerability checks

**Semgrep Rules**:
- `p/security-audit` - General security audit
- `p/php` - PHP-specific vulnerabilities
- `p/javascript` - JavaScript vulnerabilities
- `p/owasp-top-ten` - OWASP Top 10 vulnerabilities
- `p/xss` - Cross-site scripting detection
- `p/sql-injection` - SQL injection detection

**PHPStan Analysis**:
- Level 5 analysis (moderate strictness)
- Type checking
- Dead code detection
- Best practices validation

**Basic Security Checks**:
- Hardcoded password detection
- SQL injection vulnerability scanning
- XSS vulnerability detection
- File inclusion vulnerability detection

### **3. DevSkim Security Scanning (Enhanced)**
**File**: `.github/workflows/devskim.yml`

**Coverage**:
- ✅ **Multi-language support** (PHP, JavaScript, YAML, etc.)
- ✅ **Credential scanning**
- ✅ **Security rules**
- ✅ **GitHub Security integration**

**Enhanced Rules**:
- `security` - General security vulnerabilities
- `credentials` - Hardcoded credentials detection

## 🚀 How Security Testing Works

### **Automatic Triggers**
```yaml
# Semua workflows trigger pada:
on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]
```

### **Security Analysis Flow**
```
📝 Code Push/PR
    ↓
🔄 GitHub Actions Trigger
    ↓
🔍 Parallel Security Scans:
    ├── CodeQL (JavaScript)
    ├── Semgrep (PHP + JS)
    ├── PHPStan (PHP)
    ├── Basic Security Scan (PHP)
    └── DevSkim (Multi-language)
    ↓
📊 Results Collection
    ↓
🔔 GitHub Security Tab Integration
    ↓
📋 PR Comments & Alerts
```

## 📊 Security Coverage Matrix

| Vulnerability Type | CodeQL | Semgrep | PHPStan | DevSkim | Coverage |
|-------------------|---------|----------|----------|----------|----------|
| **SQL Injection** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **XSS** | ✅ | ✅ | ❌ | ✅ | ✅ |
| **CSRF** | ✅ | ✅ | ❌ | ✅ | ✅ |
| **Hardcoded Credentials** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **File Inclusion** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **Code Injection** | ✅ | ✅ | ❌ | ✅ | ✅ |
| **Type Errors** | ❌ | ❌ | ✅ | ❌ | ✅ |
| **Dead Code** | ❌ | ❌ | ✅ | ❌ | ✅ |
| **OWASP Top 10** | ✅ | ✅ | ❌ | ✅ | ✅ |

## 🎯 Expected Security Findings

### **PHP Vulnerabilities**
```php
// ❌ SQL Injection (will be detected)
$sql = "SELECT * FROM users WHERE id = $id";

// ✅ Safe (prepared statement)
$stmt = $connection->prepare("SELECT * FROM users WHERE id = ?");
$stmt->bind_param("i", $id);
```

### **JavaScript Vulnerabilities**
```javascript
// ❌ XSS (will be detected)
element.innerHTML = userInput;

// ✅ Safe (text content)
element.textContent = userInput;
```

### **Hardcoded Credentials**
```php
// ❌ Hardcoded password (will be detected)
$password = "secret123";

// ✅ Safe (environment variable)
$password = getenv('DB_PASSWORD');
```

## 📈 GitHub Security Integration

### **Security Tab Features**
- **CodeQL Alerts**: JavaScript vulnerabilities
- **Semgrep Alerts**: PHP + JavaScript security issues
- **DevSkim Alerts**: Credential leaks
- **Dependency Graph**: Third-party vulnerabilities

### **PR Integration**
- **Security Comments**: Automated feedback
- **Status Checks**: Pass/fail indicators
- **Remediation Guidance**: Fix suggestions

## 🔧 Local Security Testing

### **Run Security Scans Locally**

#### **Semgrep**
```bash
# Install Semgrep
pip install semgrep

# Run security scan
semgrep --config=auto --severity=ERROR,WARNING .

# Run specific rules
semgrep --config=p/php --config=p/security-audit .
```

#### **PHPStan**
```bash
# Install PHPStan
composer require --dev phpstan/phpstan

# Run analysis
vendor/bin/phpstan analyse

# Run with specific level
vendor/bin/phpstan analyse --level=5
```

#### **Manual Security Checks**
```bash
# Check for hardcoded passwords
grep -r "password.*=" . --include="*.php" | grep -v "getenv\|environment"

# Check for SQL injection
grep -r "mysqli_query.*\$" . --include="*.php" | grep -v "prepared\|stmt"

# Check for XSS
grep -r "echo.*\$" . --include="*.php" | grep -v "htmlspecialchars\|htmlentities"
```

## 🛠️ Configuration Files

### **PHPStan Configuration** (`phpstan.neon`)
```yaml
parameters:
    level: 5                    # Analysis strictness
    paths:
        - .                     # Scan all files
    excludePaths:
        - vendor/*              # Exclude dependencies
    ignoreErrors:
        # Allow legacy functions
        - '#Call to an undefined method mysqli::#'
```

### **Semgrep Configuration**
Semgrep menggunakan rules dari Semgrep Registry:
- `p/security-audit` - General security
- `p/php` - PHP-specific rules
- `p/javascript` - JavaScript rules
- `p/owasp-top-ten` - OWASP vulnerabilities

## 📊 Performance Metrics

### **Scan Duration Estimates**
- **CodeQL**: 2-5 minutes
- **Semgrep**: 30-60 seconds
- **PHPStan**: 1-2 minutes
- **DevSkim**: 30-60 seconds
- **Total**: ~5-10 minutes

### **Resource Usage**
- **Memory**: 2-4 GB total
- **CPU**: Medium usage
- **Storage**: Minimal (temporary files)

## 🎯 Best Practices

### **Development Security**
1. **Write secure code from start**
2. **Use prepared statements** for database queries
3. **Sanitize all user input**
4. **Use environment variables** for credentials
5. **Follow OWASP guidelines**

### **Code Review Security**
1. **Check security scan results** in PRs
2. **Fix high-severity issues** immediately
3. **Document security decisions**
4. **Keep dependencies updated**

### **Production Security**
1. **Regular security scans** (weekly)
2. **Monitor security alerts**
3. **Update dependencies** regularly
4. **Implement security headers**

## 🔍 Troubleshooting

### **Common Issues**

#### **False Positives**
```bash
# Exclude specific patterns in PHPStan
ignoreErrors:
    - '#Call to an undefined method mysqli::#'
```

#### **Missing Dependencies**
```bash
# Install PHPStan locally
composer require --dev phpstan/phpstan

# Install Semgrep locally
pip install semgrep
```

#### **Performance Issues**
```bash
# Limit scan scope
semgrep --config=p/php --severity=ERROR .

# Use caching
vendor/bin/phpstan analyse --memory-limit=1G
```

---

## 🎉 Success Criteria

### **✅ Security Testing Success**
- All 3 workflows pass without errors
- No high-severity vulnerabilities
- All findings documented and addressed
- GitHub Security tab populated

### **✅ Development Integration**
- Security feedback in PRs
- Local testing capabilities
- Clear remediation guidance
- Performance optimization

---

**🚀 Your PHP Native Dashboard now has enterprise-grade security testing for both PHP and JavaScript!**