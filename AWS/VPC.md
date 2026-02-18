# AWS VPC – Step-by-Step Beginner Guide

This **README.md** is written for **absolute beginners**. It explains what a **VPC (Virtual Private Cloud)** is and how to create one **step by step**, using very simple language.

---

## What is a VPC? (Very Simple Explanation)

A **VPC (Virtual Private Cloud)** is your **own private network inside AWS**.

Think of it like:

- A private office building
- You control who can enter and leave
- You decide the network range, subnets, and security

Inside a VPC, you can place:

- EC2 instances
- Load Balancers
- Databases

---

## Why Do We Need a VPC?

We use a VPC to:

- Isolate our resources
- Control network traffic
- Improve security
- Design scalable architectures

---

## Prerequisites

Before starting, make sure you have:

- An AWS account
- Basic understanding of EC2
- Internet access

---

# STEP 1: Open VPC Dashboard

1. Log in to AWS Console
2. Search for **VPC**
3. Click **VPC → Your VPCs**
4. Click **Create VPC**

---

# STEP 2: Create VPC

1. Select **VPC only**
2. Enter:
   - **Name tag**: `my-vpc`
   - **IPv4 CIDR block**: `10.0.0.0/16`

3. Leave other settings as default
4. Click **Create VPC**

### Explanation

- CIDR `10.0.0.0/16` gives you a large private network

---

# STEP 3: Create Subnets

Subnets divide your VPC into smaller networks.

---

## Step 3.1: Create Public Subnet

1. Go to **Subnets → Create subnet**
2. Select your VPC: `my-vpc`
3. Enter:
   - **Subnet name**: `public-subnet`
   - **Availability Zone**: choose any (example: us-east-1a)
   - **CIDR block**: `10.0.1.0/24`

4. Click **Create subnet**

---

## Step 3.2: Create Private Subnet

1. Click **Create subnet** again
2. Enter:
   - **Subnet name**: `private-subnet`
   - **Availability Zone**: choose another AZ
   - **CIDR block**: `10.0.2.0/24`

3. Click **Create subnet**

---

# STEP 4: Create Internet Gateway (IGW)

An **Internet Gateway** allows internet access for your VPC.

1. Go to **Internet Gateways**
2. Click **Create internet gateway**
3. Name it: `my-igw`
4. Click **Create**

---

## Step 4.1: Attach IGW to VPC

1. Select `my-igw`
2. Click **Actions → Attach to VPC**
3. Select `my-vpc`
4. Click **Attach**

---

# STEP 5: Create Route Table

Route tables control where network traffic goes.

---

## Step 5.1: Create Public Route Table

1. Go to **Route Tables → Create route table**
2. Name: `public-rt`
3. Select VPC: `my-vpc`
4. Click **Create**

---

## Step 5.2: Add Internet Route

1. Select `public-rt`
2. Go to **Routes → Edit routes**
3. Add route:
   - Destination: `0.0.0.0/0`
   - Target: **Internet Gateway (my-igw)**

4. Save routes

---

## Step 5.3: Associate Route Table with Public Subnet

1. Go to **Subnet associations**
2. Click **Edit subnet associations**
3. Select `public-subnet`
4. Save

---

# STEP 6: Enable Public IP for Public Subnet

1. Go to **Subnets**
2. Select `public-subnet`
3. Click **Edit subnet settings**
4. Enable **Auto-assign public IPv4 address**
5. Save

---

# STEP 7: Launch EC2 in VPC

1. Launch an EC2 instance
2. Select:
   - VPC: `my-vpc`
   - Subnet: `public-subnet`

3. Enable public IP
4. Attach security group

---

🎉 **Congratulations! Your AWS VPC is ready.**
