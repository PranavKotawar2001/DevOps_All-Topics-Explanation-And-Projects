# AWS EBS (Elastic Block Store) – Complete Beginner Guide

This **README.md** explains **Amazon Elastic Block Store (EBS)** in a **simple, step-by-step way** so that even a beginner can understand it easily.

---

## What is EBS?

**EBS (Elastic Block Store)** is a **block-level storage service** used with **EC2 instances**.

👉 Think of EBS like a **hard disk (HDD/SSD)** that you attach to a virtual server (EC2).

- EC2 = Computer (CPU + RAM)
- EBS = Hard Disk (storage)

Without EBS, your EC2 has **no permanent storage**.

---

## Why Do We Need EBS?

EBS is used to:

- Store operating system files
- Store application data
- Store databases
- Keep data safe even if EC2 stops

Key benefit:

> **Data persists even after EC2 is stopped or restarted**

---

## Key Features of EBS

- Persistent storage
- High availability (replicated within AZ)
- Snapshot support (backup)
- Encryption supported
- Resize volumes anytime

---

## Types of EBS Volumes

### 1. General Purpose SSD (gp3 / gp2)

- Most commonly used
- Balanced performance and cost
- Used for web servers, apps, small DBs

### 2. Provisioned IOPS SSD (io1 / io2)

- High performance
- Used for large databases
- Very low latency

### 3. Throughput Optimized HDD (st1)

- For large sequential workloads
- Big data, logs

### 4. Cold HDD (sc1)

- Cheapest
- Infrequently accessed data

---

## EBS Volume vs Instance Store

| Feature       | EBS             | Instance Store |
| ------------- | --------------- | -------------- |
| Persistent    | Yes             | No             |
| Backup        | Yes (Snapshots) | No             |
| Attach/Detach | Yes             | No             |
| Use case      | Most workloads  | Temporary data |

---

## EBS Architecture

- EBS volumes are **AZ-specific**
- You cannot attach an EBS volume to EC2 in a different AZ

Example:

- EC2 in ap-south-1a → EBS must be in ap-south-1a

---

## Step-by-Step: Create and Attach EBS Volume

### Step 1: Open EC2 Console

- Go to AWS Console
- Open **EC2 → Volumes**

---

### Step 2: Create Volume

- Click **Create Volume**
- Select:
  - Volume type: gp3
  - Size: 10 GB
  - Availability Zone: Same as EC2

- Click **Create Volume**

---

### Step 3: Attach Volume to EC2

- Select the volume
- Click **Actions → Attach Volume**
- Choose EC2 instance
- Click **Attach**

---

## Step-by-Step: Mount EBS Volume in EC2 (Linux)

### Step 4: Check Volume

```bash
lsblk
```

---

### Step 5: Format Volume

```bash
sudo mkfs -t ext4 /dev/xvdf
```

---

### Step 6: Create Mount Directory

```bash
sudo mkdir /data
```

---

### Step 7: Mount Volume

```bash
sudo mount /dev/xvdf /data
```

---

### Step 8: Verify Mount

```bash
df -h
```

---

## Make EBS Persistent After Reboot

Edit fstab file:

```bash
sudo nano /etc/fstab
```

Add:

```
/dev/xvdf /data ext4 defaults,nofail 0 2
```

---

## EBS Snapshots (Backup)

### What is a Snapshot?

A snapshot is a **backup of EBS volume stored in S3**.

- Incremental backup
- Can restore volume anytime

---

### Create Snapshot

- Go to **EC2 → Volumes**
- Select volume
- Click **Actions → Create Snapshot**

---

### Restore from Snapshot

- Go to **Snapshots**
- Click **Create Volume**

---

## EBS Encryption

EBS supports **encryption at rest and in transit**.

- Uses AWS KMS
- Enable encryption during volume creation

Best Practice:

> Always use encrypted EBS volumes

---

## EBS Resize (Increase Size)

Steps:

1. Modify volume size
2. Resize filesystem inside EC2

```bash
sudo resize2fs /dev/xvdf
```

---

## EBS Performance Factors

Performance depends on:

- Volume type
- IOPS
- Throughput
- EC2 instance type

---

## EBS Pricing (Simple)

You pay for:

- Storage size (GB per month)
- Snapshots storage
- Provisioned IOPS (if any)

Stopped EC2 **still costs EBS storage**.

---

## Real-World Use Cases

- EC2 root volume
- Database storage
- Application data storage
- Log storage

---

## EBS Best Practices

- Use gp3 for most workloads
- Enable encryption
- Take regular snapshots
- Monitor with CloudWatch

---

🎉 **You now understand AWS EBS clearly and practically!**
