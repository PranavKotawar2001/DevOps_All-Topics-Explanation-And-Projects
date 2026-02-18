# AWS RDS (Relational Database Service) – Complete Beginner Guide

This **README.md** is a **detailed, beginner-friendly guide** to **AWS RDS**. It explains **what RDS is, why it is used, all core concepts, supported engines, security, backups, scaling, and step-by-step usage** in very simple language.

---

## What is AWS RDS? (Simple Explanation)

**AWS RDS (Relational Database Service)** is a **managed database service** that makes it easy to create, operate, and scale relational databases in the cloud.

Think of RDS as:

> A **database server managed by AWS**, so you don’t have to worry about installation, patching, backups, or maintenance.

---

## Why Use AWS RDS?

Without RDS:

- You must install database software manually
- Handle backups yourself
- Manage updates and security

With RDS:

- AWS manages database operations
- Automatic backups
- High availability
- Easy scaling
- Secure by default

---

## Supported Database Engines

AWS RDS supports the following engines:

| Engine     | Use Case                |
| ---------- | ----------------------- |
| MySQL      | Web applications        |
| PostgreSQL | Advanced applications   |
| MariaDB    | MySQL compatible        |
| Oracle     | Enterprise workloads    |
| SQL Server | Microsoft workloads     |
| Aurora     | High-performance AWS DB |

---

## Key RDS Concepts (Must Know)

### 1. DB Instance

A **DB instance** is a running database server.

---

### 2. DB Engine

The database software (MySQL, PostgreSQL, etc.).

---

### 3. Storage

Where database data is stored.

- General Purpose (gp3)
- Provisioned IOPS (io1/io2)

---

### 4. Endpoint

The **connection address** used by applications.

Example:

```
mydb.xxxxx.us-east-1.rds.amazonaws.com
```

---

## RDS Deployment Options

### Single-AZ

- One database instance
- Low cost
- Not highly available

### Multi-AZ

- Primary + standby instance
- Automatic failover
- High availability (recommended)

---

## Step-by-Step: Create RDS Instance (MySQL Example)

### Step 1: Open RDS

- Go to AWS Console
- Search **RDS**

---

### Step 2: Create Database

1. Click **Create database**
2. Choose **Standard Create**
3. Select engine: **MySQL**

---

### Step 3: Configure Settings

- DB identifier: `my-rds-db`
- Master username: `admin`
- Password: create strong password

---

### Step 4: Instance Configuration

- Instance type: `db.t3.micro` (free tier)
- Storage: 20 GB

---

### Step 5: Connectivity

- VPC: default
- Public access: Yes (for learning)
- Security group: Allow DB port (3306)

---

### Step 6: Create Database

Click **Create database** and wait.

---

## Step-by-Step: Connect to RDS

### From EC2 (Recommended)

```bash
mysql -h <endpoint> -u admin -p
```

---

### From Local Machine

- Ensure security group allows your IP

---

## RDS Security

### 1. Network Security

- Use VPC
- Use security groups

### 2. Authentication

- Database username & password
- IAM authentication (optional)

### 3. Encryption

- Encryption at rest
- Encryption in transit (SSL)

---

## RDS Backups & Snapshots

### Automated Backups

- Enabled by default
- Point-in-time recovery

### Manual Snapshots

- User initiated
- Retained until deleted

---

## RDS Scaling

### Vertical Scaling

- Change instance size

### Storage Scaling

- Increase storage size

---

## RDS Monitoring

### CloudWatch Metrics

- CPU utilization
- Memory
- Disk I/O

### Enhanced Monitoring

- OS-level metrics

---

## RDS Maintenance

- Automatic minor upgrades
- Maintenance window
- Patch management by AWS

---

## RDS Pricing Basics

You pay for:

- Instance hours
- Storage
- Backup storage
- Data transfer

---

## RDS vs EC2 Database

| RDS               | EC2 DB       |
| ----------------- | ------------ |
| Managed           | Self-managed |
| Automatic backups | Manual       |
| Easy scaling      | Complex      |

