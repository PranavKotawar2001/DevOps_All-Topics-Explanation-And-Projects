# AWS IAM (Identity and Access Management) – Complete Beginner Guide

This **README.md** is a **full beginner-friendly guide** to **AWS IAM**. It explains **what IAM is, why it is used, all IAM components, and step-by-step usage** in very simple language.

---

## What is IAM? (Simple Explanation)

**IAM (Identity and Access Management)** is an AWS service that helps you:

- Control **who** can access AWS
- Control **what** they can access
- Control **what actions** they can perform

Think of IAM as:

> A **security guard** that decides who can enter AWS and what they are allowed to do.

---

## Why Do We Need IAM?

Without IAM:

- Everyone would have full access
- High risk of data loss
- Security issues

With IAM:

- Least privilege access
- Strong security
- Better control
- Audit and compliance

---

## Core IAM Components (Must Know)

### 1. IAM Users

An **IAM User** represents a **person or application**.

Examples:

- Developer
- Admin
- Application service

Each user can have:

- Username
- Password (for Console)
- Access keys (for CLI)

---

### 2. IAM Groups

A **Group** is a collection of users.

Example:

- Developers group
- Admins group

Permissions are attached to **groups**, not directly to users (best practice).

---

### 3. IAM Policies

A **Policy** defines permissions.

It answers:

- What actions are allowed?
- On which resources?

Policies are written in **JSON format**.

Example:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "*"
    }
  ]
}
```

---

### 4. IAM Roles

A **Role** is used by AWS services (EC2, Lambda, etc.).

Key difference:

- Users → People
- Roles → Services

Roles do **not** have passwords or access keys.

---

## IAM Authentication Methods

1. AWS Console Login (username & password)
2. AWS CLI (access key & secret key)
3. IAM Role (temporary credentials)

---

## Step-by-Step: Create IAM User

### Step 1: Open IAM

- Go to AWS Console
- Search **IAM**

### Step 2: Create User

1. Click **Users → Create user**
2. Enter username
3. Select access type:
   - Console access
   - Programmatic access

### Step 3: Attach Permissions

- Add user to a group OR
- Attach policy directly

### Step 4: Save Credentials

- Download credentials file

---

## Step-by-Step: Create IAM Group

1. Go to IAM → Groups
2. Create group (example: Developers)
3. Attach policy
4. Add users to group

---

## Step-by-Step: Create IAM Role (EC2 Example)

### Step 1: Create Role

1. Go to IAM → Roles
2. Create role
3. Select **EC2** as trusted entity

### Step 2: Attach Policy

- Example: AmazonS3ReadOnlyAccess

### Step 3: Attach Role to EC2

1. Go to EC2
2. Select instance
3. Modify IAM role

---

## IAM Policies Types

### 1. Managed Policies

- AWS Managed
- Customer Managed

### 2. Inline Policies

- Attached directly to one user or role

---

## IAM Best Practices (Very Important)

- Never use root account for daily work
- Enable MFA for all users
- Use roles instead of access keys
- Apply least privilege principle
- Rotate credentials

---

## IAM Security Features

### 1. MFA (Multi-Factor Authentication)

Adds extra security using OTP or device.

### 2. Password Policies

- Minimum length
- Complexity rules

### 3. Access Advisor

Shows unused permissions.

---

## Common Beginner Mistakes

- Using root account
- Giving full admin access
- Hardcoding access keys
- Not enabling MFA

---

## Real-World IAM Examples

- EC2 uploads files to S3 using role
- Lambda reads DynamoDB
- Developers have read-only access

---

## IAM vs Resource Policies

| IAM Policy              | Resource Policy          |
| ----------------------- | ------------------------ |
| Attached to users/roles | Attached to resource     |
| Controls who            | Controls resource access |

---

# AWS IAM Integrations – What to Learn Next (Beginner Guide)

This **README.md** explains **how IAM works with other AWS services** in a very **simple and beginner-friendly way**.

You will learn:

1. IAM + S3
2. IAM + EC2
3. IAM + Lambda
4. IAM with Terraform

Each section includes **what it is, why it is used, and step-by-step flow**.

---

## 1. IAM + S3

### What is IAM + S3?

IAM controls **who can access S3 buckets** and **what actions they can perform** (read, write, delete).

---

### Why Use IAM with S3?

- Prevent unauthorized access
- Allow only required permissions
- Secure sensitive data

---

### Common Use Cases

- EC2 uploads files to S3
- Developers get read-only access
- Applications store logs in S3

---

### Step-by-Step: IAM + S3 (EC2 Example)

#### Step 1: Create IAM Role

1. Go to IAM → Roles → Create role
2. Trusted entity → EC2
3. Attach policy:
   - `AmazonS3ReadOnlyAccess` (learning)

#### Step 2: Attach Role to EC2

1. Go to EC2 → Instance
2. Modify IAM Role
3. Attach created role

#### Step 3: Test Access

```bash
aws s3 ls
```

✅ EC2 can access S3 securely without keys.

---

## 2. IAM + EC2

### What is IAM + EC2?

IAM roles allow EC2 instances to **access AWS services securely**.

---

### Why IAM Role for EC2?

- No access keys needed
- More secure
- Temporary credentials

---

### Step-by-Step: IAM + EC2

#### Step 1: Create IAM Role

- Service: EC2
- Policy: Required service access

#### Step 2: Attach Role to EC2

- Modify instance IAM role

#### Step 3: Verify

```bash
aws sts get-caller-identity
```

---

## 3. IAM + Lambda

### What is IAM + Lambda?

IAM allows Lambda functions to **access other AWS services**.

---

### Why IAM with Lambda?

- Lambda needs permissions to read/write resources
- Secure execution

---

### Step-by-Step: IAM + Lambda

#### Step 1: Create IAM Role for Lambda

1. Go to IAM → Roles → Create role
2. Trusted entity → Lambda
3. Attach policy (example):
   - `AmazonS3ReadOnlyAccess`

#### Step 2: Attach Role to Lambda

- Role is attached during Lambda creation

#### Step 3: Test Lambda

- Invoke Lambda
- Check logs in CloudWatch

---

## 4. IAM with Terraform

### What is IAM with Terraform?

Terraform manages IAM resources using **code (IaC)**.

---

### Why Use Terraform for IAM?

- Automation
- Version control
- Repeatable infrastructure

---

### Example: Create IAM User with Terraform

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "example" {
  name = "terraform-user"
}
```

---

### Example: Create IAM Role with Terraform

```hcl
resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}
```

---

## IAM Best Practices (Important)

- Use roles instead of access keys
- Apply least privilege
- Enable MFA
- Rotate credentials
- Avoid root account

---

## Real-World Architecture Examples

- EC2 → IAM Role → S3
- Lambda → IAM Role → DynamoDB
- Terraform → IAM → AWS Resources

---

## Summary

You learned:

- What IAM is
- IAM users, groups, roles
- Policies
- Best practices
- Security features
- IAM + S3
- IAM + EC2
- IAM + Lambda
- IAM with Terraform

---

🎉 **Congratulations! You now understand AWS IAM clearly.**
