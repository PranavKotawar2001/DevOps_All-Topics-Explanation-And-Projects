# 🌍 Terraform Complete Guide (Beginner to Intermediate)

Terraform is an **Infrastructure as Code (IaC)** tool that allows you to **define, create, update, and manage infrastructure using code** instead of manual steps.

---

## 🚀 Why Terraform?
- Automates infrastructure provisioning
- Works with **multiple cloud providers**
- Infrastructure is **version-controlled**
- Repeatable, reliable, and scalable
- Reduces human errors

---

## 🧠 What is Infrastructure as Code (IaC)?
IaC means managing infrastructure using **code files**.  
Instead of manually creating servers, networks, or databases, you define them in files and Terraform creates them for you.

---

## 🏗️ Terraform Architecture

- **Terraform CLI** – Command-line tool
- **Providers** – Connect Terraform to cloud platforms
- **Resources** – Actual infrastructure components
- **State File** – Tracks current infrastructure

---

## 📦 Terraform Basic Syntax (HCL)

Terraform uses **HCL (HashiCorp Configuration Language)**.

Basic structure:
```hcl
block_type "label1" "label2" {
  key = "value"
}

Example:
resource "aws_instance" "web" {
  instance_type = "t2.micro"
}
```
---

## 🔌 Provider Block (Most Important)
A provider tells Terraform which cloud or service to use and how to connect to it.
Without a provider, Terraform cannot create infrastructure.

**Provider Block Syntax**
provider "aws" {
  region = "ap-south-1"
}

**Explanation:**
provider "aws" → Tells Terraform to use AWS
region → AWS region where resources will be created

**Common Providers:**
AWS
Azure
Google Cloud (GCP)
Kubernetes
Docker

## 🧱 Resource Block
**What is a Resource?**
A resource defines what infrastructure to create.

**Resource Syntax**
resource "provider_resource" "resource_name" {
  argument = value
}

**Example:** AWS EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-0abcdef"
  instance_type = "t2.micro"
}

**Explanation:**
aws_instance → Resource type
web → Logical name
ami → OS image
instance_type → Server size

## 🔑 Variables
**Why Variables?**
Variables make code:
Reusable
Flexible
Environment-specific

**Variable Definition**
variable "instance_type" {
  default = "t2.micro"
}

**Variable Usage**
instance_type = var.instance_type

## 📤 Output Values
**Why Outputs?**
Outputs show important values after infrastructure is created.

**Output Example**
output "public_ip" {
  value = aws_instance.web.public_ip
}

## 📂 Terraform State
Terraform stores infrastructure information in a file called:

terraform.tfstate

**Purpose:**
Tracks what Terraform created
Helps Terraform know what to change
⚠️ Never edit state file manually.


## 🌐 Remote State (Best Practice)
**Why Remote State?**
Team collaboration
State backup
Locking support

**Example (S3 backend):**
backend "s3" {
  bucket = "terraform-state-bucket"
  key    = "dev/terraform.tfstate"
  region = "ap-south-1"
}

##🧩 Modules
**What are Modules?**
Modules are reusable Terraform code blocks.

**Example:**
module "vpc" {
  source = "./vpc"
}

**Benefits:**
Clean code
Reusability
Standardization

## 🔄 Terraform Workflow
**Step-by-step Flow and Commands**
```bash
terraform init     # Initialize project & providers
terraform plan     # Preview infrastructure changes
terraform apply    # Create or update infrastructure
terraform destroy  # Delete infrastructure
```

## 🧪 Important Terraform Commands
```bash
terraform fmt        # Format Terraform code
terraform validate   # Validate configuration
terraform show       # Show state details
terraform output     # Show output values
terraform state list # List managed resources
```

## 📁 Recommended Directory Structure
terraform-project/
│── provider.tf
│── main.tf
│── variables.tf
│── outputs.tf
│── terraform.tfvars

## 🔐 Security Best Practices
Never hardcode secrets
Use IAM roles
Store state securely
Add state files to .gitignore

## 🧠 Terraform Interview Concepts

What is Terraform state?
Difference between plan and apply
What is a provider?
What are modules?
Local vs remote state