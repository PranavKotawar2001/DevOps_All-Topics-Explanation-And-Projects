# AWS VPC Peering – Step-by-Step Beginner Guide

This **README.md** explains **VPC Peering** in a very **simple and beginner-friendly way**. It covers **what it is, why we need it, and how to configure it step by step**.

---

## What is VPC Peering? (Very Simple Explanation)

**VPC Peering** is a network connection between **two VPCs** that allows them to communicate with each other **privately** using AWS’s internal network.

Think of it like:

- Two separate office buildings
- A **private tunnel** between them
- Employees can move securely between buildings

---

## Why Do We Need VPC Peering?

We use VPC Peering to:

- Connect applications running in different VPCs
- Share services like databases or internal APIs
- Keep traffic private (no public internet)
- Reduce latency and improve security

---

## Important Points to Know

- VPC CIDR blocks **must NOT overlap**
- Peering is **one-to-one** (no transitive routing)
- Traffic stays on **AWS private network**
- Security Groups and Route Tables must allow traffic

---

## Prerequisites

Before starting, make sure you have:

- AWS account
- Two VPCs created
- VPC CIDR blocks that do not overlap
- EC2 instances running in both VPCs (for testing)

Example CIDRs:

- VPC-A: `10.0.0.0/16`
- VPC-B: `10.1.0.0/16`

---

# STEP 1: Open VPC Peering Dashboard

1. Log in to AWS Console
2. Search for **VPC**
3. Click **Peering connections**
4. Click **Create peering connection**

---

# STEP 2: Create VPC Peering Connection

Fill in the following details:

- **Name tag**: `vpc-a-to-vpc-b`
- **VPC (Requester)**: Select VPC-A
- **VPC (Accepter)**: Select VPC-B
- Account: Same account (or another AWS account if needed)
- Region: Same region (for beginners)

Click **Create peering connection**.

---

# STEP 3: Accept Peering Request

1. Go to **Peering connections**
2. Select the peering connection
3. Click **Actions → Accept request**
4. Confirm

Status should now be **Active**.

---

# STEP 4: Update Route Tables (MOST IMPORTANT)

Without routes, VPCs cannot talk.

---

## Step 4.1: Update Route Table of VPC-A

1. Go to **Route Tables**
2. Select route table of VPC-A
3. Click **Edit routes**
4. Add route:

```
Destination: 10.1.0.0/16
Target: VPC Peering Connection
```

Save routes.

---

## Step 4.2: Update Route Table of VPC-B

1. Select route table of VPC-B
2. Click **Edit routes**
3. Add route:

```
Destination: 10.0.0.0/16
Target: VPC Peering Connection
```

Save routes.

---

# STEP 5: Update Security Groups

Security Groups must allow traffic between VPCs.

---

## Step 5.1: Allow Traffic in VPC-A Security Group

Inbound rule:

- Type: All ICMP or Custom TCP
- Source: `10.1.0.0/16`

---

## Step 5.2: Allow Traffic in VPC-B Security Group

Inbound rule:

- Type: All ICMP or Custom TCP
- Source: `10.0.0.0/16`

---

# STEP 6: Test VPC Peering

1. SSH into EC2 instance in VPC-A
2. Ping private IP of EC2 in VPC-B

```bash
ping <PRIVATE_IP_OF_VPC_B_INSTANCE>
```

If ping works, **VPC Peering is successful**.

---

## Common Beginner Mistakes

- Overlapping CIDR blocks
- Forgetting to update route tables
- Security group blocking traffic
- Expecting transitive routing

---

## Summary

You have successfully:

- Created VPC Peering connection
- Accepted peering request
- Updated route tables
- Allowed traffic using security groups
- Verified private communication

---

🎉 **Congratulations! You have successfully configured VPC Peering.**
