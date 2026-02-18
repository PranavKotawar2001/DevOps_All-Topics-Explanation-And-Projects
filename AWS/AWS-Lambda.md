# AWS Lambda – Complete Beginner Guide

This **README.md** explains **AWS Lambda** in a **simple, beginner-friendly way**, with **clear explanations, examples, and step-by-step guidance**.

---

## What is AWS Lambda?

**AWS Lambda** is a **serverless compute service** that lets you run code **without creating or managing servers**.

👉 You only write code. AWS takes care of:

- Servers
- Scaling
- Availability
- Maintenance

Think of Lambda as:

> “Run this code **only when needed**, and pay **only for execution time**.”

---

## Why Use AWS Lambda?

Lambda is used when you want to:

- Run backend code without managing EC2
- Automatically scale based on traffic
- Reduce infrastructure cost
- Build event-driven applications

---

## Key Benefits of Lambda

- No server management
- Automatic scaling
- Pay-per-use pricing
- Highly available
- Integrated with many AWS services

---

## Common Use Cases

- Backend APIs
- File processing (S3 uploads)
- Data transformation
- Scheduled jobs (cron)
- Event-driven automation

---

## How AWS Lambda Works

1. An **event** occurs (API call, file upload, message, etc.)
2. Lambda function is triggered
3. Code runs in an isolated environment
4. Result is returned
5. Environment is stopped

---

## Lambda Components

### 1. Function

The actual code you run.

### 2. Runtime

Language used to run the function.

Supported runtimes include:

- Python
- Node.js
- Java
- Go
- .NET

---

### 3. Handler

The **entry point** of your code.

Example (Python):

```
def lambda_handler(event, context):
    return "Hello from Lambda"
```

---

### 4. Event

The input data that triggers the function.

---

### 5. Execution Role (IAM Role)

Gives Lambda **permission** to access other AWS services.

Example:

- Read from S3
- Write logs to CloudWatch

---

## Step-by-Step: Create Your First Lambda Function

### Step 1: Open Lambda Console

- Go to AWS Console
- Search for **Lambda**
- Click **Create function**

---

### Step 2: Choose Function Type

- Select **Author from scratch**
- Function name: `hello-lambda`
- Runtime: Python 3.x
- Click **Create function**

---

### Step 3: Add Code

```python
def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': 'Hello from AWS Lambda!'
    }
```

Click **Deploy**

---

### Step 4: Test Function

- Click **Test**
- Create test event
- Click **Test** again

You should see output successfully.

---

## Lambda Execution Flow

- Function starts
- Code executes
- Logs sent to CloudWatch
- Function stops

---

## Lambda with Triggers (Events)

Lambda can be triggered by:

- API Gateway
- S3
- EventBridge (CloudWatch Events)
- DynamoDB
- SQS
- SNS

---

## Example: Lambda Triggered by S3 Upload

Flow:

1. File uploaded to S3
2. Lambda triggered
3. File processed

Common use cases:

- Image resizing
- File validation
- Log processing

---

## Lambda with API Gateway

Used to create **serverless REST APIs**.

Flow:

1. Client sends HTTP request
2. API Gateway triggers Lambda
3. Lambda returns response

---

## Lambda Environment Variables

Used to store:

- Configuration values
- Database endpoints
- API keys

Example:

```
DB_HOST=example.com
```

---

## Lambda Timeout & Memory

### Timeout

- Max execution time: **15 minutes**

### Memory

- Range: 128 MB – 10 GB
- More memory = more CPU

---

## Lambda Pricing (Simple)

You pay for:

- Number of requests
- Execution time (milliseconds)

Free tier includes:

- 1 million requests/month
- 400,000 GB-seconds

---

## Cold Start (Beginner Explanation)

Cold start happens when:

- Lambda runs for first time
- Lambda runs after being idle

Impact:

- Slight delay (milliseconds)

---

## Logging & Monitoring

- Logs go to **CloudWatch Logs**
- Metrics available in **CloudWatch**

---

## Security Best Practices

- Use least-privilege IAM roles
- Store secrets in AWS Secrets Manager
- Avoid hardcoding credentials

---

## Lambda vs EC2

| Feature           | Lambda            | EC2               |
| ----------------- | ----------------- | ----------------- |
| Server management | No                | Yes               |
| Scaling           | Automatic         | Manual            |
| Cost model        | Pay per execution | Pay per hour      |
| Use case          | Event-driven      | Long-running apps |

---

## Real-World Example Architecture

- API Gateway → Lambda → DynamoDB
- S3 → Lambda → CloudWatch
- EventBridge → Lambda → SNS

---

## Best Practices

- Keep functions small
- One function = one responsibility
- Monitor with CloudWatch
- Use environment variables

---

🎉 **You now have a strong beginner-to-intermediate understanding of AWS Lambda!**
