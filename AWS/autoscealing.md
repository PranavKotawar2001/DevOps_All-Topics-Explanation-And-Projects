# AWS EC2 Auto Scaling – Step-by-Step Beginner Guide

This **README.md** explains how to create an **EC2 Auto Scaling Group** in AWS using **simple language** and **clear steps**. It is written for **beginners / freshers**.

---

## What is Auto Scaling? (Simple Explanation)

**Auto Scaling** automatically increases or decreases the number of EC2 instances based on demand.

Example:

- Low traffic → fewer instances
- High traffic → more instances

This helps with:

- High availability
- Cost optimization
- Automatic recovery

---

## Prerequisites

Before starting, make sure you have:

- AWS account
- EC2 key pair (for SSH access)
- Security group allowing required ports (SSH 22, HTTP 80 if needed)
- Basic knowledge of EC2

---

# STEP 1: Create a Launch Template

A **Launch Template** is a blueprint that tells AWS:

- Which OS to use
- What instance type to launch
- Which key pair and security group to use

### Step 1.1: Open Launch Templates

1. Go to **AWS Console**
2. Open **EC2 Dashboard**
3. Click **Launch Templates**
4. Click **Create launch template**

---

### Step 1.2: Configure Launch Template

Fill in the following details:

- **Launch template name**: `asg-ubuntu-template`
- **AMI**: Ubuntu 20.04 / 22.04
- **Instance type**: `t3.micro`
- **Key pair**: Select your existing key pair
- **Security group**: Select your security group
- **User data (optional)**: Add startup scripts if required

Click **Create launch template**.

---

# STEP 2: Create Auto Scaling Group

Now we will create the Auto Scaling Group using the launch template.

### Step 2.1: Open Auto Scaling Groups

1. Go to **EC2 Dashboard**
2. Click **Auto Scaling Groups**
3. Click **Create Auto Scaling group**

---

### Step 2.2: Select Launch Template

1. Select the **launch template** you created earlier
2. Click **Next**

---

### Step 2.3: Choose Network and AZs

1. Select your **VPC**
2. Select **multiple subnets (AZs)**

Explanation:

- Multiple AZs provide **high availability**
- If one AZ fails, instances in another AZ will run

---

### Step 2.4: Configure Group Size (Very Important)

Set the following values:

- **Desired capacity**: `2`
- **Minimum capacity**: `2`
- **Maximum capacity**: `4`

Explanation:

- Minimum = instances never go below 2
- Desired = start with 2 instances
- Maximum = scale up to 4 when needed

---

### Step 2.5: Scaling Policies (Optional)

You can:

- Skip scaling policies (manual scaling)
- OR add automatic scaling based on CPU or traffic

For beginners, **skip this step**.

---

### Step 2.6: Create Auto Scaling Group

1. Review all settings
2. Click **Create Auto Scaling group**

---

# STEP 3: Verify EC2 Instances

1. Go to **EC2 → Instances**
2. You should see **2 running EC2 instances**
3. Instance names will include the Auto Scaling Group name

This confirms Auto Scaling is working correctly.

---

🎉 **Congratulations! You have created EC2 Auto Scaling successfully.**
