# AWS CloudWatch – Complete Beginner Guide

This README explains **Amazon CloudWatch** from scratch in a beginner-friendly way. By the end, you will understand **what CloudWatch is**, **why it is used**, and **how to use it step by step** in real projects.

---

## What is Amazon CloudWatch?

Amazon CloudWatch is a **monitoring and observability service** provided by AWS.

It helps you:

- Monitor AWS resources (EC2, RDS, Lambda, Load Balancers, etc.)
- Collect and visualize **metrics**
- Store and analyze **logs**
- Set **alarms** and get notifications
- Troubleshoot issues and improve performance

Think of CloudWatch as:

> **The eyes and ears of your AWS infrastructure**

---

## Why CloudWatch is Important

Without monitoring:

- You don’t know if your server is down
- You don’t know why an application is slow
- You may get unexpected AWS bills

With CloudWatch:

- You detect problems early
- You receive alerts automatically
- You improve reliability and performance
- You reduce downtime

---

## Core Components of CloudWatch

### 1. Metrics

Metrics are **numerical data points** collected over time.

Examples:

- EC2 CPUUtilization
- RDS FreeStorageSpace
- Load Balancer RequestCount
- Lambda Invocations

Key points:

- Metrics are stored by default
- Most metrics are collected every **5 minutes** (1 minute for detailed monitoring)

---

### 2. Namespaces

Namespaces organize metrics.

Examples:

- AWS/EC2
- AWS/RDS
- AWS/ELB
- Custom namespaces (your application metrics)

---

### 3. Dimensions

Dimensions filter metrics.

Example:

- InstanceId = i-123456
- LoadBalancerName = my-alb

They help you monitor **specific resources**.

---

### 4. CloudWatch Logs

CloudWatch Logs store **text-based log data**.

Used for:

- Application logs
- System logs
- Access logs

Structure:

- Log Group → Log Streams → Log Events

Example:

- Log Group: /aws/ec2/app
- Log Stream: instance-id

---

### 5. CloudWatch Alarms

Alarms monitor metrics and take actions.

Actions:

- Send notification (SNS)
- Auto scale EC2
- Stop or terminate instance

Example:

- If CPU > 80% for 5 minutes → Send alert

---

### 6. Dashboards

Dashboards provide **visual monitoring**.

Features:

- Custom widgets
- Real-time metrics
- Multiple services in one view

---

### 7. Events (EventBridge)

CloudWatch Events (now EventBridge) reacts to AWS events.

Examples:

- EC2 instance stopped
- Root login detected
- Scheduled events

---

## CloudWatch Pricing (Simple Explanation)

Free Tier includes:

- Basic metrics
- Limited log ingestion
- 10 alarms

Charged for:

- Custom metrics
- Logs storage & queries
- High-resolution alarms

Tip:

> Always delete unused logs and alarms

---

## Step-by-Step: Monitor an EC2 Instance

### Step 1: Launch EC2 Instance

- Launch an EC2 instance
- Ensure it has an IAM role with CloudWatch permissions

---

### Step 2: View Default Metrics

1. Go to CloudWatch
2. Open Metrics → EC2
3. Select InstanceId
4. View CPU, Network, Disk metrics

---

### Step 3: Enable Detailed Monitoring (Optional)

- EC2 → Monitoring → Enable detailed monitoring
- Collects metrics every 1 minute

---

### Step 4: Create an Alarm

1. CloudWatch → Alarms → Create Alarm
2. Select metric (CPUUtilization)
3. Set threshold (CPU > 80%)
4. Choose SNS notification
5. Create alarm

---

### Step 5: Create SNS Notification

1. Create SNS topic
2. Subscribe email
3. Confirm subscription

Now you receive alerts automatically.

---

## Step-by-Step: CloudWatch Logs for EC2

### Step 1: Install CloudWatch Agent

```bash
sudo apt update
sudo apt install amazon-cloudwatch-agent -y
```

---

### Step 2: Configure Agent

```bash
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
```

---

### Step 3: Start Agent

```bash
sudo systemctl start amazon-cloudwatch-agent
```

---

### Step 4: Verify Logs

- CloudWatch → Logs
- Check log groups

---

## CloudWatch for Other AWS Services

### EC2

- CPU, Memory, Disk, Network

### RDS

- CPUUtilization
- FreeStorageSpace
- DatabaseConnections

### Lambda

- Invocations
- Errors
- Duration

### Load Balancer

- RequestCount
- HTTP errors

---

## Best Practices

- Enable alarms for critical metrics
- Delete unused log groups
- Use dashboards for visibility
- Avoid too many custom metrics
- Monitor billing alarms

---

## Real-World Use Case

Example:

- EC2 CPU spikes
- Alarm triggers
- SNS sends email
- Auto Scaling adds new instance

---

## CloudWatch vs CloudTrail

| Feature | CloudWatch | CloudTrail |
| ------- | ---------- | ---------- |
| Purpose | Monitoring | Auditing   |
| Logs    | App/System | API calls  |
| Metrics | Yes        | No         |

---

## Summary

CloudWatch is essential for:

- Monitoring
- Alerting
- Troubleshooting
- Reliability

Mastering CloudWatch makes you a **better AWS engineer**.

---

Happy Monitoring 🚀
