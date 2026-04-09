# STUDENT-INSTRUCTION.md — aws-rivermarket-ecommerce

**Powered by CloudBlitz** · A Product of **Greamio Technologies Private Limited**

---

## 1. Project Overview

### What This Project Does

You are deploying a **production-grade e-commerce API** on AWS for RiverMarket Foods. The stack includes:

- **ECS Fargate** — runs the Node.js API in containers without you managing servers
- **Application Load Balancer (ALB)** — distributes traffic and performs health checks
- **RDS PostgreSQL** — managed database with automated backups
- **Secrets Manager** — stores the `DATABASE_URL` so it's never in your code
- **ECR** — stores your Docker container images
- **S3** — stores static assets with encryption
- **CloudWatch** — logs and alarms
- **Terraform** — provisions all of the above as code

The API exposes two endpoints: `GET /health` and `GET /api/products`. It connects to PostgreSQL via a connection string injected from Secrets Manager at container startup.

### Real-World Context

This is the exact architecture pattern used by e-commerce companies moving from "a server that Priya manages" to a scalable, secure, observable cloud platform. You are simulating the full delivery lifecycle: infrastructure provisioning, application containerisation, deployment automation, and monitoring.

---

## 2. Prerequisites

### Technical Requirements

| Requirement | Minimum Version | Purpose |
|-------------|----------------|---------|
| **OS** | macOS, Ubuntu 20.04+, or Windows WSL2 | Development environment |
| **Docker Desktop / Engine** | 24.x | Building container images locally |
| **Terraform** | ≥ 1.5.0 | Provisioning all AWS infrastructure |
| **AWS CLI** | v2 (2.x) | Interacting with AWS; deploying images |
| **AWS Account** | — | Permissions detailed below |
| **curl** | Any | API testing |
| **jq** | 1.6+ | Parsing JSON responses |
| **git** | Any | Cloning and version control |

**Required AWS IAM Permissions** (minimum for this lab):
- `AmazonVPCFullAccess`
- `AmazonECS_FullAccess`
- `AmazonRDSFullAccess`
- `AmazonEC2ContainerRegistryFullAccess`
- `AmazonS3FullAccess`
- `SecretsManagerReadWrite`
- `CloudWatchFullAccess`
- `IAMFullAccess` (needed for Terraform to create task execution roles)

> If you're using a personal AWS account, attaching `AdministratorAccess` to your IAM user is the simplest approach for a lab environment. **Do not use root account credentials.**

### Knowledge Requirements

You should understand these concepts before starting:
- What a Docker container and image are
- What a VPC, subnet, and security group are
- Basic Terraform workflow: `init → plan → apply → destroy`
- What ECS is (containers as a managed service)
- What a load balancer does
- How environment variables work in applications

---

## 3. Prerequisite Setup (Step-by-Step)

### Step 3.1 — Install Docker