---

## Real-World Use Cases

- Web application databases
- ERP systems
- SaaS applications
- Reporting databases

---

# AWS RDS – Advanced Topics (What to Learn Next)

This **README.md** explains the **next important RDS topics** that every beginner should learn after understanding basic RDS.

Topics covered:

1. RDS + IAM Authentication
2. RDS Read Replicas
3. Amazon Aurora (Deep Dive)
4. RDS with Terraform

Each section includes **what it is, why it is used, how it works, and simple steps**.

---

## 1. RDS + IAM Authentication

### What is RDS IAM Authentication?

RDS IAM Authentication allows you to **connect to an RDS database using IAM roles instead of database passwords**.

Instead of:

- Username + Password

You use:

- IAM Role + Temporary Token

---

### Why Use IAM Authentication?

- No hardcoded passwords
- More secure
- Centralized access control
- Easy rotation

---

### Supported Engines

- MySQL
- PostgreSQL

---

### How It Works (Simple)

1. IAM generates a temporary auth token
2. Token is used to connect to RDS
3. Token expires automatically

---

### High-Level Steps

1. Enable IAM authentication on RDS
2. Create IAM role with RDS permissions
3. Grant DB user permission
4. Connect using auth token

---

## 2. RDS Read Replicas

### What are Read Replicas?

Read replicas are **read-only copies of the main RDS database**.

---

### Why Use Read Replicas?

- Improve read performance
- Reduce load on primary DB
- Scale read-heavy applications

---

### How Read Replicas Work

- Data is asynchronously replicated
- Primary DB handles writes
- Replicas handle reads

---

### Use Cases

- Reporting
- Analytics
- High-traffic applications

---

### Key Points

- Replicas are read-only
- Can be in same or different region
- Supported engines: MySQL, PostgreSQL, Aurora

---

## 3. Amazon Aurora – Deep Dive

### What is Aurora?

Aurora is a **cloud-native, high-performance relational database** compatible with MySQL and PostgreSQL.

---

### Why Use Aurora?

- Faster than standard RDS
- Highly available
- Auto-scaling storage
- Fault-tolerant

---

### Aurora Architecture (Simple)

- 1 Writer instance
- Multiple Reader instances
- Distributed storage across 3 AZs

---

### Aurora Features

- Automatic failover
- Read replicas (up to 15)
- Serverless option
- Continuous backups

---

### Aurora vs RDS

| Feature      | RDS      | Aurora    |
| ------------ | -------- | --------- |
| Performance  | Good     | Very High |
| Availability | Multi-AZ | Built-in  |
| Cost         | Lower    | Higher    |

---

## 4. RDS with Terraform

### What is RDS with Terraform?

Terraform allows you to **create and manage RDS using code** instead of manual clicks.

---

### Why Use Terraform?

- Automation
- Version control
- Repeatable deployments
- Infrastructure as Code (IaC)

---

### Example: Create RDS with Terraform

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "example" {
  identifier        = "terraform-rds"
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  username          = "admin"
  password          = "StrongPassword123"
  skip_final_snapshot = true
}
```

---

### Terraform Workflow

```bash
terraform init
terraform plan
terraform apply
```

---

## Security Best Practices (Important)

- Use IAM authentication where possible
- Enable encryption at rest
- Do not make DB public in production
- Use Multi-AZ for production
- Rotate credentials

---

## Real-World Architecture Examples

- EC2 → IAM Role → RDS
- Application → Read Replica → Reporting
- Aurora → High availability application
- Terraform → RDS provisioning

---

🎉 **You now understand advanced AWS RDS concepts clearly!**

## Summary

You learned:

- What RDS is
- Supported engines
- How to create RDS
- Security, backups, scaling
- Best practices
- RDS + IAM authentication
- RDS read replicas
- Aurora deep dive
- RDS with Terraform

---

🎉 **Congratulations! You now understand AWS RDS clearly.**
