# SonarQube Installation & Configuration Guide (Ubuntu + PostgreSQL)

This document provides a step-by-step guide to install and configure **:contentReference[oaicite:0]{index=0}** with **:contentReference[oaicite:1]{index=1}** on a Linux (Ubuntu/Debian-based) system.

---

## Prerequisites

- Ubuntu/Debian-based Linux OS
- Root or sudo access
- Minimum 2 GB RAM (4 GB recommended)

---

## Step 1: Install Java 17

SonarQube requires Java 17.

```bash
apt update
apt install openjdk-17-jdk -y
java -version
```

## Step 2: Install and Configure PostgreSQL

### 2.1 Install PostgreSQL

```bash
apt install postgresql -y
systemctl start postgresql
systemctl enable postgresql
```

### 2.2 Create Database and User

```bash
sudo -u postgres psql
```

### SQL

```bash
CREATE USER linux PASSWORD 'redhat';
CREATE DATABASE sonarqube;
GRANT ALL PRIVILEGES ON DATABASE sonarqube TO linux;
\c sonarqube;
GRANT ALL PRIVILEGES ON SCHEMA public TO linux;
\q
```

## Step 3: Configure Linux System Limits

```bash
sysctl -w vm.max_map_count=524288
sysctl -w fs.file-max=131072
ulimit -n 131072
ulimit -u 8192
```

## Step 4: Download and Install SonarQube

```bash
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-25.5.0.107428.zip
apt install unzip -y
unzip sonarqube-25.5.0.107428.zip
mv sonarqube-25.5.0.107428 /opt/sonar
```

## Step 5: Configure SonarQube Database Connection

```bash
vim /opt/sonar/conf/sonar.properties
```

### Add the following:

```bash
sonar.jdbc.username=linux
sonar.jdbc.password=redhat
sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube
```

## Step 6: Create SonarQube User and Set Permissions

```bash
useradd sonar -m
chown sonar:sonar -R /opt/sonar
```

## Step 7: Start SonarQube

```bash
su sonar
cd /opt/sonar/bin/linux-x86-64
./sonar.sh start
./sonar.sh status
```

## Step 8: Access SonarQube Web U

### Open your browser and navigate to:

```bASH
http://<server-ip>:9000
```

### Default Login

- Username: admin
- Password: admin
  **_ (Change password on first login) _**
