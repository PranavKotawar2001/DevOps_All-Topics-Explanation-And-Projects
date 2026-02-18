# Jenkins Installation Guide (Ubuntu / Debian)

This document provides a step-by-step guide to install and configure **:contentReference[oaicite:0]{index=0}**, a popular open-source **CI/CD automation server**, on a Linux (Ubuntu/Debian-based) system.

---

## Prerequisites

- Ubuntu/Debian-based Linux OS
- Root or sudo access
- Minimum 2 GB RAM (4 GB recommended)
- Internet connectivity

---

## Step 1: Update System Packages

Before installing Jenkins, update the system package index:

```bash
apt update
```

---

## Step 2: Install Java 17

### Jenkins requires Java to run. Install OpenJDK 17:

```bash
apt install openjdk-17-jdk -y
```

### Verify Java installation:

```bash
java -version
```

---

## Step 3: Add Jenkins Repository and GPG Key

### 3.1 Add Jenkins GPG Key

```bash
wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
```

### 3.2 Add Jenkins Repository

```bash
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null
```

---

## Step 4: Install Jenkins

### Update package index and install Jenkins:

```bash
apt update
apt install jenkins -y
```

---

## Step 5: Start and Enable Jenkins Service

### Start Jenkins service:

```bash
systemctl start jenkins
```

### Enable Jenkins to start on boot:

```bash
systemctl enable jenkins
```

### Check Jenkins status:

```bash
systemctl status jenkins
```

---

## Step 6: Access Jenkins Web UI

### Open your browser and navigate to:

```bash
http://<server-ip>:8080
```

---

## Step 7: Unlock Jenkins

###cRetrieve the initial admin password:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

### **_ Paste this password into the Jenkins UI to unlock Jenkins. _**

---

## Step 8: Complete Jenkins Setup

**_ Click Install Suggested Plugins _**
**_ Create the Admin User _**
**_ Configure Jenkins URL _**
**_ Finish setup _**

---

### 🎉 Installation Complete

Jenkins is now successfully installed and ready to use.

### **_ Default Jenkins Details _**

Service Name: jenkins
Port: 8080
Home Directory: /var/lib/jenkins
Config File: /etc/default/jenkins

---
