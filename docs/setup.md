# RiverMarket AWS — Setup

## Prerequisites

- AWS account with admin or scoped IAM for VPC, ECS, RDS, ECR, IAM, CodeBuild
- AWS CLI v2, Docker, Terraform ≥ 1.5
- `aws configure` or SSO profile

## 1. Bootstrap Terraform

```bash
cd infra/terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

Record outputs: `alb_dns_name`, `ecr_repository_url`.

## 2. Initialize database schema

RDS is private — use **RDS Query Editor** (IAM auth) or a **bastion** / **VPN** / **ECS exec** session.

Run SQL from `app/migrations/001_init.sql`.

## 3. Build and push container

From repository root:

```bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh rivermarket-dev api
```

Adjust cluster/service names to match `environment` (e.g. `rivermarket-prod`).

## 4. Verify

```bash
ALB=$(terraform output -raw alb_dns_name)
curl -s "http://${ALB}/health"
curl -s "http://${ALB}/api/products"
```

## 5. CodeBuild (optional)

Set `codebuild_github_repo = "org/repo"` in `terraform.tfvars`, `terraform apply`, connect GitHub in the CodeBuild console if prompted, then start a build.

## 6. View logs

CloudWatch → Log groups → `/ecs/rivermarket-*` and `/codebuild/*`.
