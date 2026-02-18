# AWS Transit Gateway – Step-by-Step Beginner Guide

This **README.md** explains **AWS Transit Gateway** in a **simple, beginner-friendly way**. It covers **what it is, why it is used, and how to configure it step by step**.

---

## What is a Transit Gateway? (Very Simple Explanation)

An **AWS Transit Gateway (TGW)** acts like a **central hub** that connects multiple networks together.

Think of it like:

- Many office buildings (VPCs)
- One **central highway junction**
- All traffic passes through this junction

Instead of connecting each VPC to every other VPC, all VPCs connect to the **Transit Gateway**.

---

## Why Do We Need Transit Gateway?

Transit Gateway is used when:

- You have **many VPCs**
- VPC Peering becomes complex
- You want **centralized network control**
- You need scalable architecture

---

## Transit Gateway vs VPC Peering (Simple)

| Feature            | VPC Peering | Transit Gateway |
| ------------------ | ----------- | --------------- |
| Number of VPCs     | Few         | Many            |
| Transitive routing | ❌ No       | ✅ Yes          |
| Management         | Complex     | Centralized     |
| Scalability        | Limited     | High            |

---

## Important Points to Remember

- Transit Gateway supports **transitive routing**
- CIDR blocks must **not overlap**
- TGW is **regional**
- Attachments connect VPCs to TGW
- Route tables control traffic flow

---

## Prerequisites

Before starting, make sure you have:

- AWS account
- Two or more VPCs
- Non-overlapping CIDR blocks
- EC2 instances in each VPC (for testing)

Example:

- VPC-A: `10.0.0.0/16`
- VPC-B: `10.1.0.0/16`
- VPC-C: `10.2.0.0/16`

---

# STEP 1: Open Transit Gateway Dashboard

1. Log in to AWS Console
2. Search for **VPC**
3. Click **Transit Gateways**
4. Click **Create Transit Gateway**

---

# STEP 2: Create Transit Gateway

Fill in the details:

- **Name tag**: `my-transit-gateway`
- Description: Optional
- Leave other settings as default (for beginners)

Click **Create Transit Gateway**.

Wait until status becomes **Available**.

---

# STEP 3: Create Transit Gateway Attachments

Each VPC must be attached to the Transit Gateway.

---

## Step 3.1: Attach VPC-A

1. Click **Transit Gateway Attachments**
2. Click **Create attachment**
3. Attachment type: **VPC**
4. Select:
   - Transit Gateway: `my-transit-gateway`
   - VPC: VPC-A
   - Subnets: Select one subnet per AZ

5. Click **Create attachment**

---

## Step 3.2: Attach VPC-B and VPC-C

Repeat the same steps for:

- VPC-B
- VPC-C

---

# STEP 4: Update VPC Route Tables

Without routes, traffic will not flow.

---

## Step 4.1: Update Route Table of VPC-A

Add routes:

```
Destination: 10.1.0.0/16 → Target: Transit Gateway
Destination: 10.2.0.0/16 → Target: Transit Gateway
```

---

## Step 4.2: Update Route Table of VPC-B

```
Destination: 10.0.0.0/16 → Target: Transit Gateway
Destination: 10.2.0.0/16 → Target: Transit Gateway
```

---

## Step 4.3: Update Route Table of VPC-C

```
Destination: 10.0.0.0/16 → Target: Transit Gateway
Destination: 10.1.0.0/16 → Target: Transit Gateway
```

---

# STEP 5: Update Security Groups

Security Groups must allow traffic between VPC CIDR ranges.

Example inbound rule:

- Type: All ICMP or Custom TCP
- Source: Other VPC CIDR blocks

---

# STEP 6: Test Transit Gateway Connectivity

1. SSH into EC2 in VPC-A
2. Ping private IP of EC2 in VPC-B or VPC-C

```bash
ping <PRIVATE_IP>
```

If ping works, Transit Gateway is configured correctly.

---

## When to Use Transit Gateway

- Large organizations
- Multi-account AWS setups
- Hub-and-spoke architectures
- Hybrid networking (VPN / Direct Connect)

---

## Summary

You have successfully:

- Created a Transit Gateway
- Attached multiple VPCs
- Configured routing
- Enabled transitive communication

---

🎉 **Congratulations! You have successfully configured AWS Transit Gateway.**
