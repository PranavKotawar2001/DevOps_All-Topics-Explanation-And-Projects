# Create MySQL RDS (Step-by-Step Guide)

---

## Step 1: Use the Default VPC or create custom VPC

### Why?

AWS automatically creates a **default VPC** in every region. Using it:

* Saves setup time
* Avoids creating custom networking
* Is suitable for learning and demos

### Terraform Code

```hcl
data "aws_vpc" "default" {
  default = true
}
```

### What This Does

* Fetches the existing default VPC
* Does **not** create a new VPC

---

## Step 2: Fetch Default Subnets or create subnet

### Why?

RDS requires a **DB Subnet Group**, which must contain **multiple subnets** across availability zones.

### Terraform Code

```hcl
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
```

### What This Does

* Retrieves all subnets associated with the default VPC
* These subnets are later used for the RDS subnet group

---

## Step 3: Create a Security Group for RDS

### Why?

A **security group** acts as a firewall for the RDS instance and controls:

* Who can connect to the database
* On which port

### Terraform Code

```hcl
resource "aws_security_group" "RDS_security_group" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS_security_group"
  }
}
```

### Explanation

* **Ingress rule**: Allows MySQL traffic on port `3306`
* **Egress rule**: Allows outbound traffic to anywhere

⚠️ **Security Note**:

* `0.0.0.0/0` allows access from anywhere
* Acceptable for learning
* ❌ Not recommended for production

---

## Step 4: Create DB Subnet Group

### Why?

RDS must be launched inside a **DB subnet group**, which defines:

* Which subnets RDS can use
* High availability across AZs

### Terraform Code

```hcl
resource "aws_db_subnet_group" "default" {
  name       = "default-db-subnet-group"
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = "default-db-subnet-group"
  }
}
```

### What This Does

* Groups default subnets together
* Enables RDS to run in multiple availability zones

---

## Step 5: Create the MySQL RDS Instance

### Terraform Code

```hcl
resource "aws_db_instance" "default" {
  allocated_storage      = 10
  max_allocated_storage  = 20
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "foo"
  password               = "foobarbaz"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true

  vpc_security_group_ids = [aws_security_group.RDS_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name

  tags = {
    Name = "RDS-db-instance"
  }
}
```

### Explanation

#### 🔹 Storage

* Starts with **10 GB**
* Can scale up to **20 GB**

#### 🔹 Engine

* MySQL 8.0

#### 🔹 Instance Type

* `db.t3.micro`
* Low-cost, suitable for testing

#### 🔹 Credentials

* Hardcoded (for learning only)
* ❌ Use Secrets Manager in production

#### 🔹 Security

* Attached to the RDS security group
* Uses subnet group for VPC placement

---

## Step 6: Run Terraform Commands

### Initialize Terraform

```bash
terraform init
```

* Downloads AWS provider
* Initializes Terraform

---

### Review the Plan

```bash
terraform plan
```

* Shows what resources will be created
* Validates configuration

---

### Apply the Configuration

```bash
terraform apply
```

* Creates:

  * Security group
  * DB subnet group
  * MySQL RDS instance

---