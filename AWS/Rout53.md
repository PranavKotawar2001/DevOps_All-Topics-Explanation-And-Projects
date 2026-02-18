# AWS Route 53 – Complete Beginner Guide

This **README.md** is a **detailed, beginner-friendly guide** to **AWS Route 53**. It explains **what Route 53 is, why it is used, all record types, routing policies, health checks, and step-by-step usage** in very simple language.

---

## What is AWS Route 53? (Simple Explanation)

**AWS Route 53** is a **Domain Name System (DNS) service** provided by AWS.

Think of Route 53 as:

> The **internet phonebook** that converts domain names (like `www.example.com`) into IP addresses (like `54.10.20.30`).

---

## Why Do We Use Route 53?

Without Route 53:

- Users must remember IP addresses
- No traffic control
- No health-based routing

With Route 53:

- Easy domain access
- High availability
- Traffic routing
- Health checks
- Scalable DNS

---

## Key Route 53 Concepts (Must Know)

### 1. Domain Name

A human-readable name like:

```
example.com
```

---

### 2. Hosted Zone

A **hosted zone** is a container for DNS records.

Types:

- Public Hosted Zone (internet-facing)
- Private Hosted Zone (inside VPC)

---

### 3. DNS Records

DNS records map domain names to AWS resources.

---

## Common Route 53 Record Types

| Record Type | Purpose                       |
| ----------- | ----------------------------- |
| A           | Maps domain to IPv4 address   |
| AAAA        | Maps domain to IPv6 address   |
| CNAME       | Maps domain to another domain |
| ALIAS       | AWS-specific record           |
| MX          | Mail servers                  |
| TXT         | Verification, SPF             |
| NS          | Name servers                  |
| SOA         | Zone information              |

---

## Alias vs CNAME (Important)

| Alias                 | CNAME                   |
| --------------------- | ----------------------- |
| AWS specific          | Standard DNS            |
| Root domain supported | Root domain not allowed |
| Free                  | Standard charges        |

---

## Step-by-Step: Create Hosted Zone

### Step 1: Open Route 53

- Go to AWS Console
- Search **Route 53**

---

### Step 2: Create Hosted Zone

1. Click **Hosted zones → Create hosted zone**
2. Domain name: `example.com`
3. Type: Public Hosted Zone
4. Create

---

## Step-by-Step: Create DNS Record

### Example: Connect Domain to EC2

1. Open hosted zone
2. Create record
3. Record type: **A**
4. Value: EC2 Public IP
5. Save record

---

## Route 53 Routing Policies

Routing policies control **how traffic is routed**.

---

### 1. Simple Routing

- Single resource
- No health checks

Use case: Single EC2 instance

---

### 2. Weighted Routing

- Split traffic by percentage

Example:

- 70% → Server A
- 30% → Server B

---

### 3. Latency-Based Routing

- Route user to **lowest latency region**

Use case: Global applications

---

### 4. Failover Routing

- Primary + Secondary
- Uses health checks

Use case: Disaster recovery

---

### 5. Geolocation Routing

- Based on user location

Use case: Country-based content

---

### 6. Multi-Value Answer Routing

- Returns multiple healthy resources

---

## Route 53 Health Checks

Health checks monitor **endpoint health**.

---

### What Can Be Checked?

- HTTP / HTTPS
- TCP

---

### Use Case

- Route traffic only to healthy resources

---

## Step-by-Step: Health Check

1. Go to Route 53 → Health checks
2. Create health check
3. Endpoint: EC2 or Load Balancer
4. Protocol: HTTP/HTTPS
5. Save

---

## Route 53 with Load Balancer

Common setup:

```
User → Route 53 → ALB → EC2
```

Use **Alias record** for ALB.

---

## Route 53 with S3 Website

- Use Alias record
- Point to S3 static website

---

## Route 53 Security Best Practices

- Use private hosted zones for internal apps
- Enable health checks
- Use least privilege IAM
- Avoid hardcoding IPs

---

## Route 53 Pricing Basics

You pay for:

- Hosted zones
- DNS queries
- Health checks

---

## Real-World Architecture Examples

- Website hosting: Route 53 → ALB → EC2
- DR setup: Failover routing
- Global app: Latency routing

---

## Summary

You learned:

- What Route 53 is
- Hosted zones & records
- Routing policies
- Health checks
- Real-world use cases

---

🎉 **Congratulations! You now understand AWS Route 53 clearly.**
