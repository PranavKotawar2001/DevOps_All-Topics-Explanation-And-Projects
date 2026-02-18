# AWS EC2 Instance – Step-by-Step Beginner Guide

This **README.md** is written for **absolute beginners**. It explains how to create, connect to, and verify an **EC2 instance** in AWS using **simple language**.

---

## What is an EC2 Instance? (Simple Explanation)

An **EC2 instance** is a virtual server in the cloud. You can use it to:

- Host applications
- Run websites
- Practice Linux and DevOps tools

Think of it as a **computer on the internet**.

---

## Prerequisites

Before starting, make sure you have:

- An AWS account
- Basic internet access
- An SSH client (Terminal / Git Bash / PuTTY)

---

# STEP 1: Open EC2 Dashboard

1. Log in to AWS Console
2. Search for **EC2**
3. Click **EC2 → Instances**
4. Click **Launch instance**

---

# STEP 2: Choose an AMI (Operating System)

1. Select **Ubuntu Server 20.04 / 22.04 LTS**
2. This is the OS that will run on your EC2 instance

---

# STEP 3: Choose Instance Type

1. Select **t2.micro** or **t3.micro**
2. These are **free-tier eligible** and good for beginners

---

# STEP 4: Create or Select Key Pair

A **key pair** is used to securely connect to your instance.

1. Select an existing key pair
   OR
2. Create a new key pair
   - Name it (example: `ec2-key`)
   - Download and save the `.pem` file safely

⚠️ Do not delete or share this key.

---

# STEP 5: Configure Network Settings

1. Select your **VPC** (default is fine)
2. Select a **Subnet**
3. Enable **Auto-assign public IP**

---

# STEP 6: Configure Security Group

A **Security Group** acts like a firewall.

### Inbound Rules

Add the following rules:

- SSH (22) → Source: Your IP
- HTTP (80) → Source: Anywhere (0.0.0.0/0)

### Outbound Rules

- Allow **All traffic** (default)

---

# STEP 7: Launch EC2 Instance

1. Review all settings
2. Click **Launch instance**

Wait for the instance state to become **Running**.

---

# STEP 8: Connect to EC2 Instance

1. Select your instance
2. Click **Connect**
3. Choose **SSH client**

Example command:

```bash
ssh -i ec2-key.pem ubuntu@<PUBLIC_IP>
```

---

# STEP 9: Verify Instance is Working

After login, run:

```bash
whoami
uname -a
```

If commands work, your EC2 instance is ready.

---

# STEP 10: (Optional) Install Web Server

Install Apache:

```bash
sudo apt update
sudo apt install apache2 -y
```

Open browser and hit:

```
http://<PUBLIC_IP>
```

You should see the **Apache default page**.

---

🎉 **Congratulations! Your EC2 instance is ready to use.**