**Mac:**
1. Download Docker Desktop from [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
2. Open the `.dmg`, drag to Applications, launch it
3. Wait for the whale icon to stop animating

**Ubuntu/WSL2:**
```bash
sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER && newgrp docker
```

Verify:
```bash
docker version
```
Expected: shows Client and Server versions, both 24.x or higher.

### Step 3.2 — Install Terraform

**Mac:**
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

**Ubuntu/WSL2:**
```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install -y terraform
```

Verify:
```bash
terraform version
```
Expected output: `Terraform v1.x.x`

### Step 3.3 — Install AWS CLI v2

**Mac:**
```bash
brew install awscli
```

**Linux/WSL2:**
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/
```

Verify:
```bash
aws --version
```
Expected: `aws-cli/2.x.x ...`

### Step 3.4 — Configure AWS Credentials

You need an AWS IAM user with programmatic access (Access Key ID + Secret Access Key).

```bash
aws configure
```

Enter when prompted:
- **AWS Access Key ID:** your key
- **AWS Secret Access Key:** your secret
- **Default region name:** `us-east-1` (this project is configured for us-east-1)
- **Default output format:** `json`

Verify configuration works:
```bash
aws sts get-caller-identity
```

Expected output:
```json
{
    "UserId": "AIDA...",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/yourname"
}
```

If you see `Unable to locate credentials`, your `aws configure` didn't save. Re-run it.
If you see `InvalidClientTokenId`, your Access Key ID is wrong.
If you see `SignatureDoesNotMatch`, your Secret Access Key is wrong.

### Step 3.5 — Install Supporting Tools

**Mac:**
```bash
brew install curl jq
```

**Ubuntu/WSL2:**
```bash
sudo apt-get install -y curl jq
```

Verify:
```bash
curl --version | head -1
jq --version
```

---

## 4. Project Setup (Step-by-Step)

### Step 4.1 — Navigate to the Project Root

```bash
cd /path/to/curriculum-project/aws-rivermarket-ecommerce
ls
```

Expected directory contents:
```
README.md  STUDENT-INSTRUCTION.md  PROJECT-INFORMATION.md
app/  architecture/  cicd/  docker/  docs/  env/  infra/  monitoring/  scripts/
```

### Step 4.2 — Understand the Directory Structure

Take 5 minutes to read the structure before touching anything:

```
aws-rivermarket-ecommerce/
├── app/                         ← Node.js API source code
│   ├── server.js                ← Express app (two endpoints)
│   ├── package.json
│   └── migrations/
│       └── 001_init.sql         ← Database schema + seed data
├── docker/
│   └── Dockerfile               ← Production multi-stage Dockerfile
├── infra/
│   └── terraform/               ← ALL AWS infrastructure as code
│       ├── main.tf              ← Provider + backend config
│       ├── variables.tf         ← All input variables
│       ├── terraform.tfvars.example  ← Template — copy to terraform.tfvars
│       ├── vpc.tf               ← VPC, subnets, IGW, NAT, routes
│       ├── ecs.tf               ← ECS cluster, task definition, service
│       ├── rds.tf               ← RDS PostgreSQL instance
│       ├── alb.tf               ← Application Load Balancer + target group
│       ├── ecr.tf               ← ECR repository
│       ├── s3.tf                ← S3 bucket + encryption
│       ├── secrets.tf           ← Secrets Manager secret
│       ├── iam.tf               ← ECS task execution role + policies
│       └── monitoring.tf        ← CloudWatch log groups + alarms
├── scripts/
│   └── deploy.sh                ← Builds image, pushes to ECR, restarts ECS
├── env/
│   ├── dev.env                  ← Dev environment variable template
│   └── prod.env                 ← Prod environment variable template
└── docs/
    ├── setup.md
    └── troubleshooting.md
```

### Step 4.3 — Copy and Configure terraform.tfvars

```bash
cp infra/terraform/terraform.tfvars.example infra/terraform/terraform.tfvars
```

Open `terraform.tfvars` in a text editor:
```bash
cat infra/terraform/terraform.tfvars.example
```

You will see variables like:
```hcl
region           = "us-east-1"
environment      = "dev"
project          = "rivermarket"
db_username      = "riveruser"
db_password      = "RiverMarket2024!"
```

Edit `terraform.tfvars` with your values:
- Change `db_password` to something you'll remember (at least 8 characters, alphanumeric)
- Keep `region` as `us-east-1` unless you specifically want to change it (and read the note below)

> **Region note:** If you change the region, you must also update the AMI lookups in any EC2 resources. For this project, `us-east-1` is the safest choice as all configurations are tested there.

### Step 4.4 — Review the Application Code

```bash
cat app/server.js
```

Understand what it does:
- Creates an Express server on port 3000
- `GET /health` returns `{"status":"ok","service":"rivermarket-api",...}`
- `GET /api/products` queries the `products` table in PostgreSQL via the `pg` library
- Reads `DATABASE_URL` from environment (injected by ECS from Secrets Manager)

```bash
cat app/migrations/001_init.sql
```

This creates the `products` table and inserts sample grocery data. You'll need to run this manually after RDS is up.

### Step 4.5 — Review the Dockerfile

```bash
cat docker/Dockerfile
```

The Dockerfile uses a two-stage build:
1. **Stage 1 (builder):** Installs npm dependencies
2. **Stage 2 (production):** Copies only the production artifacts — no dev dependencies, no source maps

This keeps the production image small and secure.

---

## 5. Infrastructure Deployment

### Step 5.1 — Initialize Terraform

```bash
cd infra/terraform
terraform init
```

What this does:
- Downloads the AWS provider plugin (~50MB, cached after first run)
- Initialises the backend (local `.terraform/` directory)
- Validates module configurations

Expected output ends with:
```
Terraform has been successfully initialized!
```

If you see `Error: Failed to query available provider packages`, your internet connection is blocked or you need to configure a proxy.

### Step 5.2 — Validate Configuration

```bash
terraform validate
```

Expected: `Success! The configuration is valid.`

If you see validation errors, read them carefully — they usually point to a missing variable or a typo in a `.tf` file.

### Step 5.3 — Plan the Deployment

```bash
terraform plan
```

This shows you everything Terraform will create **without actually creating it**. Read through the output. You should see resources being created for:
- VPC, subnets, IGW, route tables
- Security groups
- RDS subnet group + instance
- Secrets Manager secret
- ECR repository
- ECS cluster + task definition + service
- ALB + target group + listener
- S3 bucket
- CloudWatch log groups + alarms
- IAM roles

Expected last line: `Plan: X to add, 0 to change, 0 to destroy.`

> **Cost awareness:** Before running `apply`, note that this deployment will incur AWS costs. For a dev environment, expect ~$4–6/day. Always run `terraform destroy` when done.

### Step 5.4 — Apply the Infrastructure

```bash
terraform apply
```

Type `yes` when prompted: `Do you want to perform these actions?`

This takes **8–15 minutes**. RDS takes the longest (~10 minutes to become available).

Expected final output:
```
Apply complete! Resources: X added, 0 changed, 0 destroyed.

Outputs:
alb_dns_name = "rivermarket-dev-alb-XXXXXXXXXX.us-east-1.elb.amazonaws.com"
ecr_repository_url = "123456789012.dkr.ecr.us-east-1.amazonaws.com/rivermarket-dev"
rds_endpoint = "rivermarket-dev-db.XXXXXX.us-east-1.rds.amazonaws.com"
```

### Step 5.5 — Save the Outputs

```bash
terraform output
```

Copy and save these values — you'll need them for the deployment steps:
- `alb_dns_name` — the URL you'll use to test the API
- `ecr_repository_url` — where you'll push your Docker image
- `rds_endpoint` — needed for the database migration

### Step 5.6 — Verify AWS Resources

```bash
aws ecs list-clusters --query 'clusterArns[]' --output table
aws rds describe-db-instances --query 'DBInstances[].DBInstanceStatus' --output text
aws elbv2 describe-load-balancers --query 'LoadBalancers[].DNSName' --output text
```

All three should return valid values. RDS should show `available`.

---

## 6. Application Deployment

### Step 6.1 — Run the Database Migration

The RDS instance is in a **private subnet** — you cannot connect to it directly from your laptop. You have three options:

**Option A — RDS Query Editor (easiest for lab)**
1. Go to AWS Console → RDS → Query Editor
2. Connect to your instance using the credentials from `terraform.tfvars`
3. Paste the contents of `app/migrations/001_init.sql` and run it

**Option B — EC2 Bastion (if you added one)**
```bash
ssh -i your-key.pem ec2-user@<bastion-public-ip>
psql -h <rds_endpoint> -U riveruser -d rivermarket -f /tmp/001_init.sql
```

**Option C — Temporarily allow your IP (dev only, not for production)**
Add a security group rule to allow port 5432 from your IP via Terraform, run the migration, then remove the rule.

Verify the migration ran:
```bash
psql -h <rds_endpoint> -U riveruser -d rivermarket -c "SELECT COUNT(*) FROM products;"
```
Expected: `count = 5` (or however many rows are in the seed data)

### Step 6.2 — Build and Push the Docker Image

First, authenticate Docker with ECR:
```bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(terraform output -raw ecr_repository_url | cut -d/ -f1)
```

Expected: `Login Succeeded`

Now build and push the image. From the project root (not the `infra/terraform` directory):
```bash
cd ../..    # back to project root: aws-rivermarket-ecommerce/
chmod +x scripts/deploy.sh
./scripts/deploy.sh rivermarket-dev api
```

What `deploy.sh` does:
1. Gets the ECR URL from Terraform outputs
2. Builds the Docker image from `docker/Dockerfile`
3. Tags it with both `:latest` and the git commit SHA
4. Pushes both tags to ECR
5. Calls `aws ecs update-service --force-new-deployment` to restart ECS with the new image

Watch the output. After it finishes, the ECS service will start pulling the new image.

### Step 6.3 — Wait for ECS to Stabilise

```bash
aws ecs wait services-stable \
  --cluster rivermarket-dev \
  --services rivermarket-dev-api \
  --region us-east-1
```

This command blocks until ECS reports the service as stable (all tasks running and healthy). Takes 2–3 minutes.

### Step 6.4 — Test the API

Get the ALB DNS name:
```bash
ALB=$(cd infra/terraform && terraform output -raw alb_dns_name)
echo "Testing: http://$ALB"
```

Test the health endpoint:
```bash
curl -s "http://$ALB/health" | jq .
```

Expected response:
```json
{
  "status": "ok",
  "service": "rivermarket-api",
  "region": "us-east-1",
  "timestamp": "2024-03-15T09:30:00.000Z"
}
```

Test the products endpoint:
```bash
curl -s "http://$ALB/api/products" | jq .
```

Expected response (after migration):
```json
[
  {"id": 1, "name": "Organic Rolled Oats", "category": "Grains", "price": 8.99},
  {"id": 2, "name": "Wildflower Honey 500g", "category": "Sweeteners", "price": 12.49},
  ...
]
```

If `/api/products` returns an empty array or an error, the database migration didn't run, or the `DATABASE_URL` in Secrets Manager isn't correct.

---

## 7. CI/CD Setup (Optional — CodeBuild)

The Terraform creates an **optional CodeBuild project** when you set `codebuild_github_repo` in `terraform.tfvars`.

### Step 7.1 — Enable CodeBuild

Edit `infra/terraform/terraform.tfvars`:
```hcl
codebuild_github_repo = "https://github.com/YOUR_USERNAME/aws-rivermarket-ecommerce"
```

Run:
```bash
cd infra/terraform
terraform apply
```

### Step 7.2 — Connect GitHub to CodeBuild

1. Go to AWS Console → CodeBuild → your project
2. Click **Edit Source** → **Connect to GitHub**
3. Authorise AWS CodeBuild to access your repository
4. Save

### Step 7.3 — Trigger a Build

1. Click **Start build** in the CodeBuild console
2. Watch the build logs
3. After the build succeeds, check ECR — you should see a new image with a recent timestamp

### Step 7.4 — Verify Automated Deployment

The `buildspec.yml` (in `cicd/`) does the same steps as `deploy.sh` — build, push, and restart ECS. After the build completes, wait 2 minutes and test the API again.

---

## 8. Monitoring & Validation

### View ECS Logs in CloudWatch

```bash
aws logs tail /ecs/rivermarket-dev-api --follow
```

This streams real-time logs from your API containers. You should see HTTP request logs for each `curl` you make.

Press `Ctrl+C` to stop following.

### View ECS Service Events

```bash
aws ecs describe-services \
  --cluster rivermarket-dev \
  --services rivermarket-dev-api \
  --query 'services[0].events[0:5]' \
  --output table
```

This shows the 5 most recent service events — useful for diagnosing deployment issues.

### Check CloudWatch Alarms

```bash
aws cloudwatch describe-alarms \
  --query 'MetricAlarms[].{Name:AlarmName,State:StateValue}' \
  --output table
```

All alarms should show `OK` state.

### Check RDS Connections

```bash
aws cloudwatch get-metric-statistics \
  --namespace AWS/RDS \
  --metric-name DatabaseConnections \
  --dimensions Name=DBInstanceIdentifier,Value=rivermarket-dev-db \
  --start-time $(date -u -v-1H +%Y-%m-%dT%H:%M:%SZ) \
  --end-time $(date -u +%Y-%m-%dT%H:%M:%SZ) \
  --period 300 \
  --statistics Average \
  --output table
```

*(On Linux, replace `-v-1H` with `-d '1 hour ago'`)*

---

## 9. Sample Output

### Terraform Apply (final lines)

```
Apply complete! Resources: 42 added, 0 changed, 0 destroyed.

Outputs:

alb_dns_name = "rivermarket-dev-alb-1234567890.us-east-1.elb.amazonaws.com"
ecr_repository_url = "123456789012.dkr.ecr.us-east-1.amazonaws.com/rivermarket-dev"
rds_endpoint = "rivermarket-dev-db.abc123.us-east-1.rds.amazonaws.com:5432"
```

### ECS Service Status

```
SERVICENAME        RUNNINGCOUNT  DESIREDCOUNT  STATUS
rivermarket-api    2             2             ACTIVE
```

### API Response — /health

```json
{
  "status": "ok",
  "service": "rivermarket-api",
  "region": "us-east-1",
  "timestamp": "2024-03-15T09:30:00.000Z"
}
```

### API Response — /api/products

```json
[
  {"id": 1, "name": "Organic Rolled Oats", "category": "Grains", "price": 8.99, "stock": 240},
  {"id": 2, "name": "Wildflower Honey 500g", "category": "Sweeteners", "price": 12.49, "stock": 85}
]
```

### Screenshots to Capture

1. `terraform output` showing all outputs
2. AWS Console → ECS → Service showing "2/2 running tasks"
3. CloudWatch → Log Groups → `/ecs/rivermarket-dev-api` → recent log entries
4. Browser or curl showing `/api/products` response
5. AWS Console → CloudWatch Alarms showing "OK" state
6. AWS Console → RDS → Instance showing "Available" status

---

## 10. Common Errors & Fixes

### Error 1: Terraform `Error acquiring state lock`

**Full error:**
```
Error: Error acquiring the state lock
Lock Info:
  ID:        xxxx-xxxx-xxxx
  Operation: OperationTypeApply
```

**Root cause:** A previous `terraform apply` was interrupted, leaving a stale lock file.

**Fix:**
```bash
terraform force-unlock <LOCK_ID>
```
Replace `<LOCK_ID>` with the ID shown in the error. Only do this if you're certain no other `terraform apply` is running.

---

### Error 2: ECS `CannotPullContainerError`

**Symptom:** ECS tasks fail to start; CloudWatch shows `CannotPullContainerError`

**Root cause:** The ECS task is trying to pull an image from ECR, but the image doesn't exist yet, or the task execution role doesn't have ECR permissions.

**Fix step 1:** Check if the image exists in ECR:
```bash
aws ecr list-images --repository-name rivermarket-dev --query 'imageIds[]' --output table
```

If empty: run `./scripts/deploy.sh rivermarket-dev api` first.

**Fix step 2:** Verify the task execution role has `AmazonEC2ContainerRegistryReadOnly` policy attached. Check in `infra/terraform/iam.tf`.

---

### Error 3: ALB Returns 503 Service Unavailable

**Root cause:** One of three things — ECS tasks aren't healthy, the database migration hasn't run, or the security group blocks the ECS task from connecting to RDS.

**Debug steps:**
```bash
# Check if tasks are running
aws ecs describe-tasks --cluster rivermarket-dev \
  --tasks $(aws ecs list-tasks --cluster rivermarket-dev --service-name rivermarket-dev-api --query 'taskArns[0]' --output text) \
  --query 'tasks[0].lastStatus'

# Check ECS logs for the specific error
aws logs tail /ecs/rivermarket-dev-api --since 10m
```

Common log message for DB connection failure:
```
Error: connect ETIMEDOUT - is DATABASE_URL correct? Can ECS reach RDS on port 5432?
```

**Fix:** Verify the security group on RDS allows inbound TCP 5432 from the ECS task security group.

---

### Error 4: RDS Engine Version Not Found

**Error message:**
```
Error: InvalidParameterCombination: Cannot find version 16.x for postgres
```

**Root cause:** The PostgreSQL version specified in `infra/terraform/rds.tf` isn't available in your chosen region or as a minor version.

**Fix:**
```bash
aws rds describe-db-engine-versions \
  --engine postgres \
  --query 'DBEngineVersions[?contains(DBEngineVersionDescription, `16`)].EngineVersion' \
  --output table
```

Use one of the returned versions. Edit `rds.tf` accordingly.

---

### Error 5: CodeBuild — Source Provider Error

**Error message:**
```
DOWNLOAD_SOURCE FAILED: Error calling GitHub API
```

**Root cause:** CodeBuild isn't connected to GitHub.

**Fix:** In the AWS Console → CodeBuild → your project → Edit Source → Connect to GitHub OAuth. Follow the prompts.

---

### Error 6: `deploy.sh` — `aws: command not found` or `docker: command not found`

**Root cause:** The PATH in your shell session doesn't include the AWS CLI or Docker installation directory.

**Fix (Mac):**
```bash
export PATH="$PATH:/usr/local/bin"
which aws
which docker
```

Add the above `export PATH` to your `~/.zshrc` or `~/.bash_profile` to make it permanent.

---

## 11. Final Validation Checklist

Work through each item before considering this project complete:

- [ ] `terraform apply` completed successfully with no errors
- [ ] `terraform output` shows `alb_dns_name`, `ecr_repository_url`, and `rds_endpoint`
- [ ] ECR repository has at least one image: `aws ecr list-images --repository-name rivermarket-dev`
- [ ] ECS service shows 2/2 running tasks: `aws ecs describe-services --cluster rivermarket-dev --services rivermarket-dev-api`
- [ ] Database migration ran: `psql` query returns `count > 0`
- [ ] `curl http://<alb_dns_name>/health` returns `{"status":"ok",...}` (HTTP 200)
- [ ] `curl http://<alb_dns_name>/api/products` returns a JSON array of products
- [ ] CloudWatch log group `/ecs/rivermarket-dev-api` has recent log entries
- [ ] All CloudWatch alarms are in `OK` state
- [ ] `deploy.sh` can be run a second time without errors (idempotent deployment)

---

## 12. Cleanup Steps

**IMPORTANT: Running this project costs money. Always destroy when done with the lab.**

### Step 12.1 — Destroy All Infrastructure

```bash
cd infra/terraform
terraform destroy
```

Type `yes` when prompted. This takes 10–15 minutes. Terraform destroys resources in the correct order to avoid dependency errors.

Expected output ends with:
```
Destroy complete! Resources: X destroyed.
```

### Step 12.2 — Manually Clean Up (if `terraform destroy` fails)

If `terraform destroy` errors on specific resources, delete them manually via console:
1. ECS Service → Update desired count to 0 → Delete service
2. ALB → Delete load balancer
3. RDS → Delete (skip final snapshot for lab)
4. ECR → Delete repository (requires emptying first)
5. VPC → Delete VPC (deletes most other VPC resources automatically)

### Step 12.3 — Verify No Billing Resources Remain

```bash
aws ecs list-clusters --output text
aws rds describe-db-instances --query 'DBInstances[].DBInstanceIdentifier' --output text
aws elbv2 describe-load-balancers --query 'LoadBalancers[].LoadBalancerName' --output text
aws ec2 describe-nat-gateways --filter "Name=state,Values=available" --query 'NatGateways[].NatGatewayId' --output text
```

All should return empty output after a successful destroy. **NAT Gateway is the most expensive resource if left running** (~$1.05/day base cost).

---

**Primary documentation:** `README.md`
**Troubleshooting guide:** `docs/troubleshooting.md`
**Architecture diagram:** `architecture/architecture.md`
**Project delivery context:** `PROJECT-INFORMATION.md`
