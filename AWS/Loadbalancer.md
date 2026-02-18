# AWS Application Load Balancer (ALB) – Step-by-Step Beginner Guide

This **README.md** explains how to create and test an **AWS Application Load Balancer** using **simple language**. It is written for **beginners / freshers**.

---

## What is a Load Balancer? (Simple Explanation)

A **Load Balancer** distributes incoming traffic across multiple EC2 instances so that:

- No single server is overloaded
- Application remains available even if one server fails

Example:

- User requests → Load Balancer → EC2 Instance 1 or EC2 Instance 2

---

## Prerequisites

Before starting, make sure you have:

- AWS account
- 2 EC2 instances running
- Instances in **different Availability Zones (AZs)**
- HTTP server installed on both instances (Apache / Nginx)
- Security group allowing **HTTP (port 80)**

---

# STEP 1: Create EC2 Instances in Different AZs

1. Go to **EC2 Dashboard → Instances**
2. Launch **2 EC2 instances**
3. Select:
   - AMI: Ubuntu 20.04 / 22.04
   - Instance type: t2.micro or t3.micro

4. While launching:
   - Select **different AZs** (example: us-east-1a, us-east-1b)
   - Enable **HTTP (port 80)** in security group

---

## Step 1.1: Install Web Server on Each Instance

SSH into each instance and install Apache:

```bash
sudo apt update
sudo apt install apache2 -y
```

(Optional) Change index page to identify server:

```bash
echo "This is Server 1" | sudo tee /var/www/html/index.html
```

On second instance:

```bash
echo "This is Server 2" | sudo tee /var/www/html/index.html
```

---

# STEP 2: Create a Target Group

A **Target Group** tells the Load Balancer **where to send traffic**.

### Step 2.1: Open Target Groups

1. Go to **EC2 Dashboard**
2. Click **Target Groups** (left menu)
3. Click **Create target group**

---

### Step 2.2: Configure Target Group

1. Target type: **Instances**
2. Protocol: **HTTP**
3. Port: **80**
4. VPC: Select your VPC
5. Click **Next**

---

### Step 2.3: Register Targets

1. Select **both EC2 instances**
2. Click **Include as pending below**
3. Click **Create target group**

---

# STEP 3: Create Load Balancer

### Step 3.1: Open Load Balancers

1. Go to **EC2 Dashboard**
2. Click **Load Balancers**
3. Click **Create load balancer**

---

### Step 3.2: Choose Load Balancer Type

1. Select **Application Load Balancer**
2. Click **Create**

---

### Step 3.3: Configure Load Balancer

1. Name: `my-alb`
2. Scheme: **Internet-facing**
3. IP address type: IPv4
4. Listeners: HTTP on port 80

---

# STEP 4: Create Security Group for Load Balancer

### Step 4.1: Create Security Group

Inbound rules:

- HTTP (80) → Source: Anywhere (0.0.0.0/0)

Outbound rules:

- Allow **All traffic**

Attach this security group to the Load Balancer.

---

# STEP 5: Attach Target Group

1. Select the **target group** you created earlier
2. Click **Create load balancer**

Wait until the Load Balancer status becomes **Active**.

---

# STEP 6: Test Load Balancer

1. Copy the **DNS name** of the Load Balancer
2. Paste it into your browser

Example:

```
http://my-alb-123456.us-east-1.elb.amazonaws.com
```

Refresh multiple times — you should see:

- "This is Server 1"
- "This is Server 2"

This confirms traffic is being balanced.

---

# STEP 7: Verify Using Resource Map

1. Go to **EC2 → Load Balancers**
2. Select your Load Balancer
3. Click **Resource Map**
4. Verify:
   - Load Balancer → Target Group → EC2 Instances

---

🎉 **Congratulations! You have successfully created an AWS Load Balancer.**
