# S3 Static Website Hosting Using Terraform

## Architecture Overview

* AWS S3 bucket
* S3 static website hosting enabled
* Public access allowed via bucket policy
* Terraform used as Infrastructure as Code (IaC)

---

## Step 1: Create S3 Bucket

This block creates an S3 bucket and enables **static website hosting**.

```hcl
resource "aws_s3_bucket" "pranav" {
  bucket = "pranav-static-website-123"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
```

### Purpose

* Creates an S3 bucket
* Enables website hosting
* Defines index and error pages

---

## Step 2: Disable Public Access Block

By default, AWS blocks public access. For static websites, this must be disabled.

```hcl
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.pranav.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
```

### Purpose

* Allows public access to the bucket
* Required for public website hosting

---

## Step 3: Add Bucket Policy for Public Read

This policy allows anyone to read objects from the bucket.

```hcl
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.pranav.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.pranav.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.example]
}
```

### Purpose

* Makes website content publicly accessible
* Required for browser access

---

## Step 4: Output Website Endpoint

```hcl
output "website_endpoint" {
  value       = aws_s3_bucket.pranav.website_endpoint
  description = "The URL to access the static website"
}
```

### Purpose

* Displays website URL after deployment

---

## Step 5: Initialize Terraform

```bash
terraform init
```

---

## Step 6: Validate Configuration

```bash
terraform validate
```

---

## Step 7: Apply Terraform Configuration

```bash
terraform apply
```

Type `yes` when prompted.

---

## Step 8: Upload Website Files

Upload files manually or via CLI:

```bash
aws s3 sync ./website s3://pranav-static-website-123
```

Files required:

* index.html
* error.html

---

## Step 9: Access the Website

Terraform output will show:

```text
website_endpoint = http://pranav-static-website-123.s3-website-<region>.amazonaws.com
```

Open this URL in a browser.

---

## Security Notes

* Public access is enabled intentionally
* Use **CloudFront + OAC** for production
* Do not host sensitive data

---

## Interview Explanation

> We use S3 static website hosting with a public bucket policy to serve frontend files, managed via Terraform for consistency and automation.

---

## Cleanup

```bash
terraform destroy
```