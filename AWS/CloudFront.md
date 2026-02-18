# AWS CloudFront – Complete Beginner Guide

This **README.md** is a **detailed, beginner-friendly guide** to **AWS CloudFront**. It explains **what CloudFront is, why it is used, how it works, key concepts, security, pricing, and step-by-step configuration** in simple language.

---

## What is AWS CloudFront? (Simple Explanation)

**AWS CloudFront** is a **Content Delivery Network (CDN)** service.

Think of CloudFront as:

> A **global network of servers** that deliver your website content (images, videos, HTML, CSS, JS) **faster to users** by serving it from the nearest location.

---

## Why Do We Use CloudFront?

Without CloudFront:

- Content is served from one region
- Higher latency for distant users
- Slower website performance

With CloudFront:

- Faster page load
- Low latency
- High availability
- Better security
- Reduced load on origin servers

---

## How CloudFront Works (Simple Flow)

```
User → Nearest Edge Location → CloudFront → Origin (S3 / ALB / EC2)
```

- User requests content
- CloudFront checks cache
- If cached → served immediately
- If not cached → fetches from origin and caches it

---

## Key CloudFront Concepts (Must Know)

### 1. Distribution

A **distribution** is the main CloudFront configuration.

Types:

- Web distribution (most common)

---

### 2. Origin

The **origin** is the source of content.

Examples:

- S3 bucket
- Application Load Balancer
- EC2 instance
- API Gateway

---

### 3. Edge Locations

Edge locations are **CloudFront servers around the world** that cache and serve content.

---

### 4. Cache Behavior

Defines:

- Which content is cached
- How long it is cached
- HTTP methods allowed

---

## Common CloudFront Use Cases

- Static website acceleration
- Serving images and videos
- API acceleration
- Secure content delivery

---

## Step-by-Step: CloudFront with S3 (Most Common Setup)

### Step 1: Create an S3 Bucket

- Create bucket
- Upload static files
- Keep bucket private (recommended)

---

### Step 2: Create CloudFront Distribution

1. Go to CloudFront
2. Click **Create distribution**
3. Origin domain → Select S3 bucket
4. Enable **Origin Access Control (OAC)**
5. Default settings → Create

---

### Step 3: Update S3 Bucket Policy

Allow CloudFront to access the bucket (not public users).

---

### Step 4: Access CloudFront URL

- Copy distribution domain name
- Open in browser

Content loads faster globally.

---

## CloudFront with Load Balancer

Architecture:

```
User → CloudFront → ALB → EC2
```

Benefits:

- DDoS protection
- Caching
- Reduced ALB load

---

## CloudFront Caching

### TTL (Time To Live)

Controls how long content stays cached.

- Default TTL
- Minimum TTL
- Maximum TTL

---

### Cache Invalidation

Used to remove old content.

Example:

```
/index.html
/*
```

---

## CloudFront Security Features

### 1. HTTPS / SSL

- Free SSL certificates
- Enforce HTTPS

---

### 2. Origin Access Control (OAC)

- Prevents public access to S3
- CloudFront-only access

---

### 3. AWS WAF

- Protect against SQL injection
- Protect against XSS
- Block malicious traffic

---

### 4. Geo-Restriction

- Allow or block countries

---

## CloudFront Logging & Monitoring

### Access Logs

- Stored in S3

### CloudWatch Metrics

- Requests
- Error rates
- Cache hit ratio

---

## CloudFront Pricing Basics

You pay for:

- Data transfer out
- HTTP/HTTPS requests
- Invalidation requests (after free tier)

Cost optimization tips:

- Cache static content
- Use compression
- Set correct TTL

---

## CloudFront vs S3 Direct Access

| CloudFront | S3                      |
| ---------- | ----------------------- |
| Global CDN | Single region           |
| Fast       | Slower for global users |
| Secure     | Public access risk      |

---

## Real-World Architectures

- Website: CloudFront → S3
- Application: CloudFront → ALB → EC2
- API: CloudFront → API Gateway

---

## Summary

You learned:

- What CloudFront is
- How it works
- Core concepts
- Step-by-step setup
- Security and pricing

---

🎉 **Congratulations! You now understand AWS CloudFront clearly.**
